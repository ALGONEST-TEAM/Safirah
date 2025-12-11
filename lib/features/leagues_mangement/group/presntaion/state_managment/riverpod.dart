import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../data/data_source/local_data_source.dart';
import '../../data/reposaitory/reposaitory.dart';

final groupsDraftProvider = StateNotifierProvider.family<GroupsDraftNotifier,
    DataState<Unit>, (int leagueId, int? groupsCount)>(
  (ref, args) => GroupsDraftNotifier( args.$1, args.$2!),
);

class GroupsDraftNotifier extends StateNotifier<DataState<Unit>> {
  GroupsDraftNotifier( this.leagueId, this.groupsCount)
      : super(DataState.initial(unit));

  final int leagueId;
  final int groupsCount;

  late final _repo = GroupsRepository(local: di.sl<GroupsLocalDataSource>());

  Future<void> run({
    required int qualifiedPerGroup,

    bool clearExisting = true,
    bool useLetters = true,
    int? seed,
  }) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.draw(
      leagueId: leagueId,
      groupsCount: groupsCount,
      qualifiedPerGroup:qualifiedPerGroup ,
      clearExisting: clearExisting,
      useLetters: useLetters,
    );
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) {
        state = state.copyWith(state: States.loaded, data: list);
      },
    );
  }
}

final groupsWithQualifiedTeamsProvider = StateNotifierProvider.family<
    GroupsWithQualifiedTeamsNotifier,
    DataState<List<GroupWithQt>>,
    int>((ref, leagueId) {
  return GroupsWithQualifiedTeamsNotifier(leagueId);
});

class GroupsWithQualifiedTeamsNotifier
    extends StateNotifier<DataState<List<GroupWithQt>>> {
  GroupsWithQualifiedTeamsNotifier(this.leagueId)
      : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = GroupsRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeagueGroupsWithQualifiedTeams(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}
