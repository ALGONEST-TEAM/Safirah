import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
import '../model/rule_league_model.dart';
import '../service/league_service.dart';
import '../../../team_and_player/data/model/team_model.dart';
import 'package:rxdart/rxdart.dart';



class LeagueLocalDataSource {
  final Safirah db;
  final LeagueService _service;

  LeagueLocalDataSource(this.db) : _service = const LeagueService();
  //
  // Future<String> insertLeague(LeaguesCompanion league) async {
  //   final syncId =
  //       league.syncId.present && league.syncId.value.trim().isNotEmpty
  //           ? league.syncId.value
  //           : const Uuid().v7();
  //
  //   await db.into(db.leagues).insert(
  //         league.copyWith(
  //           syncId: Value(syncId),
  //         ),
  //       );
  //
  //   return syncId;
  // }

  Future<String> insertLeague(
      LeaguesCompanion league, {
        String? logoLocalPath,
      }) async {

    final syncId =
    league.syncId.present && league.syncId.value.trim().isNotEmpty
        ? league.syncId.value.trim()
        : const Uuid().v7();

    try {
   final x=   await db.into(db.leagues).insertReturning(
        league.copyWith(
          syncId: Value(syncId),
          logoLocalPath:
          (logoLocalPath != null && logoLocalPath.trim().isNotEmpty)
              ? Value(logoLocalPath.trim())
              : league.logoLocalPath,
        ),

      );
      print(x.logoLocalPath);
      return syncId;
    } catch (e, st) {

      // ignore: avoid_print
      print('❌ insertLeague failed: $e\n$st');
      rethrow;
    }
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

  Future<List<LeagueRuleModel  >> getRulesByLeague(String leagueSyncId) async{
    final rule =await  (db.select(db.leagueRules)
          ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
        .get();
    return rule.map(LeagueRuleModel.fromEntity).toList();
  }

  Future<int> deleteRule(String leagueSyncId) {
    return (db.delete(db.leagueRules)
          ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
        .go();
  }

  Future<List<LeagueRuleModel>> insertRules({
    required List<LeagueRuleModel> rule,
    required String leagueSyncId,
  }) async {
    if (rule.isEmpty) return <LeagueRuleModel>[];

    return db.transaction(() async {
      await db.batch((batch) {
        batch.insertAll(
          db.leagueRules,
          rule.map((r) => r.toCompanion(leagueSyncId)).toList(),
        );
      });

      // رجّع القواعد المخزنة فعليًا للدوري (وبالتالي تحمل ids إن وُجدت)
      final stored = await (db.select(db.leagueRules)
            ..where((tbl) => tbl.leagueSyncId.equals(leagueSyncId)))
          .get();
      return stored.map(LeagueRuleModel.fromEntity).toList();
    });
  }

  Stream<List<League>> watchLeagues() => db.select(db.leagues).watch();

  Future<void> replaceAllLeagues(List<LeagueModel> leagues) async {
    await db.batch((batch) {
      batch.deleteWhere(db.leagues, (t) => const Constant(true));
      batch.insertAll(
        db.leagues,
        leagues.map((m) => m.toRemoteCompanion()).toList(),
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
    bool? hasKnockout,

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
        hasKnockout:
        hasKnockout != null ? Value(hasKnockout) : const Value.absent(),
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

  // Future<void> upsertLeaguesFromRemote(List<LeagueModel> leagues) async {
  //   if (leagues.isEmpty) return;
  //
  //   await db.transaction(() async {
  //     for (final m in leagues) {
  //       await db.into(db.leagues).insertOnConflictUpdate(m.toCompanionUpsert());
  //     }
  //   });
  // }
  Future<void> upsertLeaguesFromRemote(List<LeagueModel> leagues) async {
    if (leagues.isEmpty) return;

    await db.transaction(() async {
      for (final m in leagues) {
        await db.into(db.leagues).insert(
          m.toRemoteCompanion(),
          onConflict: DoUpdate(
                (old) => m.toRemoteCompanionUpsert(),
            target: [db.leagues.syncId], // 👈 هذا المهم
          ),
        );
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
      return LeagueStatusModel.fromEntity(row);
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
            // الأحدث أولاً
            (l) => OrderingTerm.desc(l.createdAt),
            // tie-breaker لتثبيت ترتيب العناصر عند تساوي createdAt
          //  (l) => OrderingTerm.desc(l.id),
          ])
          ..limit(limit))
        .watch()
        .map((rows) => rows.map(LeagueModel.fromEntity).toList())
        .startWith(const <LeagueModel>[]); // ✅ مهم

    final metaStream = (db.select(db.paginationMeta)
          ..where((t) => t.resource.equals(_leaguesResource))
          ..where((t) => t.scope.equals(_scopeFromPrivacy(isPrivate)))
          ..where((t) => t.key.isNull())
          ..where((t) => t.parentKey.isNull())
          ..limit(1))
        .watchSingleOrNull()
        .startWith(null); // ✅ مهم

    return Rx.combineLatest2<List<LeagueModel>, PaginationMetaData?,
        PaginationModel<LeagueModel>>(
      leaguesStream,
      metaStream,
      (rows, meta) {
        final total = meta?.total ?? rows.length;
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
      },
    );
  }
  Future<void> upsertLeagueBundle({
    required String leagueSyncId,
    required LeagueBundleModel bundle,
    bool deleteMissingTeams = false,
    bool deleteMissingTerms = false,
    bool deleteMissingCategories = false,
  }) async {
    await db.transaction(() async {
      // 1) League upsert
      await db.into(db.leagues).insert(
        bundle.league.toRemoteCompanion(),
        onConflict: DoUpdate(
              (old) => bundle.league.toRemoteCompanionUpsert(),
          target: [db.leagues.syncId],
        ),
      );

      // 2) Terms + LeagueTerms upsert (من نفس payload)
      final keepTermSyncIds = <String>{};

      for (final lt in bundle.leagueTermModel) {
        final leagueTermSid = (lt.syncId).trim();
        final termSid = (lt.termSyncId).trim();

        // term nested
        final term = lt.term; // TermModel?
        final termNestedSid = (term?.syncId ?? '').trim();

        final effectiveTermSid = termSid.isNotEmpty ? termSid : termNestedSid;
        if (effectiveTermSid.isEmpty) continue;

        keepTermSyncIds.add(effectiveTermSid);

        await db.into(db.leagueTerms).insert(
          LeagueTermsCompanion(
            syncId: Value(leagueTermSid),
            leagueSyncId: Value(leagueSyncId),
            termSyncId: Value(effectiveTermSid),
            durationMinutes: Value(lt.durationMinutes),
            updatedAt: Value(DateTime.now()),
          ),
          onConflict: DoUpdate(
            (old) => LeagueTermsCompanion(
              durationMinutes: Value(lt.durationMinutes),
              updatedAt: Value(DateTime.now()),
            ),
            target: [db.leagueTerms.leagueSyncId, db.leagueTerms.termSyncId],
          ),
        );
      }

      // 3) Delete missing league_terms (اختياري)
      if (deleteMissingTerms) {
        if (keepTermSyncIds.isEmpty) {
          await (db.delete(db.leagueTerms)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
              .go();
        } else {
          await (db.delete(db.leagueTerms)
            ..where((t) =>
            t.leagueSyncId.equals(leagueSyncId) &
            t.termSyncId.isNotIn(keepTermSyncIds)))
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

  /// مراقبة قواعد الدوري من قاعدة البيانات المحلية.
  ///
  /// - مرتب حسب `createdAt` ثم `id` لضمان ثبات ترتيب العرض.
  /// - يرجع `LeagueRuleModel` جاهز للاستخدام في الدومين.
  Stream<List<LeagueRuleModel>> watchLeagueRules({
    required String leagueSyncId,
  }) {
    return (db.select(db.leagueRules)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.createdAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .watch()
        .map((rows) => rows.map(LeagueRuleModel.fromEntity).toList())
        .distinct();
  }

  /// Upsert لقواعد الدوري القادمة من السيرفر (أو أي مصدر)
  ///
  /// - يعمل upsert باستخدام المفتاح المنطقي: (leagueSyncId + syncId).
  /// - خيار [deleteMissing] يسمح بحذف القواعد المحلية التي لم تعد موجودة
  ///   ضمن [rules] لنفس الدوري.
  /// - يقوم بـ trim للقيم الأساسية لتفادي إدخالات غير نظيفة.
  Future<void> upsertLeagueRulesFromRemote({
    required String leagueSyncId,
    required List<LeagueRuleModel> rules,
    bool deleteMissing = false,
  }) async {
    final lid = leagueSyncId.trim();
    if (lid.isEmpty) return;

    // نظّف البيانات وامنع إدخالات syncId/description الفارغة
    final normalized = rules
        .map(
          (r) => r.copyWith(
            leagueSyncId: lid,
            syncId: r.syncId.trim(),
            description: r.description.trim(),
          ),
        )
        .where((r) => r.syncId.isNotEmpty && r.description.isNotEmpty)
        .toList();

    await db.transaction(() async {
      final keepSyncIds = <String>{};

      for (final r in normalized) {
        keepSyncIds.add(r.syncId);

        await db.into(db.leagueRules).insert(
              r.toCompanion(lid),
              onConflict: DoUpdate(
                (old) => LeagueRulesCompanion(
                  description: Value(r.description),
                  isMandatory: Value(r.isMandatory),
                  // لا نلمس createdAt عند التحديث
                ),
                // ✅ مفتاح منطقي: rule per league + syncId
                target: [db.leagueRules.leagueSyncId, db.leagueRules.syncId],
              ),
            );
      }

      if (deleteMissing) {
        if (keepSyncIds.isEmpty) {
          await (db.delete(db.leagueRules)
                ..where((t) => t.leagueSyncId.equals(lid)))
              .go();
        } else {
          await (db.delete(db.leagueRules)
                ..where((t) =>
                    t.leagueSyncId.equals(lid) & t.syncId.isNotIn(keepSyncIds)))
              .go();
        }
      }
    });
  }
}
