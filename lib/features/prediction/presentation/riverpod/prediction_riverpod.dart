import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../core/state/state.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../../data/model/standings_model.dart';
import '../../data/repos/prediction_repo.dart';

final getAllMatchesProvider = StateNotifierProvider<GetAllMatchesNotifier,
    DataState<List<LeaguesContainerModel>>>(
  (ref) {
    return GetAllMatchesNotifier();
  },
);

class GetAllMatchesNotifier
    extends StateNotifier<DataState<List<LeaguesContainerModel>>> {
  GetAllMatchesNotifier() : super(DataState.initial([])) {
    getData();
  }

  final _controller = PredictionReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllMatches();
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final getAllPredictionsProvider = StateNotifierProvider<
    GetAllPredictionsNotifier,
    DataState<PaginationModel<LeaguesContainerModel>>>(
  (ref) {
    return GetAllPredictionsNotifier();
  },
);

class GetAllPredictionsNotifier
    extends StateNotifier<DataState<PaginationModel<LeaguesContainerModel>>> {
  GetAllPredictionsNotifier()
      : super(DataState<PaginationModel<LeaguesContainerModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  final _controller = PredictionReposaitory();

  Future<void> getData({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.getAllPredictions(nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.success(newData, moreData);
      },
    );
  }
}

final sendPredictionProvider =
    StateNotifierProvider.autoDispose<SendPredictionNotifier, DataState<Unit>>(
        (ref) => SendPredictionNotifier());

class SendPredictionNotifier extends StateNotifier<DataState<Unit>> {
  SendPredictionNotifier() : super(DataState<Unit>.initial(unit));
  final _controller = PredictionReposaitory();

  Future<void> send({
    required int matchId,
    required int homeScore,
    required int awayScore,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.sendPrediction(
      matchId,
      homeScore,
      awayScore,
    );
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}

final editPredictionProvider =
    StateNotifierProvider.autoDispose<EditPredictionNotifier, DataState<Unit>>(
        (ref) => EditPredictionNotifier());

class EditPredictionNotifier extends StateNotifier<DataState<Unit>> {
  EditPredictionNotifier() : super(DataState<Unit>.initial(unit));
  final _controller = PredictionReposaitory();

  Future<void> edit({
    required int productionId,
    required int homeScore,
    required int awayScore,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.editPrediction(
      productionId,
      homeScore,
      awayScore,
    );
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}

final standingsProvider =
    StateNotifierProvider.family<StandingsNotifier, DataState<StandingsData>,String>(
  (ref,String scope) {
    return StandingsNotifier(scope);
  },
);

class StandingsNotifier extends StateNotifier<DataState<StandingsData>> {
  final String scope;

  StandingsNotifier(this.scope)
      : super(DataState<StandingsData>.initial(StandingsData.empty())) {
    getData();
  }

  final _controller = PredictionReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.standings(scope);
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final standingsScopeProvider = StateProvider<String>((ref) => 'week');

//Choose the sorting method
// ===================== Match Status Helpers (Riverpod) =====================

const Set<int> _notStartedStatuses = {1, 13, 26};
const Set<int> _liveStatuses = {2, 3, 4, 6, 9, 21, 22, 23, 25};
const Set<int> _finishedStatuses = {5, 7, 8, 14, 17};

class MatchStatusHelper {
  const MatchStatusHelper();

  int? _toInt(num? status) => status?.toInt();

  bool isNotStarted(num? status) {
    final s = _toInt(status);
    return s != null && _notStartedStatuses.contains(s);
  }

  bool isLive(num? status) {
    final s = _toInt(status);
    return s != null && _liveStatuses.contains(s);
  }

  bool isFinished(num? status) {
    final s = _toInt(status);
    return s != null && _finishedStatuses.contains(s);
  }
}

final matchStatusHelperProvider = Provider<MatchStatusHelper>(
  (ref) => const MatchStatusHelper(),
);
