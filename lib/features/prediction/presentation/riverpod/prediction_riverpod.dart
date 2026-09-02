import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../core/state/state.dart';
import '../../data/model/awards_model.dart';
import '../../data/model/league_for_prediction_model.dart';
import '../../data/model/standings_model.dart';
import '../../data/repos/prediction_repo.dart';

final matchesScopeProvider = StateProvider<String>((ref) => 'today');

final getAllMatchesProvider = StateNotifierProvider.family<GetAllMatchesNotifier,
    DataState<List<LeaguesContainerModel>>,String>(
  (ref,String scope) {
    return GetAllMatchesNotifier(scope);
  },
);

class GetAllMatchesNotifier
    extends StateNotifier<DataState<List<LeaguesContainerModel>>> {
  final String scope;

  GetAllMatchesNotifier(this.scope) : super(DataState.initial([])) {
    getData();
  }

  final _controller = PredictionReposaitory();

  Future<void> getData({bool silent = false}) async {
    if (!silent || state.data.isEmpty) {
      state = state.copyWith(state: States.loading);
    }

    final data = await _controller.getAllMatches(scope);
    data.fold((failure) {
      if (!silent || state.data.isEmpty) {
        state = state.copyWith(state: States.error, exception: failure);
      }
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }

  void updateMatchFromWebSocket({
    required int matchId,
    int? homeScore,
    int? awayScore,
    int? stateId,
    String? resultInfo,
    int? minute,
    int? second,
    bool? ticking,
    int? timeAdded,
  }) {
    if (state.data.isEmpty) return;

    bool updatedAny = false;
    final newContainers = state.data.map((container) {
      final newLeagues = container.leagues.map((league) {
        final newMatches = league.matches.map((match) {
          if (match.matchId == matchId) {
            updatedAny = true;
            
            String? newGoalSide = match.lastGoalSide;
            DateTime? newGoalTime = match.lastGoalTime;

            if (homeScore != null && homeScore > (match.homeTeam.score ?? 0)) {
              newGoalSide = 'home';
              newGoalTime = DateTime.now();
            } else if (awayScore != null && awayScore > (match.awayTeam.score ?? 0)) {
              newGoalSide = 'away';
              newGoalTime = DateTime.now();
            }

            return match.copyWith(
              status: stateId ?? match.status,
              resultInfo: resultInfo ?? match.resultInfo,
              minute: minute ?? match.minute,
              second: second ?? match.second,
              ticking: ticking ?? match.ticking,
              timeAdded: timeAdded ?? match.timeAdded,
              homeTeam: homeScore != null
                  ? match.homeTeam.copyWith(score: homeScore)
                  : match.homeTeam,
              awayTeam: awayScore != null
                  ? match.awayTeam.copyWith(score: awayScore)
                  : match.awayTeam,
              lastGoalSide: newGoalSide,
              lastGoalTime: newGoalTime,
            );
          }
          return match;
        }).toList();

        return league.copyWith(matches: newMatches);
      }).toList();

      return container.copyWith(leagues: newLeagues);
    }).toList();

    if (updatedAny) {
      state = state.copyWith(
        state: state.stateData,
        data: newContainers,
      );
    }
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

final getCompetitorPredictionsProvider = StateNotifierProvider.family<
    GetCompetitorPredictionsNotifier,
    DataState<PaginationModel<LeaguesContainerModel>>, int>(
  (ref, int competitorId) {
    return GetCompetitorPredictionsNotifier(competitorId);
  },
);

class GetCompetitorPredictionsNotifier
    extends StateNotifier<DataState<PaginationModel<LeaguesContainerModel>>> {
  final int competitorId;

  GetCompetitorPredictionsNotifier(this.competitorId)
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

    final result = await _controller.getCompetitorPredictions(competitorId, nextPage);

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

final standingsScopeProvider = StateProvider<String?>((ref) => null);

final awardsScopeProvider = StateProvider<String>((ref) => 'season');

final awardsScopeRefreshProvider =
    StateProvider<RefreshState>((ref) => RefreshState.idle());

final awardsProvider =
    StateNotifierProvider<AwardsNotifier, DataState<AwardsData>>(
  (ref) {
    return AwardsNotifier();
  },
);

class AwardsNotifier extends StateNotifier<DataState<AwardsData>> {
  static const String initialScope = 'season';

  AwardsNotifier()
      : super(DataState<AwardsData>.initial(AwardsData.empty())) {
    getData();
  }

  final _controller = PredictionReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.awards(initialScope);
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }

  Future<Object?> ensureScopeLoaded(String scope) async {
    if (scope.trim().isEmpty || state.data.hasScope(scope)) return null;

    final data = await _controller.awards(scope);
    Object? failure;

    data.fold((error) {
      failure = error;
    }, (newData) {
      final merged = state.data.scopes.isEmpty ? newData : state.data.mergeWith(newData);
      state = state.copyWith(state: States.loaded, data: merged);
    });

    return failure;
  }
}

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
