import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/team_remote_data_source.dart';
import '../model/team_matches_model.dart';

class TeamRepository {
  final TeamRemoteDataSource _remoteDataSource = TeamRemoteDataSource();

  Future<Either<DioException, TeamMatchesModel>> getTeamMatches(int teamId) async {
    try {
      final remote = await _remoteDataSource.getTeamMatches(teamId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: e.toString(),
        ),
      );
    }
  }
}
