import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/database/sync_orchestrator.dart';
import 'package:safirah/core/database/sync_service.dart';
import 'package:safirah/core/database/sync_trigger.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';
import 'package:safirah/core/network/connectivity_service.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/goal_model.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/reposaitory/reposaitory.dart';
import 'package:safirah/injection.dart' as di;
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

class FakeConnectivityService extends ConnectivityService {
  bool isConnected;
  FakeConnectivityService({this.isConnected = false});

  @override
  Future<bool> isOnline({Duration timeout = const Duration(seconds: 2)}) async {
    return isConnected;
  }
}

class FakeSyncTrigger extends SyncTrigger {
  final FakeConnectivityService fakeConn;
  final SyncOrchestrator syncOrchestrator;

  FakeSyncTrigger({required this.fakeConn, required this.syncOrchestrator})
      : super(connectivity: fakeConn, orchestrator: syncOrchestrator);

  @override
  Future<void> syncIfOnline({bool throwOnFirstError = true}) async {
    if (fakeConn.isConnected) {
      await syncOrchestrator.syncAll(throwOnFirstError: throwOnFirstError);
    }
  }

  @override
  void syncIfOnlineInBackground({bool throwOnFirstError = false}) {
    if (fakeConn.isConnected) {
      syncOrchestrator.syncAll(throwOnFirstError: throwOnFirstError);
    }
  }
}

