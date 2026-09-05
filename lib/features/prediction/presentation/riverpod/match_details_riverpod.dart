import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/match_details_model.dart';
import '../../data/model/match_statistics_model.dart';
import '../../data/model/match_fixture_standings_model.dart';
import '../../data/model/match_events_model.dart';
import '../../data/model/match_h2h_model.dart';
import '../../data/repos/match_details_repo.dart';
import 'package:flutter_riverpod/legacy.dart';

final matchDetailsProvider = StateNotifierProvider.family
    .autoDispose<MatchDetailsNotifier, DataState<MatchDetailsModel>, int>(
  (ref, int matchId) {
    return MatchDetailsNotifier(matchId);
  },
);

class MatchDetailsNotifier extends StateNotifier<DataState<MatchDetailsModel>> {
  final int matchId;

  MatchDetailsNotifier(this.matchId)
      : super(DataState.initial(MatchDetailsModel.empty())) {
    getMatchDetails();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchDetails({bool isRefresh = false}) async {
    // Only show loading shimmer if we don't have loaded data yet
    if (!isRefresh && state.stateData != States.loaded) {
      state = state.copyWith(state: States.loading);
    }

    final result = await _repository.getMatchDetails(matchId);

    if (!mounted) return;

    result.fold(
      (failure) {
        // Only show error screen if we failed the initial load
        if (!isRefresh && state.stateData != States.loaded) {
          state = state.copyWith(state: States.error, exception: failure);
        }
      },
      (newData) {
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }

  void updatePrediction({
    required int homeScore,
    required int awayScore,
    int? predictionId,
  }) {
    state = state.copyWith(
      state: state.stateData,
      data: state.data.copyWith(
        hasPrediction: true,
        userHomeScore: homeScore,
        userAwayScore: awayScore,
        predictionId: predictionId ?? state.data.predictionId,
      ),
    );
  }

  void updateFromWebSocket({
    int? homeScore,
    int? awayScore,
    int? stateId,
    String? stateName,
    String? resultInfo,
    int? minute,
    int? second,
    bool? ticking,
    int? timeAdded,
  }) {
    final current = state.data;

    final newScore = current.score?.copyWith(
          home: homeScore ?? current.score?.home,
          away: awayScore ?? current.score?.away,
          resultInfo: resultInfo ?? current.score?.resultInfo,
        ) ??
        MatchScoreModel(
          home: homeScore ?? 0,
          away: awayScore ?? 0,
          resultInfo: resultInfo ?? '',
        );

    final newState = current.state != null
        ? current.state!.copyWith(
            id: stateId ?? current.state!.id,
            name: stateName ??
                (stateId == 3
                    ? 'استراحة'
                    : (stateId == 5
                        ? 'انتهت'
                        : (stateId == 2 ? 'مباشر' : current.state!.name))),
          )
        : (stateId != null
            ? MatchStateModel(
                id: stateId,
                name: stateName ??
                    (stateId == 3
                        ? 'استراحة'
                        : (stateId == 5 ? 'انتهت' : 'مباشر')),
                code: stateId == 3 ? 'HT' : (stateId == 5 ? 'FT' : 'LIVE'),
                hasStarted: stateId != 1,
              )
            : null);

    String? newGoalSide = current.lastGoalSide;
    DateTime? newGoalTime = current.lastGoalTime;

    if (homeScore != null && homeScore > (current.score?.home ?? 0)) {
      newGoalSide = 'home';
      newGoalTime = DateTime.now();
    } else if (awayScore != null && awayScore > (current.score?.away ?? 0)) {
      newGoalSide = 'away';
      newGoalTime = DateTime.now();
    }

    final updated = current.copyWith(
      score: newScore,
      state: newState,
      status: stateId != null ? stateId.toString() : current.status,
      minute: minute ?? current.minute,
      second: second ?? current.second,
      ticking: ticking ?? current.ticking,
      timeAdded: timeAdded ?? current.timeAdded,
      lastGoalSide: newGoalSide,
      lastGoalTime: newGoalTime,
    );

    state = state.copyWith(
      state: States.loaded,
      data: updated,
    );
  }
}

final matchStatisticsProvider = StateNotifierProvider.family<MatchStatisticsNotifier, DataState<MatchStatisticsModel>, int>(
  (ref, int matchId) {
    return MatchStatisticsNotifier(matchId);
  },
);

class MatchStatisticsNotifier
    extends StateNotifier<DataState<MatchStatisticsModel>> {
  final int matchId;
  String currentPeriod = 'all';
  final Map<String, MatchStatisticsModel> _periodCache = {};

  MatchStatisticsNotifier(this.matchId)
      : super(DataState.initial(MatchStatisticsModel.empty())) {
    getMatchStatistics();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchStatistics(
      {String? period, bool forceRefresh = false}) async {
    if (period != null && period.isNotEmpty) {
      currentPeriod = period;
    }

    final String targetPeriod = currentPeriod;

    // Return cached period data instantly if available and not forcing refresh
    if (!forceRefresh && _periodCache.containsKey(targetPeriod)) {
      state = state.copyWith(
        state: States.loaded,
        data: _periodCache[targetPeriod],
      );
      return;
    }

    // Set loading state on first-time request for this period to show loading feedback
    if (_periodCache[targetPeriod] == null ||
        _periodCache[targetPeriod]!.sections.isEmpty) {
      state = state.copyWith(state: States.loading);
    }

    final result =
        await _repository.getMatchStatistics(matchId, period: targetPeriod);

    if (!mounted) return;

    result.fold(
      (failure) {
        if (_periodCache[targetPeriod] == null ||
            _periodCache[targetPeriod]!.sections.isEmpty) {
          state = state.copyWith(state: States.error, exception: failure);
        }
      },
      (newData) {
        _periodCache[targetPeriod] = newData;
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }
}

final matchStandingsProvider = StateNotifierProvider.family<
    MatchFixtureStandingsNotifier, DataState<MatchFixtureStandingsModel>, int>(
  (ref, int matchId) {
    return MatchFixtureStandingsNotifier(matchId);
  },
);

class MatchFixtureStandingsNotifier
    extends StateNotifier<DataState<MatchFixtureStandingsModel>> {
  final int matchId;
  String currentScope = 'all';
  final Map<String, MatchFixtureStandingsModel> _scopeCache = {};

  MatchFixtureStandingsNotifier(this.matchId)
      : super(DataState.initial(MatchFixtureStandingsModel.empty())) {
    getMatchStandings();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchStandings(
      {String? scope, bool forceRefresh = false}) async {
    if (scope != null && scope.isNotEmpty) {
      currentScope = scope == 'overall' ? 'all' : scope;
    }

    final String targetScope = currentScope;
    final String apiScope = targetScope == 'all' ? 'overall' : targetScope;

    // Return cached scope data instantly if available and not forcing refresh
    if (!forceRefresh && _scopeCache.containsKey(targetScope)) {
      state = state.copyWith(
        state: States.loaded,
        data: _scopeCache[targetScope],
      );
      return;
    }

    // Set loading state on first-time request for this scope to show loading feedback
    state = state.copyWith(state: States.loading);

    final result =
        await _repository.getMatchStandings(matchId, scope: apiScope);

    if (!mounted) return;

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        _scopeCache[targetScope] = newData;
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }
}

final matchEventsProvider = StateNotifierProvider.family<MatchEventsNotifier,
    DataState<MatchEventsModel>, int>(
  (ref, int matchId) {
    return MatchEventsNotifier(matchId);
  },
);

class MatchEventsNotifier extends StateNotifier<DataState<MatchEventsModel>> {
  final int matchId;

  MatchEventsNotifier(this.matchId)
      : super(DataState.initial(MatchEventsModel.empty(matchId))) {
    getMatchEvents();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchEvents() async {
    // Only show loading shimmer if we don't have data yet (prevents UI flashing on socket updates)
    if (state.data == null || state.data!.allEvents.isEmpty) {
      state = state.copyWith(state: States.loading);
    }

    final result = await _repository.getMatchEvents(matchId);

    if (!mounted) return;

    result.fold(
      (failure) {
        // If we already have data, don't show error screen on background refresh failure
        if (state.data == null || state.data!.allEvents.isEmpty) {
          state = state.copyWith(state: States.error, exception: failure);
        }
      },
      (newData) {
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }
}

final matchH2HProvider = StateNotifierProvider.family<MatchH2HNotifier,
    DataState<MatchH2hModel>, int>(
  (ref, int matchId) {
    return MatchH2HNotifier(matchId);
  },
);

class MatchH2HNotifier extends StateNotifier<DataState<MatchH2hModel>> {
  final int matchId;

  MatchH2HNotifier(this.matchId)
      : super(DataState.initial(MatchH2hModel.empty(matchId))) {
    getMatchH2H();
  }

  final _repository = MatchDetailsRepository();

  Future<void> getMatchH2H() async {
    state = state.copyWith(state: States.loading);

    final result = await _repository.getMatchH2H(matchId);

    if (!mounted) return;

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.copyWith(state: States.loaded, data: newData);
      },
    );
  }
}
