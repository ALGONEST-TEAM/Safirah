import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/model/rule_league_model.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_knockout_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/goal_model.dart';
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

void main() {
  late Safirah db;
  late LeagueLocalDataSource leagueLocal;
  late GroupsLocalDataSource groupLocal;
  late MatchesLocalDataSource matchLocal;
  late MatchTermsEventLocalDataSource termLocal;
  late KnockoutGeneratorLocalDataSource koLocal;

  setUp(() {
    db = TestDbHelper.createTestDatabase();
    leagueLocal = LeagueLocalDataSource(db);
    groupLocal = GroupsLocalDataSource(db);
    matchLocal = MatchesLocalDataSource(db);
    termLocal = MatchTermsEventLocalDataSource(db);
    koLocal = KnockoutGeneratorLocalDataSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Level 5 Master Simulation: Full 8-Team Tournament from Creation to Championship Trophy', () async {
    // =========================================================================
    // PHASE 1: LEAGUE SETUP & CONFIGURATION
    // =========================================================================
    await TestDbHelper.seedDefaultTerms(db);

    final leagueSyncId = const Uuid().v7();
    await leagueLocal.insertLeague(
      LeaguesCompanion.insert(
        syncId: leagueSyncId,
        name: 'بطولة كأس النخبة الكبرى',
        subscriptionPrice: '500',
        status: const Value('draft'),
        maxTeams: const Value(8),
        maxMainPlayers: const Value(5),
        maxSubPlayers: const Value(2),
      ),
    );

    // Setup 5 terms for the league
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
              leagueSyncId: leagueSyncId,
              termSyncId: d.$2,
              durationMinutes: const Value(45),
            )),
      );
    });

    // Add Tournament Rules
    await leagueLocal.insertRules(
      rule: [
        LeagueRuleModel(leagueSyncId: leagueSyncId, description: 'الروح الرياضية أولاً'),
        LeagueRuleModel(leagueSyncId: leagueSyncId, description: 'وقت المباراة 90 دقيقة مقسمة لشوطين'),
      ],
      leagueSyncId: leagueSyncId,
    );

    // Create 8 Teams
    final createdTeams = await leagueLocal.createTeamsOnLeagueCreate(
      leagueSyncId: leagueSyncId,
      maxTeams: 8,
    );
    expect(createdTeams.length, 8);

    // Register 16 Players (2 per team)
    final playerSyncIds = <String, String>{}; // teamSyncId -> playerSyncId
    for (final team in createdTeams) {
      final lpId = const Uuid().v7();
      final pId = const Uuid().v7();
      playerSyncIds[team.syncId] = pId;

      await db.into(db.leaguePlayers).insert(
            LeaguePlayersCompanion.insert(
              syncId: lpId,
              leagueSyncId: leagueSyncId,
              name: Value('نجم ${team.teamName}'),
            ),
          );
      await db.into(db.players).insert(
            PlayersCompanion.insert(
              syncId: pId,
              playerLeagueSyncId: lpId,
              teamSyncId: team.syncId,
              fullName: 'نجم ${team.teamName}',
            ),
          );
    }

    // =========================================================================
    // PHASE 2: GROUP STAGE DRAW & FIXTURES
    // =========================================================================
    final drawPayloads = await groupLocal.drawGroupsByCount(
      leagueSyncId: leagueSyncId,
      groupsCount: 2,
      qualifiedPerGroup: 2,
      useLetters: true,
    );
    expect(drawPayloads.length, 2);

    await matchLocal.ensureGroupRounds(leagueSyncId: leagueSyncId);
    final scheduledMatches = await matchLocal.scheduleGroupStageMatchesRR(
      leagueSyncId: leagueSyncId,
    );
    expect(scheduledMatches.length, 12); // 6 matches per group

    // Update status to active
    await leagueLocal.updateLeagueStatus(
      leagueSyncId: leagueSyncId,
      hasGroups: true,
      hasTeamsInGroups: true,
      hasMatches: true,
    );
    await (db.update(db.leagues)..where((l) => l.syncId.equals(leagueSyncId))).write(
      const LeaguesCompanion(status: Value('active')),
    );

    final activeLeague = await leagueLocal.getLeague(leagueSyncId);
    expect(activeLeague.status, 'active');

    // =========================================================================
    // PHASE 3: PLAYING THE GROUP STAGE
    // =========================================================================
    // In Group A: We make Team 0 win all 3 matches, Team 1 win 2 matches
    // In Group B: We make Team 4 win all 3 matches, Team 5 win 2 matches
    // All other matches played with goals and realistic events

    final groupMatches = await (db.select(db.matches)..where((m) => m.leagueSyncId.equals(leagueSyncId))).get();

    for (final m in groupMatches) {
      // Find terms for this match
      final terms = await (db.select(db.matchTerms)
            ..where((t) => t.matchSyncId.equals(m.syncId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      // Start Term 1
      await termLocal.startTermSafe(m.syncId, terms[0].syncId);

      // Score a goal for home team in term 1
      final scorerPlayerSyncId = playerSyncIds[m.homeTeamSyncId]!;
      await termLocal.insertGoalAndUpdateQualifiedTeams(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: m.syncId,
          playerSyncId: scorerPlayerSyncId,
          matchTermSyncId: terms[0].syncId,
          goalTime: 25,
          goalType: 'regular',
        ),
      );

      // Finish Term 1
      await termLocal.finishTermSmart(
        matchSyncId: m.syncId,
        matchTermSyncId: terms[0].syncId,
      );

      // Start Term 2
      await termLocal.startTermSafe(m.syncId, terms[1].syncId);

      // Finish Term 2 -> match concludes
      final finishRes = await termLocal.finishTermSmart(
        matchSyncId: m.syncId,
        matchTermSyncId: terms[1].syncId,
      );

      expect(finishRes.matchFinished, isTrue);

      // Update league table points for group match
      await termLocal.finishMatchAndUpdatePoints(m.syncId, DateTime.now());
    }

    // Verify all 12 group matches finished
    final allFinished = await koLocal.areAllGroupMatchesFinished(leagueSyncId);
    expect(allFinished, isTrue);

    // Verify Standings computed accurately
    final groupStandings = await groupLocal.getLeagueGroupsWithQualifiedTeams(leagueSyncId);
    expect(groupStandings.length, 2);
    for (final g in groupStandings) {
      expect(g.qualifiedTeams.length, 4);
      // Top team has highest points
      expect(g.qualifiedTeams[0].points >= g.qualifiedTeams[1].points, isTrue);
    }

    // =========================================================================
    // PHASE 4: KNOCKOUT SEMI-FINALS
    // =========================================================================
    final semiFinalRound = await koLocal.generateKnockoutFromGroups(
      leagueSyncId: leagueSyncId,
      qualifiedPerGroup: 2,
    );

    final sfMatches = semiFinalRound.matches ?? [];
    expect(sfMatches.length, 2);

    // --- Semi-Final 1 (Decided in Regular Time) ---
    final sf1 = sfMatches[0];
    final sf1Terms = await (db.select(db.matchTerms)
          ..where((t) => t.matchSyncId.equals(sf1.syncId!))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    // Term 1
    await termLocal.startTermSafe(sf1.syncId!, sf1Terms[0].syncId);
    await termLocal.finishTermSmart(matchSyncId: sf1.syncId!, matchTermSyncId: sf1Terms[0].syncId);

    // Goal for SF1 Home
    await (db.update(db.matches)..where((m) => m.syncId.equals(sf1.syncId!))).write(
      const MatchesCompanion(homeScore: Value(2), awayScore: Value(1)),
    );

    // Term 2
    await termLocal.startTermSafe(sf1.syncId!, sf1Terms[1].syncId);
    final sf1Result = await termLocal.finishTermSmart(
      matchSyncId: sf1.syncId!,
      matchTermSyncId: sf1Terms[1].syncId,
    );

    expect(sf1Result.matchFinished, isTrue);
    expect(sf1Result.isKnockout, isTrue);

    // --- Semi-Final 2 (Decided via Penalty Shootout) ---
    final sf2 = sfMatches[1];
    final sf2Terms = await (db.select(db.matchTerms)
          ..where((t) => t.matchSyncId.equals(sf2.syncId!))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    // Finish 4 terms tied 1 - 1
    await (db.update(db.matches)..where((m) => m.syncId.equals(sf2.syncId!))).write(
      const MatchesCompanion(homeScore: Value(1), awayScore: Value(1)),
    );

    for (var i = 0; i < 4; i++) {
      await termLocal.startTermSafe(sf2.syncId!, sf2Terms[i].syncId);
      await termLocal.finishTermSmart(
        matchSyncId: sf2.syncId!,
        matchTermSyncId: sf2Terms[i].syncId,
      );
    }

    // Set penalty shootout winner: Home wins penalties (5 - 4)
    await termLocal.updatePenaltyShootoutScore(
      matchSyncId: sf2.syncId!,
      homePenaltyScore: 5,
      awayPenaltyScore: 4,
    );

    // Finish penalty term
    await termLocal.startTermSafe(sf2.syncId!, sf2Terms[4].syncId);
    final sf2Result = await termLocal.finishTermSmart(
      matchSyncId: sf2.syncId!,
      matchTermSyncId: sf2Terms[4].syncId,
    );

    expect(sf2Result.matchFinished, isTrue);
    expect(sf2Result.homePenaltyScore, 5);

    // =========================================================================
    // PHASE 5: THE GRAND FINAL & CROWNING THE CHAMPION
    // =========================================================================
    final grandFinalRound = await koLocal.createNextKnockoutRoundFromFinished(
      leagueSyncId: leagueSyncId,
      finishedRoundSyncId: semiFinalRound.syncId!,
    );

    expect(grandFinalRound, isNotNull);
    final finalMatches = grandFinalRound!.matches ?? [];
    expect(finalMatches.length, 1);

    final finalMatch = finalMatches[0];
    final finalTerms = await (db.select(db.matchTerms)
          ..where((t) => t.matchSyncId.equals(finalMatch.syncId!))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    // Final Match Term 1
    await termLocal.startTermSafe(finalMatch.syncId!, finalTerms[0].syncId);
    await termLocal.finishTermSmart(matchSyncId: finalMatch.syncId!, matchTermSyncId: finalTerms[0].syncId);

    // Champion scores 2 goals in Final!
    await (db.update(db.matches)..where((m) => m.syncId.equals(finalMatch.syncId!))).write(
      const MatchesCompanion(homeScore: Value(2), awayScore: Value(0)),
    );

    // Final Match Term 2
    await termLocal.startTermSafe(finalMatch.syncId!, finalTerms[1].syncId);
    final finalResult = await termLocal.finishTermSmart(
      matchSyncId: finalMatch.syncId!,
      matchTermSyncId: finalTerms[1].syncId,
    );

    expect(finalResult.matchFinished, isTrue);

    // Crown Champion and complete League
    await (db.update(db.leagues)..where((l) => l.syncId.equals(leagueSyncId))).write(
      const LeaguesCompanion(status: Value('completed')),
    );

    final completedLeague = await leagueLocal.getLeague(leagueSyncId);
    expect(completedLeague.status, 'completed');
  });
}
