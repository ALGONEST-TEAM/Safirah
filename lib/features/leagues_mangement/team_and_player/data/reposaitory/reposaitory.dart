import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/local_data_source.dart';
import '../model/team_model.dart';

class TeamAndPlayerRepository {
  final TeamAndPlayerLocalDataSource local;
  TeamAndPlayerRepository({required this.local});
  // team_repository.dart
  // Future<Either<DioException, List<TeamModel>>> getTeamsByLeague(int leagueId) async {
  //   try {
  //     final rows = await local.getTeamsByLeague(leagueId);
  //     return Right(rows.map(TeamModel.fromEntity).toList());
  //   } catch (_) {
  //     return Left(DioException(requestOptions: RequestOptions(path: '/teams/by_league')));
  //   }
  // }
  Future<Either<DioException, List<TeamModel>>> getTeamsByLeague(int leagueId) async {
    try {
      final list = await local.getTeamsByLeague(leagueId);
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/teams/byLeague')),
      );
    }
  }

  Future<Either<DioException, List<PlayerModel>>> getPlayersOfTeam(int teamId) async {
    try {
      final list = await local.getPlayerTeam( teamId: teamId);
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/teams/byLeague')),
      );
    }
  }
  Future<Either<DioException, Unit>> updateTeam(TeamModel team) async {
    try {
      await local.updateTeam(team);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        DioException(requestOptions: RequestOptions(path: '/teams/update')),
      );
    }
  }

  Future<Either<DioException, List<LeaguePlayerModel>>> getLeagueUsers(int leagueId) async {
    try {
      final rows = await local.getLeagueUsers(leagueId);
      return Right(rows);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(DioException(requestOptions: RequestOptions(path: '/league_users')));
    }
  }
  Future<Either<DioException, List<TeamPlayerCategoryModel>>> getCategoriesByLeague(int leagueId) async {
    try {
      final list = await local.getCategoriesByLeague(leagueId);
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(DioException(requestOptions: RequestOptions(path: '/categories')));
    }
  }

  Future<Either<DioException, bool>> setLeaguePlayerCategory(
      {required int leaguePlayerId, required int categoryId}) async {
    try {
      final updated = await local.setLeaguePlayerCategory(
        leaguePlayerId: leaguePlayerId,
        categoryId: categoryId,
      );
      return Right(updated > 0);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(DioException(
        requestOptions:
        RequestOptions(path: '/league_players/set_category_local'),
      ));
    }
  }
  Future<Either<DioException, bool>> deleteLeaguePlayerCategory(
      {required int leaguePlayerId, required int categoryId}) async {
    try {
      final updated = await local.deleteLeaguePlayerCategory(
        leaguePlayerId: leaguePlayerId,
        categoryId: categoryId,
      );
      return Right(updated > 0);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(DioException(
        requestOptions:
        RequestOptions(path: '/league_players/set_category_local'),
      ));
    }
  }
  Future<Either<DioException, List<LeaguePlayerModel>>> getLeaguePlayersByCategory(
      {required int leagueId, required int categoryId}) async {
    try {
      final list = await local.getLeaguePlayersByCategory(
        leagueId: leagueId, categoryId: categoryId,
      );
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(DioException(requestOptions: RequestOptions(path: '/leaguePlayers/byCategory')));
    }
  }
  Future<Either<DioException, List<PlayerModel>>> runDraft(int leagueId) async {
    try {
      final result = await local.runDraft(leagueId: leagueId);
      return Right(result);
    } catch (e, st) {
      return Left(DioException(requestOptions: RequestOptions(path: '/leaguePlayers/byCategory')));
    }
  }
  Future<Either<DioException, List<PlayerModel>>> assignPlayersToTeam({
    required int teamId,
    required List<int> leaguePlayerIds,
  }) async {
    try {
      final list = await local.assignPlayersToTeam(
        teamId: teamId,
        leaguePlayerIds: leaguePlayerIds,
      );
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/teams/$teamId/assign'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, List<LeaguePlayerModel>>> leaguePlayersWithoutCategory(int leagueId) async {
    try { return Right(await local.leaguePlayersWithoutCategory(leagueId)); }
    on DioException catch (e) { return Left(e); }
    catch (e) {
      return Left(DioException(requestOptions: RequestOptions(path: '/league_players/without_category'), error: e));
    }
  }

  Future<Either<DioException, List<LeaguePlayerModel>>> leaguePlayersWithoutTeam(int leagueId) async {
    try { return Right(await local.leaguePlayersWithoutTeam(leagueId)); }
    on DioException catch (e) { return Left(e); }
    catch (e) {
      return Left(DioException(requestOptions: RequestOptions(path: '/league_players/without_team'), error: e));
    }
  }
}

