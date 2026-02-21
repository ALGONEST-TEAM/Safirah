import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source/remote_data_source.dart';
import '../../data/reposaitory/reposaitory.dart';
import '../../data/model/model.dart';

final groupsDraftProvider = StateNotifierProvider.family<GroupsDraftNotifier,
    DataState<Unit>, (String leagueSyncId, int? groupsCount)>(
  (ref, args) => GroupsDraftNotifier( args.$1, args.$2!),
);

class GroupsDraftNotifier extends StateNotifier<DataState<Unit>> {
  GroupsDraftNotifier( this.leagueSyncId, this.groupsCount)
      : super(DataState.initial(unit));

  final String leagueSyncId;
  final int groupsCount;

  late final _repo = GroupsRepository(local: di.sl<GroupsLocalDataSource>(),
      connectivity: di.sl(), syncService: di.sl(),remote: di.sl<GroupRemoteDataSource>() );

  Future<void> run({
    required int qualifiedPerGroup,

    bool clearExisting = true,
    bool useLetters = true,
    int? seed,
  }) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.draw(
      leagueSyncId: leagueSyncId,
      groupsCount: groupsCount,
      qualifiedPerGroup:qualifiedPerGroup ,
      clearExisting: clearExisting,
      useLetters: useLetters,
    );
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) {
        state = state.copyWith(state: States.loaded,);
      },
    );
  }
}
//
// final groupsWithQualifiedTeamsProvider = StateNotifierProvider.family<
//     GroupsWithQualifiedTeamsNotifier,
//     DataState<List<GroupModel>>,
//     String>((ref, leagueSyncId) {
//   return GroupsWithQualifiedTeamsNotifier(leagueSyncId);
// });
//
// class GroupsWithQualifiedTeamsNotifier
//     extends StateNotifier<DataState<List<GroupModel>>> {
//   GroupsWithQualifiedTeamsNotifier(this.leagueSyncId)
//       : super(DataState.initial(const [])) {
//     load();
//   }
//
//   final String leagueSyncId;
//   final _repo =  GroupsRepository(local: di.sl<GroupsLocalDataSource>(),
//       connectivity: di.sl(), syncService: di.sl(),remote: di.sl<GroupRemoteDataSource>() );
//
//   Future<void> load() async {
//     state = state.copyWith(state: States.loading);
//     final r = await _repo.getLeagueGroupsWithQualifiedTeams(leagueSyncId);
//     r.fold(
//       (e) => state = state.copyWith(state: States.error, exception: e),
//       (list) => state = state.copyWith(state: States.loaded, data: list),
//     );
//   }
// }
final groupRepoProvider = Provider<GroupsRepository>((ref) {
  return GroupsRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
    syncService: di.sl(),
  );
});
final groupsStreamProvider =
StreamProvider.family<List<GroupModel>, String>((ref, param) {
  final repo = ref.read(groupRepoProvider);
  return repo.watchQualifiedTeam(
    leagueSyncId: param,
  );
});
final groupRefreshProvider = StateNotifierProvider.family<
    GroupRefreshNotifier,
    RefreshState,
     String>((ref, param) {
  final repo = ref.read(groupRepoProvider);
  return GroupRefreshNotifier(repo, param);
});

class GroupRefreshNotifier extends StateNotifier<RefreshState> {
  final GroupsRepository _repo;
  final String leagueSyncId;

  GroupRefreshNotifier(this._repo, this.leagueSyncId,)
      : super(RefreshState.idle()){
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeagueGroupsWithQualifiedTeams(
      leagueSyncId: leagueSyncId,
    );

    res.fold(
          (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
          (_) => state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}
