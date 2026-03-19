import 'dart:async';

import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/database/safirah_database.dart';
import '../../../../group/data/model/model.dart';
import '../../../../match/data/model/match_model.dart';
import '../../../../match/data/model/round_model.dart';
import '../../../../team_and_player/data/model/team_model.dart';
import '../../model/match_term_model.dart';
import '../../service/knockout_generator_service.dart';
import 'local_term_data_source.dart';

class KnockoutGeneratorLocalDataSource {
  final Safirah db;
  final KnockoutGeneratorService _service;

  KnockoutGeneratorLocalDataSource(this.db)
      : _service = const KnockoutGeneratorService();

  // ---------------------------------------------------------------------------
  // GROUP => Generate first KO
  // ---------------------------------------------------------------------------

  Future<RoundModel>  generateKnockoutFromGroups({
    required String leagueSyncId,
    required int qualifiedPerGroup, // غير مستخدمة الآن بناءً على طلبك
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    int _goalDiff(QualifiedTeamModel t) => t.goalsFor - t.goalsAgainst;

    Future<Map<String, num>> _computeHeadToHeadPointsForGroup({
      required String groupSyncId,
      required Set<String> teamSyncIds,
      int winPoints = 3,
      int drawPoints = 1,
    }) async {
      if (teamSyncIds.length < 2) return const {};

      final points = <String, num>{for (final id in teamSyncIds) id: 0};

      // matches JOIN rounds to filter group matches
      final rows = await (db.select(db.matches).join([
        innerJoin(
          db.rounds,
          db.rounds.syncId.equalsExp(db.matches.roundSyncId),
        ),
      ])
        ..where(db.matches.leagueSyncId.equals(leagueSyncId))
        ..where(db.rounds.groupSyncId.equals(groupSyncId))
        ..where(db.matches.status.equals('finished'))
        ..where(db.matches.homeTeamSyncId.isIn(teamSyncIds.toList()))
        ..where(db.matches.awayTeamSyncId.isIn(teamSyncIds.toList())))
          .get();

      for (final row in rows) {
        final m = row.readTable(db.matches);
        final home = m.homeTeamSyncId;
        final away = m.awayTeamSyncId;

        if (!teamSyncIds.contains(home) || !teamSyncIds.contains(away)) continue;

        final hs = m.homeScore;
        final as = m.awayScore;

        if (hs > as) {
          points[home] = (points[home] ?? 0) + winPoints;
        } else if (as > hs) {
          points[away] = (points[away] ?? 0) + winPoints;
        } else {
          points[home] = (points[home] ?? 0) + drawPoints;
          points[away] = (points[away] ?? 0) + drawPoints;
        }
      }

      return points;
    }

    List<QualifiedTeamModel> _applyH2HTieBreaker({
      required List<QualifiedTeamModel> input,
      required Map<String, num> h2hPoints,
    }) {
      final list = List<QualifiedTeamModel>.from(input);

      list.sort((a, b) {
        // 1) points desc
        final p = b.points.compareTo(a.points);
        if (p != 0) return p;

        // 2) goal diff desc
        final gd = _goalDiff(b).compareTo(_goalDiff(a));
        if (gd != 0) return gd;

        // 3) head-to-head desc (after goal diff)
        final aH = h2hPoints[a.teamSyncId] ?? 0;
        final bH = h2hPoints[b.teamSyncId] ?? 0;
        final h = bH.compareTo(aH);
        if (h != 0) return h;

        // 4) goals for desc
        final gf = b.goalsFor.compareTo(a.goalsFor);
        if (gf != 0) return gf;

        // 5) stable last tie (avoid random ordering)
        return a.teamSyncId.compareTo(b.teamSyncId);
      });

      return list;
    }

    List<QualifiedTeamModel> _resolveTiesWithH2HForCut({
      required List<QualifiedTeamModel> sortedBase,
      required int cut,
      required Map<String, num> h2hPoints,
    }) {
      if (sortedBase.isEmpty || cut <= 0) return const [];
      if (sortedBase.length <= cut) return sortedBase;

      // Identify "tie block" intersecting the cut boundary
      final boundary = sortedBase[cut - 1];
      final boundaryPoints = boundary.points;
      final boundaryDiff = _goalDiff(boundary);

      int start = cut - 1;
      while (start - 1 >= 0) {
        final t = sortedBase[start - 1];
        if (t.points == boundaryPoints && _goalDiff(t) == boundaryDiff) {
          start--;
        } else {
          break;
        }
      }

      int end = cut - 1;
      while (end + 1 < sortedBase.length) {
        final t = sortedBase[end + 1];
        if (t.points == boundaryPoints && _goalDiff(t) == boundaryDiff) {
          end++;
        } else {
          break;
        }
      }

      // If no tie block spanning boundary, simple take
      if (start == end) return sortedBase.take(cut).toList();

      final before = sortedBase.sublist(0, start);
      final block = sortedBase.sublist(start, end + 1);
      final after = sortedBase.sublist(end + 1);

      final reSortedBlock = _applyH2HTieBreaker(input: block, h2hPoints: h2hPoints);

      final merged = <QualifiedTeamModel>[
        ...before,
        ...reSortedBlock,
        ...after,
      ];

      return merged.take(cut).toList();
    }

    return db.transaction<RoundModel>(() async {
      // ✅ Idempotency guard: إذا وُجدت جولة Knockout بالفعل لهذا الدوري، أرجعها بدل إنشاء جديد
      final existingRound = await (db.select(db.rounds)
            ..where((r) => r.leagueSyncId.equals(leagueSyncId) & r.roundType.equals('knockout'))
            ..orderBy([(r) => OrderingTerm.asc(r.createdAt)])
            ..limit(1))
          .getSingleOrNull();

      if (existingRound != null) {
        final matchEntities = await (db.select(db.matches)
              ..where((m) => m.roundSyncId.equals(existingRound.syncId))
              ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
            .get();

        final matches = <MatchModel>[];
        for (final m in matchEntities) {
          final matchTermsEnt = await (db.select(db.matchTerms)
                ..where((mt) => mt.matchSyncId.equals(m.syncId)))
              .get();

          final terms = matchTermsEnt.map((mt) => MatchTermModel.fromEntity(mt)).toList();

          matches.add(
            MatchModel.fromEntityWithRelations(
              m,
              home: null,
              away: null,
              matchTerms: terms,
            ),
          );
        }

        return RoundModel(
          syncId: existingRound.syncId,
          leagueSyncId: existingRound.leagueSyncId,
          roundName: existingRound.name,
          roundType: existingRound.roundType,
          groups: const [],
          matches: matches,
        );
      }

      // 1) Ensure no scheduled/live matches
      final unfinished = await (db.select(db.matches)
            ..where((m) => m.leagueSyncId.equals(leagueSyncId) & (m.status.equals('scheduled') | m.status.equals('live'))))
          .get();
      if (unfinished.isNotEmpty) {
        throw Exception('⚠️ لا يمكن إنشاء التصفيات، بعض المباريات لم تنته بعد.');
      }

      // 2) جلب المجموعات
      final groupRows = await (db.select(db.group)
            ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
          .get();
      if (groupRows.isEmpty) {
        throw Exception('❌ لا توجد مجموعات لهذا الدوري ($leagueSyncId)');
      }
      final groups = groupRows.map(GroupModel.fromEntity).toList();

      // 3) المتأهلين لكل مجموعة
      final Map<int, List<QualifiedTeamModel>> groupQualified = {};

      for (final g in groupRows) {
        final limit = g.qualifiedTeamNumber;
        if (limit <= 0) {
          groupQualified[g.id] = const [];
          continue;
        }

        final qualifiedRows = await (db.select(db.qualifiedTeam)
          ..where((q) => q.groupSyncId.equals(g.syncId) & q.leagueSyncId.equals(leagueSyncId))
          ..orderBy([
                (r) => OrderingTerm.desc(r.points),
                (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
                (r) => OrderingTerm.desc(r.goalsFor),
                (r) => OrderingTerm.desc(r.wins),
                (r) => OrderingTerm.asc(r.losses),
          ]))
            .get();

        // Enrich with team names
        final enriched = <QualifiedTeamModel>[];
        for (final r in qualifiedRows) {
          final teamEnt = await (db.select(db.teams)..where((t) => t.syncId.equals(r.teamSyncId))).getSingleOrNull();
          if (teamEnt == null) continue;

          enriched.add(QualifiedTeamModel(
            teamName: teamEnt.teamName,
            groupSyncId: g.syncId,
            teamSyncId: teamEnt.syncId,
            leagueSyncId: leagueSyncId,
            points: r.points,
            goalsFor: r.goalsFor,
            goalsAgainst: r.goalsAgainst,
            wins: r.wins,
            losses: r.losses,
          ));
        }

        if (enriched.isEmpty) {
          groupQualified[g.id] = const [];
          continue;
        }

        // Base sort (points, goal diff, goalsFor, wins, losses)
        final baseSorted = List<QualifiedTeamModel>.from(enriched)
          ..sort((a, b) {
            final p = b.points.compareTo(a.points);
            if (p != 0) return p;

            final gd = _goalDiff(b).compareTo(_goalDiff(a));
            if (gd != 0) return gd;

            final gf = b.goalsFor.compareTo(a.goalsFor);
            if (gf != 0) return gf;

            final w = b.wins.compareTo(a.wins);
            if (w != 0) return w;

            final l = a.losses.compareTo(b.losses);
            if (l != 0) return l;

            return a.teamSyncId.compareTo(b.teamSyncId);
          });

        // Compute H2H only for teams that might affect the cut boundary:
        final cut = limit.clamp(0, baseSorted.length);
        final boundaryCandidates = baseSorted.take((cut + 6).clamp(1, baseSorted.length)).toList();
        final teamSet = boundaryCandidates.map((e) => e.teamSyncId).toSet();

        final h2hPoints = await _computeHeadToHeadPointsForGroup(
          groupSyncId: g.syncId,
          teamSyncIds: teamSet,
        );

        // Apply H2H ONLY for tie blocks at the cut boundary (after goal diff)
        final finalSelected = _resolveTiesWithH2HForCut(
          sortedBase: baseSorted,
          cut: cut,
          h2hPoints: h2hPoints,
        );

        groupQualified[g.id] = finalSelected;
      }

      // 4) بناء مباريات التصفيات منطقياً عبر الخدمة
      final logicalMatches = _service.buildKnockoutMatchesFromGroups(
        leagueSyncId: leagueSyncId,
        groups: groups,
        groupQualified: groupQualified,
        homeAway: homeAway,
        seed: seed,
      );
      if (logicalMatches.isEmpty) {
        throw Exception('⚠️ لا توجد فرق متأهلة بعد من المجموعات.');
      }

      // 5) اسم الجولة
      final roundName = _service.roundNameForCount(logicalMatches.length, roundNamePrefix);

      // 6) حفظ الجولة والمباريات + terms
      final roundSyncId = const Uuid().v7();

      final roundId = await db.into(db.rounds).insert(
        RoundsCompanion.insert(
          syncId: roundSyncId,
          leagueSyncId: leagueSyncId,
          name: roundName,
          roundType: 'knockout',
          groupSyncId: const Value.absent(),
        ),
      );

      final insertedMatches = <MatchModel>[];

      for (final m in logicalMatches) {
        final homeTid = m.homeTeamSyncId;
        final awayTid = m.awayTeamSyncId;
        if (homeTid == null || awayTid == null) continue;

        final matchRow = await db.into(db.matches).insertReturning(
          MatchesCompanion.insert(
            syncId: const Uuid().v7(),
            leagueSyncId: m.leagueSyncId ?? leagueSyncId,
            roundSyncId: roundSyncId,
            homeTeamSyncId: homeTid,
            awayTeamSyncId: awayTid,
            matchDate: m.matchDate ?? DateTime.now(),
            status: Value(m.status),
            homeScore: Value(m.homeScore),
            awayScore: Value(m.awayScore),
          ),
        );

        final terms = await matchTermLocal.createMatchTermsFromLeague(
          matchSyncId: matchRow.syncId,
          leagueSyncId: leagueSyncId,
          roundType: 'knockout',
        );

        insertedMatches.add(
          m.copyWith(
            roundSyncId: roundSyncId,
            syncId: matchRow.syncId,
            matchTerms: terms,
          ),
        );
      }

      return RoundModel(
        id: roundId,
        syncId: roundSyncId,
        leagueSyncId: leagueSyncId,
        roundName: roundName,
        roundType: 'knockout',
        groups: const [],
        matches: insertedMatches,
      );
    });
  }

  Future<RoundModel?> createNextKnockoutRoundFromFinished({
    required String leagueSyncId,
    required String finishedRoundSyncId,
    String pairingStrategy = 'seeded',
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    bool isFinished(String s) => s.toLowerCase().trim() == 'finished';

    return db.transaction<RoundModel?>(() async {
      final finishedRoundEntity = await (db.select(db.rounds)
        ..where((r) => r.syncId.equals(finishedRoundSyncId)))
          .getSingleOrNull();

      if (finishedRoundEntity == null) return null;

      // 1) matches of finished round
      final matchEntities = await (db.select(db.matches)
        ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
          .get();

      if (matchEntities.isEmpty) return null;

      if (matchEntities.any((m) => !isFinished(m.status))) {
        throw Exception('⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
      }

      // 2) teams by syncId (for validation)
      final teamSyncIds = <String>{
        for (final m in matchEntities) m.homeTeamSyncId,
        for (final m in matchEntities) m.awayTeamSyncId,
      };

      final teamRows = await (db.select(db.teams)
        ..where((t) => t.syncId.isIn(teamSyncIds.toList())))
          .get();

      final teamsBySyncId = <String, TeamModel>{
        for (final t in teamRows) t.syncId: TeamModel.fromEntity(t),
      };

      // safety: ensure all teams exist
      if (teamsBySyncId.length != teamSyncIds.length) {
        throw Exception('⚠️ بعض الفرق غير موجود محليًا (teams rows mismatch).');
      }

      // 3) convert matches to models (sync-based)
      final finishedMatches = matchEntities
          .map((m) => MatchModel.fromEntityWithRelations(
        m,
        home: null,
        away: null,
        matchTerms: const <MatchTermModel>[],
      ))
          .toList();

      // 4) build next logical matches (THIS was returning empty before)
      final logicalMatches = _service.buildNextKnockoutMatches(
        leagueSyncId: leagueSyncId,
        finishedMatches: finishedMatches,
        teamsBySyncId: teamsBySyncId,
        pairingStrategy: pairingStrategy,
        homeAway: homeAway,
        seed: seed,
      );

      if (logicalMatches.isEmpty) return null;

      // 5) next round name + create round
      final nextRoundName =
      _service.roundNameForCount(logicalMatches.length, roundNamePrefix);

      final nextRoundSyncId = const Uuid().v7();

      final nextRoundId = await db.into(db.rounds).insert(
        RoundsCompanion.insert(
          syncId: nextRoundSyncId,
          leagueSyncId: leagueSyncId,
          name: nextRoundName,
          roundType: 'knockout',
          groupSyncId: const Value.absent(),
        ),
      );

      // 6) insert matches + terms
      final insertedMatches = <MatchModel>[];

      for (final match in logicalMatches) {
        final homeSync = (match.homeTeamSyncId ?? '').trim();
        final awaySync = (match.awayTeamSyncId ?? '').trim();

        // جدولك يمنع null و يمنع home==away
        if (homeSync.isEmpty || awaySync.isEmpty) continue;
        if (homeSync == awaySync) continue;

        final inserted = await db.into(db.matches).insertReturning(
          MatchesCompanion.insert(
            syncId: const Uuid().v7(),
            leagueSyncId: (match.leagueSyncId ?? leagueSyncId).trim(),
            roundSyncId: nextRoundSyncId,
            homeTeamSyncId: homeSync,
            awayTeamSyncId: awaySync,
            matchDate: match.matchDate ?? DateTime.now(),
            status: Value(match.status),
            homeScore: Value(match.homeScore),
            awayScore: Value(match.awayScore),
          ),
        );

        final termsMatch = await matchTermLocal.createMatchTermsFromLeague(
          matchSyncId: inserted.syncId,
          leagueSyncId: leagueSyncId,
          roundType: 'knockout',
        );

        insertedMatches.add(
          MatchModel.fromEntityWithRelations(
            inserted,
            home: null,
            away: null,
            matchTerms: termsMatch,
          ),
        );
      }

      return RoundModel(
        id: nextRoundId,
        syncId: nextRoundSyncId,
        leagueSyncId: leagueSyncId,
        roundName: nextRoundName,
        roundType: 'knockout',
        matches: insertedMatches,
        groups: const [],
      );
    });
  }
  // ---------------------------------------------------------------------------
  // Queries & watchers
  // ---------------------------------------------------------------------------
  Future<bool> areAllGroupMatchesFinished(String leagueSyncId) async {
    final groupMatches = await (db.select(db.matches).join([
      innerJoin(db.rounds, db.rounds.syncId.equalsExp(db.matches.roundSyncId)),
    ])
      ..where(db.rounds.leagueSyncId.equals(leagueSyncId))
      ..where(db.rounds.groupSyncId.isNotNull()))
        .get()
        .then((rows) => rows.map((row) => row.readTable(db.matches)).toList());

    if (groupMatches.isEmpty) return false;

    const unfinishedStatuses = {
      'scheduled',
      'unscheduled',
      'live',
      'pending',
      'in_progress',
    };

    return groupMatches.every((m) {
      final s = m.status.toLowerCase().trim();
      return !unfinishedStatuses.contains(s);
    });
  }

  Future<RoundModel?> getCurrentLeagueRound(String leagueSyncId) async {
    final rounds = await (db.select(db.rounds)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId))
      ..orderBy([(r) => OrderingTerm.asc(r.createdAt)]))
        .get();

    if (rounds.isEmpty) return null;
    return RoundModel.fromEntity(rounds.last);
  }

  Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
    required String leagueSyncId,
    required String matchFilter,
  }) {
    final roundsTrigger = (db.select(db.rounds)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);

    final matchesTrigger = (db.select(db.matches)
      ..where((m) => m.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);

    return MergeStream([roundsTrigger, matchesTrigger])
        .debounceTime(const Duration(milliseconds: 120))
        .asyncMap((_) => getAllKnockoutRoundsWithMatches(leagueSyncId, matchFilter));
  }

  Future<List<RoundModel>> getAllKnockoutRoundsWithMatches(
      String leagueSyncId,
      String matchFilter,
      ) async {
    final homeAlias = db.alias(db.teams, 'home');
    final awayAlias = db.alias(db.teams, 'away');

    final roundEntities = await (db.select(db.rounds)
      ..where((r) =>
      r.leagueSyncId.equals(leagueSyncId) &
      r.roundType.equals('knockout')))
        .get();

    final List<RoundModel> rounds = [];
    final filtersList = matchFilter
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final bool showAll = filtersList.contains('all') || filtersList.isEmpty;

    for (final r in roundEntities) {
      final query = db.select(db.matches).join([
        innerJoin(homeAlias, homeAlias.syncId.equalsExp(db.matches.homeTeamSyncId)),
        innerJoin(awayAlias, awayAlias.syncId.equalsExp(db.matches.awayTeamSyncId)),
      ]);

      final filters = <Expression<bool>>[
        db.matches.roundSyncId.equals(r.syncId),
        db.matches.leagueSyncId.equals(leagueSyncId),
      ];

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
          filters.add(statusExpressions.reduce((a, b) => a | b));
        }
      }

      query.where(filters.reduce((a, b) => a & b));
      final joined = await query.get();

      final matches = await Future.wait(joined.map((row) async {
        final match = row.readTable(db.matches);
        final home = row.readTable(homeAlias);
        final away = row.readTable(awayAlias);

        final matchTerms = await (db.select(db.matchTerms)
          ..where((mt) => mt.matchSyncId.equals(match.syncId)))
            .get();

        final matchTermModels =
        matchTerms.map((mt) => MatchTermModel.fromEntity(mt)).toList();

        return MatchModel.fromEntityWithRelations(
          match,
          home: home,
          away: away,
          matchTerms: matchTermModels,
        );
      }));

      rounds.add(RoundModel(
        syncId: r.syncId,
        groupSyncId: r.groupSyncId,
        leagueSyncId: r.leagueSyncId,
        roundName: r.name,
        roundType: r.roundType,
        createdAt: r.createdAt,
        matches: matches,
      ));
    }

    return rounds;
  }

  Future<RoundModel?> checkAndCreateNextKnockoutRoundIfNeeded(
    String leagueSyncId,
    String finishedRoundSyncId,
  ) async {
    final finishedRoundEntity = await (db.select(db.rounds)
          ..where((r) => r.syncId.equals(finishedRoundSyncId)))
        .getSingleOrNull();

    if (finishedRoundEntity == null) return null;

    final matches = await (db.select(db.matches)
          ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
        .get();

    if (matches.isEmpty) return null;
    if (matches.any((m) => m.status != 'finished')) return null;

    final finishedCount = matches.length;

    // ✅ Extra idempotency: if any knockout round exists with fewer matches,
    // the next round was already created.
    final knockoutRounds = await (db.select(db.rounds)
          ..where((r) =>
              r.leagueSyncId.equals(leagueSyncId) &
              r.roundType.equals('knockout')))
        .get();

    for (final r in knockoutRounds) {
      if (r.syncId == finishedRoundSyncId) continue;
      final otherMatches = await (db.select(db.matches)
            ..where((m) => m.roundSyncId.equals(r.syncId)))
          .get();
      if (otherMatches.isEmpty) continue;
      if (otherMatches.length < finishedCount) return null;
    }

    // ...keep existing createdAt-based guard (optional) or remove it...
    final existingNext = await (db.select(db.rounds)
          ..where((r) => r.leagueSyncId.equals(leagueSyncId))
          ..where((r) => r.roundType.equals('knockout'))
          ..where((r) =>
              r.createdAt.isBiggerThanValue(finishedRoundEntity.createdAt))
          ..orderBy([(r) => OrderingTerm.asc(r.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (existingNext != null) return null;

    return await createNextKnockoutRoundFromFinished(
      leagueSyncId: leagueSyncId,
      finishedRoundSyncId: finishedRoundSyncId,
    );
  }

  Future<void> upsertRoundsWithMatchesLocal(
    List<RoundModel> apiRounds,
  ) async {
    if (apiRounds.isEmpty) return;

    final rounds = apiRounds
        .where((r) => (r.syncId ?? '').trim().isNotEmpty)
        .toList();
    if (rounds.isEmpty) return;

    // (A) Identify rounds that actually included a matches payload (even if empty)
    final roundsWithMatchesPayload = <String, List<MatchModel>>{};
    for (final r in rounds) {
      final roundSyncId = (r.syncId ?? '').trim();
      if (roundSyncId.isEmpty) continue;
      if (r.matches != null) {
        roundsWithMatchesPayload[roundSyncId] = r.matches ?? const <MatchModel>[];
      }
    }

    // (B) Prepare batch upserts + sync-delete inputs
    final roundsToUpsert = <RoundsCompanion>[];
    final matchesToUpsert = <MatchesCompanion>[];

    // incoming match ids per round (for sync delete)
    final incomingMatchIdsByRound = <String, Set<String>>{};

    // matchTerms payloads prepared for upsert + incoming term ids per match
    final matchTermsToUpsert = <MatchTermsCompanion>[];
    final incomingTermIdsByMatch = <String, Set<String>>{};

    for (final r in rounds) {
      final roundSyncId = (r.syncId ?? '').trim();
      if (roundSyncId.isEmpty) continue;

      roundsToUpsert.add(
        RoundsCompanion.insert(
          syncId: roundSyncId,
          leagueSyncId: (r.leagueSyncId ?? '').trim(),
          name: (r.roundName ?? '').trim(),
          roundType: (r.roundType ?? '').trim(),
          groupSyncId: const Value.absent(),
        ),
      );

      final matchesProvided = roundsWithMatchesPayload.containsKey(roundSyncId);
      if (!matchesProvided) continue;

      final matches = roundsWithMatchesPayload[roundSyncId]!;
      final incomingMatchIds = <String>{};

      for (final m in matches) {
        final matchSyncId = (m.syncId ?? '').trim();
        if (matchSyncId.isNotEmpty) incomingMatchIds.add(matchSyncId);

        final homeId = (m.homeTeamSyncId ?? '').trim();
        final awayId = (m.awayTeamSyncId ?? '').trim();

        // Ignore invalid matches (missing teams)
        if (homeId.isEmpty || awayId.isEmpty) continue;

        // Ensure foreign keys are present
        final leagueId = (m.leagueSyncId ?? r.leagueSyncId ?? '').trim();
        if (leagueId.isEmpty) continue;

        matchesToUpsert.add(
          MatchesCompanion(
            syncId: Value(matchSyncId.isNotEmpty ? matchSyncId : const Uuid().v7()),
            leagueSyncId: Value(leagueId),
            roundSyncId: Value(((m.roundSyncId ?? '').trim().isNotEmpty)
                ? (m.roundSyncId ?? '').trim()
                : roundSyncId),
            homeTeamSyncId: Value(homeId),
            awayTeamSyncId: Value(awayId),
            matchDate: Value(m.matchDate ?? DateTime.now()),
            status: Value((m.status).trim()),
            homeScore: Value(m.homeScore),
            awayScore: Value(m.awayScore),
            updatedAt: Value(DateTime.now()),
          ),
        );

        // --- Match Terms (أشواط المباراة) ---
        // Only sync terms if API actually sent them.
        final terms = m.matchTerms;
        if (terms == null) continue;

        final effectiveMatchSyncId = matchSyncId.isNotEmpty ? matchSyncId : '';
        // If match has no syncId, we can't reliably sync terms.
        if (effectiveMatchSyncId.isEmpty) continue;

        final incomingTermIds = <String>{};
        for (final t in terms) {
          final termSync = (t.syncId).trim();
          if (termSync.isNotEmpty) incomingTermIds.add(termSync);

          final leagueTermSyncId = (t.leagueTermSyncId).trim();
          if (leagueTermSyncId.isEmpty) continue;

          matchTermsToUpsert.add(
            MatchTermsCompanion.insert(
              syncId: termSync.isNotEmpty ? termSync : const Uuid().v7(),
              matchSyncId: effectiveMatchSyncId,
              leagueTermSyncId: leagueTermSyncId,
              startTime: Value(t.startTime),
              endTime: Value(t.endTime),
              additionalMinutes: Value(t.additionalMinutes),
              isFinished: Value(t.isFinished),
            ),
          );
        }

        incomingTermIdsByMatch[effectiveMatchSyncId] = incomingTermIds;
      }

      incomingMatchIdsByRound[roundSyncId] = incomingMatchIds;
    }

    await db.transaction(() async {
      // 1) Upsert rounds (Drift-native)
      if (roundsToUpsert.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAllOnConflictUpdate(db.rounds, roundsToUpsert);
        });
      }

      // 2) Sync-delete matches for rounds that included matches payload
      for (final entry in incomingMatchIdsByRound.entries) {
        final roundSyncId = entry.key;
        final incomingMatchIds = entry.value;

        if (incomingMatchIds.isEmpty) {
          await (db.delete(db.matches)
                ..where((t) => t.roundSyncId.equals(roundSyncId)))
              .go();
          continue;
        }

        await (db.delete(db.matches)
              ..where((t) => t.roundSyncId.equals(roundSyncId))
              ..where((t) => t.syncId.isNotIn(incomingMatchIds.toList())))
            .go();
      }

      // 3) Upsert matches
      if (matchesToUpsert.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAllOnConflictUpdate(db.matches, matchesToUpsert);
        });
      }

      // 4) Sync-delete matchTerms only for matches that included terms payload
      for (final entry in incomingTermIdsByMatch.entries) {
        final matchSyncId = entry.key;
        final incomingTermIds = entry.value;

        if (incomingTermIds.isEmpty) {
          await (db.delete(db.matchTerms)
                ..where((t) => t.matchSyncId.equals(matchSyncId)))
              .go();
          continue;
        }

        await (db.delete(db.matchTerms)
              ..where((t) => t.matchSyncId.equals(matchSyncId))
              ..where((t) => t.syncId.isNotIn(incomingTermIds.toList())))
            .go();
      }

      // 5) Upsert matchTerms
      if (matchTermsToUpsert.isNotEmpty) {
        // Drift's insertAllOnConflictUpdate updates on PRIMARY KEY (id),
        // بينما جدول match_terms يعتبر sync_id هو الـ unique key.
        // لذلك نستخدم insertOrReplace على rows بعد إزالة التكرارات.

        final dedup = <String, MatchTermsCompanion>{};
        for (final c in matchTermsToUpsert) {
          final sid = c.syncId.value;
          // آخر واحد يكسب (أحدث payload)
          dedup[sid] = c;
        }

        await db.batch((batch) {
          batch.insertAll(
            db.matchTerms,
            dedup.values.toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }
    });
  }

  Future<bool> hasAnyKnockoutRound(String leagueSyncId) async {
    final row = await (db.select(db.rounds)
      ..where((r) =>
      r.leagueSyncId.equals(leagueSyncId) &
      r.roundType.equals('knockout'))
      ..limit(1))
        .getSingleOrNull();

    return row != null;
  }

  /// يمنع الإنشاء إذا:
  /// - يوجد بالفعل knockout
  /// - أو مباريات group لم تنته
  Future<bool> shouldGenerateFirstKnockout(String leagueSyncId) async {
    if (await hasAnyKnockoutRound(leagueSyncId)) return false;
    return await areAllGroupMatchesFinished(leagueSyncId);
  }
// -------- Locks: First Knockout (مرة لكل League) --------
  Future<bool> _isFirstKnockoutLocked(String leagueSyncId) async {

    final row = await (db.select(db.leagueKnockoutFlags)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .getSingleOrNull();
    return row?.firstKnockoutCreated ?? false;

  }

  Future<void> _lockFirstKnockout(String leagueSyncId) async {
    await db.into(db.leagueKnockoutFlags).insertOnConflictUpdate(
      LeagueKnockoutFlagsCompanion(
        leagueSyncId: Value(leagueSyncId),
        firstKnockoutCreated: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

// -------- Locks: Next Knockout (مرة لكل finishedRoundSyncId) --------
  Future<bool> _hasNextLock({
    required String leagueSyncId,
    required String finishedRoundSyncId,
  }) async {
    final row = await (db.select(db.knockoutProgressLocks)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId))
      ..where((t) => t.finishedRoundSyncId.equals(finishedRoundSyncId)))
        .getSingleOrNull();
    return row != null;
  }

  Future<void> _addNextLock({
    required String leagueSyncId,
    required String finishedRoundSyncId,
  }) async {
    await db.into(db.knockoutProgressLocks).insert(
      KnockoutProgressLocksCompanion(
        leagueSyncId: Value(leagueSyncId),
        finishedRoundSyncId: Value(finishedRoundSyncId),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }
  Future<RoundModel?> ensureKnockoutProgress({
    required String leagueSyncId,
    required int qualifiedPerGroup,
  }) async {
    RoundModel? result;

    await db.transaction(() async {
      // 1) تحديد المرحلة الحالية (آخر round)
      final current = await getCurrentLeagueRound(leagueSyncId);
      if (current == null) {
        result = null;
        return;
      }

      // الافتراضي: ما في إنشاء -> رجّع الجولة الحالية
      result = current;

      // =========================
      // GROUP => Generate First KO
      // =========================
      if (current.roundType == 'group') {
        final should = await shouldGenerateFirstKnockout(leagueSyncId);
        if (!should) return;

        // lock لمنع التكرار (مرة لكل league)
        final locked = await _isFirstKnockoutLocked(leagueSyncId);
        if (locked) return;

        final firstKnockoutRound = await generateKnockoutFromGroups(
          leagueSyncId: leagueSyncId,
          qualifiedPerGroup: qualifiedPerGroup,
        );

        await _lockFirstKnockout(leagueSyncId);
        result = firstKnockoutRound;
        return;
      }

      // =========================
      // KNOCKOUT => Generate Next KO (ممكن أكثر من جولة)
      // =========================
      const int maxSteps = 10; // أمان ضد أي loop غير متوقع
      for (var step = 0; step < maxSteps; step++) {
        final finishedRoundSyncId =
            await _getLastFinishedKnockoutRoundSyncId(leagueSyncId);
        if (finishedRoundSyncId == null) return;

        final hasLock = await _hasNextLock(
          leagueSyncId: leagueSyncId,
          finishedRoundSyncId: finishedRoundSyncId,
        );
        if (hasLock) return;

        final nextRound = await checkAndCreateNextKnockoutRoundIfNeeded(
          leagueSyncId,
          finishedRoundSyncId,
        );

        if (nextRound == null) return;

        await _addNextLock(
          leagueSyncId: leagueSyncId,
          finishedRoundSyncId: finishedRoundSyncId,
        );

        result = nextRound;
      }
    });

    return result;
  }

  /// اختيار الجولة المنتهية للتقدم منها بدون الاعتماد على createdAt.
  ///
  /// الفكرة:
  /// - كل تقدم يقلل عدد مباريات الجولة (مثلاً 4 -> 2 -> 1)
  /// - إذا كانت هناك جولة أصغر (بعدد مباريات أقل) موجودة بالفعل، فهذا يعني أنه تم التقدم بالفعل
  ///   من الجولة الأكبر.
  ///
  /// بالتالي نختار: جولة Knockout "منتهية" ولا يوجد في نفس الدوري جولة Knockout بعدد مباريات أقل.
  Future<String?> _getLastFinishedKnockoutRoundSyncId(String leagueSyncId) async {
    final rounds = await (db.select(db.rounds)
          ..where((r) =>
              r.leagueSyncId.equals(leagueSyncId) &
              r.roundType.equals('knockout'))).get();

    if (rounds.isEmpty) return null;

    for (final r in rounds) {
      final matches = await (db.select(db.matches)
            ..where((m) => m.roundSyncId.equals(r.syncId)))
          .get();

      if (matches.isEmpty) continue;
      final allFinished = matches.every((m) => m.status == 'finished');
      if (!allFinished) continue;

      final finishedCount = matches.length;

      // هل يوجد round آخر بعدد مباريات أقل؟ إذا نعم -> هذا round تم التقدم منه مسبقاً.
      var hasSmallerRound = false;
      for (final other in rounds) {
        if (other.syncId == r.syncId) continue;

        final otherMatches = await (db.select(db.matches)
              ..where((m) => m.roundSyncId.equals(other.syncId)))
            .get();

        if (otherMatches.isEmpty) continue;

        if (otherMatches.length < finishedCount) {
          hasSmallerRound = true;
          break;
        }
      }

      if (!hasSmallerRound) {
        return r.syncId;
      }
    }

    return null;
  }
}
// lib/.../knockout_generator_local_data_source.dart

class _AsyncMutex {
  @Deprecated('Unused helper (kept for possible future concurrency control).')
  Future<void> _tail = Future.value();

  Future<T> run<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _tail = _tail.then((_) async {
      try {
        completer.complete(await action());
      } catch (e, st) {
        completer.completeError(e, st);
      }
    });
    return completer.future;
  }
}
