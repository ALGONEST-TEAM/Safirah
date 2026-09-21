import 'package:drift/drift.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:uuid/uuid.dart';

class LeagueFixture {
  final String leagueSyncId;
  final String leagueName;
  final List<String> teamSyncIds;
  final Map<String, String> teamNames;
  final String groupSyncId;
  final String roundSyncId;
  final String matchSyncId;
  final String term1SyncId; // الشوط الأول
  final String term2SyncId; // الشوط الثاني
  final String leagueTerm1SyncId;
  final String leagueTerm2SyncId;
  final String homePlayerSyncId;
  final String awayPlayerSyncId;

  const LeagueFixture({
    required this.leagueSyncId,
    required this.leagueName,
    required this.teamSyncIds,
    required this.teamNames,
    required this.groupSyncId,
    required this.roundSyncId,
    required this.matchSyncId,
    required this.term1SyncId,
    required this.term2SyncId,
    required this.leagueTerm1SyncId,
    required this.leagueTerm2SyncId,
    required this.homePlayerSyncId,
    required this.awayPlayerSyncId,
  });
}

class TestDbHelper {
  static const termRegular1SyncId = '967d9f64-cb79-464d-8a79-ff8379b0694c';
  static const termRegular2SyncId = 'a24c1724-86ec-49ef-8319-4c76724cba8a';
  static const termExtra1SyncId = '8ce4d336-7468-4258-b311-e3c1e9e1056b';
  static const termExtra2SyncId = '32c34219-3dc4-463a-bc4e-a4ce6b1b378d';
  static const termPenaltySyncId = 'b0334a2c-741f-48b4-aefb-d5596e4babeb';

  /// Creates a clean in-memory SQLite database instance for testing.
  static Safirah createTestDatabase() {
    return Safirah.forTesting();
  }

  /// Seeds standard system terms (regular, extra, penalty).
  static Future<void> seedDefaultTerms(Safirah db) async {
    final existing = await db.select(db.terms).get();
    if (existing.isNotEmpty) return;

    await db.batch((batch) {
      batch.insertAll(db.terms, [
        TermsCompanion.insert(
          syncId: termRegular1SyncId,
          name: 'الشوط الأول',
          type: 'regular',
          order: 1,
        ),
        TermsCompanion.insert(
          syncId: termRegular2SyncId,
          name: 'الشوط الثاني',
          type: 'regular',
          order: 2,
        ),
        TermsCompanion.insert(
          syncId: termExtra1SyncId,
          name: 'الشوط الإضافي الأول',
          type: 'extra',
          order: 3,
        ),
        TermsCompanion.insert(
          syncId: termExtra2SyncId,
          name: 'الشوط الإضافي الثاني',
          type: 'extra',
          order: 4,
        ),
        TermsCompanion.insert(
          syncId: termPenaltySyncId,
          name: 'ركلات الترجيح',
          type: 'penalty',
          order: 5,
        ),
      ]);
    });
  }

