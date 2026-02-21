import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
import '../service/league_service.dart';
import '../../../team_and_player/data/model/team_model.dart';



class LeagueLocalDataSource {
  final Safirah db;
  final LeagueService _service;

  LeagueLocalDataSource(this.db) : _service = const LeagueService();

  Future<String> insertLeague(LeaguesCompanion league) async {
    final syncId =
        league.syncId.present && league.syncId.value.trim().isNotEmpty
            ? league.syncId.value
            : const Uuid().v7();

    await db.into(db.leagues).insert(
          league.copyWith(
            syncId: Value(syncId),
          ),
        );

    return syncId;
  }

  /// Wrapper للتوافق: يستدعي أول صفحة بحجم كبير (سلوك قريب من القديم)
  Future<List<LeagueModel>> getAllLeaguesNoPagination() async {
    final leagues = await db.select(db.leagues).get();
    return leagues.map(LeagueModel.fromEntity).toList();
  }

  Future<LeagueModel> getLeague(String leagueSyncId) async {
    final league = await (db.select(db.leagues)
          ..where((t) => t.syncId.equals(leagueSyncId)))
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

  Future<List<LeagueRule>> getRulesByLeague(String leagueSyncId) {
    return (db.select(db.leagueRules)
          ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
        .get();
  }

  Future<int> deleteRule(String leagueSyncId) {
    return (db.delete(db.leagueRules)
          ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
        .go();
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

  /// إنشاء فئات اللاعبين (categories) ا��خاصة بالدوري وإرجاع السجلات المُضافة.
  Future<List<TeamPlayerCategoryModel>> createCategoriesOnLeagueCreate({
    required String leagueSyncId,
    required int maxMainPlayers,
    required int maxSubPlayers,
  }) async {
    final catsCount = _service.calculateCategoriesCount(
      maxMainPlayers: maxMainPlayers,
      maxSubPlayers: maxSubPlayers,
    );
    if (catsCount <= 0) return <TeamPlayerCategoryModel>[];
    final labels = _service.alphaLabels(catsCount);
    final companions = labels
        .map(
          (name) => TeamPlayerCategoriesCompanion.insert(
              leagueSyncId: leagueSyncId,
              name: name,
              syncId: const Uuid().v4()),
        )
        .toList();

    // insertAll لا يرجع IDs، لذلك ندرج واحداً واحداً ثم نرجع السجلات المقروءة.
    for (final c in companions) {
      await db.into(db.teamPlayerCategories).insert(c);
    }

    final rows = await (db.select(db.teamPlayerCategories)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
    return rows.map(TeamPlayerCategoryModel.fromEntity).toList();
  }

  /// إنشاء الفرق (teams) الافتراضية الخاصة بالدوري وإرجاع السجلات المُضافة.
  Future<List<TeamModel>> createTeamsOnLeagueCreate({
    required String leagueSyncId,
    required int maxTeams,
  }) async {
    if (maxTeams <= 0) return <TeamModel>[];

    final companions = List.generate(
      maxTeams,
      (i) => TeamsCompanion.insert(
        leagueSyncId: leagueSyncId,
        syncId: const Uuid().v4(),
        teamName: 'الفريق ${i + 1}',
      ),
    );

    for (final c in companions) {
      await db.into(db.teams).insert(c);
    }

    final rows = await (db.select(db.teams)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
    return rows.map(TeamModel.fromEntity).toList();
  }

  Future<List<LeagueModel>> getLeaguesByPrivacy(
      {required bool isPrivate}) async {
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
    required String leagueSyncId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasPlayersAssigned,
  }) async {
    try {
      final updateData = LeagueStatusCompanion(
        leagueSyncId: Value(leagueSyncId),
        updatedAt: Value(DateTime.now()),
        hasGroups: hasGroups != null ? Value(hasGroups) : const Value.absent(),
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

      print('✅ League status upserted for leagueId=$leagueSyncId');
    } catch (e, st) {
      print('❌ updateLeagueStatus ERROR: $e\n$st');
      rethrow;
    }
  }

  Future<LeagueStatusModel> getLeagueStatus(String leagueSyncId) async {
    final row = await (db.select(db.leagueStatus)
          ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
        .getSingleOrNull();

    print(row);
    if (row == null) {
      return LeagueStatusModel(
        leagueSyncId: leagueSyncId,
      );
    }
    return LeagueStatusModel.fromEntity(row);
  }

  Future<void> upsertLeaguesFromRemote(List<LeagueModel> leagues) async {
    if (leagues.isEmpty) return;

    await db.transaction(() async {
      for (final m in leagues) {
        await db.into(db.leagues).insertOnConflictUpdate(m.toCompanion());
      }
    });
  }
  Stream<LeagueStatusModel> watchLeagueStatus({
    required String leagueSyncId,
  }) {
    return (db.select(db.leagueStatus)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .watchSingleOrNull()
        .map((row) {
      if (row == null) {
        return LeagueStatusModel(leagueSyncId: leagueSyncId);
      }
      return LeagueStatusModel.fromEntity(row!);
    });
  }

  // --- Server-driven pagination meta for leagues ---
  static const String _leaguesResource = 'leagues';

  String _scopeFromPrivacy(bool isPrivate) => isPrivate ? 'private' : 'public';

  Future<void> upsertLeaguesPaginationMeta({
    required bool isPrivate,
    required int lastPage,
    required int perPage,
    required int total,
  }) async {
    await db.into(db.paginationMeta).insertOnConflictUpdate(
          PaginationMetaCompanion.insert(
            resource: _leaguesResource,
            scope: Value(_scopeFromPrivacy(isPrivate)),
            key: const Value.absent(),
            parentKey: const Value.absent(),
            lastPage: Value(lastPage),
            perPage: Value(perPage),
            total: Value(total),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<PaginationMetaData?> getLeaguesPaginationMeta({
    required bool isPrivate,
  }) {
    return (db.select(db.paginationMeta)
          ..where((t) => t.resource.equals(_leaguesResource))
          ..where((t) => t.scope.equals(_scopeFromPrivacy(isPrivate)))
          ..where((t) => t.key.isNull())
          ..where((t) => t.parentKey.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.updatedAt),
            (t) => OrderingTerm.desc(t.id),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<PaginationModel<LeagueModel>> watchLeaguesAccumulatedPagination({
    required bool isPrivate,
    required int currentPage,
    int pageSize = 20,
  }) {
    final safePage = currentPage < 1 ? 1 : currentPage;
    final safePageSize = pageSize < 1 ? 1 : pageSize;

    final limit = safePage * safePageSize;

    final leaguesStream = (db.select(db.leagues)
          ..where((l) => l.isPrivate.equals(isPrivate))
          ..orderBy([
            (l) => OrderingTerm.desc(l.updatedAt),
            (l) => OrderingTerm.desc(l.id),
          ])
          ..limit(limit))
        .watch()
        .map((rows) => rows.map(LeagueModel.fromEntity).toList());

    final metaStream = (db.select(db.paginationMeta)
          ..where((t) => t.resource.equals(_leaguesResource))
          ..where((t) => t.scope.equals(_scopeFromPrivacy(isPrivate)))
          ..where((t) => t.key.isNull())
          ..where((t) => t.parentKey.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.updatedAt),
            (t) => OrderingTerm.desc(t.id),
          ])
          ..limit(1))
        .watchSingleOrNull();

    return leaguesStream.asyncMap((rows) async {
      final meta = await metaStream.first;

      final localTotal = await db
          .customSelect(
            'SELECT COUNT(*) AS c FROM leagues WHERE is_private = ?',
            variables: [Variable.withBool(isPrivate)],
            readsFrom: {db.leagues},
          )
          .getSingle()
          .then((r) => (r.data['c'] as int?) ?? 0);

      final total = meta?.total ?? localTotal;
      final lastPage = meta?.lastPage ??
          (total == 0 ? 0 : ((total + safePageSize - 1) ~/ safePageSize));
      final perPage = meta?.perPage ?? safePageSize;

      return PaginationModel<LeagueModel>(
        currentPage: safePage,
        lastPage: lastPage,
        perPage: perPage,
        total: total,
        data: rows,
      );
    });
  }
  Future<void> upsertLeagueBundle({
    required String leagueSyncId,
    required LeagueBundleModel bundle,
    bool deleteMissingTeams = false,
    bool deleteMissingTerms = false,
    bool deleteMissingCategories = false,
  }) async {
    await db.transaction(() async {
      // 1) League
       await (db.update(db.leagues)
        ..where((t) => t.syncId.equals(leagueSyncId)))
          .write(
         LeaguesCompanion(
           // ❌ لا تكتب syncId هنا حتى لا يغيّره
           name: Value(bundle.league.name ?? ''),
           type: bundle.league.type != null ? Value(bundle.league.type!) : const Value.absent(),
           organizerId: bundle.league.organizerId != null
               ? Value(bundle.league.organizerId!)
               : const Value.absent(),
           scope: bundle.league.scope != null ? Value(bundle.league.scope!) : const Value.absent(),
           startDate: bundle.league.startDate != null
               ? Value(bundle.league.startDate!)
               : const Value.absent(),
           endDate: bundle.league.endDate != null ? Value(bundle.league.endDate!) : const Value.absent(),
           maxTeams: bundle.league.maxTeams != null ? Value(bundle.league.maxTeams!) : const Value.absent(),
           maxMainPlayers: bundle.league.maxMainPlayers != null
               ? Value(bundle.league.maxMainPlayers!)
               : const Value.absent(),
           maxSubPlayers: bundle.league.maxSubPlayers != null
               ? Value(bundle.league.maxSubPlayers!)
               : const Value.absent(),
           isPrivate: Value(bundle.league.isPrivate),
           status: Value(bundle.league.status),
           subscriptionPrice: Value(bundle.league.subscriptionPrice ?? ''),
           logoPath: bundle.league.logoPath != null ? Value(bundle.league.logoPath!) : const Value.absent(),
         ),
       );


      // 2) Teams
      if (bundle.teams.isNotEmpty) {
        await db.batch((b) {
          b.insertAll(
            db.teams,
            bundle.teams.map((t) => t.toCompanion()).toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }



      // 4) Categories
      if (bundle.categories.isNotEmpty) {
        await db.batch((b) {
          b.insertAll(
            db.teamPlayerCategories,
            bundle.categories.map((c) => c.toCompanion()).toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }

      // 5) Cleanup اختياري (إذا تريده)
      if (deleteMissingTeams) {
        final keep = bundle.teams.map((e) => e.syncId).where((e) => e.isNotEmpty).toList();
        if (keep.isNotEmpty) {
          await (db.delete(db.teams)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId))
            ..where((t) => t.syncId.isNotIn(keep)))
              .go();
        }
      }



      if (deleteMissingCategories) {
        final keep = bundle.categories.map((e) => e.syncId).where((e) => e.isNotEmpty).toList();
        if (keep.isNotEmpty) {
          await (db.delete(db.teamPlayerCategories)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId))
            ..where((t) => t.syncId.isNotIn(keep)))
              .go();
        }
      }
    });
  }
  Stream<LeagueModel?> watchLeague(String leagueSyncId) {
    return (db.select(db.leagues)..where((t) => t.syncId.equals(leagueSyncId)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : LeagueModel.fromEntity(row))
        .distinct();
  }

}



