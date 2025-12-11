import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../data/model/round_model.dart';
import '../../data/reposaitory/reposaitory.dart';

final ensureGroupRoundsProvider = StateNotifierProvider.family<
    EnsureGroupRoundsNotifier, DataState<Unit>, int>(
  (ref, leagueId) => EnsureGroupRoundsNotifier(leagueId),
);

class EnsureGroupRoundsNotifier extends StateNotifier<DataState<Unit>> {
  EnsureGroupRoundsNotifier(this.leagueId)
      : super(DataState<Unit>.initial(unit));

  final int leagueId;
  final _repo = MatchesRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.ensureGroupRounds(leagueId);
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final scheduleGroupStageMatchesRRProvider = StateNotifierProvider.family<
    ScheduleGroupStageMatchesRRNotifier,
    DataState<Unit>,
    (int leagueId, bool homeAway)>(
  (ref, args) => ScheduleGroupStageMatchesRRNotifier(args.$1, args.$2),
);

class ScheduleGroupStageMatchesRRNotifier
    extends StateNotifier<DataState<Unit>> {
  ScheduleGroupStageMatchesRRNotifier(this.leagueId, this.homeAway)
      : super(DataState<Unit>.initial(unit));

  final int leagueId;
  final bool homeAway;
  final _repo = MatchesRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.scheduleGroupStageMatchesRR(
      leagueId,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final roundsWithGroupsProvider = StateNotifierProvider.family<
    RoundsWithGroupsNotifier, DataState<List<RoundModel>>, Tuple2<int, String>>(
  (ref, param) => RoundsWithGroupsNotifier(param.value1, param.value2),
);

class RoundsWithGroupsNotifier
    extends StateNotifier<DataState<List<RoundModel>>> {
  final int leagueId;
  final String matchFilter;
  final _repo = MatchesRepository(local: di.sl());

  RoundsWithGroupsNotifier(this.leagueId, this.matchFilter)
      : super(DataState.initial([])) {
    run();
  }

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.getLeagueRoundsWithGroupsAndMatches(
        leagueId, matchFilter);
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final scheduleMatchProvider =
    StateNotifierProvider<ScheduleMatchNotifier, DataState<Unit>>(
  (ref) => ScheduleMatchNotifier(),
);

class ScheduleMatchNotifier extends StateNotifier<DataState<Unit>> {
  final MatchesRepository _repo = MatchesRepository(local: di.sl());

  ScheduleMatchNotifier() : super(DataState<Unit>.initial(unit));

  Future<void> run({
    required int matchId,
    required DateTime scheduledDateTime,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.scheduleMatch(
      matchId: matchId,
      scheduledDateTime: scheduledDateTime,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}
