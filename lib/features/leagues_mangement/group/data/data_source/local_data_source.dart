import 'dart:math';
import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/model.dart';
import '../service/group_service.dart';

class GroupsLocalDataSource {
  final Safirah db;
  final GroupService _groupService;

  GroupsLocalDataSource(this.db) : _groupService = const GroupService();

  Future<void> drawGroupsByCount({
    required int leagueId,
    required int groupsCount,
    required int qualifiedPerGroup,
    bool clearExisting = true,
    bool useLetters = true,
  }) async {
    final rng = Random();

    await db.transaction(() async {
      final teamRows = await (db.select(db.teams)
            ..where((t) => t.leagueId.equals(leagueId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      final teamIds = teamRows.map((e) => e.id).toList();

      // استخدام الخدمة لحساب توزيع الفرق على المجموعات
      final drawResult = _groupService.drawGroupsByCount(
        teamIds: teamIds,
        groupsCount: groupsCount,
        useLetters: useLetters,
        random: rng,
      );

      if (clearExisting) {
        await (db.delete(db.qualifiedTeam)
              ..where((q) => q.leagueId.equals(leagueId)))
            .go();
        await (db.delete(db.group)..where((g) => g.leagueId.equals(leagueId)))
            .go();
      }

      // إنشاء المجموعات في DB وفق أسماء الخدمة
      final groupIds = <int>[];
      for (var i = 0; i < drawResult.groupNames.length; i++) {
        final name = drawResult.groupNames[i];
        final gid = await db.into(db.group).insert(
              GroupCompanion.insert(
                leagueId: leagueId,
                groupName: name,
                qualifiedTeamNumber: Value(qualifiedPerGroup),
              ),
            );
        groupIds.add(gid);
      }

      // ربط الفرق بالمجموعات وإنشاء السجلات المؤهلة
      for (var i = 0; i < groupIds.length; i++) {
        final gid = groupIds[i];
        final bucket = drawResult.buckets[i];

        for (final tid in bucket) {
          await db.into(db.groupTeam).insert(
                GroupTeamCompanion.insert(groupId: gid, teamId: tid),
                mode: InsertMode.insertOrIgnore,
              );

          await db.into(db.qualifiedTeam).insert(
                QualifiedTeamCompanion.insert(
                  leagueId: leagueId,
                  groupId: gid,
                  teamId: tid,
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
      }
    });
  }

  Future<List<(GroupModel, List<QualifiedTeamModel>)>>
      getLeagueGroupsWithQualifiedTeams(int leagueId) async {
    // 1️⃣ جلب جميع المجموعات التابعة للدوري
    final groups = await (db.select(db.group)
          ..where((g) => g.leagueId.equals(leagueId))
          ..orderBy([(g) => OrderingTerm.asc(g.groupName)]))
        .get();

    if (groups.isEmpty) return const [];

    final groupIds = groups.map((g) => g.id).toList();

    // 2️⃣ جلب سجلات الفرق المؤهلة (QualifiedTeam)
    final q = db.qualifiedTeam;
    final qtRows = await (db.select(q)
          ..where((r) => r.leagueId.equals(leagueId) & r.groupId.isIn(groupIds))
          ..orderBy([
            (r) => OrderingTerm.asc(r.groupId),
            (r) => OrderingTerm.desc(r.points),
            (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
            (r) => OrderingTerm.desc(r.goalsFor),
            (r) => OrderingTerm.asc(r.goalsAgainst),
          ]))
        .get();

    // 3️⃣ جلب أسماء الفرق المرتبطة دفعة واحدة لتقليل الاستعلامات
    final teamIds = {for (final e in qtRows) e.teamId}.toList();
    final teamsRows = teamIds.isEmpty
        ? const <Team>[]
        : await (db.select(db.teams)..where((t) => t.id.isIn(teamIds))).get();

    final nameById = {for (final t in teamsRows) t.id: t.teamName};

    // 4️⃣ تحويل النتائج إلى موديلات مجمعة حسب المجموعات
    final map = <int, List<QualifiedTeamModel>>{
      for (final gid in groupIds) gid: <QualifiedTeamModel>[]
    };

    for (final e in qtRows) {
      final model =
          QualifiedTeamModel.fromEntity(e).withTeamName(nameById[e.teamId]);
      map[e.groupId]!.add(model);
    }

    final result = <(GroupModel, List<QualifiedTeamModel>)>[];

    for (final g in groups) {
      final groupModel = GroupModel.fromEntity(g);
      final teams = map[g.id]!;

      // 1) ترتيب مبدئي بالنقاط (موجود بالفعل من الاستعلام)
      final orderedByPoints = List<QualifiedTeamModel>.from(teams);

      // 2) جلب كل مباريات هذه المجموعة من جدول matches
      final matchesForGroup = await (db.select(db.matches)
            ..where((m) => m.leagueId.equals(leagueId)))
          .get();

      // 3) تطبيق head-to-head داخل كل مجموعة تعادل بالنقاط
      final finalOrdered = <QualifiedTeamModel>[];
      var start = 0;
      while (start < orderedByPoints.length) {
        var end = start + 1;
        while (end < orderedByPoints.length &&
            orderedByPoints[end].points == orderedByPoints[start].points) {
          end++;
        }

        if (end - start == 1) {
          finalOrdered.add(orderedByPoints[start]);
        } else {
          final tieGroup = orderedByPoints.sublist(start, end);
          final tieTeamIds = tieGroup.map((t) => t.teamId).toSet();

          // حساب نقاط head-to-head بين الفرق المتساوية
          final h2hPoints = <int, num>{for (final id in tieTeamIds) id: 0};

          for (final m in matchesForGroup) {
            if (!tieTeamIds.contains(m.homeTeamId) ||
                !tieTeamIds.contains(m.awayTeamId)) {
              continue;
            }

            if (m.homeScore > m.awayScore) {
              h2hPoints[m.homeTeamId] = (h2hPoints[m.homeTeamId] ?? 0) + 3;
            } else if (m.awayScore > m.homeScore) {
              h2hPoints[m.awayTeamId] = (h2hPoints[m.awayTeamId] ?? 0) + 3;
            } else {
              h2hPoints[m.homeTeamId] = (h2hPoints[m.homeTeamId] ?? 0) + 1;
              h2hPoints[m.awayTeamId] = (h2hPoints[m.awayTeamId] ?? 0) + 1;
            }
          }

          final orderedTie = _groupService.sortByHeadToHead(tieGroup, h2hPoints);
          finalOrdered.addAll(orderedTie);
        }

        start = end;
      }

      result.add((groupModel, finalOrdered));
    }

    return result;
  }
}
