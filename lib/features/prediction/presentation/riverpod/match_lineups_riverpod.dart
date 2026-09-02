import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/match_lineups_model.dart';
import '../../data/repos/match_details_repo.dart';

final matchLineupsProvider = StateNotifierProvider.family.autoDispose<
    MatchLineupsNotifier, DataState<MatchLineupsModel>, int>(
  (ref, int matchId) {
    return MatchLineupsNotifier(matchId);
  },
);

class MatchLineupsNotifier extends StateNotifier<DataState<MatchLineupsModel>> {
  final int matchId;

  MatchLineupsNotifier(this.matchId)
      : super(DataState.initial(MatchLineupsModel(
          matchId: matchId,
          fixtureId: '',
          selectedTeam: 'all',
          teams: [],
        ))) {
    getMatchLineups();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchLineups({bool isRefresh = false}) async {
    if (!isRefresh && state.stateData != States.loaded) {
      state = state.copyWith(state: States.loading);
    }

    final result = await _repository.getMatchLineups(matchId);

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
