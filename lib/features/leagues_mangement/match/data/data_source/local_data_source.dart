import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../group/data/model/model.dart';
import '../../../match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import '../../../match_term_event/data/model/match_term_model.dart';
import '../model/match_model.dart';
import '../model/round_model.dart';
import '../service/match_round_service.dart' show MatchService;

class MatchesLocalDataSource {
  final Safirah db;
  final MatchService _matchService;

  MatchesLocalDataSource(this.db) : _matchService = const MatchService();

  Future<Unit> ensureGroupRounds({required int leagueId}) async {
    await db.transaction(() async {
      final groups = await (db.select(db.group)
            ..where((g) => g.leagueId.equals(leagueId)))
          .get();

      for (final g in groups) {
        final countRow = await (db.selectOnly(db.groupTeam)
              ..addColumns([db.groupTeam.id.count()])
              ..where(db.groupTeam.groupId.equals(g.id)))
            .getSingleOrNull();

        final teamCount = countRow?.read<int>(db.groupTeam.id.count()) ?? 0;
        final roundsNeeded = _matchService.calculateRoundsCount(teamCount);
        if (roundsNeeded == 0) continue;

        for (var r = 1; r <= roundsNeeded; r++) {
          final roundName = 'Group ${g.groupName} - Round $r';

          final exists = await (db.select(db.rounds)
                ..where((x) =>
                    x.leagueId.equals(leagueId) &
                    x.groupId.equals(g.id) &
                    x.name.equals(roundName)))
              .getSingleOrNull();

          if (exists == null) {
            await db.into(db.rounds).insert(
                  RoundsCompanion.insert(
                    leagueId: leagueId,
                    groupId: Value(g.id),
                    name: roundName,
                    roundType: 'group',
                  ),
                );
            // يمكن لاحقاً استبدال print بنظام logging إن أحببت
            print("✅ Created $roundName (group=${g.groupName})");
          }
        }
      }
    });
    return unit;
  }