void main() {
  late Safirah db;
  late LeagueLocalDataSource leagueLocal;
  late GroupsLocalDataSource groupLocal;
  late MatchesLocalDataSource matchLocal;
  late MatchTermsEventLocalDataSource termLocal;
  late SyncService syncService;
  late SyncOrchestrator orchestrator;
  late FakeConnectivityService connectivity;
  late FakeSyncTrigger syncTrigger;
  late MatchTermsEventRepository termRepository;
  late List<({EntitySyncEndpoint endpoint, Map<String, dynamic> data})> dispatchedRequests;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    dispatchedRequests = [];

    syncService = SyncService(
      db: db,
      remoteSender: (endpoint, data) async {
        dispatchedRequests.add((endpoint: endpoint, data: data));
      },
    );

    orchestrator = SyncOrchestrator(syncService);
    connectivity = FakeConnectivityService(isConnected: false);
    syncTrigger = FakeSyncTrigger(fakeConn: connectivity, syncOrchestrator: orchestrator);

    if (di.sl.isRegistered<SyncTrigger>()) {
      di.sl.unregister<SyncTrigger>();
    }
    di.sl.registerSingleton<SyncTrigger>(syncTrigger);

    leagueLocal = LeagueLocalDataSource(db);
    groupLocal = GroupsLocalDataSource(db);
    matchLocal = MatchesLocalDataSource(db);
    termLocal = MatchTermsEventLocalDataSource(db);
    termRepository = MatchTermsEventRepository(
      local: termLocal,
      connectivity: connectivity,
      syncService: syncService,
    );
  });

  tearDown(() async {
    if (di.sl.isRegistered<SyncTrigger>()) {
      di.sl.unregister<SyncTrigger>();
    }
    await db.close();
  });

  /// Helper to create a league with 4 teams, 1 group, 2 terms, and scheduled matches
  Future<({
    String leagueSyncId,
    String groupSyncId,
    List<String> teamSyncIds,
    Map<String, String> playerSyncIds,
    List<Matche> matches,
  })> createFullLeagueWithMatches({required String name}) async {
    await TestDbHelper.seedDefaultTerms(db);

    final lSyncId = const Uuid().v7();
    await leagueLocal.insertLeague(
      LeaguesCompanion.insert(
        syncId: lSyncId,
        name: name,
        subscriptionPrice: '200',
        status: const Value('active'),
      ),
    );

    // Setup 2 regular terms for the league
    await db.batch((batch) {
      batch.insertAll(db.leagueTerms, [
        LeagueTermsCompanion.insert(
          syncId: const Uuid().v7(),
          leagueSyncId: lSyncId,
          termSyncId: TestDbHelper.termRegular1SyncId,
          durationMinutes: const Value(45),
        ),
        LeagueTermsCompanion.insert(
          syncId: const Uuid().v7(),
          leagueSyncId: lSyncId,
          termSyncId: TestDbHelper.termRegular2SyncId,
          durationMinutes: const Value(45),
        ),
      ]);
    });

    // Create 4 teams
    final teamIds = <String>[];
    for (var i = 1; i <= 4; i++) {
      final tId = const Uuid().v7();
      teamIds.add(tId);
      await db.into(db.teams).insert(
            TeamsCompanion.insert(
              syncId: tId,
              leagueSyncId: lSyncId,
              teamName: '$name - فريق $i',
            ),
          );
    }

    // Register 1 player for each team
    final playerIds = <String, String>{};
    for (final tId in teamIds) {
      final lpId = const Uuid().v7();
      final pId = const Uuid().v7();
      playerIds[tId] = pId;

      await db.into(db.leaguePlayers).insert(
            LeaguePlayersCompanion.insert(
              syncId: lpId,
              leagueSyncId: lSyncId,
              name: const Value('لاعب'),
            ),
          );
      await db.into(db.players).insert(
            PlayersCompanion.insert(
              syncId: pId,
              playerLeagueSyncId: lpId,
              teamSyncId: tId,
              fullName: 'لاعب الفريق',
            ),
          );
    }

    // Draw 1 group with 4 teams
    await groupLocal.drawGroupsByCount(
      leagueSyncId: lSyncId,
      groupsCount: 1,
      qualifiedPerGroup: 2,
    );

    final groupRow = await (db.select(db.group)..where((g) => g.leagueSyncId.equals(lSyncId))).getSingle();

    // Generate rounds and schedule Round-Robin matches (3 rounds, 6 matches)
    await matchLocal.ensureGroupRounds(leagueSyncId: lSyncId);
    await matchLocal.scheduleGroupStageMatchesRR(leagueSyncId: lSyncId);

    final scheduledMatches = await (db.select(db.matches)
          ..where((m) => m.leagueSyncId.equals(lSyncId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();

    return (
      leagueSyncId: lSyncId,
      groupSyncId: groupRow.syncId,
      teamSyncIds: teamIds,
      playerSyncIds: playerIds,
      matches: scheduledMatches,
    );
  }

  group('Multi-League & Concurrent Matches Simulation Tests', () {
    test('1. Multiple leagues creation: entities are strictly partitioned without data bleed', () async {
      final leagueAlpha = await createFullLeagueWithMatches(name: 'دوري ألفا');
      final leagueBeta = await createFullLeagueWithMatches(name: 'دوري بيتا');
      final leagueGamma = await createFullLeagueWithMatches(name: 'دوري جاما');

      // Verify all 3 leagues exist
      final allLeagues = await db.select(db.leagues).get();
      expect(allLeagues.length, 3);

      // Verify each league has exactly 4 teams
      for (final l in [leagueAlpha, leagueBeta, leagueGamma]) {
        final teams = await (db.select(db.teams)..where((t) => t.leagueSyncId.equals(l.leagueSyncId))).get();
        expect(teams.length, 4);

        final groups = await (db.select(db.group)..where((g) => g.leagueSyncId.equals(l.leagueSyncId))).get();
        expect(groups.length, 1);

        final qualified = await (db.select(db.qualifiedTeam)..where((q) => q.leagueSyncId.equals(l.leagueSyncId))).get();
        expect(qualified.length, 4);

        final matches = await (db.select(db.matches)..where((m) => m.leagueSyncId.equals(l.leagueSyncId))).get();
        expect(matches.length, 6);
      }
    });

    test('2. Concurrent Matches in the SAME League (Intra-League Concurrency on 2 pitches)', () async {
      // In League Alpha: Match 0 (Pitch 1) and Match 1 (Pitch 2) run at the same time
      final league = await createFullLeagueWithMatches(name: 'دوري المحترفين');

      final matchA = league.matches[0]; // Match 1: Team 1 vs Team 2
      final matchB = league.matches[1]; // Match 2: Team 3 vs Team 4

      // Terms for Match A
      final termsA = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(matchA.syncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      // Terms for Match B
      final termsB = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(matchB.syncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      // --- SIMULTANEOUS KICKOFF (Pitch 1 & Pitch 2) ---
      await termRepository.startTermSafe(matchA.syncId, termsA[0].syncId);
      await termRepository.startTermSafe(matchB.syncId, termsB[0].syncId);

      // --- CONCURRENT IN-GAME EVENTS ---
      // Goal in Match A (Team 1 scores at min 15)
      await termRepository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: matchA.syncId,
          playerSyncId: league.playerSyncIds[matchA.homeTeamSyncId]!,
          matchTermSyncId: termsA[0].syncId,
          goalTime: 15,
          goalType: 'regular',
        ),
      );

      // Goal in Match B (Team 4 scores at min 22)
      await termRepository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: matchB.syncId,
          playerSyncId: league.playerSyncIds[matchB.awayTeamSyncId]!,
          matchTermSyncId: termsB[0].syncId,
          goalTime: 22,
          goalType: 'regular',
        ),
      );

      // Finish First Halves concurrently
      await termRepository.finishCurrentTerm(matchSyncId: matchA.syncId, matchTermSyncId: termsA[0].syncId);
      await termRepository.finishCurrentTerm(matchSyncId: matchB.syncId, matchTermSyncId: termsB[0].syncId);

      // Start Second Halves concurrently
      await termRepository.startTermSafe(matchA.syncId, termsA[1].syncId);
      await termRepository.startTermSafe(matchB.syncId, termsB[1].syncId);

      // Finish Matches concurrently
      final finishA = await termRepository.finishCurrentTerm(matchSyncId: matchA.syncId, matchTermSyncId: termsA[1].syncId);
      final finishB = await termRepository.finishCurrentTerm(matchSyncId: matchB.syncId, matchTermSyncId: termsB[1].syncId);

      expect(finishA.isRight(), isTrue);
      expect(finishB.isRight(), isTrue);

      // --- VERIFY RESULTS & TABLE STANDINGS ---
      // Match A: Home won (1 - 0)
      final matchARow = await (db.select(db.matches)..where((m) => m.syncId.equals(matchA.syncId))).getSingle();
      expect(matchARow.homeScore, 1);
      expect(matchARow.awayScore, 0);
      expect(matchARow.status, 'finished');

      // Match B: Away won (0 - 1)
      final matchBRow = await (db.select(db.matches)..where((m) => m.syncId.equals(matchB.syncId))).getSingle();
      expect(matchBRow.homeScore, 0);
      expect(matchBRow.awayScore, 1);
      expect(matchBRow.status, 'finished');

      // Verify League Standings:
      // Match A winner (Home) has 3 points
      final winnerA = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(league.leagueSyncId) & q.teamSyncId.equals(matchA.homeTeamSyncId)))
          .getSingle();
      expect(winnerA.points, 3);
      expect(winnerA.played, 1);
      expect(winnerA.goalsFor, 1);

      // Match B winner (Away) has 3 points
      final winnerB = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(league.leagueSyncId) & q.teamSyncId.equals(matchB.awayTeamSyncId)))
          .getSingle();
      expect(winnerB.points, 3);
      expect(winnerB.played, 1);
      expect(winnerB.goalsFor, 1);

      // Both losers have 0 points
      final loserA = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(league.leagueSyncId) & q.teamSyncId.equals(matchA.awayTeamSyncId)))
          .getSingle();
      expect(loserA.points, 0);
      expect(loserA.played, 1);

      final loserB = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(league.leagueSyncId) & q.teamSyncId.equals(matchB.homeTeamSyncId)))
          .getSingle();
      expect(loserB.points, 0);
      expect(loserB.played, 1);
    });

    test('3. Concurrent Matches across DIFFERENT Leagues (Inter-League Concurrency & Zero Data Bleed)', () async {
      // 2 different leagues playing matches simultaneously
      final leagueAlpha = await createFullLeagueWithMatches(name: 'دوري الرياض');
      final leagueBeta = await createFullLeagueWithMatches(name: 'دوري جدة');

      final matchAlpha = leagueAlpha.matches[0];
      final matchBeta = leagueBeta.matches[0];

      final termsAlpha = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(matchAlpha.syncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      final termsBeta = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(matchBeta.syncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      // Start both concurrently
      await termRepository.startTermSafe(matchAlpha.syncId, termsAlpha[0].syncId);
      await termRepository.startTermSafe(matchBeta.syncId, termsBeta[0].syncId);

      // Goal in Alpha: 2 goals for Home
      for (var i = 0; i < 2; i++) {
        await termRepository.addGoal(
          GoalModel(
            syncId: const Uuid().v7(),
            matchSyncId: matchAlpha.syncId,
            playerSyncId: leagueAlpha.playerSyncIds[matchAlpha.homeTeamSyncId]!,
            matchTermSyncId: termsAlpha[0].syncId,
            goalTime: 10 + (i * 10),
            goalType: 'regular',
          ),
        );
      }

      // Goal in Beta: 3 goals for Away
      for (var i = 0; i < 3; i++) {
        await termRepository.addGoal(
          GoalModel(
            syncId: const Uuid().v7(),
            matchSyncId: matchBeta.syncId,
            playerSyncId: leagueBeta.playerSyncIds[matchBeta.awayTeamSyncId]!,
            matchTermSyncId: termsBeta[0].syncId,
            goalTime: 5 + (i * 10),
            goalType: 'regular',
          ),
        );
      }

      // Conclude both matches
      await termRepository.finishCurrentTerm(matchSyncId: matchAlpha.syncId, matchTermSyncId: termsAlpha[0].syncId);
      await termRepository.finishCurrentTerm(matchSyncId: matchBeta.syncId, matchTermSyncId: termsBeta[0].syncId);

      await termRepository.startTermSafe(matchAlpha.syncId, termsAlpha[1].syncId);
      await termRepository.startTermSafe(matchBeta.syncId, termsBeta[1].syncId);

      await termRepository.finishCurrentTerm(matchSyncId: matchAlpha.syncId, matchTermSyncId: termsAlpha[1].syncId);
      await termRepository.finishCurrentTerm(matchSyncId: matchBeta.syncId, matchTermSyncId: termsBeta[1].syncId);

      // Verify League Alpha:
      final alphaMatchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(matchAlpha.syncId))).getSingle();
      expect(alphaMatchRow.homeScore, 2);
      expect(alphaMatchRow.awayScore, 0);

      // Verify League Beta:
      final betaMatchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(matchBeta.syncId))).getSingle();
      expect(betaMatchRow.homeScore, 0);
      expect(betaMatchRow.awayScore, 3);

      // Verify STRICT ISOLATION in tables:
      // In Alpha: Winner has 3 points and 2 goalsFor
      final alphaWinner = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(leagueAlpha.leagueSyncId) & q.teamSyncId.equals(matchAlpha.homeTeamSyncId)))
          .getSingle();
      expect(alphaWinner.points, 3);
      expect(alphaWinner.goalsFor, 2);

      // In Beta: Winner has 3 points and 3 goalsFor
      final betaWinner = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(leagueBeta.leagueSyncId) & q.teamSyncId.equals(matchBeta.awayTeamSyncId)))
          .getSingle();
      expect(betaWinner.points, 3);
      expect(betaWinner.goalsFor, 3);

      // Ensure Beta table contains NO references or scores from Alpha
      final allBetaQualified = await (db.select(db.qualifiedTeam)..where((q) => q.leagueSyncId.equals(leagueBeta.leagueSyncId))).get();
      for (final b in allBetaQualified) {
        expect(b.leagueSyncId, leagueBeta.leagueSyncId);
        expect(leagueAlpha.teamSyncIds.contains(b.teamSyncId), isFalse);
      }
    });

    test('4. Concurrent Sync Operations: operations from multiple leagues queue and dispatch cleanly', () async {
      connectivity.isConnected = false; // Offline

      final league1 = await createFullLeagueWithMatches(name: 'دوري 1');
      final league2 = await createFullLeagueWithMatches(name: 'دوري 2');

      // Concurrent actions in both leagues
      await termRepository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: league1.matches[0].syncId,
          playerSyncId: league1.playerSyncIds[league1.matches[0].homeTeamSyncId]!,
          matchTermSyncId: const Uuid().v7(),
          goalTime: 10,
          goalType: 'regular',
        ),
      );

      await termRepository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: league2.matches[0].syncId,
          playerSyncId: league2.playerSyncIds[league2.matches[0].homeTeamSyncId]!,
          matchTermSyncId: const Uuid().v7(),
          goalTime: 15,
          goalType: 'regular',
        ),
      );

      // Check sync_queue in SQLite:
      final queuedOps = await db.select(db.syncQueue).get();
      expect(queuedOps.length >= 2, isTrue);

      // Go online & dispatch all
      connectivity.isConnected = true;
      await orchestrator.syncAll(throwOnFirstError: true);

      // All operations dispatched and marked synced
      final allQueueRows = await db.select(db.syncQueue).get();
      for (final op in allQueueRows) {
        expect(op.status, SyncQueueStatus.synced);
        expect(op.synced, isTrue);
      }
      expect(dispatchedRequests.length >= 2, isTrue);
    });

    test('5. Stream / Watch Query Isolation: watch stream for League A never leaks League B updates (FIX-02)', () async {
      final leagueA = await createFullLeagueWithMatches(name: 'دوري أ للمراقبة');
      final leagueB = await createFullLeagueWithMatches(name: 'دوري ب للمراقبة');

      final initialEmissionA = await matchLocal.watchLeagueRoundsWithGroupsAndMatches(
        leagueSyncId: leagueA.leagueSyncId,
        matchFilter: 'all',
      ).first;
      expect(initialEmissionA.isNotEmpty, isTrue);
      for (final r in initialEmissionA) {
        expect(r.leagueSyncId, leagueA.leagueSyncId);
      }

      // Now mutate League B (add goals, update matches in League B)
      await (db.update(db.matches)..where((m) => m.syncId.equals(leagueB.matches[0].syncId))).write(
        const MatchesCompanion(homeScore: Value(5), awayScore: Value(4)),
      );

      // Query League A stream again
      final emissionAfterBUpdate = await matchLocal.watchLeagueRoundsWithGroupsAndMatches(
        leagueSyncId: leagueA.leagueSyncId,
        matchFilter: 'all',
      ).first;

      // Verify League A stream still contains ONLY League A rounds and matches
      for (final r in emissionAfterBUpdate) {
        expect(r.leagueSyncId, leagueA.leagueSyncId);
        for (final g in r.groups) {
          for (final m in g.matches) {
            expect(m.leagueSyncId, leagueA.leagueSyncId);
            expect(m.syncId, isNot(leagueB.matches[0].syncId));
          }
        }
      }
    });
  });
}
