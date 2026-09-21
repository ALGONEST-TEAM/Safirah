import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/model/rule_league_model.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/data_source/local_data_source.dart';
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late LeagueLocalDataSource leaguesDataSource;
  late TeamAndPlayerLocalDataSource teamPlayerDataSource;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    leaguesDataSource = LeagueLocalDataSource(db);
    teamPlayerDataSource = TeamAndPlayerLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Level 1: Leagues, Rules, Teams & Player Draft Setup', () {
    test('1. League creation with rules and category auto-generation', () async {
      final leagueSyncId = const Uuid().v7();

      // Insert League
      await leaguesDataSource.insertLeague(
        LeaguesCompanion.insert(
          syncId: leagueSyncId,
          name: 'دوري المحترفين التجريبي',
          subscriptionPrice: '200',
          status: const Value('draft'),
          maxTeams: const Value(4),
          maxMainPlayers: const Value(5),
          maxSubPlayers: const Value(2),
        ),
      );

      // Verify League Retrieval
      final league = await leaguesDataSource.getLeague(leagueSyncId);
      expect(league.name, 'دوري المحترفين التجريبي');
      expect(league.status, 'draft');
      expect(league.maxTeams, 4);

      // Insert Rules
      final rules = [
        LeagueRuleModel(
          leagueSyncId: leagueSyncId,
          description: 'احترام قرارات الحكم أمر إلزامي',
        ),
        LeagueRuleModel(
          leagueSyncId: leagueSyncId,
          description: 'التأخر عن موعد المباراة 15 دقيقة يعني الانسحاب',
        ),
      ];
      final savedRules = await leaguesDataSource.insertRules(
        rule: rules,
        leagueSyncId: leagueSyncId,
      );
      expect(savedRules.length, 2);

      final fetchedRules = await leaguesDataSource.getRulesByLeague(leagueSyncId);
      expect(fetchedRules.length, 2);
      expect(fetchedRules.any((r) => r.description.contains('الحكم')), isTrue);

      // Auto-create Player Categories based on main + sub (5 + 2 = 7 categories)
      final categories = await leaguesDataSource.createCategoriesOnLeagueCreate(
        leagueSyncId: leagueSyncId,
        maxMainPlayers: 5,
        maxSubPlayers: 2,
      );
      expect(categories.length, 7);

      final fetchedCategories = await teamPlayerDataSource.getCategoriesByLeague(leagueSyncId);
      expect(fetchedCategories.length, 7);
    });

    test('2. League status flags transitions and query verification', () async {
      final leagueSyncId = const Uuid().v7();

      await leaguesDataSource.insertLeague(
        LeaguesCompanion.insert(
          syncId: leagueSyncId,
          name: 'دوري الفئات السنية',
          subscriptionPrice: '100',
          status: const Value('draft'),
        ),
      );

      // Initial status before updates
      var statusModel = await leaguesDataSource.getLeagueStatus(leagueSyncId);
      expect(statusModel.hasGroups, isFalse);
      expect(statusModel.hasMatches, isFalse);

      // Update flags: Groups drawn, matches scheduled
      await leaguesDataSource.updateLeagueStatus(
        leagueSyncId: leagueSyncId,
        hasGroups: true,
        hasTeamsInGroups: true,
        hasMatches: true,
      );

      statusModel = await leaguesDataSource.getLeagueStatus(leagueSyncId);
      expect(statusModel.hasGroups, isTrue);
      expect(statusModel.hasTeamsInGroups, isTrue);
      expect(statusModel.hasMatches, isTrue);
      expect(statusModel.hasKnockout, isFalse);

      // Transition league to active in leagues table
      await (db.update(db.leagues)..where((l) => l.syncId.equals(leagueSyncId))).write(
        const LeaguesCompanion(status: Value('active')),
      );

      final activeLeague = await leaguesDataSource.getLeague(leagueSyncId);
      expect(activeLeague.status, 'active');
    });

    test('3. Team auto-generation and team updates', () async {
      final leagueSyncId = const Uuid().v7();

      await leaguesDataSource.insertLeague(
        LeaguesCompanion.insert(
          syncId: leagueSyncId,
          name: 'دوري الأكاديميات',
          subscriptionPrice: '150',
          status: const Value('draft'),
        ),
      );

      // Create 4 default teams
      final teams = await leaguesDataSource.createTeamsOnLeagueCreate(
        leagueSyncId: leagueSyncId,
        maxTeams: 4,
      );
      expect(teams.length, 4);

      final leagueTeams = await teamPlayerDataSource.getTeamsByLeague(leagueSyncId);
      expect(leagueTeams.length, 4);
      expect(leagueTeams.map((t) => t.teamName), containsAll(['الفريق 1', 'الفريق 2', 'الفريق 3', 'الفريق 4']));

      // Update Team Name
      final teamToUpdate = leagueTeams.first;
      final updatedTeam = await teamPlayerDataSource.updateTeam(
        teamToUpdate.copyWith(teamName: 'نادي النجوم'),
      );
      expect(updatedTeam?.teamName, 'نادي النجوم');

      final refreshedTeams = await teamPlayerDataSource.getTeamsByLeague(leagueSyncId);
      expect(refreshedTeams.firstWhere((t) => t.syncId == teamToUpdate.syncId).teamName, 'نادي النجوم');
    });

    test('4. League player draft distribution (runDraft) assigns players evenly', () async {
      final leagueSyncId = const Uuid().v7();

      // Create League (2 teams, 2 players each)
      await leaguesDataSource.insertLeague(
        LeaguesCompanion.insert(
          syncId: leagueSyncId,
          name: 'دوري المسودة التجريبي',
          subscriptionPrice: '50',
          maxTeams: const Value(2),
          maxMainPlayers: const Value(2),
          maxSubPlayers: const Value(0),
        ),
      );

      // Create 2 teams
      final teams = await leaguesDataSource.createTeamsOnLeagueCreate(
        leagueSyncId: leagueSyncId,
        maxTeams: 2,
      );
      expect(teams.length, 2);

      // Register 4 League Players
      final playerNames = ['أحمد', 'خالد', 'سعد', 'محمد'];
      for (final name in playerNames) {
        await db.into(db.leaguePlayers).insert(
              LeaguePlayersCompanion.insert(
                syncId: const Uuid().v7(),
                leagueSyncId: leagueSyncId,
                name: Value(name),
              ),
            );
      }

      // Verify unassigned players count
      final unassigned = await teamPlayerDataSource.leaguePlayersWithoutTeam(leagueSyncId);
      expect(unassigned.length, 4);

      // Run Draft
      final draftedPlayers = await teamPlayerDataSource.runDraft(
        leagueSyncId: leagueSyncId,
        seed: 42,
      );
      expect(draftedPlayers.length, 4);

      // Check team rosters: Each team must have exactly 2 players
      final team1Players = await teamPlayerDataSource.getPlayerTeam(
        teamSyncId: teams[0].syncId,
      );
      final team2Players = await teamPlayerDataSource.getPlayerTeam(
        teamSyncId: teams[1].syncId,
      );

      expect(team1Players.length, 2);
      expect(team2Players.length, 2);

      // No unassigned players remain
      final remainingUnassigned = await teamPlayerDataSource.leaguePlayersWithoutTeam(leagueSyncId);
      expect(remainingUnassigned.isEmpty, isTrue);
    });
  });
}
