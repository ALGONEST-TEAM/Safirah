import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/model/round_model.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late MatchesLocalDataSource matchLocal;
  late MatchTermsEventLocalDataSource termLocal;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    matchLocal = MatchesLocalDataSource(db);
    termLocal = MatchTermsEventLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Match Terms & Points Lifecycle Test Suite', () {
    test('FIX-01: Multi-League Isolation - Syncing League B must NEVER delete League A match terms', () async {
      // 1. Create League A with 1 match and 2 match terms
      final leagueA = await TestDbHelper.createLeagueFixture(
        db,
        leagueSyncId: 'league-A',
        leagueName: 'الدوري الأول A',
      );

      // 2. Create League B with 1 match and 2 match terms
      final leagueB = await TestDbHelper.createLeagueFixture(
        db,
        leagueSyncId: 'league-B',
        leagueName: 'الدوري الثاني B',
      );

      // Verify both leagues have terms in DB
      final termsBeforeA = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(leagueA.matchSyncId)))
          .get();
      final termsBeforeB = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(leagueB.matchSyncId)))
          .get();

      expect(termsBeforeA.length, 2);
      expect(termsBeforeB.length, 2);

      // 3. Simulate API refresh for League B (which previously wiped League A terms)
      await matchLocal.upsertLeagueRoundsFromApiOneResponse(
        leagueSyncId: leagueB.leagueSyncId,
        apiRounds: <RoundModel>[], // empty or partial rounds from API
        deleteMissingMatchTerms: true,
      );

      // 4. VERIFY: League A match terms must STILL exist!
      final termsAfterA = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(leagueA.matchSyncId)))
          .get();

      expect(
        termsAfterA.length,
        2,
        reason: 'FIX-01 Failed: Syncing League B wiped out match_terms of League A!',
      );
      expect(termsAfterA.map((t) => t.syncId).toSet(), {leagueA.term1SyncId, leagueA.term2SyncId});
    });

    test('Deduplication: Calling createMatchTermsNoTx when terms already exist must NOT duplicate terms', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Call createMatchTermsNoTx again for the same match
      final terms = await termLocal.createMatchTermsNoTx(
        matchSyncId: fixture.matchSyncId,
        leagueSyncId: fixture.leagueSyncId,
      );

      expect(terms.length, 2);

      // Verify in DB directly
      final inDb = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(fixture.matchSyncId)))
          .get();

      expect(inDb.length, 2, reason: 'Duplicate terms were inserted into match_terms table!');
      final leagueTermIds = inDb.map((t) => t.leagueTermSyncId).toList();
      expect(leagueTermIds.toSet().length, 2, reason: 'Found duplicate leagueTermSyncId in match_terms!');
    });

    test('Full Match Flow: Start term 1 -> Finish term 1 -> Start term 2 -> Finish term 2 -> Points updated', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Step 1: Start Term 1
      final start1 = await termLocal.startTermSafe(fixture.matchSyncId, fixture.term1SyncId);
      expect(start1.termStarted, true);
      expect(start1.matchStatus, 'live');

      // Step 2: Finish Term 1
      final finish1 = await termLocal.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term1SyncId,
      );
      expect(finish1.termFinished, true);
      expect(finish1.matchFinished, false);
      expect(finish1.pointsUpdatedLocally, false);

      // Step 3: Start Term 2
      final start2 = await termLocal.startTermSafe(fixture.matchSyncId, fixture.term2SyncId);
      expect(start2.termStarted, true);

      // Set score: Home (team 0) = 2, Away (team 1) = 1
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId)))
          .write(const MatchesCompanion(
        homeScore: Value(2),
        awayScore: Value(1),
      ));

      // Step 4: Finish Term 2 (final term for group match)
      final finish2 = await termLocal.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term2SyncId,
      );
      expect(finish2.termFinished, true);
      expect(finish2.matchFinished, true);
      expect(finish2.pointsUpdatedLocally, true);

      // Step 5: Update Points in QualifiedTeam
      final updatedTeams = await termLocal.finishMatchAndUpdatePoints(
        fixture.matchSyncId,
        DateTime.now(),
      );

      expect(updatedTeams.home, isNotNull);
      expect(updatedTeams.away, isNotNull);

      final homeTeam = updatedTeams.home!;
      final awayTeam = updatedTeams.away!;

      // Verify points: Home won -> 3 points, Away lost -> 0 points
      expect(homeTeam.points, 3);
      expect(homeTeam.played, 1);
      expect(homeTeam.wins, 1);
      expect(homeTeam.losses, 0);

      expect(awayTeam.points, 0);
      expect(awayTeam.played, 1);
      expect(awayTeam.wins, 0);
      expect(awayTeam.losses, 1);
    });

    test('FIX-03 & FIX-06: Idempotency - Calling finish again does NOT double the points or re-update', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Complete both terms and set score 1 - 0
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId)))
          .write(const MatchesCompanion(homeScore: Value(1), awayScore: Value(0)));

      await termLocal.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term1SyncId,
      );
      await termLocal.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term2SyncId,
      );

      // Update points first time
      await termLocal.finishMatchAndUpdatePoints(fixture.matchSyncId, DateTime.now());

      // Check points in DB
      final qTable = db.qualifiedTeam;
      final homeRow1 = await (db.select(qTable)
            ..where((t) => t.teamSyncId.equals(fixture.teamSyncIds[0])))
          .getSingle();
      expect(homeRow1.points, 3);

      // RE-INVOKE FIX-06: Call finishTermSmart again (simulating rapid tap)
      final reFinish = await termLocal.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.term2SyncId,
      );
      expect(reFinish.pointsUpdatedLocally, false, reason: 'FIX-06: Should NOT allow updating points again!');

      // RE-INVOKE FIX-03: Call finishMatchAndUpdatePoints again
      final reUpdated = await termLocal.finishMatchAndUpdatePoints(
        fixture.matchSyncId,
        DateTime.now(),
      );
      expect(reUpdated.home, isNull, reason: 'FIX-03: Must return null when match is already finished!');
      expect(reUpdated.away, isNull);

      // Verify points in DB were NOT doubled
      final homeRow2 = await (db.select(qTable)
            ..where((t) => t.teamSyncId.equals(fixture.teamSyncIds[0])))
          .getSingle();
      expect(homeRow2.points, 3, reason: 'Points were doubled! Expected 3, got ${homeRow2.points}');
    });

    test('FIX-04: Self-Healing - Missing match terms are automatically recreated instead of returning "انتهت المباراة"', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Delete all terms for match 1 (simulating data wipe or sync anomaly)
      await (db.delete(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(fixture.matchSyncId)))
          .go();

      // Verify terms are gone
      final termsBefore = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(fixture.matchSyncId)))
          .get();
      expect(termsBefore, isEmpty);

      // Call getCurrentMatchTerm - should self-heal
      final currentTerm = await termLocal.getCurrentMatchTerm(fixture.matchSyncId);

      expect(currentTerm.termName, isNot('انتهت المباراة'),
          reason: 'FIX-04: Unfinished match returned "انتهت المباراة" when terms were missing!');
      expect(currentTerm.termName, 'الشوط الأول');
      expect(currentTerm.isFinished, false);

      // Verify terms exist in DB again
      final termsAfter = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(fixture.matchSyncId)))
          .get();
      expect(termsAfter.length, 2, reason: 'FIX-04: Terms were not recreated in DB!');
    });
  });
}
