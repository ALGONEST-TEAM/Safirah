import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/prediction_remote_data_source.dart';
import '../model/awards_model.dart';
import '../model/league_for_prediction_model.dart';
import '../model/standings_model.dart';

class PredictionReposaitory {
  final PredictionRemoteDataSource _predictionRemoteDataSource =
      PredictionRemoteDataSource();

  DioException _toDioException(Object e) {
    if (e is DioException) return e;
    return DioException(
      requestOptions: RequestOptions(path: ''),
      error: e.toString(),
      type: DioExceptionType.unknown,
    );
  }

  Future<Either<DioException, List<LeaguesContainerModel>>>
      getAllMatches(String scope) async {
    try {
      final remote = await _predictionRemoteDataSource.getAllMatches(scope);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
    }
  }

  Future<Either<DioException, PaginationModel<LeaguesContainerModel>>>
      getAllPredictions(int page) async {
    try {
      final remote = await _predictionRemoteDataSource.getAllPredictions(page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
    }
  }

  Future<Either<DioException, PaginationModel<LeaguesContainerModel>>>
      getCompetitorPredictions(int competitorId, int page) async {
    try {
      final remote = await _predictionRemoteDataSource.getCompetitorPredictions(
          competitorId, page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
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
    } catch (e) {
      return Left(_toDioException(e));
    }
  }

  Future<Either<DioException, Unit>> editPrediction(
    int productionId,
    int homeScore,
    int awayScore,
  ) async {
    try {
      final remote = await _predictionRemoteDataSource.editPrediction(
        productionId,
        homeScore,
        awayScore,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
    }
  }

  Future<Either<DioException, StandingsData>> standings(String scope) async {
    try {
      final remote = await _predictionRemoteDataSource.standings(scope);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
    }
  }

  Future<Either<DioException, AwardsData>> awards(String scope) async {
    try {
      final remote = await _predictionRemoteDataSource.awards(scope);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(_toDioException(e));
    }
  }
}
