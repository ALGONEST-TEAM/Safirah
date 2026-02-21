import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';
import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../injection.dart' as di;
import '../data_source/league_remote_data_source.dart';
import '../data_source/local_data_source.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
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
      } catch (_) {}
    });

    // Accumulated local stream + meta
    return local.watchLeaguesAccumulatedPagination(
      isPrivate: isPrivate,
      currentPage: safePage,
      pageSize: safePerPage,
    );
  }

  Future<Either<DioException, String>> createLeague(LeagueModel model) async {
    try {
      final uuid = const Uuid().v7();
      // تأكد من وجود syncId (UUID) قبل الإدخال/المزامنة
      final ensured =
          model.syncId.trim().isNotEmpty ? model : model.copyWith(syncId: uuid);

      final leagueSyncId = await local.insertLeague(ensured.toCompanion());

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
        hasTeamsInGroups: false,
        hasMatches: false,
        hasPlayersAssigned: false,
      );
   final rule=   await local.getRulesByLeague(leagueSyncId);
   print(rule);
      try {
        final payloads = {
          'league_sync_id': leagueSyncId,
          'league': ensured.copyWith(syncId: leagueSyncId).toJson(),
          'team_player_categories': categories.map((c) => c.toJson()).toList(),
        //  'league_rules':rule.map((r)=>r.toJson()),
          'teams': teams.map((t) {
            return t.toJson();
          }).toList(),
        };

        await syncService.enqueueOperation(
          entityType: 'league',
          operation: SyncService.operationCreate,
          payload: payloads,
        );
        //
        // // ✅ هنا فقط نعرض رسالة للـUI إذا فشلت "مزامنة" فورية
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

  /// حذف دوري محليًا + Enqueue
  Future<Either<DioException, int>> deleteLeagueLocal(int id) async {
    try {
      final count = await local.deleteLeague(id);
      return Right(count);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
          DioException(requestOptions: RequestOptions(path: '/leagues')));
    }
  }

  Future<Either<DioException, int>> addRule(
      LeagueRuleModel companion, String leagueSyncId) async {
    try {
      final id = await local.insertRule(companion.toCompanion(leagueSyncId));
      return Right(id);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/league_rule')),
      );
    }
  }

  /// جلب القواعد الخاصة بدوري
  Future<Either<DioException, List<LeagueRule>>> getRulesByLeague(
      String leagueSyncId) async {
    try {
      final rules = await local.getRulesByLeague(leagueSyncId);
      return Right(rules);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/league_rule')),
      );
    }
  }

  /// حذف قاعدة
  Future<Either<DioException, int>> deleteRule(String leagueSyncId) async {
    try {
      final deletedCount = await local.deleteRule(leagueSyncId);
      return Right(deletedCount);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/league_rule')),
      );
    }
  }

  Future<Either<DioException, Unit>> replaceRulesForLeague(
      String leagueSyncId, List<LeagueRuleModel> rules) async {
    try {
      await local.insertRules(
        rules.map((r) => r.toCompanion(leagueSyncId)).toList(),
      );
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
    bool? hasPlayersAssigned,
  }) async {
    return RepoGuard.run<Unit>(
      action: () async {
        await local.updateLeagueStatus(
          leagueSyncId: leagueSyncId,
          hasGroups: hasGroups,
          hasTeamsInGroups: hasTeamsInGroups,
          hasMatches: hasMatches,
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

  // Future<Either<DioException, LeagueStatusModel>> getStatus(
  //     String leagueSyncId) async {
  //   try {
  //     final status = await local.getLeagueStatus(leagueSyncId);
  //     // final remoteLeagueStatus = await remote.getStatusOfLeague(
  //     //   leagueSyncId,
  //     // );
  //     // await local.updateLeagueStatus(
  //     //   leagueSyncId: leagueSyncId,
  //     //   hasGroups: remoteLeagueStatus.hasGroups,
  //     //   hasTeamsInGroups: remoteLeagueStatus.hasTeamsInGroups,
  //     //   hasMatches: remoteLeagueStatus.hasMatches,
  //     //   hasPlayersAssigned: remoteLeagueStatus.hasPlayersInTeams,
  //     // );
  //     // await di.sl<SyncTrigger>().syncIfOnline();
  //
  //     return Right(status);
  //   } catch (e) {
  //     return Left(DioException(
  //       requestOptions: RequestOptions(path: '/league/status'),
  //       error: e,
  //     ));
  //   }
  // }

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
        hasGroups: remoteStatus.hasGroups,
        hasTeamsInGroups: remoteStatus.hasTeamsInGroups,
        hasMatches: remoteStatus.hasMatches,
        hasPlayersAssigned: remoteStatus.hasPlayersInTeams,
      );
      await di.sl<SyncTrigger>().syncIfOnline();
    });
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
  Stream<LeagueModel?> watchLeague({required String leagueSyncId}) =>
      local.watchLeague(leagueSyncId);

}

