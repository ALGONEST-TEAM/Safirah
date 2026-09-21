import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_knockout_data_source.dart';
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late GroupsLocalDataSource groupsDataSource;
  late MatchesLocalDataSource matchesDataSource;
  late KnockoutGeneratorLocalDataSource knockoutDataSource;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    groupsDataSource = GroupsLocalDataSource(db);
    matchesDataSource = MatchesLocalDataSource(db);
    knockoutDataSource = KnockoutGeneratorLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Helper to setup a full 8-team league with groups and fixtures
  Future<({String leagueSyncId, List<String> teamSyncIds})> setupLeagueWithCompletedGroups() async {
    await TestDbHelper.seedDefaultTerms(db);

    final lSyncId = const Uuid().v7();
    await db.into(db.leagues).insert(
          LeaguesCompanion.insert(
            syncId: lSyncId,
            name: 'دوري التصفيات والنهائيات',
            subscriptionPrice: '100',
            status: const Value('active'),
          ),
        );

    // Setup 5 terms (2 regular, 2 extra, 1 penalty) for the league
    final ltDefs = [
      (const Uuid().v7(), TestDbHelper.termRegular1SyncId),
      (const Uuid().v7(), TestDbHelper.termRegular2SyncId),
      (const Uuid().v7(), TestDbHelper.termExtra1SyncId),
      (const Uuid().v7(), TestDbHelper.termExtra2SyncId),
      (const Uuid().v7(), TestDbHelper.termPenaltySyncId),
    ];

    await db.batch((batch) {
      batch.insertAll(
        db.leagueTerms,
        ltDefs.map((d) => LeagueTermsCompanion.insert(
              syncId: d.$1,
              leagueSyncId: lSyncId,
              termSyncId: d.$2,
              durationMinutes: const Value(45),
            )),
      );
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

    // Draw 2 groups
    await groupsDataSource.drawGroupsByCount(
      leagueSyncId: lSyncId,
      groupsCount: 2,
      qualifiedPerGroup: 2,
    );

    // Ensure group rounds & schedule matches
    await matchesDataSource.ensureGroupRounds(leagueSyncId: lSyncId);
    await matchesDataSource.scheduleGroupStageMatchesRR(leagueSyncId: lSyncId);

    return (leagueSyncId: lSyncId, teamSyncIds: teamIds);
  }

  group('Level 4: Knockout Generation & Bracket Progression Tests', () {
    test('1. Premature knockout generation throws exception if group matches are unfinished', () async {
      final setup = await setupLeagueWithCompletedGroups();

      // Matches are still scheduled (not finished)
      expect(
        () => knockoutDataSource.generateKnockoutFromGroups(
          leagueSyncId: setup.leagueSyncId,
          qualifiedPerGroup: 2,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('2. generateKnockoutFromGroups creates Semi-Finals pairing top 2 from each group', () async {
      final setup = await setupLeagueWithCompletedGroups();

      // Finish all group matches
      await (db.update(db.matches)..where((m) => m.leagueSyncId.equals(setup.leagueSyncId))).write(
        const MatchesCompanion(status: Value('finished')),
      );

      // Setup standings so we know exactly who finished 1st and 2nd in each group
      final groups = await (db.select(db.group)..where((g) => g.leagueSyncId.equals(setup.leagueSyncId))).get();
      final groupA = groups.firstWhere((g) => g.groupName == 'A');
      final groupB = groups.firstWhere((g) => g.groupName == 'B');

      final groupATeams = await (db.select(db.groupTeam)..where((gt) => gt.groupSyncId.equals(groupA.syncId))).get();
      final groupBTeams = await (db.select(db.groupTeam)..where((gt) => gt.groupSyncId.equals(groupB.syncId))).get();

      // In Group A: Team 0 is 1st (9 pts), Team 1 is 2nd (6 pts)
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(setup.leagueSyncId) & q.teamSyncId.equals(groupATeams[0].teamSyncId)))
          .write(const QualifiedTeamCompanion(points: Value(9)));
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(setup.leagueSyncId) & q.teamSyncId.equals(groupATeams[1].teamSyncId)))
          .write(const QualifiedTeamCompanion(points: Value(6)));

      // In Group B: Team 0 is 1st (9 pts), Team 1 is 2nd (6 pts)
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(setup.leagueSyncId) & q.teamSyncId.equals(groupBTeams[0].teamSyncId)))
          .write(const QualifiedTeamCompanion(points: Value(9)));
      await (db.update(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(setup.leagueSyncId) & q.teamSyncId.equals(groupBTeams[1].teamSyncId)))
          .write(const QualifiedTeamCompanion(points: Value(6)));

      // Generate First Knockout Round (Semi-Finals)
      final koRound = await knockoutDataSource.generateKnockoutFromGroups(
        leagueSyncId: setup.leagueSyncId,
        qualifiedPerGroup: 2,
      );

      expect(koRound.roundType, 'knockout');
      final koMatches = koRound.matches ?? [];
      expect(koMatches.length, 2); // 2 Semi-Final matches

      // Verify the 4 qualifying teams are the ones playing
      final koTeamIds = <String>{
        for (final m in koMatches) ...[m.homeTeamSyncId!, m.awayTeamSyncId!]
      };

      expect(koTeamIds, contains(groupATeams[0].teamSyncId)); // 1st of A
      expect(koTeamIds, contains(groupATeams[1].teamSyncId)); // 2nd of A
      expect(koTeamIds, contains(groupBTeams[0].teamSyncId)); // 1st of B
      expect(koTeamIds, contains(groupBTeams[1].teamSyncId)); // 2nd of B

      // Each knockout match must have terms initialized
      for (final m in koMatches) {
        final terms = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(m.syncId!))).get();
        expect(terms.isNotEmpty, isTrue);
      }
    });

    test('3. Knockout Idempotency: repeated call returns existing round and does not duplicate', () async {
      final setup = await setupLeagueWithCompletedGroups();

      // Finish all matches
      await (db.update(db.matches)..where((m) => m.leagueSyncId.equals(setup.leagueSyncId))).write(
        const MatchesCompanion(status: Value('finished')),
      );

      final firstCall = await knockoutDataSource.generateKnockoutFromGroups(
        leagueSyncId: setup.leagueSyncId,
        qualifiedPerGroup: 2,
      );

      final secondCall = await knockoutDataSource.generateKnockoutFromGroups(
        leagueSyncId: setup.leagueSyncId,
        qualifiedPerGroup: 2,
      );

      expect(secondCall.syncId, firstCall.syncId);

      // Verify DB contains only 1 knockout round
      final koRoundsInDb = await (db.select(db.rounds)
            ..where((r) => r.leagueSyncId.equals(setup.leagueSyncId) & r.roundType.equals('knockout')))
          .get();
      expect(koRoundsInDb.length, 1);
    });

    test('4. createNextKnockoutRoundFromFinished advances Semi-Final winners to the Grand Final', () async {
      final setup = await setupLeagueWithCompletedGroups();

      // Finish group matches & generate semi-finals
      await (db.update(db.matches)..where((m) => m.leagueSyncId.equals(setup.leagueSyncId))).write(
        const MatchesCompanion(status: Value('finished')),
      );

      final semiFinalRound = await knockoutDataSource.generateKnockoutFromGroups(
        leagueSyncId: setup.leagueSyncId,
        qualifiedPerGroup: 2,
      );

      final sfMatches = semiFinalRound.matches ?? [];
      expect(sfMatches.length, 2);

      // Play Semi-Final 1: Home team wins (3 - 1)
      final sf1 = sfMatches[0];
      await (db.update(db.matches)..where((m) => m.syncId.equals(sf1.syncId!))).write(
        const MatchesCompanion(
          homeScore: Value(3),
          awayScore: Value(1),
          status: Value('finished'),
        ),
      );

      // Play Semi-Final 2: Away team wins (0 - 2)
      final sf2 = sfMatches[1];
      await (db.update(db.matches)..where((m) => m.syncId.equals(sf2.syncId!))).write(
        const MatchesCompanion(
          homeScore: Value(0),
          awayScore: Value(2),
          status: Value('finished'),
        ),
      );

      // Advance to the Next Knockout Round (Grand Final)
      final finalRound = await knockoutDataSource.createNextKnockoutRoundFromFinished(
        leagueSyncId: setup.leagueSyncId,
        finishedRoundSyncId: semiFinalRound.syncId!,
      );

      expect(finalRound, isNotNull);
      expect(finalRound!.roundType, 'knockout');
      final finalMatches = finalRound.matches ?? [];
      expect(finalMatches.length, 1); // 1 Final match!

      // The 2 finalists must be sf1.homeTeamSyncId and sf2.awayTeamSyncId
      final finalMatch = finalMatches[0];
      final finalists = {finalMatch.homeTeamSyncId, finalMatch.awayTeamSyncId};
      expect(finalists, contains(sf1.homeTeamSyncId));
      expect(finalists, contains(sf2.awayTeamSyncId));
    });
  });
}
