import 'dart:math';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/model.dart';
import '../model/group_draw_payload.dart';
import '../service/group_service.dart';
import 'package:rxdart/rxdart.dart';

class GroupsLocalDataSource {
  final Safirah db;
  final GroupService _groupService;

  GroupsLocalDataSource(this.db) : _groupService = const GroupService();

  Future<List<GroupDrawPayload>> drawGroupsByCount({
    required String leagueSyncId,
    required int groupsCount,
    required int qualifiedPerGroup,
    bool clearExisting = true,
    bool useLetters = true,
  }) async {
    final rng = Random();

    return db.transaction(() async {
      final teamRows = await (db.select(db.teams)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      // بدل id -> نستخدم syncId
      final teamIds = teamRows.map((e) => e.syncId).toList();

      // استخدام الخدمة لحساب توزيع الفرق على المجموعات
      final drawResult = _groupService.drawGroupsByCount(
        teamIds: teamIds,
        groupsCount: groupsCount,
        useLetters: useLetters,
        random: rng,
      );

      if (clearExisting) {
        await (db.delete(db.qualifiedTeam)
              ..where((q) => q.leagueSyncId.equals(leagueSyncId)))
            .go();
        await (db.delete(db.group)
              ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
            .go();
      }

      // إدراج المجموعات مع التقاط syncId لكل مجموعة بنفس ترتيب groupNames
      final groupSyncIds = <String>[];
      for (var i = 0; i < drawResult.groupNames.length; i++) {
        final name = drawResult.groupNames[i];
        final groupSyncId = const Uuid().v7();

        await db.into(db.group).insert(
              GroupCompanion.insert(
                leagueSyncId: leagueSyncId,
                groupName: name,
                qualifiedTeamNumber: Value(qualifiedPerGroup),
                syncId: groupSyncId,
              ),
            );

        groupSyncIds.add(groupSyncId);
      }

      // ربط الفرق بالمجموعات وإنشاء السجلات المؤهلة
      // + تجهيز payload لكل مجموعة
      final payloads = <GroupDrawPayload>[];

      for (var i = 0; i < groupSyncIds.length; i++) {
        final gid = groupSyncIds[i];
        final bucket = drawResult.buckets[i];

        final groupTeams = <GroupTeamModel>[];
        final qualifiedTeams = <QualifiedTeamModel>[];

        for (final tid in bucket) {
          // group_team
          await db.into(db.groupTeam).insert(
                GroupTeamCompanion.insert(
                  syncId: const Uuid().v7(),
                  groupSyncId: gid,
                  teamSyncId: tid,
                ),
                mode: InsertMode.insertOrIgnore,
              );
          groupTeams.add(GroupTeamModel(groupSyncId: gid, teamSyncId: tid));

          // qualified_team
          await db.into(db.qualifiedTeam).insert(
                QualifiedTeamCompanion.insert(
                  syncId: const Uuid().v7(),
                  leagueSyncId: leagueSyncId,
                  groupSyncId: gid,
                  teamSyncId: tid,
                ),
                mode: InsertMode.insertOrIgnore,
              );

          qualifiedTeams.add(
            QualifiedTeamModel(
              leagueSyncId: leagueSyncId,
              groupSyncId: gid,
              teamSyncId: tid,
              qualificationType: 'auto',
            ),
          );
        }

        final insertedQt = await (db.select(db.qualifiedTeam)
              ..where((q) =>
                  q.leagueSyncId.equals(leagueSyncId) &
                  q.groupSyncId.equals(gid)))
            .get();
        final qtSyncIdByTeamId = {
          for (final e in insertedQt) e.teamSyncId: e.syncId,
        };

        payloads.add(
          GroupDrawPayload(
            groupSyncId: gid,
            group: GroupModel(
              leagueSyncId: leagueSyncId,
              groupName: drawResult.groupNames[i],
              qualifiedTeamNumber: qualifiedPerGroup,
            ),
            groupTeams: groupTeams,
            qualifiedTeams: qualifiedTeams,
            qualifiedTeamSyncIdByTeamId: qtSyncIdByTeamId,
          ),
        );
      }

      return payloads;
    });
  }

  Future<List<GroupModel>> getLeagueGroupsWithQualifiedTeams(
      String leagueSyncId) async {
    // 1️⃣ جلب جميع المجموعات التابعة للدوري
    final groups = await (db.select(db.group)
          ..where((g) => g.leagueSyncId.equals(leagueSyncId))
          ..orderBy([(g) => OrderingTerm.asc(g.groupName)]))
        .get();

    if (groups.isEmpty) return const [];

    final groupIds = groups.map((g) => g.syncId).toList();

    final q = db.qualifiedTeam;
    final qtRows = await (db.select(q)
          ..where((r) =>
              r.leagueSyncId.equals(leagueSyncId) &
              r.groupSyncId.isIn(groupIds))
          ..orderBy([
            (r) => OrderingTerm.asc(r.groupSyncId),
            (r) => OrderingTerm.desc(r.points),
            (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
            (r) => OrderingTerm.desc(r.goalsFor),
            (r) => OrderingTerm.asc(r.goalsAgainst),
          ]))
        .get();

    // 3️⃣ جلب أسماء الفرق المرتبطة دفعة واحدة لتقليل الاستعلامات
    final teamIds = {for (final e in qtRows) e.teamSyncId}.toList();
    final teamsRows = teamIds.isEmpty
        ? const <Team>[]
        : await (db.select(db.teams)..where((t) => t.syncId.isIn(teamIds)))
            .get();

    final nameById = {for (final t in teamsRows) t.syncId: t.teamName};

    // 4️⃣ تحويل النتائج إلى موديلات مجمعة حسب المجموعات
    final map = <String, List<QualifiedTeamModel>>{
      for (final gid in groupIds) gid: <QualifiedTeamModel>[]
    };

    for (final e in qtRows) {
      final model =
          QualifiedTeamModel.fromEntity(e).withTeamName(nameById[e.teamSyncId]);
      map[e.groupSyncId]!.add(model);
    }

    final result = <GroupModel>[];

    for (final g in groups) {
      final groupModel = GroupModel.fromEntity(g);
      final teams = map[g.syncId]!;

      // 1) ترتيب مبدئي بالنقاط (موجود بالفعل من الاستعلام)
      final orderedByPoints = List<QualifiedTeamModel>.from(teams);

      // 2) تطبيق head-to-head داخل كل مجموعة تعادل بالنقاط
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
          final tieTeamIds = tieGroup.map((t) => t.teamSyncId).toSet();

          // حساب نقاط head-to-head بين الفرق المتساوية (key = teamSyncId)
          final h2hPoints = <String, num>{for (final id in tieTeamIds) id: 0};

          final orderedTie =
              _groupService.sortByHeadToHead(tieGroup, h2hPoints);
          finalOrdered.addAll(orderedTie);
        }

        start = end;
      }

      result.add(groupModel.withQualifiedTeams(finalOrdered));
    }

    return result;
  }

  Stream<List<GroupModel>> watchQualifiedTeam({
    required String leagueSyncId,
  }) {
    final groupTrigger = (db.select(db.group)
          ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);
    final qualifiedTrigger = (db.select(db.qualifiedTeam)
          ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);

    return MergeStream([groupTrigger, qualifiedTrigger])
        .debounceTime(const Duration(milliseconds: 120))
        .asyncMap((_) => getLeagueGroupsWithQualifiedTeams(
              leagueSyncId,
            ));
  }

  Future<void> upsertLeagueGroupsAndQualifiedTeamsFromRemote({
    required String leagueSyncId,
    required List<GroupModel> groupAndQulifiedTeam,
    bool clearExisting = true,
  }) async {
    await db.transaction(() async {
      final filtered = groupAndQulifiedTeam
          .where((g) => g.leagueSyncId == leagueSyncId)
          .toList();

      if (clearExisting) {
        await (db.delete(db.qualifiedTeam)
              ..where((q) => q.leagueSyncId.equals(leagueSyncId)))
            .go();
        await (db.delete(db.group)
              ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
            .go();
      }

      for (final g in filtered) {
        // --- Groups (tLeagueGroups) ---
        final groupSyncId = g.syncId ?? const Uuid().v7();

        await db.into(db.group).insert(
              GroupCompanion.insert(
                leagueSyncId: leagueSyncId,
                groupName: g.groupName,
                syncId: groupSyncId,
                qualifiedTeamNumber: Value(g.qualifiedTeamNumber),
                createdAt: g.createdAt != null
                    ? Value(g.createdAt!)
                    : const Value.absent(),
              ),
              mode: InsertMode.insertOrReplace,
            );

        // --- QualifiedTeams ---
        for (final qt in g.qualifiedTeams) {
          final qtSyncId = qt.syncId ?? const Uuid().v7();

          await db.into(db.qualifiedTeam).insert(
                QualifiedTeamCompanion.insert(
                  syncId: qtSyncId,
                  leagueSyncId: leagueSyncId,
                  groupSyncId:
                      qt.groupSyncId.isNotEmpty ? qt.groupSyncId : groupSyncId,
                  teamSyncId: qt.teamSyncId,
                  played: Value(qt.played),
                  wins: Value(qt.wins),
                  draws: Value(qt.draws),
                  losses: Value(qt.losses),
                  goalsFor: Value(qt.goalsFor),
                  goalsAgainst: Value(qt.goalsAgainst),
                  points: Value(qt.points),
                  qualificationType: Value(qt.qualificationType),
                  createdAt: qt.createdAt != null
                      ? Value(qt.createdAt!)
                      : const Value.absent(),
                  updatedAt: qt.updatedAt != null
                      ? Value(qt.updatedAt!)
                      : const Value.absent(),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }
    });
  }
}
