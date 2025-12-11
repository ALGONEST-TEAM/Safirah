import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/local_data_source.dart';
import '../model/round_model.dart';


class MatchesRepository {
  final MatchesLocalDataSource local;
  MatchesRepository({required this.local});

  // Future<Either<DioException, Unit>> initGroupStageMatches(int leagueId) async {
  //   try { return Right(await local.initGroupStageMatches(leagueId: leagueId)); }
  //   catch (e) { return Left(DioException(requestOptions: RequestOptions(path: '/matches/init_group'), error: e)); }
  // }
  Future<Either<DioException, Unit>> ensureGroupRounds(int leagueId) async {
    try {
      await local.ensureGroupRounds(leagueId: leagueId);
      return Right(unit);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/ensure_group'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, Unit>> scheduleGroupStageMatchesRR(int leagueId) async {
    try {
      await local.scheduleGroupStageMatchesRR(leagueId: leagueId);
      return Right(unit);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/ensure_group'),
        error: e,
      ));
    }
  }
  // Future<Either<DioException, List<RoundWithGroups>>> getLeagueRoundsWithGroupsAndMatches(int leagueId) async {
  //   try {
  //     final list = await local.getRoundsWithGroupsAndMatches(leagueId);
  //     return Right(list);
  //   } on DioException catch (e) {
  //     return Left(e);
  //   } catch (_) {
  //     return Left(
  //       DioException(requestOptions: RequestOptions(path: '/teams/byLeague')),
  //     );
  //   }
  // }

  Future<Either<DioException, List<RoundModel>>> getLeagueRoundsWithGroupsAndMatches(int leagueId,String matchFilter) async {
    try {
      final list = await local.getLeagueRoundsWithGroupsAndMatches(leagueId,matchFilter);
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      print(e);
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/$leagueId/groups-matches'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> scheduleMatch({
    required int matchId,
    required DateTime scheduledDateTime,
  }) async {
    try {
       await local.scheduleMatch(
        matchId: matchId,
        scheduledDateTime: scheduledDateTime,
      );



      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/matches/$matchId/schedule'),
        error: e,
      ));
    }
  }
}
