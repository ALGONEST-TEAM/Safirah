import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../injection.dart' as di;
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source/remote_data_source.dart';
import '../model/model.dart';
import '../model/group_draw_payload.dart';
import '../../../../authorization/authorization_access_policy.dart';

class GroupsRepository {
  final GroupsLocalDataSource local;
  final GroupRemoteDataSource remote;
  final ConnectivityService connectivity;
  final SyncService syncService;

  GroupsRepository(
      {required this.local,
      required this.remote,
      required this.connectivity,
      required this.syncService});

  Future<Either<DioException, List<GroupDrawPayload>>> draw({
    required String leagueSyncId,
    required int groupsCount,
    required int qualifiedPerGroup,
    bool clearExisting = true,
    bool useLetters = true,
  }) async {
    try {
      final payload = await local.drawGroupsByCount(
        leagueSyncId: leagueSyncId,
        groupsCount: groupsCount,
        clearExisting: clearExisting,
        qualifiedPerGroup: qualifiedPerGroup,
        useLetters: useLetters,
      );
      await syncService.enqueueOperation(
        entityType: 'drawGroups',
        operation: SyncService.operationCreate,
        payload: {
          'groups': payload.map((p) => p.toJson()).toList(),
        },
      );
      try {
        await di.sl<SyncTrigger>().syncIfOnline();
      } on DioException catch (e) {
        throw SyncDioException.from(e);
      }
      return Right(payload);
    } on DioException catch (erorr) {
      return Left(erorr);
    }
  }

  Stream< List<GroupModel>> watchQualifiedTeam({
    required String leagueSyncId,
  }) {
    return local.watchQualifiedTeam(
      leagueSyncId: leagueSyncId,
    );
  }
  Future<Either<DioException, void>> refreshLeagueGroupsWithQualifiedTeams({
    required String leagueSyncId,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;
      final groupAndQulifiedTeam =
      await remote.fetchGroupWithRankingTeam();
      await local.upsertLeagueGroupsAndQualifiedTeamsFromRemote(
        leagueSyncId: leagueSyncId,
        groupAndQulifiedTeam: groupAndQulifiedTeam,
      );

      await di.sl<SyncTrigger>().syncIfOnline();
    });
  }
  Future<Either<DioException, List<GroupModel>>>
      getLeagueGroupsWithQualifiedTeams(String leagueSyncId) async {
    try {
      final hasAnyPermission = await di
          .sl<AuthorizationAccessPolicy>()
          .hasAnyLeaguePermission(leagueSyncId);

      if (!hasAnyPermission) {
        final remoteGroups = await remote.fetchGroupWithRankingTeam();
        final filtered =
            remoteGroups.where((g) => g.leagueSyncId == leagueSyncId).toList();
        return Right(filtered);
      }

      final list = await local.getLeagueGroupsWithQualifiedTeams(leagueSyncId);

      () async {
        try {
          if (await connectivity.isOnline()) {
            final groupAndQulifiedTeam =
                await remote.fetchGroupWithRankingTeam();
            await local.upsertLeagueGroupsAndQualifiedTeamsFromRemote(
              leagueSyncId: leagueSyncId,
              groupAndQulifiedTeam: groupAndQulifiedTeam,
            );

            await di.sl<SyncTrigger>().syncIfOnline();
          }
        } catch (_) {}
      }();

      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    }
    }

}