  Future<Unit> scheduleGroupStageMatchesRR({
    required int leagueId,
    bool homeAway = false,
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    await db.transaction(() async {
      final groups = await (db.select(db.group)
            ..where((g) => g.leagueId.equals(leagueId)))
          .get();

      for (final g in groups) {
        final groupModel = GroupModel.fromEntity(g);

        // جلب فرق المجموعة
        final teamJoin = await (db.select(db.groupTeam).join([
          innerJoin(db.teams, db.teams.id.equalsExp(db.groupTeam.teamId)),
        ])
              ..where(db.groupTeam.groupId.equals(g.id))
              ..orderBy([OrderingTerm.asc(db.teams.id)]))
            .get();

        final ids = teamJoin.map((r) => r.readTable(db.teams).id).toList();
        if (ids.length < 2) continue;

        // استخدام MatchService لبناء المباريات منطقياً
        final logicalMatches = _matchService.buildGroupMatches(
          leagueId: leagueId,
          group: groupModel,
          teamIds: ids,
          homeAway: homeAway,
        );

        if (logicalMatches.isEmpty) continue;

        // توزيع المباريات على الجولات الموجودة (Round 1, Round 2, ...)
        // بالترتيب نفسه المستخدم في ensureGroupRounds.
        final rounds = await (db.select(db.rounds)
              ..where((r) =>
                  r.leagueId.equals(leagueId) & r.groupId.equals(g.id))
              ..orderBy([(r) => OrderingTerm.asc(r.id)]))
            .get();

        if (rounds.isEmpty) continue;

        // حساب عدد المباريات لكل جولة تقريبياً
        final roundsCount = rounds.length;
        var matchIndex = 0;

        for (var roundPos = 0; roundPos < roundsCount; roundPos++) {
          final round = rounds[roundPos];

          // عدد المباريات المفترض لهذه الجولة (تقسيم بسيط)
          final remainingMatches = logicalMatches.length - matchIndex;
          if (remainingMatches <= 0) break;

          final remainingRounds = roundsCount - roundPos;
          final takeCount = (remainingMatches / remainingRounds).ceil();

          final slice = logicalMatches
              .skip(matchIndex)
              .take(takeCount)
              .toList();
          matchIndex += slice.length;

          for (final m in slice) {
            // التحقق من وجود المباراة مسبقاً
            final exists = await (db.select(db.matches)
                  ..where((match) =>
                      match.leagueId.equals(leagueId) &
                      match.roundId.equals(round.id) &
                      ((match.homeTeamId.equals(m.homeTeamId!) &
                              match.awayTeamId.equals(m.awayTeamId!)) |
                          (match.homeTeamId.equals(m.awayTeamId!) &
                              match.awayTeamId.equals(m.homeTeamId!)))))
                .getSingleOrNull();

            if (exists != null) continue;

            final matchId = await db.into(db.matches).insert(
                  MatchesCompanion.insert(
                    leagueId: leagueId,
                    roundId: round.id,
                    homeTeamId: m.homeTeamId!,
                    awayTeamId: m.awayTeamId!,
                    matchDate: m.matchDate ?? DateTime.now(),
                    homeScore: Value(m.homeScore),
                    awayScore: Value(m.awayScore),
                    status: Value(m.status),
                  ),
                );

            print(
                "✅ Inserted match: ${m.homeTeamId} vs ${m.awayTeamId} in ${round.name}");

            await matchTermLocal.createMatchTermsFromLeague(
              matchId: matchId,
              leagueId: leagueId,
            );
          }
        }
      }
    });
    return unit;
  }

  Future<List<RoundModel>> getLeagueRoundsWithGroupsAndMatches(
      int leagueId,
      String matchFilter, // مثال: 'scheduled' أو 'scheduled,live' أو 'all'
      ) async {
    final homeAlias = db.alias(db.teams, 'home');
    final awayAlias = db.alias(db.teams, 'away');

    // 1️⃣ جلب كل الجولات الخاصة بالدوري
    final rounds = await (db.select(db.rounds)
      ..where((r) => r.leagueId.equals(leagueId))
      ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();

    if (rounds.isEmpty) {
      print('⚠️ لا توجد جولات لهذا الدوري ($leagueId)');
      return [];
    }

    // 2️⃣ استخراج أرقام الجولات
    final roundNumbers = rounds
        .map((r) {
      final match = RegExp(r'(\d+)$').firstMatch(r.name);
      return match != null ? int.tryParse(match.group(1)!) : null;
    })
        .whereType<int>()
        .toSet()
        .toList()
      ..sort();

    final List<RoundModel> result = [];

    // 3️⃣ تحليل matchFilter إلى قائمة من الحالات
    final filtersList = matchFilter
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final bool showAll = filtersList.contains('all') || filtersList.isEmpty;

    // 4️⃣ حلقة على كل رقم جولة
    for (final roundNo in roundNumbers) {
      final relatedRounds =
      rounds.where((r) => r.name.endsWith('Round $roundNo')).toList();
      if (relatedRounds.isEmpty) continue;

      final List<GroupModel> groupsForThisRound = [];

      for (final round in relatedRounds) {
        if (round.groupId == null) continue;
        // 🔹 جلب المجموعة
        final group = await (db.select(db.group)
          ..where((g) => g.id.equals(round.groupId!)))
            .getSingleOrNull();
        if (group == null) continue;

        // 🔹 جلب المباريات مع الفرق
        final query = db.select(db.matches).join([
          innerJoin(homeAlias, homeAlias.id.equalsExp(db.matches.homeTeamId)),
          innerJoin(awayAlias, awayAlias.id.equalsExp(db.matches.awayTeamId)),
        ]);

        final filters = <Expression<bool>>[
          db.matches.roundId.equals(round.id),
          db.matches.leagueId.equals(leagueId),
        ];

        // 🧩 تحديد حالات المباريات المطلوبة
        if (!showAll) {
          final statusExpressions = <Expression<bool>>[];

          for (final status in filtersList) {
            switch (status) {
              case 'scheduled':
                statusExpressions.add(db.matches.status.equals('scheduled'));
                break;
              case 'unscheduled':
                statusExpressions.add(db.matches.status.equals('unscheduled'));
                break;
              case 'live':
                statusExpressions.add(db.matches.status.equals('live'));
                break;
              case 'finished':
                statusExpressions.add(db.matches.status.equals('finished'));
                break;
            }
          }

          if (statusExpressions.isNotEmpty) {
            // 🧠 نربطها بـ OR حتى نحصل على أكثر من حالة
            final combined = statusExpressions.reduce((a, b) => a | b);
            filters.add(combined);
          }
        }

        query.where(filters.reduce((a, b) => a & b));

        final joined = await query.get();

        // 🔹 تحويل النتائج إلى MatchModel
        final matches = await Future.wait(joined.map((row) async {
          final match = row.readTable(db.matches);
          final home = row.readTable(homeAlias);
          final away = row.readTable(awayAlias);
          var matchTermsQuery = db.select(db.matchTerms)
            ..where((mt) => mt.matchId.equals(match.id));
          final matchTerms = await matchTermsQuery.get();

          final matchTermModels =
          matchTerms.map((mt) => MatchTermModel.fromEntity(mt)).toList();
          return MatchModel.fromEntityWithRelations(
            match,
            home: home,
            away: away,
            matchTerms: matchTermModels,
          );
        }));

        print(
            '✅ ${round.name} - Group ${group.groupName} => matches: ${matches.length}');

        if (matches.isEmpty) continue;

        groupsForThisRound
            .add(GroupModel.fromEntity(group).copyWith(matches: matches));
      }

      if (groupsForThisRound.any((g) => g.matches.isNotEmpty)) {
        final roundEntity = relatedRounds.first;
        final roundModel = RoundModel.fromEntity(roundEntity).copyWith(
          roundName: 'Round $roundNo',
          groups: groupsForThisRound,
        );
        result.add(roundModel);
      }
    }

    print('📊 Total rounds with groups: ${result.length}');
    return result;
  }
  Future<int> scheduleMatch({
    required int matchId,
    required DateTime scheduledDateTime,
  }) async {
    return await (db.update(db.matches)..where((m) => m.id.equals(matchId)))
        .write(
      MatchesCompanion(
        status: const Value('scheduled'),
        matchDate: Value(scheduledDateTime), // ← لتخزين اليوم أيضًا
        scheduledStartTime: Value(scheduledDateTime), // ← لتخزين الوقت المحدد
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
  // dart
  Future<int> updateScheduleMatch({required MatchModel match}) async {
    if (match.id == null) {
      throw ArgumentError('match.id must not be null');
    }

    return await (db.update(db.matches)..where((m) => m.id.equals(match.id!))).write(
      MatchesCompanion(
        status: Value(match.status),
        matchDate: Value(match.matchDate ?? DateTime.now()),
        scheduledStartTime: Value(match.scheduledStartTime ?? match.matchDate ?? DateTime.now()),
        homeScore: Value(match.homeScore),
        awayScore: Value(match.awayScore),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
  
}
