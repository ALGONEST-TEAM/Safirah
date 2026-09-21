import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late GroupsLocalDataSource groupsDataSource;
  late MatchesLocalDataSource matchesDataSource;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    groupsDataSource = GroupsLocalDataSource(db);
    matchesDataSource = MatchesLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Helper to setup a league with 8 teams and 2 league terms
  Future<({String leagueSyncId, List<String> teamSyncIds})> setupLeagueWith8Teams() async {
    await TestDbHelper.seedDefaultTerms(db);

    final lSyncId = const Uuid().v7();
    await db.into(db.leagues).insert(
          LeaguesCompanion.insert(
            syncId: lSyncId,
            name: 'دوري المجموعات 8 فرق',
            subscriptionPrice: '100',
            status: const Value('draft'),
          ),
        );

    // Setup LeagueTerms (شوط أول وثانٍ)
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

    // 8 Teams
    final teamIds = <String>[];
    for (var i = 1; i <= 8; i++) {
      final tId = const Uuid().v7();
      teamIds.add(tId);
      await db.into(db.teams).insert(
            TeamsCompanion.insert(
              syncId: tId,
              leagueSyncId: lSyncId,
              teamName: 'فريق $i',
            ),
          );
    }

    return (leagueSyncId: lSyncId, teamSyncIds: teamIds);
  }

  group('Level 2: Group Stage Draw, Rounds & Round-Robin Fixtures', () {
    test('1. drawGroupsByCount evenly distributes 8 teams into 2 groups (A & B) with qualifiedTeam setup', () async {
      final setup = await setupLeagueWith8Teams();

      final drawPayloads = await groupsDataSource.drawGroupsByCount(
        leagueSyncId: setup.leagueSyncId,
        groupsCount: 2,
        qualifiedPerGroup: 2,
        useLetters: true,
      );

      expect(drawPayloads.length, 2);

      // Verify Groups in DB
      final groups = await (db.select(db.group)..where((g) => g.leagueSyncId.equals(setup.leagueSyncId))).get();
      expect(groups.length, 2);
      expect(groups.map((g) => g.groupName), containsAll(['A', 'B']));

      // Verify each group has exactly 4 teams
      for (final g in groups) {
        final groupTeams = await (db.select(db.groupTeam)..where((gt) => gt.groupSyncId.equals(g.syncId))).get();
        expect(groupTeams.length, 4);
      }

      // Verify Qualified Teams initialized with 0 points
      final qualified = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(setup.leagueSyncId)))
          .get();
      expect(qualified.length, 8);
      for (final q in qualified) {
        expect(q.points, 0);
        expect(q.played, 0);
        expect(q.wins, 0);
        expect(q.draws, 0);
        expect(q.losses, 0);
        expect(q.goalsFor, 0);
        expect(q.goalsAgainst, 0);
      }
    });

    test('2. generateGroupStageRounds creates exactly 3 rounds per group (6 rounds total) and is idempotent', () async {
      final setup = await setupLeagueWith8Teams();
      await groupsDataSource.drawGroupsByCount(
        leagueSyncId: setup.leagueSyncId,
        groupsCount: 2,
        qualifiedPerGroup: 2,
      );

      // First run: Creates 6 rounds (3 for Group A + 3 for Group B)
      final createdRounds = await matchesDataSource.ensureGroupRounds(
        leagueSyncId: setup.leagueSyncId,
      );
      expect(createdRounds.length, 6);

      final roundsInDb = await (db.select(db.rounds)..where((r) => r.leagueSyncId.equals(setup.leagueSyncId))).get();
      expect(roundsInDb.length, 6);

      // Idempotency: Running again creates 0 new rounds
      final secondRun = await matchesDataSource.ensureGroupRounds(
        leagueSyncId: setup.leagueSyncId,
      );
      expect(secondRun.isEmpty, isTrue);

      final roundsAfterSecondRun = await (db.select(db.rounds)..where((r) => r.leagueSyncId.equals(setup.leagueSyncId))).get();
      expect(roundsAfterSecondRun.length, 6);
    });

    test('3. scheduleGroupStageMatchesRR generates complete Round-Robin schedule with match terms', () async {
      final setup = await setupLeagueWith8Teams();
      await groupsDataSource.drawGroupsByCount(
        leagueSyncId: setup.leagueSyncId,
        groupsCount: 2,
        qualifiedPerGroup: 2,
      );
      await matchesDataSource.ensureGroupRounds(
        leagueSyncId: setup.leagueSyncId,
      );

      // Generate Round-Robin matches
      final scheduledMatches = await matchesDataSource.scheduleGroupStageMatchesRR(
        leagueSyncId: setup.leagueSyncId,
        homeAway: false,
      );

      // 4 teams per group -> 6 matches per group -> 12 matches total
      expect(scheduledMatches.length, 12);

      final matchesInDb = await (db.select(db.matches)..where((m) => m.leagueSyncId.equals(setup.leagueSyncId))).get();
      expect(matchesInDb.length, 12);

      // Verify every match has 2 terms created
      for (final m in matchesInDb) {
        final terms = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(m.syncId))).get();
        expect(terms.length, 2);
      }

      // Verify Round-Robin pairing integrity:
      // For each group, verify every team plays each other team exactly once
      final groups = await (db.select(db.group)..where((g) => g.leagueSyncId.equals(setup.leagueSyncId))).get();
      for (final g in groups) {
        // Get all rounds for this group
        final groupRounds = await (db.select(db.rounds)
              ..where((r) => r.leagueSyncId.equals(setup.leagueSyncId) & r.groupSyncId.equals(g.syncId)))
            .get();
        final groupRoundSyncIds = groupRounds.map((r) => r.syncId).toSet();

        // Matches in this group
        final groupMatches = matchesInDb.where((m) => groupRoundSyncIds.contains(m.roundSyncId)).toList();
        expect(groupMatches.length, 6);

        // Verify no team plays twice in the same round
        for (final r in groupRounds) {
          final roundMatches = groupMatches.where((m) => m.roundSyncId == r.syncId).toList();
          expect(roundMatches.length, 2); // 2 matches per round

          final teamsInRound = <String>{};
          for (final m in roundMatches) {
            expect(teamsInRound.add(m.homeTeamSyncId), isTrue, reason: 'Team played twice in same round');
            expect(teamsInRound.add(m.awayTeamSyncId), isTrue, reason: 'Team played twice in same round');
          }
          expect(teamsInRound.length, 4); // All 4 teams play in each round
        }

        // Verify all pairs played exactly once
        final playedPairs = <String>{};
        for (final m in groupMatches) {
          final pair = [m.homeTeamSyncId, m.awayTeamSyncId]..sort();
          final pairKey = '${pair[0]}_${pair[1]}';
          expect(playedPairs.add(pairKey), isTrue, reason: 'Teams played each other more than once');
        }
        expect(playedPairs.length, 6); // 4 choose 2 = 6 unique pairs
      }
    });
  });
}
