import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/prediction_remote_data_source.dart';
import '../model/league_for_prediction_model.dart';

class PredictionReposaitory {
  final PredictionRemoteDataSource _predictionRemoteDataSource =
      PredictionRemoteDataSource();

  Future<Either<DioException, List<LeaguesContainerModel>>>
      getAllMatches() async {
    try {
      final remote = await _predictionRemoteDataSource.getAllMatches();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, PaginationModel<LeaguesContainerModel>>>
  getAllPredictions(int page) async {
    try {
      final remote = await _predictionRemoteDataSource.getAllPredictions(page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
  Future<Either<DioException, Unit>> sendPrediction(
    int matchId,
    int homeScore,
    int awayScore,
  ) async {
    try {
      final remote = await _predictionRemoteDataSource.sendPrediction(
        matchId,
        homeScore,
        awayScore,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
