import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../injection.dart' as di;
import '../../../home/data/models/banners_model.dart';
import '../../../home/data/models/news_item_model.dart';
import '../data_source/league_remote_data_source.dart';
import '../data_source/local_data_source.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
import '../model/report_model.dart';
import '../model/rule_league_model.dart';

class LeagueRepository {
  final LeagueLocalDataSource local;
  final LeagueRemoteDataSource remote;
  final ConnectivityService connectivity;
  final SyncService syncService;

  LeagueRepository({
    required this.local,
    required this.remote,
    required this.connectivity,
    required this.syncService,
  });

  Stream<PaginationModel<LeagueModel>> getLeagues({
    required bool isPrivate,
    int page = 1,
    int perPage = 15,
  }) {
    final safePage = page < 1 ? 1 : page;
    final safePerPage = perPage < 1 ? 1 : perPage;

    Future(() async {
      if (!await connectivity.isOnline()) return;
      try {
        final remotePage = await remote.fetchLeagues(
          page: safePage,
          perPage: safePerPage,
          isPrivate: isPrivate,
        );

        final remoteFiltered =
            remotePage.data.where((l) => l.isPrivate == isPrivate).toList();

        await local.upsertLeaguesFromRemote(remoteFiltered);
        await local.upsertLeaguesPaginationMeta(
          isPrivate: isPrivate,
          lastPage: remotePage.lastPage,
          perPage: remotePage.perPage,
          total: remotePage.total,
        );

        await di.sl<SyncTrigger>().syncIfOnline();
      } catch (e, st) {
        print('❌ getLeagues fetch failed: $e\n$st');
      }
    });

    // Accumulated local stream + meta
    return local.watchLeaguesAccumulatedPagination(
      isPrivate: isPrivate,
      currentPage: safePage,
      pageSize: safePerPage,
    );
  }

