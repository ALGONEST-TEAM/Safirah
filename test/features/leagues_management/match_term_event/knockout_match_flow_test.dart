import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/network/errors/local_app_exception.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late MatchTermsEventLocalDataSource dataSource;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    dataSource = MatchTermsEventLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Knockout Match Flow Tests', () {
    test('1. Knockout win in regular time auto-finishes extra & penalty terms', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Start term 1, finish term 1
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[0],
      );
      await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[0],
      );

      // Home team scores 1 goal (1 - 0)
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(1),
          awayScore: Value(0),
        ),
      );

      // Start term 2, finish term 2
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[1],
      );

      final finishResult = await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[1],
      );

      expect(finishResult.termFinished, isTrue);
      expect(finishResult.matchFinished, isTrue);
      expect(finishResult.isKnockout, isTrue);
      expect(finishResult.pointsUpdatedLocally, isFalse); // Knockout has no group table points

      // Match should be finished
      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.status, 'finished');

      // All remaining terms (extra time 1, extra time 2, penalties) must be auto-finished
      final allTerms = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(fixture.matchSyncId))).get();
      expect(allTerms.length, 5);
      for (final t in allTerms) {
        expect(t.isFinished, isTrue, reason: 'Term ${t.syncId} should be finished');
      }
    });

    test('2. Knockout tie at regular time moves to Extra Time', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Finish term 1
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[0],
      );
      await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[0],
      );

      // Match is tied 1 - 1
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(1),
          awayScore: Value(1),
        ),
      );

      // Finish term 2
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[1],
      );
      final finishTerm2Result = await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[1],
      );

      expect(finishTerm2Result.termFinished, isTrue);
      expect(finishTerm2Result.matchFinished, isFalse); // Match should NOT finish

      // Match status must still be live/not finished
      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.status, isNot('finished'));

      // Next term must be Extra Time 1 (index 2)
      final currentTerm = await dataSource.getCurrentMatchTerm(fixture.matchSyncId);
      expect(currentTerm.syncId, fixture.matchTermSyncIds[2]);
      expect(currentTerm.termType, 'extra');
    });

    test('3. Knockout win in extra time finishes match and auto-closes penalties', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Finish terms 1 and 2 tied at 0-0
      for (var i = 0; i < 2; i++) {
        await dataSource.startTermSafe(
          fixture.matchSyncId,
          fixture.matchTermSyncIds[i],
        );
        await dataSource.finishTermSmart(
          matchSyncId: fixture.matchSyncId,
          matchTermSyncId: fixture.matchTermSyncIds[i],
        );
      }

      // Finish extra time 1 (term 3)
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[2],
      );
      await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[2],
      );

      // Away team scores in extra time 2 (0 - 1)
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(0),
          awayScore: Value(1),
        ),
      );

      // Finish extra time 2 (term 4)
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[3],
      );
      final finishExtra2 = await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[3],
      );

      expect(finishExtra2.termFinished, isTrue);
      expect(finishExtra2.matchFinished, isTrue);

      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.status, 'finished');

      // Penalty term (index 4) should also be auto-finished
      final penaltyTerm = await (db.select(db.matchTerms)
            ..where((t) => t.syncId.equals(fixture.matchTermSyncIds[4])))
          .getSingle();
      expect(penaltyTerm.isFinished, isTrue);
    });

    test('4. Tied knockout match after penalties without winner throws LocalAppException', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Finish terms 1, 2, 3, 4 tied
      for (var i = 0; i < 4; i++) {
        await dataSource.startTermSafe(
          fixture.matchSyncId,
          fixture.matchTermSyncIds[i],
        );
        await dataSource.finishTermSmart(
          matchSyncId: fixture.matchSyncId,
          matchTermSyncId: fixture.matchTermSyncIds[i],
        );
      }

      // Start penalty term
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[4],
      );

      // Penalty shootout scores are not set or equal (tied 4 - 4)
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(1),
          awayScore: Value(1),
          homePenaltyScore: Value(4),
          awayPenaltyScore: Value(4),
        ),
      );

      // Attempting to finish penalty term without a winner must throw LocalAppException
      expect(
        () => dataSource.finishTermSmart(
          matchSyncId: fixture.matchSyncId,
          matchTermSyncId: fixture.matchTermSyncIds[4],
        ),
        throwsA(isA<LocalAppException>()),
      );
    });

    test('5. Penalty shootout with winner successfully finishes match', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Finish terms 1, 2, 3, 4 tied
      for (var i = 0; i < 4; i++) {
        await dataSource.startTermSafe(
          fixture.matchSyncId,
          fixture.matchTermSyncIds[i],
        );
        await dataSource.finishTermSmart(
          matchSyncId: fixture.matchSyncId,
          matchTermSyncId: fixture.matchTermSyncIds[i],
        );
      }

      // Start penalty term
      await dataSource.startTermSafe(
        fixture.matchSyncId,
        fixture.matchTermSyncIds[4],
      );

      // Penalties won by Home (5 - 4)
      await (db.update(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).write(
        const MatchesCompanion(
          homeScore: Value(2),
          awayScore: Value(2),
          homePenaltyScore: Value(5),
          awayPenaltyScore: Value(4),
        ),
      );

      final finishPenaltyResult = await dataSource.finishTermSmart(
        matchSyncId: fixture.matchSyncId,
        matchTermSyncId: fixture.matchTermSyncIds[4],
      );

      expect(finishPenaltyResult.termFinished, isTrue);
      expect(finishPenaltyResult.matchFinished, isTrue);

      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.status, 'finished');
    });
  });
}
