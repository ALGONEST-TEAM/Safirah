import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
import '../service/league_service.dart';

class LeagueLocalDataSource {
  final Safirah db;
  final LeagueService _service;

  LeagueLocalDataSource(this.db) : _service = const LeagueService();

  Future<int> insertLeague(LeaguesCompanion league) =>
      db.into(db.leagues).insert(league);

  Future<List<League>> getAllLeagues() => db.select(db.leagues).get();

  Future<LeagueModel> getLeagueById(int id) async {
    final league = await (db.select(db.leagues)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return LeagueModel.fromEntity(league!);
  }

  Future<bool> updateLeague(League league) =>
      db.update(db.leagues).replace(league);

  Future<int> deleteLeague(int id) =>
      (db.delete(db.leagues)..where((t) => t.id.equals(id))).go();

  Future<int> insertRule(LeagueRulesCompanion companion) {
    return db.into(db.leagueRules).insert(companion);
  }

  Future<List<LeagueRule>> getRulesByLeague(int leagueId) {
    return (db.select(db.leagueRules)
          ..where((tbl) => tbl.leagueId.equals(leagueId)))
        .get();
  }

  Future<int> deleteRule(int id) {
    return (db.delete(db.leagueRules)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> insertRules(List<LeagueRulesCompanion> companions) async {
    await db.batch((batch) {
      batch.insertAll(db.leagueRules, companions);
    });
  }

  Stream<List<League>> watchLeagues() => db.select(db.leagues).watch();

  Future<void> replaceAllLeagues(List<LeagueModel> leagues) async {
    await db.batch((batch) {
      batch.deleteWhere(db.leagues, (t) => const Constant(true));
      batch.insertAll(
        db.leagues,
        leagues.map((m) => m.toCompanion()).toList(),
      );
    });
  }

  Future<void> createTeamsAndCatOnLeagueCreate({
    required int leagueId,
    required int maxMainPlayers,
    required int maxSubPlayers,
    required int maxTeams,
  }) async {
    final catsCount = _service.calculateCategoriesCount(
      maxMainPlayers: maxMainPlayers,
      maxSubPlayers: maxSubPlayers,
    );

    await db.batch((b) {
      if ( catsCount > 0) {
        final labels = _service.alphaLabels(catsCount);
        b.insertAll(
          db.teamPlayerCategories,
          labels
              .map((name) => TeamPlayerCategoriesCompanion.insert(
                    leagueId: leagueId,
                    name: name,
                  ))
              .toList(),
        );
      }
      if ( maxTeams > 0) {
        b.insertAll(
          db.teams,
          List.generate(
            maxTeams,
            (i) => TeamsCompanion.insert(
              leagueId: leagueId,
              teamName: 'الفريق ${i + 1}',
            ),
          ),
        );
      }
    });
  }

  Future<void> seedDummyLeaguePlayers({
    required int leagueId,
    int total = 0,
    int placeholderUserId = 0,
  }) async {
    final exists = await (db.select(db.leaguePlayers)
          ..where((t) => t.leagueId.equals(leagueId)))
        .get()
        .then((r) => r.isNotEmpty);
    if (exists) return;

    final count = _service.defaultSeedPlayersCount(total);

    await db.batch((b) {
      b.insertAll(
        db.leaguePlayers,
        List.generate(
          count,
          (_) => LeaguePlayersCompanion.insert(
            leagueId: leagueId,
            userId: placeholderUserId,
            teamPlayerCategoryId: const Value.absent(),
          ),
        ),
      );
    });
  }

  Future<List<LeagueModel>> getLeaguesByPrivacy({required bool isPrivate}) async {
    final rows = await (db.select(db.leagues)
          ..where((l) => l.isPrivate.equals(isPrivate))
          ..orderBy([
            (l) => OrderingTerm.desc(l.createdAt),
            (l) => OrderingTerm.asc(l.id),
          ]))
        .get();
    return rows.map(LeagueModel.fromEntity).toList();
  }

  Future<void> updateLeagueStatus({
    required int leagueId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasPlayersAssigned,
  }) async {
    try {
      final updateData = LeagueStatusCompanion(
        leagueId: Value(leagueId),
        updatedAt: Value(DateTime.now()),
        hasGroups:
            hasGroups != null ? Value(hasGroups) : const Value.absent(),
        hasTeamsInGroups: hasTeamsInGroups != null
            ? Value(hasTeamsInGroups)
            : const Value.absent(),
        hasMatches:
            hasMatches != null ? Value(hasMatches) : const Value.absent(),
        hasPlayersAssigned: hasPlayersAssigned != null
            ? Value(hasPlayersAssigned)
            : const Value.absent(),
      );

      await db.into(db.leagueStatus).insertOnConflictUpdate(updateData);

      print('✅ League status upserted for leagueId=$leagueId');
    } catch (e, st) {
      print('❌ updateLeagueStatus ERROR: $e\n$st');
      rethrow;
    }
  }

  Future<LeagueStatusModel> getLeagueStatus(int leagueId) async {
    final row = await (db.select(db.leagueStatus)
          ..where((tbl) => tbl.leagueId.equals(leagueId)))
        .getSingleOrNull();

    print(row);
    if (row == null) {
      return LeagueStatusModel(
        leagueId: leagueId,
      );
    }
    return LeagueStatusModel.fromEntity(row);
  }
}
