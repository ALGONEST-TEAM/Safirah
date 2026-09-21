import 'dart:convert';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/database/sync_orchestrator.dart';
import 'package:safirah/core/database/sync_service.dart';
import 'package:safirah/core/database/sync_trigger.dart';
import 'package:safirah/core/database/table/sync_queue_table.dart';
import 'package:safirah/core/network/connectivity_service.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/model/match_model.dart';
import 'package:safirah/features/leagues_mangement/match/data/model/round_model.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/goal_model.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/match_term_model.dart';
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
  late SyncService syncService;
  late SyncOrchestrator orchestrator;
  late FakeConnectivityService connectivity;
  late FakeSyncTrigger syncTrigger;
  late MatchTermsEventLocalDataSource localDataSource;
  late MatchesLocalDataSource matchesLocalDataSource;
  late MatchTermsEventRepository repository;
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

    // Register test SyncTrigger in GetIt
    if (di.sl.isRegistered<SyncTrigger>()) {
      di.sl.unregister<SyncTrigger>();
    }
    di.sl.registerSingleton<SyncTrigger>(syncTrigger);

    localDataSource = MatchTermsEventLocalDataSource(db);
    matchesLocalDataSource = MatchesLocalDataSource(db);
    repository = MatchTermsEventRepository(
      local: localDataSource,
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

  group('Full Sync Architecture & User Real-World Simulation Tests', () {
    test('1. Offline Queue Flow: UI actions enqueue operations in syncQueue without network calls', () async {
      connectivity.isConnected = false; // User is OFFLINE
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // User starts Term 1 via Repository
      final startTermRes = await repository.startTermSafe(
        fixture.matchSyncId,
        fixture.term1SyncId,
      );
      expect(startTermRes.isRight(), isTrue);

      // User scores a Goal via Repository
      final goalSyncId = const Uuid().v7();
      final goalRes = await repository.addGoal(
        GoalModel(
          syncId: goalSyncId,
          matchSyncId: fixture.matchSyncId,
          playerSyncId: fixture.homePlayerSyncId,
          matchTermSyncId: fixture.term1SyncId,
          goalTime: 12,
          goalType: 'regular',
        ),
      );
      expect(goalRes.isRight(), isTrue);

      // User finishes Term 1 via Repository
      final finishTerm1Res = await repository.finishCurrentTerm(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term1SyncId,
      );
      expect(finishTerm1Res.isRight(), isTrue);

      // Since user is offline, zero remote requests were dispatched
      expect(dispatchedRequests.isEmpty, isTrue);

      // Verify sync_queue in SQLite:
      // Operations must be queued with status: pending and valid JSON payloads
      final queuedOps = await (db.select(db.syncQueue)
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      expect(queuedOps.isNotEmpty, isTrue);
      for (final op in queuedOps) {
        expect(op.status, SyncQueueStatus.pending);
        expect(op.synced, isFalse);

        final payload = jsonDecode(op.payload) as Map<String, dynamic>;
        expect(payload, isNotEmpty);
      }

      // Verify specific queue items exist
      expect(queuedOps.any((op) => op.entityType == 'match' && op.operation == 'update'), isTrue);
      expect(queuedOps.any((op) => op.entityType == 'goal' && op.operation == 'create'), isTrue);
      expect(queuedOps.any((op) => op.entityType == 'qualifiedTeam' && op.operation == 'update'), isTrue);
    });

    test('2. Online Dispatch Flow: SyncOrchestrator dispatches queue to API endpoints and updates status to synced', () async {
      connectivity.isConnected = false;
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Queue actions while offline
      await repository.startTermSafe(fixture.matchSyncId, fixture.term1SyncId);
      await repository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: fixture.matchSyncId,
          playerSyncId: fixture.homePlayerSyncId,
          matchTermSyncId: fixture.term1SyncId,
          goalTime: 30,
          goalType: 'regular',
        ),
      );

      final pendingCountBefore = (await syncService.getPendingOperations()).length;
      expect(pendingCountBefore >= 2, isTrue);

      // Now user connects to Internet (ONLINE)
      connectivity.isConnected = true;

      // Trigger sync
      await orchestrator.syncAll(throwOnFirstError: true);

      // Verify all queued requests were dispatched with correct endpoints
      expect(dispatchedRequests.isNotEmpty, isTrue);

      // Check endpoints: matches -> /matches, goals -> /goals
      expect(dispatchedRequests.any((r) => r.endpoint.path.contains('/matches')), isTrue);
      expect(dispatchedRequests.any((r) => r.endpoint.path.contains('/goals')), isTrue);

      // Verify sync_queue status in SQLite: ALL operations are now marked synced!
      final allQueueRows = await db.select(db.syncQueue).get();
      for (final row in allQueueRows) {
        expect(row.status, SyncQueueStatus.synced);
        expect(row.synced, isTrue);
      }

      // Pending queue is now completely empty
      final pendingCountAfter = (await syncService.getPendingOperations()).length;
      expect(pendingCountAfter, 0);
    });

    test('3. Goal Cancellation Sync: deleting a goal enqueues PUT /goals/cancel and rolls back local stats', () async {
      connectivity.isConnected = false;
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Add a goal
      final goalSyncId = const Uuid().v7();
      await repository.addGoal(
        GoalModel(
          syncId: goalSyncId,
          matchSyncId: fixture.matchSyncId,
          playerSyncId: fixture.homePlayerSyncId,
          matchTermSyncId: fixture.term1SyncId,
          goalTime: 18,
          goalType: 'regular',
        ),
      );

      // Verify match score is 1 - 0
      var matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 1);

      // Delete the goal via Repository
      final deleteRes = await repository.deleteGoalBySyncId(goalSyncId);
      expect(deleteRes.isRight(), isTrue);

      // Match score locally rolled back to 0 - 0
      matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 0);

      // User goes online & syncs
      connectivity.isConnected = true;
      await orchestrator.syncAll(throwOnFirstError: true);

      // Verify cancellation request was dispatched to /goals/cancel with HTTP PUT
      final cancelRequest = dispatchedRequests.firstWhere(
        (r) => r.endpoint.path.contains('/goals/cancel'),
      );
      expect(cancelRequest.endpoint.method, HttpMethod.put);
      expect(cancelRequest.data['goal_sync_id'], goalSyncId);
    });

    test('4. Inbound Sync (Pull & Merge): server bundle upsert never deletes other leagues terms (FIX-01 validation)', () async {
      // Create League A and League B
      final leagueA = await TestDbHelper.createLeagueFixture(db, leagueName: 'دوري أ');
      final leagueB = await TestDbHelper.createLeagueFixture(db, leagueName: 'دوري ب');

      // Verify League A has 2 match terms
      final termsABefore = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(leagueA.matchSyncId))).get();
      expect(termsABefore.length, 2);

      // Simulate Inbound Remote Sync: Server sends updated rounds & matches for League B ONLY
      final remoteMatchForB = MatchModel(
        syncId: leagueB.matchSyncId,
        leagueSyncId: leagueB.leagueSyncId,
        roundSyncId: leagueB.roundSyncId,
        homeTeamSyncId: leagueB.teamSyncIds[0],
        awayTeamSyncId: leagueB.teamSyncIds[1],
        homeScore: 1,
        awayScore: 0,
        status: 'live',
        matchTerms: [
          MatchTermModel(
            id: 1,
            syncId: leagueB.term1SyncId,
            matchSyncId: leagueB.matchSyncId,
            leagueTermSyncId: leagueB.leagueTerm1SyncId,
            isFinished: true,
          ),
          MatchTermModel(
            id: 2,
            syncId: leagueB.term2SyncId,
            matchSyncId: leagueB.matchSyncId,
            leagueTermSyncId: leagueB.leagueTerm2SyncId,
            isFinished: false,
          ),
        ],
      );

      final remoteRoundForB = RoundModel(
        syncId: leagueB.roundSyncId,
        leagueSyncId: leagueB.leagueSyncId,
        roundName: 'الجولة 1',
        roundType: 'group',
        groupSyncId: leagueB.groupSyncId,
        matches: [remoteMatchForB],
      );

      // Upsert remote response for League B
      await matchesLocalDataSource.upsertLeagueRoundsFromApiOneResponse(
        leagueSyncId: leagueB.leagueSyncId,
        apiRounds: [remoteRoundForB],
      );

      // CRITICAL CHECK (FIX-01): League A's terms MUST STILL EXIST!
      final termsAAfter = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(leagueA.matchSyncId))).get();
      expect(termsAAfter.length, 2, reason: 'FIX-01: Syncing League B must NEVER delete League A terms!');

      // League B's terms are cleanly updated without duplication
      final termsBAfter = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(leagueB.matchSyncId))).get();
      expect(termsBAfter.length, 2);
    });

    test('5. Knockout Match Sync Integrity: finishes without null crash and without group points enqueue', () async {
      connectivity.isConnected = false;
      final koFixture = await TestDbHelper.createKnockoutFixture(db);

      // Home wins in regular time (2 - 0)
      await (db.update(db.matches)..where((m) => m.syncId.equals(koFixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(2),
          awayScore: Value(0),
        ),
      );

      // Finish term 2 via Repository -> concludes knockout match
      final finishRes = await repository.finishCurrentTerm(
        matchSyncId: koFixture.matchSyncId,
        matchTermSyncId: koFixture.matchTermSyncIds[1],
      );

      // Verify NO DioException / null crash occurred (validating our repository fix)
      expect(finishRes.isRight(), isTrue);

      // Verify syncQueue:
      // Must contain 'match' update with status: 'finished'
      final queuedOps = await db.select(db.syncQueue).get();
      final finishedMatchOp = queuedOps.firstWhere(
        (op) => op.entityType == 'match' && op.payload.contains('finished'),
      );
      expect(finishedMatchOp, isNotNull);

      // CRITICAL: Knockout matches must NOT enqueue 'group_team' points update!
      final hasGroupTeamOp = queuedOps.any((op) => op.entityType == 'group_team');
      expect(hasGroupTeamOp, isFalse, reason: 'Knockout matches must not enqueue group points');
    });

    test('6. Match Terms Sync Payload Accuracy: finishing Term 1 sends Term 1 league_term_sync_id (not Term 2) with valid end_time', () async {
      connectivity.isConnected = false;
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Start Term 1
      await repository.startTermSafe(fixture.matchSyncId, fixture.term1SyncId);

      // Finish Term 1
      final finishRes = await repository.finishCurrentTerm(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term1SyncId,
      );
      expect(finishRes.isRight(), isTrue);

      // Inspect queued operations in sync_queue
      final queuedOps = await db.select(db.syncQueue).get();

      // Find the match_terms update queued for finishing Term 1
      final term1Op = queuedOps.firstWhere((op) {
        if (op.entityType != 'match' || op.operation != 'update') return false;
        final p = jsonDecode(op.payload) as Map<String, dynamic>;
        final matchTerms = p['match_terms'] as List<dynamic>?;
        return matchTerms != null &&
            matchTerms.any((t) => t['sync_id'] == fixture.term1SyncId && t['is_finished'] == true);
      });

      final payload = jsonDecode(term1Op.payload) as Map<String, dynamic>;
      final matchTerms = payload['match_terms'] as List<dynamic>;
      final termPayload = matchTerms.firstWhere((t) => t['sync_id'] == fixture.term1SyncId);

      // CRITICAL BACKEND BUG FIX VALIDATION:
      // The payload MUST send league_term_sync_id of Term 1, NEVER Term 2!
      expect(termPayload['sync_id'], fixture.term1SyncId);
      expect(termPayload['league_term_sync_id'], fixture.leagueTerm1SyncId,
          reason: 'Term 1 payload MUST contain leagueTerm1SyncId, NOT leagueTerm2SyncId!');
      expect(termPayload['league_term_sync_id'], isNot(equals(fixture.leagueTerm2SyncId)));
      expect(termPayload['is_finished'], true);
      expect(termPayload['end_time'], isNotNull,
          reason: 'Term 1 payload MUST contain a valid ISO-8601 end_time timestamp');

      // Now Start and Finish Term 2
      await repository.startTermSafe(fixture.matchSyncId, fixture.term2SyncId);
      final finishTerm2Res = await repository.finishCurrentTerm(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term2SyncId,
      );
      expect(finishTerm2Res.isRight(), isTrue);

      final allOpsAfterTerm2 = await db.select(db.syncQueue).get();
      final term2Op = allOpsAfterTerm2.firstWhere((op) {
        if (op.entityType != 'match' || op.operation != 'update') return false;
        final p = jsonDecode(op.payload) as Map<String, dynamic>;
        final matchTerms = p['match_terms'] as List<dynamic>?;
        return matchTerms != null &&
            matchTerms.any((t) => t['sync_id'] == fixture.term2SyncId && t['is_finished'] == true);
      });

      final payload2 = jsonDecode(term2Op.payload) as Map<String, dynamic>;
      final matchTerms2 = payload2['match_terms'] as List<dynamic>;
      final termPayload2 = matchTerms2.firstWhere((t) => t['sync_id'] == fixture.term2SyncId);

      expect(termPayload2['sync_id'], fixture.term2SyncId);
      expect(termPayload2['league_term_sync_id'], fixture.leagueTerm2SyncId,
          reason: 'Term 2 payload MUST contain leagueTerm2SyncId');
      expect(termPayload2['is_finished'], true);
      expect(termPayload2['end_time'], isNotNull);
    });
  });
}
