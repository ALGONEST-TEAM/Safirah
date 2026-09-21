import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late GroupsLocalDataSource groupsDataSource;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    groupsDataSource = GroupsLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Helper to create a single group with 4 teams
  Future<({String leagueSyncId, String groupSyncId, String roundSyncId, List<String> teamSyncIds})> setupGroupWith4Teams() async {
    final lSyncId = const Uuid().v7();
    final gSyncId = const Uuid().v7();
    final rSyncId = const Uuid().v7();

    await db.into(db.leagues).insert(
          LeaguesCompanion.insert(
            syncId: lSyncId,
            name: 'دوري الحسابات والترتيب',
            subscriptionPrice: '100',
            status: const Value('active'),
          ),
        );

    await db.into(db.group).insert(
          GroupCompanion.insert(
            syncId: gSyncId,
            leagueSyncId: lSyncId,
            groupName: 'A',
            qualifiedTeamNumber: const Value(2),
          ),
        );

    await db.into(db.rounds).insert(
          RoundsCompanion.insert(
            syncId: rSyncId,
            leagueSyncId: lSyncId,
            groupSyncId: Value(gSyncId),
            name: 'Group A - Round 1',
            roundType: 'group',
          ),
        );

    final teamIds = <String>[];
    for (var i = 1; i <= 4; i++) {
      final tId = const Uuid().v7();
      teamIds.add(tId);
      await db.into(db.teams).insert(
            TeamsCompanion.insert(
              syncId: tId,
              leagueSyncId: lSyncId,
              teamName: 'فريق $i',
            ),
          );

      await db.into(db.groupTeam).insert(
            GroupTeamCompanion.insert(
              syncId: const Uuid().v7(),
              groupSyncId: gSyncId,
              teamSyncId: tId,
            ),
          );

      await db.into(db.qualifiedTeam).insert(
            QualifiedTeamCompanion.insert(
              syncId: const Uuid().v7(),
              leagueSyncId: lSyncId,
              groupSyncId: gSyncId,
              teamSyncId: tId,
            ),
          );
    }

    return (leagueSyncId: lSyncId, groupSyncId: gSyncId, roundSyncId: rSyncId, teamSyncIds: teamIds);
  }

  group('Level 3: Standings, Points & Official Tiebreaker Tests', () {
    test('1. Basic Points Ordering: sorts teams strictly by points (9 > 6 > 3 > 0)', () async {
      final fixture = await setupGroupWith4Teams();

      // Set different points for teams
      final pointsConfig = [
        (fixture.teamSyncIds[0], 9, 3, 0, 0), // Team 1: 9 pts
        (fixture.teamSyncIds[1], 6, 2, 0, 1), // Team 2: 6 pts
        (fixture.teamSyncIds[2], 3, 1, 0, 2), // Team 3: 3 pts
        (fixture.teamSyncIds[3], 0, 0, 0, 3), // Team 4: 0 pts
      ];

      for (final cfg in pointsConfig) {
        await (db.update(db.qualifiedTeam)
              ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(cfg.$1)))
            .write(
          QualifiedTeamCompanion(
            points: Value(cfg.$2),
            wins: Value(cfg.$3),
            draws: Value(cfg.$4),
            losses: Value(cfg.$5),
            played: const Value(3),
          ),
        );
      }

      final groups = await groupsDataSource.getLeagueGroupsWithQualifiedTeams(fixture.leagueSyncId);
      expect(groups.length, 1);

      final standings = groups.first.qualifiedTeams;
      expect(standings.length, 4);
      expect(standings[0].teamSyncId, fixture.teamSyncIds[0]); // 9 pts
      expect(standings[1].teamSyncId, fixture.teamSyncIds[1]); // 6 pts
      expect(standings[2].teamSyncId, fixture.teamSyncIds[2]); // 3 pts
      expect(standings[3].teamSyncId, fixture.teamSyncIds[3]); // 0 pts
    });

    test('2. Goal Difference Tiebreaker: when points are equal, team with better GD ranks higher', () async {
      final fixture = await setupGroupWith4Teams();

      // Team 1 and Team 2 both have 6 points, but Team 1 has +4 GD and Team 2 has +1 GD
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(fixture.teamSyncIds[0])))
          .write(
        const QualifiedTeamCompanion(
          points: Value(6),
          goalsFor: Value(6),
          goalsAgainst: Value(2), // GD = +4
          played: Value(3),
        ),
      );

      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(fixture.teamSyncIds[1])))
          .write(
        const QualifiedTeamCompanion(
          points: Value(6),
          goalsFor: Value(3),
          goalsAgainst: Value(2), // GD = +1
          played: Value(3),
        ),
      );

      final groups = await groupsDataSource.getLeagueGroupsWithQualifiedTeams(fixture.leagueSyncId);
      final standings = groups.first.qualifiedTeams;

      // Team 1 should rank above Team 2 due to GD (+4 vs +1)
      expect(standings[0].teamSyncId, fixture.teamSyncIds[0]);
      expect(standings[1].teamSyncId, fixture.teamSyncIds[1]);
    });

    test('3. Head-to-Head (H2H) Tiebreaker: when points and GD are equal, direct match winner ranks higher', () async {
      final fixture = await setupGroupWith4Teams();

      // Team 1 and Team 2 both have 6 points AND identical GD = +2 (4-2)
      for (final tId in [fixture.teamSyncIds[0], fixture.teamSyncIds[1]]) {
        await (db.update(db.qualifiedTeam)
              ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(tId)))
            .write(
          const QualifiedTeamCompanion(
            points: Value(6),
            goalsFor: Value(4),
            goalsAgainst: Value(2), // GD = +2
            played: Value(3),
          ),
        );
      }

      // Record a direct match where Team 2 beat Team 1 (2 - 1)
      await db.into(db.matches).insert(
            MatchesCompanion.insert(
              syncId: const Uuid().v7(),
              leagueSyncId: fixture.leagueSyncId,
              roundSyncId: fixture.roundSyncId,
              homeTeamSyncId: fixture.teamSyncIds[1], // Team 2 (Home)
              awayTeamSyncId: fixture.teamSyncIds[0], // Team 1 (Away)
              homeScore: const Value(2),
              awayScore: const Value(1),
              status: const Value('finished'),
              matchDate: DateTime.now(),
            ),
          );

      final groups = await groupsDataSource.getLeagueGroupsWithQualifiedTeams(fixture.leagueSyncId);
      final standings = groups.first.qualifiedTeams;

      // Team 2 must rank higher than Team 1 because Team 2 won the H2H direct match!
      expect(standings[0].teamSyncId, fixture.teamSyncIds[1]);
      expect(standings[1].teamSyncId, fixture.teamSyncIds[0]);
    });

    test('4. Goals For Tiebreaker: when points, GD and H2H are equal, team with more goals scored ranks higher', () async {
      final fixture = await setupGroupWith4Teams();

      // Team 1 and Team 2 both have 4 points, GD = 0
      // Team 1 scored 5 goals (5-5)
      // Team 2 scored 3 goals (3-3)
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(fixture.teamSyncIds[0])))
          .write(
        const QualifiedTeamCompanion(
          points: Value(4),
          goalsFor: Value(5),
          goalsAgainst: Value(5), // GD = 0
          played: Value(3),
        ),
      );

      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(fixture.leagueSyncId) & q.teamSyncId.equals(fixture.teamSyncIds[1])))
          .write(
        const QualifiedTeamCompanion(
          points: Value(4),
          goalsFor: Value(3),
          goalsAgainst: Value(3), // GD = 0
          played: Value(3),
        ),
      );

      // Direct match was a draw (1 - 1)
      await db.into(db.matches).insert(
            MatchesCompanion.insert(
              syncId: const Uuid().v7(),
              leagueSyncId: fixture.leagueSyncId,
              roundSyncId: fixture.roundSyncId,
              homeTeamSyncId: fixture.teamSyncIds[0],
              awayTeamSyncId: fixture.teamSyncIds[1],
              homeScore: const Value(1),
              awayScore: const Value(1),
              status: const Value('finished'),
              matchDate: DateTime.now(),
            ),
          );

      final groups = await groupsDataSource.getLeagueGroupsWithQualifiedTeams(fixture.leagueSyncId);
      final standings = groups.first.qualifiedTeams;

      // Team 1 ranks higher because goalsFor = 5 > goalsFor = 3
      expect(standings[0].teamSyncId, fixture.teamSyncIds[0]);
      expect(standings[1].teamSyncId, fixture.teamSyncIds[1]);
    });
  });
}
