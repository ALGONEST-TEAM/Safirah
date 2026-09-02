import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/team_matches_model.dart';
import '../../data/repos/team_repo.dart';

final teamMatchesProvider = StateNotifierProvider.family
    .autoDispose<TeamMatchesNotifier, DataState<TeamMatchesModel>, int>(
  (ref, teamId) {
    return TeamMatchesNotifier(teamId);
  },
);

class TeamMatchesNotifier extends StateNotifier<DataState<TeamMatchesModel>> {
  final int teamId;
  final TeamRepository _repository = TeamRepository();

  TeamMatchesNotifier(this.teamId)
      : super(DataState.initial(TeamMatchesModel.empty())) {
    getTeamMatches();
  }

  Future<void> getTeamMatches({bool isRefresh = false}) async {
    if (!isRefresh && state.stateData != States.loaded) {
      state = state.copyWith(state: States.loading);
    }

    final result = await _repository.getTeamMatches(teamId);

    if (!mounted) return;

    result.fold(
      (failure) {
        if (!isRefresh && state.stateData != States.loaded) {
          state = state.copyWith(state: States.error, exception: failure);
        }
      },
      (newData) {
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }
}
