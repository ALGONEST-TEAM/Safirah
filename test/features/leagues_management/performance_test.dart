import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_knockout_data_source.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late MatchesLocalDataSource matchesDs;
  late KnockoutGeneratorLocalDataSource knockoutDs;

  setUp(() async {
    db = TestDbHelper.createTestDatabase();
    matchesDs = MatchesLocalDataSource(db);
    knockoutDs = KnockoutGeneratorLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Batch query optimization: getLeagueRoundsWithGroupsAndMatches returns correct grouped rounds and terms', () async {
    final fixture = await TestDbHelper.createLeagueFixture(db);

    // Create a round following the app's standard format (e.g. Group A Round 1)
    final roundSyncId = const Uuid().v7();
    await db.into(db.rounds).insert(
      RoundsCompanion.insert(
        syncId: roundSyncId,
        leagueSyncId: fixture.leagueSyncId,
        groupSyncId: Value(fixture.groupSyncId),
        name: 'Group A Round 1',
        roundType: 'group',
      ),
    );

    final matchSyncId = const Uuid().v7();
    await db.into(db.matches).insert(
      MatchesCompanion.insert(
        syncId: matchSyncId,
        leagueSyncId: fixture.leagueSyncId,
        roundSyncId: roundSyncId,
        homeTeamSyncId: fixture.teamSyncIds[0],
        awayTeamSyncId: fixture.teamSyncIds[1],
        status: const Value('scheduled'),
        matchDate: DateTime.now(),
        homeScore: const Value(0),
        awayScore: const Value(0),
      ),
    );

    await db.into(db.matchTerms).insert(
      MatchTermsCompanion.insert(
        syncId: const Uuid().v7(),
        matchSyncId: matchSyncId,
        leagueTermSyncId: fixture.leagueTerm1SyncId,
        isFinished: const Value(false),
      ),
    );

    // Act: Query rounds with filter 'all'
    final rounds = await matchesDs.getLeagueRoundsWithGroupsAndMatches(
      leagueSyncId: fixture.leagueSyncId,
      matchFilter: 'all',
    );

    // Assert:
    expect(rounds.isNotEmpty, isTrue);
    expect(rounds[0].roundName, 'Round 1');
    expect(rounds[0].groups.isNotEmpty, isTrue);
    expect(rounds[0].groups[0].groupName, 'المجموعة A');
    expect(rounds[0].groups[0].matches.isNotEmpty, isTrue);
    expect(rounds[0].groups[0].matches[0].syncId, matchSyncId);
    expect(rounds[0].groups[0].matches[0].matchTerms.length, 1);
    expect(rounds[0].groups[0].matches[0].homeTeam?.teamName, 'الهلال');
    expect(rounds[0].groups[0].matches[0].awayTeam?.teamName, 'النصر');

    // Act 2: Filter by 'finished'
    final finishedRounds = await matchesDs.getLeagueRoundsWithGroupsAndMatches(
      leagueSyncId: fixture.leagueSyncId,
      matchFilter: 'finished',
    );
    expect(finishedRounds.isEmpty, isTrue);

    // Act 3: Filter by 'scheduled'
    final scheduledRounds = await matchesDs.getLeagueRoundsWithGroupsAndMatches(
      leagueSyncId: fixture.leagueSyncId,
      matchFilter: 'scheduled',
    );
    expect(scheduledRounds.isNotEmpty, isTrue);
    expect(scheduledRounds[0].groups[0].matches[0].status, 'scheduled');
  });

  test('Batch query optimization: getAllKnockoutRoundsWithMatches returns all knockout rounds & terms', () async {
    final fixture = await TestDbHelper.createLeagueFixture(db);

    final knockoutRoundSyncId = const Uuid().v7();
    final matchSyncId = const Uuid().v7();

    // 1. Insert knockout round
    await db.into(db.rounds).insert(
      RoundsCompanion.insert(
        syncId: knockoutRoundSyncId,
        leagueSyncId: fixture.leagueSyncId,
        name: 'Final',
        roundType: 'knockout',
      ),
    );

    // 2. Insert knockout match
    await db.into(db.matches).insert(
      MatchesCompanion.insert(
        syncId: matchSyncId,
        leagueSyncId: fixture.leagueSyncId,
        roundSyncId: knockoutRoundSyncId,
        homeTeamSyncId: fixture.teamSyncIds[0],
        awayTeamSyncId: fixture.teamSyncIds[1],
        status: const Value('live'),
        matchDate: DateTime.now(),
        homeScore: const Value(1),
        awayScore: const Value(1),
      ),
    );

    // 3. Insert match terms
    await db.into(db.matchTerms).insert(
      MatchTermsCompanion.insert(
        syncId: const Uuid().v7(),
        matchSyncId: matchSyncId,
        leagueTermSyncId: fixture.leagueTerm1SyncId,
        isFinished: const Value(true),
      ),
    );

    // Act:
    final knockoutRounds = await knockoutDs.getAllKnockoutRoundsWithMatches(
      fixture.leagueSyncId,
      'all',
    );

    // Assert:
    expect(knockoutRounds.length, 1);
    expect(knockoutRounds[0].roundName, 'Final');
    expect(knockoutRounds[0].matches!.length, 1);
    expect(knockoutRounds[0].matches![0].syncId, matchSyncId);
    expect(knockoutRounds[0].matches![0].homeTeam?.teamName, 'الهلال');
    expect(knockoutRounds[0].matches![0].awayTeam?.teamName, 'النصر');
    expect(knockoutRounds[0].matches![0].matchTerms.length, 1);
  });
}
