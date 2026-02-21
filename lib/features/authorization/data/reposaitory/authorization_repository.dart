import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:safirah/features/authorization/authorization_permissions.dart';
import '../../../../core/database/sync_service.dart';
import '../../../../core/database/sync_trigger.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/network/errors/repo_guard.dart';
import '../../../../injection.dart' as di;
import '../data_source/authorization_local_data_source.dart';
import '../data_source/authorization_remote_data_source.dart';
import '../model/authorization_models.dart';
import '../model/user_has_role_model.dart';

class AuthorizationRepository {
  final AuthorizationLocalDataSource local;
  final AuthorizationRemoteDataSource remote;
 // final Safirah db;
  final ConnectivityService connectivity;
  final SyncService syncService;
  const AuthorizationRepository({
    required this.local,
    required this.remote,
    required this.connectivity,
    required this.syncService,
   // required this.db,
  });

  Future<Either<DioException, bool>> can({
    required String leagueSyncId,
    required String permissionKey,
  }) async {
    try {
      final perms =
          await local.getLeaguePermissionKeys(leagueSyncId: leagueSyncId);
      return Right(perms.contains(permissionKey));
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/authorization/local/can'),
        error: e,
      ));
    }
  }

  Stream<Set<String>> watchLeaguePermissionKeys({
    required String leagueSyncId,
  }) {
    return local.watchLeaguePermissionKeys(leagueSyncId: leagueSyncId);
  }

  Future<Either<DioException, Unit>> syncUserAccessForAllLeagues() async {
    try {
      final res = await remote.fetchUserAccessForAllLeagues();

      for (final access in res.data) {
        final leagueSyncId = access.leagueSyncId;
        if (leagueSyncId == null || leagueSyncId.trim().isEmpty) continue;

        final permissionKeys =
            AuthorizationPermissions.permissionsForRoles(access.roleKeys);

        await local.replaceLeaguePermissions(
          leagueSyncId: leagueSyncId,
          permissionKeys: permissionKeys.toList(),
          syncIdFactory: () => const Uuid().v7(),
        );
      }

      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<UserModelForAuthorization>>>
      searchUserToMakeAuthorization({
    required String search,
  }) async {
    try {
      final searches = await remote.searchUserToMakeAuthorization(search);
      return Right(searches);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> assignRoleForUser({
    required UserModelForAuthorization user,
  }) async {
    try {
    await remote.assignRoleForUser(user);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, void>> refreshUsersHasRoles({
    required String leagueSyncId,
    bool deleteMissing = true,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;

      final remoteList = await remote.getUsersRole(leagueSyncId);

      await local.upsertUsersHasRoles(
        leagueSyncId: leagueSyncId,
        items: remoteList,
        deleteMissing: deleteMissing,
      );

      await di.sl<SyncTrigger>().syncIfOnline();
    });
  }

  /// ✅ Watch محلي مباشر (UI)
  Stream<List<UserHasRoleModel>> watchUsersHasRoles({
    required String leagueSyncId,
  }) {
    return local.watchUsersHasRoles(leagueSyncId: leagueSyncId);
  }

  Stream<List<UserHasRoleModel>> watchUsersHasRolesByRole({
    required String leagueSyncId,
    required String role,
  }) {
    return local.watchUsersHasRolesByRole(
      leagueSyncId: leagueSyncId,
      role: role,
    );
  }
}
