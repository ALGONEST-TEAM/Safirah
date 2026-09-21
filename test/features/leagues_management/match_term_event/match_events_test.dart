import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/network/errors/local_app_exception.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/goal_model.dart';
import 'package:uuid/uuid.dart';

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

  group('Match Events & Integrity Tests', () {
    test('1. Regular Goal: updates match score and qualifiedTeam goalsFor / goalsAgainst', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Home player scores in term 1
      final goalSyncId = const Uuid().v7();
      final goal = GoalModel(
        syncId: goalSyncId,
        matchSyncId: fixture.matchSyncId,
        playerSyncId: fixture.homePlayerSyncId,
        matchTermSyncId: fixture.term1SyncId,
        goalTime: 23,
        goalType: 'regular',
      );

      final result = await dataSource.insertGoalAndUpdateQualifiedTeams(goal);

      expect(result.goal.syncId, goalSyncId);
      expect(result.scoring?.goalsFor, 1);
      expect(result.opttend?.goalsAgainst, 1);

      // Match score in DB
      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 1);
      expect(matchRow.awayScore, 0);

      // Qualified teams in DB
      final homeQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[0])))
          .getSingle();
      expect(homeQualified.goalsFor, 1);
      expect(homeQualified.goalsAgainst, 0);

      final awayQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[1])))
          .getSingle();
      expect(awayQualified.goalsFor, 0);
      expect(awayQualified.goalsAgainst, 1);
    });

    test('2. Own Goal (هدف عكسي): awards goal and goalsFor to opponent', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Home player scores an own goal
      final goalSyncId = const Uuid().v7();
      final goal = GoalModel(
        syncId: goalSyncId,
        matchSyncId: fixture.matchSyncId,
        playerSyncId: fixture.homePlayerSyncId,
        matchTermSyncId: fixture.term1SyncId,
        goalTime: 40,
        goalType: 'own_goal',
      );

      final result = await dataSource.insertGoalAndUpdateQualifiedTeams(goal);

      // Away team should receive the goal
      expect(result.scoring?.teamSyncId, fixture.teamSyncIds[1]);
      expect(result.opttend?.teamSyncId, fixture.teamSyncIds[0]);

      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 0);
      expect(matchRow.awayScore, 1);

      final homeQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[0])))
          .getSingle();
      expect(homeQualified.goalsFor, 0);
      expect(homeQualified.goalsAgainst, 1);

      final awayQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[1])))
          .getSingle();
      expect(awayQualified.goalsFor, 1);
      expect(awayQualified.goalsAgainst, 0);
    });

    test('3. Goal Rollback / Deletion: accurately rolls back scores and qualified team stats', () async {
      final fixture = await TestDbHelper.createLeagueFixture(db);

      // Insert goal for home
      final goalSyncId = const Uuid().v7();
      final goal = GoalModel(
        syncId: goalSyncId,
        matchSyncId: fixture.matchSyncId,
        playerSyncId: fixture.homePlayerSyncId,
        matchTermSyncId: fixture.term1SyncId,
        goalTime: 15,
        goalType: 'regular',
      );

      await dataSource.insertGoalAndUpdateQualifiedTeams(goal);

      // Verify score is 1 - 0
      var matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 1);

      // Delete goal (rollback)
      final deleteResult = await dataSource.deleteGoalBySyncId(goalSyncId);
      expect(deleteResult, isNotNull);

      // Score should return to 0 - 0
      matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(matchRow.homeScore, 0);
      expect(matchRow.awayScore, 0);

      // Qualified team stats should roll back to 0
      final homeQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[0])))
          .getSingle();
      expect(homeQualified.goalsFor, 0);
      expect(homeQualified.goalsAgainst, 0);

      final awayQualified = await (db.select(db.qualifiedTeam)
            ..where((t) => t.leagueSyncId.equals(fixture.leagueSyncId) & t.teamSyncId.equals(fixture.teamSyncIds[1])))
          .getSingle();
      expect(awayQualified.goalsAgainst, 0);
    });

    test('4. Disallowed goal during penalty term throws LocalAppException', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Insert player for knockout team 1
      final pSyncId = const Uuid().v7();
      final lpSyncId = const Uuid().v7();
      await db.into(db.leaguePlayers).insert(
            LeaguePlayersCompanion.insert(
              syncId: lpSyncId,
              leagueSyncId: fixture.leagueSyncId,
              name: const Value('لاعب ترجيح'),
            ),
          );
      await db.into(db.players).insert(
            PlayersCompanion.insert(
              syncId: pSyncId,
              playerLeagueSyncId: lpSyncId,
              teamSyncId: fixture.homeTeamSyncId,
              fullName: 'لاعب ترجيح',
            ),
          );

      // Penalty term is index 4
      final penaltyTermSyncId = fixture.matchTermSyncIds[4];

      final penaltyGoal = GoalModel(
        syncId: const Uuid().v7(),
        matchSyncId: fixture.matchSyncId,
        playerSyncId: pSyncId,
        matchTermSyncId: penaltyTermSyncId,
        goalTime: 120,
        goalType: 'regular',
      );

      // Must throw LocalAppException
      expect(
        () => dataSource.insertGoalAndUpdateQualifiedTeams(penaltyGoal),
        throwsA(isA<LocalAppException>()),
      );
    });

    test('5. Penalty shootout manual score update & negative score validation', () async {
      final fixture = await TestDbHelper.createKnockoutFixture(db);

      // Updating with negative score must throw LocalAppException
      expect(
        () => dataSource.updatePenaltyShootoutScore(
          matchSyncId: fixture.matchSyncId,
          homePenaltyScore: -1,
          awayPenaltyScore: 3,
        ),
        throwsA(isA<LocalAppException>()),
      );

      // Updating with valid score
      final updatedMatch = await dataSource.updatePenaltyShootoutScore(
        matchSyncId: fixture.matchSyncId,
        homePenaltyScore: 5,
        awayPenaltyScore: 4,
      );

      expect(updatedMatch.homePenaltyScore, 5);
      expect(updatedMatch.awayPenaltyScore, 4);

      final dbMatch = await (db.select(db.matches)..where((m) => m.syncId.equals(fixture.matchSyncId))).getSingle();
      expect(dbMatch.homePenaltyScore, 5);
      expect(dbMatch.awayPenaltyScore, 4);
    });
  });
}
