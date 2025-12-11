import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../match/data/model/round_model.dart';
import '../data_source/local_data_source/local_knockout_data_source.dart';

class KnockoutRepository {
  final KnockoutGeneratorLocalDataSource local;

  KnockoutRepository({required this.local});

  Future<Either<DioException, RoundModel>> generateFirstKnockout({
    required int leagueId,
    required int qualifiedPerGroup,
  }) async {
    try {
      final result = await local.generateKnockoutFromGroups(
        leagueId: leagueId,
        qualifiedPerGroup: qualifiedPerGroup,
      );
      return Right(result);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/first'),
        error: e,
      ));
    }
  }

  /// إنشاء الجولة التالية بعد انتهاء الحالية
  Future<Either<DioException, RoundModel?>> generateNextKnockout({
    required int leagueId,
    required int finishedRoundId,
  }) async {
    try {
      final result = await local.createNextKnockoutRoundFromFinished(
        leagueId: leagueId,
        finishedRoundId: finishedRoundId,
      );
      return Right(result);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/next'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, Unit>> checkAndCreateNextKnockoutRoundIfNeeded({
    required int leagueId,
    required int finishedRoundId,
  }) async {
    try {
      await local.checkAndCreateNextKnockoutRoundIfNeeded(
        leagueId,
        finishedRoundId,
      );
      return const Right(unit);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/next_knockout'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, List<RoundModel>>> getAllKnockoutRoundsWithMatches(int leagueId,String matchFilter) async {
    try {
      final result = await local.getAllKnockoutRoundsWithMatches(leagueId,matchFilter);
      return Right(result);
    } catch (e, st) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/next_knockout'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, RoundModel>> getCurrentLeagueRound(int leagueId) async {
    try {
      final result = await local.getCurrentLeagueRound(leagueId);
      return Right(result!);
    } catch (e, st) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/next_knockout'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, bool>> checkAllGroupMatchesFinished({
    required int leagueId,
  }) async {
    try {
      final finished = await local.areAllGroupMatchesFinished(leagueId);
      return Right(finished);
    } catch (e, s) {
      return Left(DioException( stackTrace: s, requestOptions: RequestOptions(path: '/groups/check-matches-finished'), error: e,));
    }
  }
}
