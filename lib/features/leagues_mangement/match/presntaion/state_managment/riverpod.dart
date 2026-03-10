import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../../../prediction/data/model/matches_predictions_model.dart';
import '../../../team_and_player/data/model/team_model.dart' show TeamModel;
import '../../data/model/match_event_model.dart';
import '../../data/model/round_model.dart';
import '../../data/reposaitory/reposaitory.dart';

final ensureGroupRoundsProvider = StateNotifierProvider.family<
    EnsureGroupRoundsNotifier, DataState<Unit>, String>(
  (ref, leagueSyncId) => EnsureGroupRoundsNotifier(leagueSyncId),
);

class EnsureGroupRoundsNotifier extends StateNotifier<DataState<Unit>> {
  EnsureGroupRoundsNotifier(this.leagueSyncId)
      : super(DataState<Unit>.initial(unit));

  final String leagueSyncId;
  final _repo = MatchesRepository(local: di.sl(), connectivity:di.sl(), syncService: di.sl(),remote: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.ensureGroupRounds(leagueSyncId);
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final scheduleGroupStageMatchesRRProvider = StateNotifierProvider.family<
    ScheduleGroupStageMatchesRRNotifier,
    DataState<Unit>,
    (String leagueSyncId, bool homeAway)>(
  (ref, args) => ScheduleGroupStageMatchesRRNotifier(args.$1, args.$2),
);

class ScheduleGroupStageMatchesRRNotifier
    extends StateNotifier<DataState<Unit>> {
  ScheduleGroupStageMatchesRRNotifier(this.leagueSyncId, this.homeAway)
      : super(DataState<Unit>.initial(unit));

  final String leagueSyncId;
  final bool homeAway;
  final _repo = MatchesRepository(local: di.sl(), connectivity:di.sl(), syncService: di.sl(),remote: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.scheduleGroupStageMatchesRR(
      leagueSyncId,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}
//
// final roundsWithGroupsProvider = StateNotifierProvider.family<
//     RoundsWithGroupsNotifier, DataState<List<RoundModel>>, Tuple2<String, String>>(
//   (ref, param) => RoundsWithGroupsNotifier(param.value1, param.value2),
// );
//
// class RoundsWithGroupsNotifier
//     extends StateNotifier<DataState<List<RoundModel>>> {
//   final String leagueSyncId;
//   final String matchFilter;
//   final _repo = MatchesRepository(local: di.sl(), connectivity:di.sl(), syncService: di.sl(),remote: di.sl());
//
//   RoundsWithGroupsNotifier(this.leagueSyncId, this.matchFilter)
//       : super(DataState.initial([])) {
//     run();
//   }
//
//   Future<void> run() async {
//     state = state.copyWith(state: States.loading);
//     final res = await _repo.getLeagueRoundsWithGroupsAndMatches(
//         leagueSyncId, matchFilter);
//     res.fold(
//       (e) => state = state.copyWith(state: States.error, exception: e),
//       (data) => state = state.copyWith(state: States.loaded, data: data),
//     );
//   }
// }
final matchesRepoProvider = Provider<MatchesRepository>((ref) {
  return MatchesRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
     syncService: di.sl(),
  );
});
final roundsWithGroupsStreamProvider =
StreamProvider.family<List<RoundModel>, Tuple2<String, String>>((ref, param) {
  final repo = ref.read(matchesRepoProvider);
  return repo.watchLeagueRoundsWithGroupsAndMatches(
    leagueSyncId: param.value1,
    matchFilter: param.value2,
  );
});
final roundsRefreshProvider = StateNotifierProvider.family<
    RoundsRefreshNotifier,
    RefreshState,
    Tuple3<String, String,String>>((ref, param) {
  final repo = ref.read(matchesRepoProvider);
  return RoundsRefreshNotifier(repo, param.value1, param.value2,param.value3);
});

class RoundsRefreshNotifier extends StateNotifier<RefreshState> {
  final MatchesRepository _repo;
  final String leagueSyncId;
  final String matchFilter;
  final String role;
  RoundsRefreshNotifier(this._repo, this.leagueSyncId, this.matchFilter,this.role)
      : super(RefreshState.idle()){
    refresh();
  }

  Future<void> refresh() async {
    
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeagueRoundsWithGroupsAndMatches(
      leagueSyncId: leagueSyncId,
      matchFilter: matchFilter,
      role: role
    );

    res.fold(
          (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
          (_) => state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final scheduleMatchProvider =
    StateNotifierProvider<ScheduleMatchNotifier, DataState<Unit>>(
  (ref) => ScheduleMatchNotifier(),
);

class ScheduleMatchNotifier extends StateNotifier<DataState<Unit>> {
  final _repo = MatchesRepository(local: di.sl(), connectivity:di.sl(), syncService: di.sl(),remote: di.sl());

  ScheduleMatchNotifier() : super(DataState<Unit>.initial(unit));

  Future<void> run({
    required String matchSyncId,
    required DateTime scheduledDateTime,
    required String refereeSyncId,
    required String mediaSyncId,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.scheduleMatch(
      matchSyncId: matchSyncId,
      scheduledDateTime: scheduledDateTime,
      refereeSyncId: refereeSyncId,
      mediaSyncId:mediaSyncId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final getMatchDetailsProvider = StateNotifierProvider.family<
    GetMatchDetailsNotifier,
    DataState<MatchDetailsModel>,
    String>((ref, matchSyncId) {
  return GetMatchDetailsNotifier(matchSyncId);
});

class GetMatchDetailsNotifier
    extends StateNotifier<DataState<MatchDetailsModel>> {
  GetMatchDetailsNotifier(this.matchSyncId)
      : super(DataState.initial(MatchDetailsModel(
    leagueName: '',
    roundName: '',
    homeTeam: TeamModel(id: 0, teamName: ''),
    awayTeam: TeamModel(id: 0, teamName: ''),
    homeScore: 0,
    awayScore: 0,
    statusText: '',
    homeScorers: [],
    awayScorers: [],
    events: [],
  ))) {
    load();
  }

  final String matchSyncId;
  final _repo = MatchesRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());


  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getMatchDetails(matchSyncId);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}