  Future<Either<DioException, String>> createLeague(
      LeagueModel model, List<LeagueRuleModel> leagueRule) async {
    try {
      final uuid = const Uuid().v7();
      final ensured =
          model.syncId.trim().isNotEmpty ? model : model.copyWith(syncId: uuid);

      final leagueSyncId = await local.insertLeague(
        ensured.toCompanion(),
        logoLocalPath: ensured.logoLocalPath,
      );
      final teams = await local.createTeamsOnLeagueCreate(
        leagueSyncId: leagueSyncId,
        maxTeams: model.maxTeams ?? 0,
      );

      final categories = await local.createCategoriesOnLeagueCreate(
        leagueSyncId: leagueSyncId,
        maxSubPlayers: model.maxSubPlayers ?? 0,
        maxMainPlayers: model.maxMainPlayers ?? 0,
      );
      await local.updateLeagueStatus(
        leagueSyncId: leagueSyncId,
        hasGroups: false,
        hasKnockout: false,
        hasTeamsInGroups: false,
        hasMatches: false,
        hasPlayersAssigned: false,
      );
      final rule =   await local.insertRules(
        leagueSyncId: leagueSyncId,
        rule: leagueRule.map((r) => r.copyWith(leagueSyncId: leagueSyncId)).toList(),
      );
      try {
        final payloads = {
          'league_sync_id': leagueSyncId,
          'league': ensured.copyWith(syncId: leagueSyncId).toJson(),
          'team_player_categories': categories.map((c) => c.toJson()).toList(),
          'teams': teams.map((t) => t.toJson()).toList(),
          'league_rules': rule.map((t) => t.toJson()).toList(),
          if (ensured.logoLocalPath != null &&
              ensured.logoLocalPath!.isNotEmpty)
            '__files': [
              {'field': 'logo', 'path': ensured.logoLocalPath},
              {'field': 'logo_path', 'path': ensured.logoLocalPath},
              {'field': 'league[logo_path]', 'path': ensured.logoLocalPath},
            ]
        };

        await syncService.enqueueOperation(
          entityType: 'league',
          operation: SyncService.operationCreate,
          payload: payloads,
        );

        try {
          di.sl<SyncTrigger>().syncIfOnlineInBackground();
        } on DioException catch (e) {
          return Left(SyncDioException.from(e));
        }
      } catch (_) {
        // keep offline-first stable
      }

      return Right(leagueSyncId);
    } on DioException catch (e) {
      // خطأ عادي (ليس من محاولات المزامنة الفورية هنا)
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/league/create')),
      );
    }
  }

  Future<Either<DioException, Unit>> replaceRulesForLeague(
      {required String leagueSyncId,
      required List<LeagueRuleModel> rules}) async {
    try {
      await local.insertRules(
        leagueSyncId: leagueSyncId,
        rule: rules,
      );
      await syncService.enqueueOperation(
        entityType: 'rule',
        operation: SyncService.operationCreate,
        payload:

          rules.first.toJson(),

      );
      di.sl<SyncTrigger>().syncIfOnlineInBackground();
      return right(unit); // نجاح
    } on DioException catch (e) {
      return left(e); // خطأ من نوع Dio
    } catch (e) {
      return left(DioException(
        requestOptions: RequestOptions(path: '/leagueRules'),
        error: e.toString(),
      ));
    }
  }

  Future<Either<DioException, LeagueModel>> getLeague({
    required String leagueSyncId,
  }) async {
    try {
      final r = await local.getLeague(leagueSyncId);
      return Right(r);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/leagues/byPrivacy'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> updateLeagueStatus({
    required String leagueSyncId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasKnockout,
    bool? hasPlayersAssigned,
  }) async {
    return RepoGuard.run<Unit>(
      action: () async {
        await local.updateLeagueStatus(
          leagueSyncId: leagueSyncId,
          hasGroups: hasGroups,
          hasTeamsInGroups: hasTeamsInGroups,
          hasMatches: hasMatches,
          hasKnockout: hasKnockout,
          hasPlayersAssigned: hasPlayersAssigned,
        );
        await syncService.enqueueOperation(
          entityType: 'leagueStatus',
          operation: SyncService.operationUpdate,
          payload: {
            'league_sync_id': leagueSyncId,
            'has_groups': hasGroups,
            'has_teams_in_groups': hasTeamsInGroups,
            'has_matches': hasMatches,
            'has_players_assigned': hasPlayersAssigned,
            'has_knockout': hasKnockout,
          },
        );

        try {
          await di.sl<SyncTrigger>().syncIfOnline();
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }
        return unit;
      },
    );
  }


  Stream<LeagueStatusModel> watchLeagueStatus({
    required String leagueSyncId,
  }) {
    return local.watchLeagueStatus(
      leagueSyncId: leagueSyncId,
    );
  }

  Future<Either<DioException, void>> refreshLeagueStatus({
    required String leagueSyncId,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;
      final remoteStatus = await remote.getStatusOfLeague(
        leagueSyncId,
      );
      await local.updateLeagueStatus(
        leagueSyncId: leagueSyncId,
        hasKnockout: remoteStatus.hasKnockout,
        hasGroups: remoteStatus.hasGroups,
        hasTeamsInGroups: remoteStatus.hasTeamsInGroups,
        hasMatches: remoteStatus.hasMatches,
        hasPlayersAssigned: remoteStatus.hasPlayersInTeams,
      );
      await di.sl<SyncTrigger>().syncIfOnline();
    });
  }

  Future<Either<DioException, PaginationModel<NewsItemModel>>>
      getAllLatestLeagueNews(String leagueSyncId, int page) async {
    try {
      final remotes = await remote.getAllLatestLeagueNews(leagueSyncId, page);
      return Right(remotes);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> refreshLeagueBundle({
    required String leagueSyncId,
  }) async {
    return RepoGuard.run<Unit>(action: () async {
      if (!await connectivity.isOnline()) return unit;

      final bundle = await remote.getLeagueBundle(leagueSyncId); // ترجع Map

      await local.upsertLeagueBundle(
        leagueSyncId: leagueSyncId,
        bundle: bundle,
      );

      await di.sl<SyncTrigger>().syncIfOnline();
      return unit;
    });
  }

  Stream<LeagueModel?> watchLeague({required String leagueSyncId}) {
    return local.watchLeague(leagueSyncId);
  }

  Future<Either<DioException, Unit>> addReport(ReportModel reportModel) async {
    try {
      final data = await remote.addReport(reportModel);
      return Right(data);
    } on DioException catch (error) {
      print('Error adding report: $error');
      return Left(error);
    }
  }

  Future<Either<DioException, NewsItemModel>> reportDetails({
    required int id,
  }) async {
    try {
      final remotes = await remote.reportDetails(id: id);
      return Right(remotes);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> orderLeagueInvitationsPlayer(
      String leagueSyncId) {
    return RepoGuard.run<Unit>(
      action: () =>
          remote.orderLeagueInvitationsPlayer(leagueSyncId: leagueSyncId),
    );
  }

  Future<Either<DioException, List<BannerModel>>> getLeagueBanners(
      String leagueSyncId) {
    return RepoGuard.run<List<BannerModel>>(
      action: () => remote.getLeagueBanners(leagueSyncId: leagueSyncId),
    );
  }

  /// مراقبة (watch) قواعد الدوري من اللوكال.
  Stream<List<LeagueRuleModel>> watchLeagueRules({
    required String leagueSyncId,
  }) {
    return local.watchLeagueRules(leagueSyncId: leagueSyncId);
  }

  /// جلب (refresh) قواعد الدوري من الريموت ثم upsert في اللوكال.
  ///
  /// - Offline-first: لو الجهاز أوفلاين يرجع `unit` بدون رمي خطأ.
  /// - [deleteMissing] لو true: يحذف من اللوكال أي قواعد ليست ضمن نتيجة الريموت.
  Future<Either<DioException, Unit>> refreshLeagueRules({
    required String leagueSyncId,
    bool deleteMissing = true,
  }) async {
    return RepoGuard.run<Unit>(
      action: () async {
        if (!await connectivity.isOnline()) return unit;

        final remoteRules = await remote.getLeagueRule(leagueSyncId);

        await local.upsertLeagueRulesFromRemote(
          leagueSyncId: leagueSyncId,
          rules: remoteRules,
          deleteMissing: deleteMissing,
        );

        await di.sl<SyncTrigger>().syncIfOnline();
        return unit;
      },
    );
  }
}
