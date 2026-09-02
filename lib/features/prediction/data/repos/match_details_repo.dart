import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/match_details_remote_data_source.dart';
import '../model/match_details_model.dart';
import '../model/match_statistics_model.dart';
import '../model/match_fixture_standings_model.dart';
import '../model/match_lineups_model.dart';

import '../model/match_events_model.dart';
import '../model/match_h2h_model.dart';

class MatchDetailsRepository {
  final MatchDetailsRemoteDataSource _remoteDataSource = MatchDetailsRemoteDataSource();

  Future<Either<DioException, MatchDetailsModel>> getMatchDetails(int matchId) async {
    try {
      final remote = await _remoteDataSource.getMatchDetails(matchId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, MatchStatisticsModel>> getMatchStatistics(int matchId, {String? period}) async {
    try {
      final remote = await _remoteDataSource.getMatchStatistics(matchId, period: period);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, MatchFixtureStandingsModel>> getMatchStandings(int matchId, {String? scope}) async {
    try {
      final remote = await _remoteDataSource.getMatchStandings(matchId, scope: scope);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, MatchLineupsModel>> getMatchLineups(int matchId) async {
    try {
      final remote = await _remoteDataSource.getMatchLineups(matchId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(requestOptions: RequestOptions(path: ''), error: e.toString()));
    }
  }

  Future<Either<DioException, MatchEventsModel>> getMatchEvents(int matchId) async {
    try {
      final remote = await _remoteDataSource.getMatchEvents(matchId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, MatchH2hModel>> getMatchH2H(int matchId) async {
    try {
      final remote = await _remoteDataSource.getMatchH2H(matchId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
