import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:safirah/features/authorization/authorization_service.dart';
import 'package:safirah/injection.dart' as di;

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/data_source/authorization_local_data_source.dart';
import '../../data/data_source/authorization_remote_data_source.dart';
import '../../data/model/authorization_models.dart';
import '../../data/model/user_has_role_model.dart';
import '../../data/reposaitory/authorization_repository.dart';

final leaguePermissionsProvider = StreamProvider.family<Set<String>, String>(
  (ref, leagueSyncId) {
    final service = di.sl<AuthorizationService>();
    return service.watchPermissions(leagueSyncId: leagueSyncId).distinct();
  },
);

final canPermissionProvider = Provider.family<bool, (String key, String leagueSyncId)>(
  (ref, args) {
    final permsAsync = ref.watch(leaguePermissionsProvider(args.$2));
    return permsAsync.maybeWhen(
      data: (set) => set.contains(args.$1),
      orElse: () => false,
    );
  },
);

final searchUserProvider = StateNotifierProvider.family<
    SearchUserNotifier,
    DataState<List<UserModelForAuthorization>>,
    String>((ref, search) {
  return SearchUserNotifier(search);
});

class SearchUserNotifier
    extends StateNotifier<DataState<List<UserModelForAuthorization>>> {
  SearchUserNotifier(this.search)
      : super(DataState.initial(const [])) {
    load();
  }

  final String search;
  final _repo =  AuthorizationRepository(local: di.sl<AuthorizationLocalDataSource>(),
     remote: di.sl<AuthorizationRemoteDataSource>(),connectivity: di.sl(),syncService: di.sl() );

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.searchUserToMakeAuthorization( search: search);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}


final assignRoleForUserProvider = StateNotifierProvider<
    AssignRoleForUserNotifier,
    DataState<Unit>>((ref) {
  return AssignRoleForUserNotifier();
});

class AssignRoleForUserNotifier
    extends StateNotifier<DataState<Unit>> {
  AssignRoleForUserNotifier()
      : super(DataState.initial(unit)) ;

  final _repo =  AuthorizationRepository(local: di.sl<AuthorizationLocalDataSource>(),
      remote: di.sl<AuthorizationRemoteDataSource>(),connectivity: di.sl(),syncService: di.sl() );

  Future<void> load(UserModelForAuthorization user) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.assignRoleForUser( user: user);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (list) => state = state.copyWith(state: States.loaded),
    );
  }
}

final usersHasRoleRepoProvider = Provider<AuthorizationRepository>((ref) {
  return AuthorizationRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
    syncService: di.sl(),
  );
});

/// Param مركّب: leagueSyncId + role
typedef UsersRoleParam = ({String leagueSyncId, String role});

final usersHasRolesStreamProvider =
StreamProvider.family<List<UserHasRoleModel>, UsersRoleParam>((ref, param) {
  final repo = ref.read(usersHasRoleRepoProvider);
  return repo.watchUsersHasRolesByRole(
    leagueSyncId: param.leagueSyncId,
    role: param.role,
  );
});

final usersHasRoleRefreshProvider = StateNotifierProvider.family.autoDispose<
    UsersHasRoleRefreshNotifier,
    RefreshState,
    String>((ref, leagueSyncId) {
  final repo = ref.read(usersHasRoleRepoProvider);
  return UsersHasRoleRefreshNotifier(repo, leagueSyncId);
});
class UsersHasRoleRefreshNotifier extends StateNotifier<RefreshState> {
  final AuthorizationRepository _repo;
  final String leagueSyncId;

  UsersHasRoleRefreshNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle()) {
    refresh();
  }

  Future<void> refresh({bool deleteMissing = true}) async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshUsersHasRoles(
      leagueSyncId:leagueSyncId,
      deleteMissing: deleteMissing,
    );

    res.fold(
          (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
          (_) => state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

class RolePickState {
  final String? refereeSyncId;
  final String? designerSyncId;
  final String? mediaSyncId;

  const RolePickState({
    this.refereeSyncId,
    this.designerSyncId,
    this.mediaSyncId,
  });

  RolePickState copyWith({
    String? refereeSyncId,
    String? designerSyncId,
    String? mediaSyncId,
  }) {
    return RolePickState(
      refereeSyncId: refereeSyncId ?? this.refereeSyncId,
      designerSyncId: designerSyncId ?? this.designerSyncId,
      mediaSyncId: mediaSyncId ?? this.mediaSyncId,
    );
  }
}

class RolePickNotifier extends StateNotifier<RolePickState> {
  RolePickNotifier() : super(const RolePickState());

  void pick(String role, String syncId) {
    switch (role) {
      case 'referee':
        state = state.copyWith(refereeSyncId: syncId);
        break;
      case 'designer':
        state = state.copyWith(designerSyncId: syncId);
        break;
      case 'media':
        state = state.copyWith(mediaSyncId: syncId);
        break;
    }
  }
}

final rolePickProvider =
StateNotifierProvider<RolePickNotifier, RolePickState>((ref) {
  return RolePickNotifier();
});
