import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di;
import '../../data/reposaitory/reposaitory.dart';

final teamsProvider = StateNotifierProvider.family<TeamsNotifier,
    DataState<List<TeamModel>>, int>((ref, leagueId) {
  return TeamsNotifier(leagueId);
});

class TeamsNotifier extends StateNotifier<DataState<List<TeamModel>>> {
  TeamsNotifier(this.leagueId) : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getTeamsByLeague(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final leagueUsersProvider = StateNotifierProvider.family<LeagueUsersNotifier,
    DataState<List<LeaguePlayerModel>>, int>((ref, leagueId) {
  return LeagueUsersNotifier(leagueId);
});

class LeagueUsersNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  LeagueUsersNotifier(this.leagueId) : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeagueUsers(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final categoriesProvider = StateNotifierProvider.family<CategoriesNotifier,
    DataState<List<TeamPlayerCategoryModel>>, int>((ref, leagueId) {
  return CategoriesNotifier(leagueId);
});

class CategoriesNotifier
    extends StateNotifier<DataState<List<TeamPlayerCategoryModel>>> {
  CategoriesNotifier(this.leagueId) : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCategoriesByLeague(leagueId);
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

  final _repo = TeamAndPlayerRepository(local: di.sl());

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
    (int leagueId, int categoryId)>(
  (ref, args) => PlayersByCategoryNotifier(args.$1, args.$2),
);
final playersCountByCategoryProvider =
    Provider.family<int, (int leagueId, int categoryId)>((ref, args) {
  final state = ref.watch(playersByCategoryProvider(args));
  return state.data.length;
});

class PlayersByCategoryNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  PlayersByCategoryNotifier(this.leagueId, this.categoryId)
      : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final int categoryId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeaguePlayersByCategory(
      leagueId: leagueId,
      categoryId: categoryId,
    );
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

final runDraftProvider = StateNotifierProvider.family<RunDraftNotifier,
    DataState<List<PlayerModel>>, int>(
  (ref, leagueId) => RunDraftNotifier(leagueId),
);

class RunDraftNotifier extends StateNotifier<DataState<List<PlayerModel>>> {
  RunDraftNotifier(this.leagueId)
      : super(DataState<List<PlayerModel>>.initial(const []));

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.runDraft(leagueId);
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

  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> update(TeamModel team) async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.updateTeam(team);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final assignToTeamProvider = StateNotifierProvider.autoDispose
    .family<AssignToTeamNotifier, DataState<List<PlayerModel>>, int>(
  (ref, teamId) => AssignToTeamNotifier(teamId),
);

class AssignToTeamNotifier extends StateNotifier<DataState<List<PlayerModel>>> {
  AssignToTeamNotifier(this.teamId)
      : super(DataState<List<PlayerModel>>.initial(const []));

  final int teamId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> assign(List<int> leaguePlayerIds) async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.assignPlayersToTeam(
      teamId: teamId,
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
    int>((ref, leagueId) {
  return LeaguePlayersWithoutCategoryNotifier(leagueId);
});
final leaguePlayersWithoutCategoryCountProvider =
Provider.family<int, int>((ref, leagueId) {
  final state = ref.watch(leaguePlayersWithoutCategoryProvider(leagueId));
  return state.data.length;
});
class LeaguePlayersWithoutCategoryNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  LeaguePlayersWithoutCategoryNotifier(this.leagueId)
      : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.leaguePlayersWithoutCategory(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}

// === لاعبو الدوري بدون فريق ===
final leaguePlayersWithoutTeamProvider = StateNotifierProvider.family<
    LeaguePlayersWithoutTeamNotifier,
    DataState<List<LeaguePlayerModel>>,
    int>((ref, leagueId) {
  return LeaguePlayersWithoutTeamNotifier(leagueId);
});

class LeaguePlayersWithoutTeamNotifier
    extends StateNotifier<DataState<List<LeaguePlayerModel>>> {
  LeaguePlayersWithoutTeamNotifier(this.leagueId)
      : super(DataState.initial(const [])) {
    load();
  }

  final int leagueId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.leaguePlayersWithoutTeam(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}
final playersOfTeamProvider = StateNotifierProvider.family<
    PlayersOfTeamNotifier,
    DataState<List<PlayerModel>>,
    int>((ref, teamId) {
  return PlayersOfTeamNotifier(teamId);
});
  final playersCountOfTeamProvider =
Provider.family<int, int>((ref, idTeam) {
  final state = ref.watch(playersOfTeamProvider(idTeam));
  return state.data.length;
});

class PlayersOfTeamNotifier
    extends StateNotifier<DataState<List<PlayerModel>>> {
  PlayersOfTeamNotifier(this.teamId)
      : super(DataState.initial(const [])) {
    load();
  }

  final int teamId;
  final _repo = TeamAndPlayerRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getPlayersOfTeam(
    teamId
    );
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}
