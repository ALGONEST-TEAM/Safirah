import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../data/reposaitory/reposaitory.dart';

final teamsAndPlayerRepoProvider = Provider<TeamAndPlayerRepository>((ref) {
  return TeamAndPlayerRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
    syncService: di.sl(),
  );
});

final teamsStreamProvider =
StreamProvider.family<List<TeamModel>, String>((ref, param) {
  final repo = ref.read(teamsAndPlayerRepoProvider);
  return repo.watchTeams(
    leagueSyncId: param,
  );
});
final teamsRefreshProvider =
StateNotifierProvider.family<TeamsNotifier, RefreshState, String>(
        (ref, param) {
      final repo = ref.read(teamsAndPlayerRepoProvider);
      return TeamsNotifier(repo, param);
    });

class TeamsNotifier extends StateNotifier<RefreshState> {
  final TeamAndPlayerRepository _repo;
  final String leagueSyncId;

  TeamsNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle()) ;

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshTeams(
      leagueSyncId: leagueSyncId,
    );

    res.fold(
          (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
          (_) =>
      state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final leaguePlayerStreamProvider =
    StreamProvider.family<List<LeaguePlayerModel>, String>((ref, param) {
  final repo = ref.read(teamsAndPlayerRepoProvider);
  return repo.watchLeaguePlayer(
    leagueSyncId: param,
  );
});
final playerLeagueRefreshProvider =
    StateNotifierProvider.family<LeaguePlayerNotifier, RefreshState, String>(
        (ref, param) {
  final repo = ref.read(teamsAndPlayerRepoProvider);
  return LeaguePlayerNotifier(repo, param);
});

class LeaguePlayerNotifier extends StateNotifier<RefreshState> {
  final TeamAndPlayerRepository _repo;
  final String leagueSyncId;

  LeaguePlayerNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle()) ;

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeaguePlayer(
      leagueSyncId: leagueSyncId,
    );

    res.fold(
      (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
      (_) =>
          state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final categoriesProvider = StateNotifierProvider.family<CategoriesNotifier,
    DataState<List<TeamPlayerCategoryModel>>, String>((ref, leagueSyncId) {
  return CategoriesNotifier(leagueSyncId);
});

class CategoriesNotifier
    extends StateNotifier<DataState<List<TeamPlayerCategoryModel>>> {
  CategoriesNotifier(this.leagueSyncId) : super(DataState.initial(const [])) {
    load();
  }

  final String leagueSyncId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCategoriesByLeague(leagueSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final invitationsPlayersProvider = StateNotifierProvider.family<
    LeagueInvitationsPlayersNotifier,
    DataState<List<InvitationsPlayersModel>>,
    String>((ref, syncLeagueId) {
  return LeagueInvitationsPlayersNotifier(syncLeagueId);
});

class LeagueInvitationsPlayersNotifier
    extends StateNotifier<DataState<List<InvitationsPlayersModel>>> {
  LeagueInvitationsPlayersNotifier(this.syncLeagueId)
      : super(DataState.initial(const [])) {
    load();
  }

  final String syncLeagueId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeagueInvitationsPlayers(syncLeagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

class SetPlayerCategoryArgs {
  final int leaguePlayerId;
  final int categoryId;

  const SetPlayerCategoryArgs(this.leaguePlayerId, this.categoryId);
}
// providers.dart

final setPlayerCategoryProvider =
    StateNotifierProvider<SetPlayerCategoryNotifier, DataState<bool>>(
  (ref) => SetPlayerCategoryNotifier(),
);

class SetPlayerCategoryNotifier extends StateNotifier<DataState<bool>> {
  SetPlayerCategoryNotifier() : super(DataState<bool>.initial(false));

  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> setCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.setLeaguePlayerCategory(
      leaguePlayerId: leaguePlayerId,
      categoryId: categoryId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (ok) => state = state.copyWith(state: States.loaded, data: ok),
    );
  }

  Future<void> deletePlayerCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.deleteLeaguePlayerCategory(
      leaguePlayerId: leaguePlayerId,
      categoryId: categoryId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (ok) => state = state.copyWith(state: States.loaded, data: ok),
    );
  }
}

final playersByCategoryProvider = StateNotifierProvider.family<
    PlayersByCategoryNotifier,
    DataState<List<LeaguePlayerModel>>,
    (String leagueSyncId, int categoryId)>(
  (ref, args) => PlayersByCategoryNotifier(args.$1, args.$2),
);
final playersCountByCategoryProvider =
    Provider.family<int, (String leagueSyncId, int categoryId)>((ref, args) {
  final state = ref.watch(playersByCategoryProvider(args));
  return state.data.length;
});

class PlayersByCategoryNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  PlayersByCategoryNotifier(this.leagueSyncId, this.categoryId)
      : super(DataState.initial(const [])) {
    load();
  }

  final String leagueSyncId;
  final int categoryId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeaguePlayersByCategory(
      leagueSyncId: leagueSyncId,
      categoryId: categoryId,
    );
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final runDraftProvider = StateNotifierProvider.family<RunDraftNotifier,
    DataState<List<PlayerModel>>, String>(
  (ref, leagueSyncId) => RunDraftNotifier(leagueSyncId),
);

class RunDraftNotifier extends StateNotifier<DataState<List<PlayerModel>>> {
  RunDraftNotifier(this.leagueSyncId)
      : super(DataState<List<PlayerModel>>.initial(const []));

  final String leagueSyncId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.runDraft(leagueSyncId);
    res.fold(
      (f) => state = state.copyWith(state: States.error, exception: f),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final updateTeamProvider =
    StateNotifierProvider.autoDispose<UpdateTeamNotifier, DataState<Unit>>(
  (ref) => UpdateTeamNotifier(),
);

class UpdateTeamNotifier extends StateNotifier<DataState<Unit>> {
  UpdateTeamNotifier() : super(DataState.initial(unit));

  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> update(TeamModel team) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.updateTeam(team);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final addPlayerLeagueProvider =
    StateNotifierProvider.autoDispose<AddPlayerLeagueNotifier, DataState<Unit>>(
  (ref) => AddPlayerLeagueNotifier(),
);

class AddPlayerLeagueNotifier extends StateNotifier<DataState<Unit>> {
  AddPlayerLeagueNotifier() : super(DataState.initial(unit));

  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> add(InvitationsPlayersModel player) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.addLeaguePlayer(player);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final assignToTeamProvider = StateNotifierProvider.autoDispose
    .family<AssignToTeamNotifier, DataState<List<PlayerModel>>, String>(
  (ref, teamSyncId) => AssignToTeamNotifier(teamSyncId),
);

class AssignToTeamNotifier extends StateNotifier<DataState<List<PlayerModel>>> {
  AssignToTeamNotifier(this.teamSyncId)
      : super(DataState<List<PlayerModel>>.initial(const []));

  final String teamSyncId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> assign(List<String> leaguePlayerIds) async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.assignPlayersToTeam(
      teamSyncId: teamSyncId,
      leaguePlayerIds: leaguePlayerIds,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final leaguePlayersWithoutCategoryProvider = StateNotifierProvider.family<
    LeaguePlayersWithoutCategoryNotifier,
    DataState<List<LeaguePlayerModel>>,
    String>((ref, leagueSyncId) {
  return LeaguePlayersWithoutCategoryNotifier(leagueSyncId);
});
final leaguePlayersWithoutCategoryCountProvider =
    Provider.family<int, String>((ref, leagueSyncId) {
  final state = ref.watch(leaguePlayersWithoutCategoryProvider(leagueSyncId));
  return state.data.length;
});

class LeaguePlayersWithoutCategoryNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  LeaguePlayersWithoutCategoryNotifier(this.leagueSyncId)
      : super(DataState.initial(const [])) {
    load();
  }

  final String leagueSyncId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.leaguePlayersWithoutCategory(leagueSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final leaguePlayersWithoutTeamProvider = StateNotifierProvider.family<
    LeaguePlayersWithoutTeamNotifier,
    DataState<List<LeaguePlayerModel>>,
    String>((ref, leagueSyncId) {
  return LeaguePlayersWithoutTeamNotifier(leagueSyncId);
});

final leaguePlayersWithoutTeamStreamProvider =
    StreamProvider.family<List<LeaguePlayerModel>, String>((ref, leagueSyncId) {
  final repo = ref.read(teamsAndPlayerRepoProvider);
  return repo.watchLeaguePlayersWithoutTeam(leagueSyncId: leagueSyncId);
});

final leaguePlayersWithoutTeamCountProvider =
    Provider.family<int?, String>((ref, leagueSyncId) {
  final async = ref.watch(leaguePlayersWithoutTeamStreamProvider(leagueSyncId));
  return async.asData?.value.length;
});

class LeaguePlayersWithoutTeamNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  LeaguePlayersWithoutTeamNotifier(this.leagueSyncId)
      : super(DataState.initial(const [])) {
    load();
  }

  final String leagueSyncId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.leaguePlayersWithoutTeam(leagueSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final playersOfTeamStreamProvider =
    StreamProvider.family<List<PlayerModel>, String>((ref, teamSyncId) {
  final repo = ref.read(teamsAndPlayerRepoProvider);
  return repo.watchPlayersOfTeam(teamSyncId: teamSyncId);
});

final playersCountOfTeamProvider = Provider.family<int, String>((ref, idSyncTeam) {
  final async = ref.watch(playersOfTeamStreamProvider(idSyncTeam));
  return async.asData?.value.length ?? 0;
});

final getLeaguePlayersStatisticsProvider = StateNotifierProvider.family<
    GetLeaguePlayersStatisticsNotifier,
    DataState<LeaguePlayerStatsModel>,
    String>((ref, syncLeagueId) {
  return GetLeaguePlayersStatisticsNotifier(syncLeagueId);
});

class GetLeaguePlayersStatisticsNotifier
    extends StateNotifier<DataState<LeaguePlayerStatsModel>> {
  GetLeaguePlayersStatisticsNotifier(this.syncLeagueId)
      : super(DataState.initial(LeaguePlayerStatsModel())) {
    load();
  }

  final String syncLeagueId;
  final _repo = TeamAndPlayerRepository(
      local: di.sl(),
      remote: di.sl(),
      connectivity: di.sl(),
      syncService: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeaguePlayersStatistics(syncLeagueId);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}