  /// Creates a full league fixture with 4 teams, 1 group, group rounds, and 1 match.
  static Future<LeagueFixture> createLeagueFixture(
    Safirah db, {
    String? leagueSyncId,
    String? leagueName,
  }) async {
    await seedDefaultTerms(db);

    final lSyncId = leagueSyncId ?? const Uuid().v7();
    final lName = leagueName ?? 'دوري أبطال الاختبار';

    // 1. Insert League
    await db.into(db.leagues).insert(
          LeaguesCompanion.insert(
            syncId: lSyncId,
            name: lName,
            subscriptionPrice: '100',
            status: const Value('active'),
          ),
        );

    // 2. Insert LeagueTerms (ربط الشوط الأول والثاني بالدوري)
    final lt1SyncId = const Uuid().v7();
    final lt2SyncId = const Uuid().v7();

    await db.batch((batch) {
      batch.insertAll(db.leagueTerms, [
        LeagueTermsCompanion.insert(
          syncId: lt1SyncId,
          leagueSyncId: lSyncId,
          termSyncId: termRegular1SyncId,
          durationMinutes: const Value(45),
        ),
        LeagueTermsCompanion.insert(
          syncId: lt2SyncId,
          leagueSyncId: lSyncId,
          termSyncId: termRegular2SyncId,
          durationMinutes: const Value(45),
        ),
      ]);
    });

    // 3. Insert 4 Teams
    final teamIds = <String>[];
    final teamNames = <String, String>{};
    final names = ['الهلال', 'النصر', 'الاتحاد', 'الأهلي'];

    for (final name in names) {
      final tId = const Uuid().v7();
      teamIds.add(tId);
      teamNames[tId] = name;
      await db.into(db.teams).insert(
            TeamsCompanion.insert(
              syncId: tId,
              leagueSyncId: lSyncId,
              teamName: name,
            ),
          );
    }

    // 4. Insert Group
    final gSyncId = const Uuid().v7();
    await db.into(db.group).insert(
          GroupCompanion.insert(
            syncId: gSyncId,
            leagueSyncId: lSyncId,
            groupName: 'المجموعة A',
            qualifiedTeamNumber: const Value(2),
          ),
        );

    // 5. Link Teams to Group & QualifiedTeam
    for (final tId in teamIds) {
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
              points: const Value(0),
              played: const Value(0),
              wins: const Value(0),
              draws: const Value(0),
              losses: const Value(0),
              goalsFor: const Value(0),
              goalsAgainst: const Value(0),
            ),
          );
    }

    // 6. Insert Round 1
    final rSyncId = const Uuid().v7();
    await db.into(db.rounds).insert(
          RoundsCompanion.insert(
            syncId: rSyncId,
            leagueSyncId: lSyncId,
            name: 'الجولة 1',
            roundType: 'group',
            groupSyncId: Value(gSyncId),
          ),
        );

    // 7. Insert Match 1 (Team 0 vs Team 1)
    final mSyncId = const Uuid().v7();
    await db.into(db.matches).insert(
          MatchesCompanion.insert(
            syncId: mSyncId,
            leagueSyncId: lSyncId,
            roundSyncId: rSyncId,
            homeTeamSyncId: teamIds[0],
            awayTeamSyncId: teamIds[1],
            matchDate: DateTime.now(),
            status: const Value('scheduled'),
            homeScore: const Value(0),
            awayScore: const Value(0),
          ),
        );

    // 8. Insert MatchTerms for Match 1
    final mt1SyncId = const Uuid().v7();
    final mt2SyncId = const Uuid().v7();

    await db.batch((batch) {
      batch.insertAll(db.matchTerms, [
        MatchTermsCompanion.insert(
          syncId: mt1SyncId,
          matchSyncId: mSyncId,
          leagueTermSyncId: lt1SyncId,
          isFinished: const Value(false),
        ),
        MatchTermsCompanion.insert(
          syncId: mt2SyncId,
          matchSyncId: mSyncId,
          leagueTermSyncId: lt2SyncId,
          isFinished: const Value(false),
        ),
      ]);
    });

    // 9. Insert Players for Home and Away Teams
    final homeLpSyncId = const Uuid().v7();
    final awayLpSyncId = const Uuid().v7();
    final homePlayerSyncId = const Uuid().v7();
    final awayPlayerSyncId = const Uuid().v7();

    await db.batch((batch) {
      batch.insertAll(db.leaguePlayers, [
        LeaguePlayersCompanion.insert(
          syncId: homeLpSyncId,
          leagueSyncId: lSyncId,
          name: const Value('سالم الدوسري'),
        ),
        LeaguePlayersCompanion.insert(
          syncId: awayLpSyncId,
          leagueSyncId: lSyncId,
          name: const Value('كريستيانو رونالدو'),
        ),
      ]);
      batch.insertAll(db.players, [
        PlayersCompanion.insert(
          syncId: homePlayerSyncId,
          playerLeagueSyncId: homeLpSyncId,
          teamSyncId: teamIds[0],
          fullName: 'سالم الدوسري',
        ),
        PlayersCompanion.insert(
          syncId: awayPlayerSyncId,
          playerLeagueSyncId: awayLpSyncId,
          teamSyncId: teamIds[1],
          fullName: 'كريستيانو رونالدو',
        ),
      ]);
    });

    return LeagueFixture(
      leagueSyncId: lSyncId,
      leagueName: lName,
      teamSyncIds: teamIds,
      teamNames: teamNames,
      groupSyncId: gSyncId,
      roundSyncId: rSyncId,
      matchSyncId: mSyncId,
      term1SyncId: mt1SyncId,
      term2SyncId: mt2SyncId,
      leagueTerm1SyncId: lt1SyncId,
      leagueTerm2SyncId: lt2SyncId,
      homePlayerSyncId: homePlayerSyncId,
      awayPlayerSyncId: awayPlayerSyncId,
    );
  }

  /// Creates a knockout match fixture with regular, extra, and penalty terms.
  static Future<({
    String leagueSyncId,
    String roundSyncId,
    String matchSyncId,
    String homeTeamSyncId,
    String awayTeamSyncId,
    List<String> matchTermSyncIds,
  })> createKnockoutFixture(Safirah db) async {
    await seedDefaultTerms(db);

    final lSyncId = const Uuid().v7();
    await db.into(db.leagues).insert(
          LeaguesCompanion.insert(
            syncId: lSyncId,
            name: 'دوري إقصائي',
            subscriptionPrice: '100',
            status: const Value('active'),
          ),
        );

    // League terms: 2 regular + 2 extra + 1 penalty
    final ltIds = [
      (const Uuid().v7(), termRegular1SyncId),
      (const Uuid().v7(), termRegular2SyncId),
      (const Uuid().v7(), termExtra1SyncId),
      (const Uuid().v7(), termExtra2SyncId),
      (const Uuid().v7(), termPenaltySyncId),
    ];

    await db.batch((batch) {
      batch.insertAll(
        db.leagueTerms,
        ltIds.map((item) => LeagueTermsCompanion.insert(
              syncId: item.$1,
              leagueSyncId: lSyncId,
              termSyncId: item.$2,
              durationMinutes: const Value(45),
            )),
      );
    });

    // 2 Teams
    final homeTid = const Uuid().v7();
    final awayTid = const Uuid().v7();

    await db.into(db.teams).insert(TeamsCompanion.insert(syncId: homeTid, leagueSyncId: lSyncId, teamName: 'فريق أ'));
    await db.into(db.teams).insert(TeamsCompanion.insert(syncId: awayTid, leagueSyncId: lSyncId, teamName: 'فريق ب'));

    // Knockout Round
    final rSyncId = const Uuid().v7();
    await db.into(db.rounds).insert(
          RoundsCompanion.insert(
            syncId: rSyncId,
            leagueSyncId: lSyncId,
            name: 'نصف النهائي',
            roundType: 'knockout',
          ),
        );

    // Knockout Match
    final mSyncId = const Uuid().v7();
    await db.into(db.matches).insert(
          MatchesCompanion.insert(
            syncId: mSyncId,
            leagueSyncId: lSyncId,
            roundSyncId: rSyncId,
            homeTeamSyncId: homeTid,
            awayTeamSyncId: awayTid,
            matchDate: DateTime.now(),
            status: const Value('scheduled'),
            homeScore: const Value(0),
            awayScore: const Value(0),
          ),
        );

    // Match terms (5 terms)
    final mtSyncIds = <String>[];
    await db.batch((batch) {
      batch.insertAll(
        db.matchTerms,
        ltIds.map((item) {
          final mtId = const Uuid().v7();
          mtSyncIds.add(mtId);
          return MatchTermsCompanion.insert(
            syncId: mtId,
            matchSyncId: mSyncId,
            leagueTermSyncId: item.$1,
            isFinished: const Value(false),
          );
        }),
      );
    });

    return (
      leagueSyncId: lSyncId,
      roundSyncId: rSyncId,
      matchSyncId: mSyncId,
      homeTeamSyncId: homeTid,
      awayTeamSyncId: awayTid,
      matchTermSyncIds: mtSyncIds,
    );
  }
}
