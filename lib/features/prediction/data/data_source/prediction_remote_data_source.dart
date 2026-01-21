import 'package:dartz/dartz.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../model/league_for_prediction_model.dart';

class PredictionRemoteDataSource {
  Future<List<LeaguesContainerModel>> getAllMatches() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllMatches,
    );
    return LeaguesContainerModel.fromJsonList(response.data['data']);
  }

  Future<PaginationModel<LeaguesContainerModel>> getAllPredictions(
      int page) async {
    final response = await RemoteRequest.getData(
      url: AppURL.prediction,
      query: {'page': page},
    );
    return PaginationModel<LeaguesContainerModel>.fromJson(
      response.data['data'] ?? response.data,
      (book) {
        return LeaguesContainerModel.fromJson(book);
      },
    );
  }

  Future<Unit> sendPrediction(
    int matchId,
    int homeScore,
    int awayScore,
  ) async {
    await RemoteRequest.postData(
      path: AppURL.prediction,
      data: {
        'match_id': matchId,
        'home_score': homeScore,
        'away_score': awayScore,
      },
    );
    return Future.value(unit);
  }

  Future<Unit> editPrediction(
    int productionId,
    int homeScore,
    int awayScore,
  ) async {
    await RemoteRequest.putData(
      path: "${AppURL.prediction}/$productionId",
      data: {
        'home_score': homeScore,
        'away_score': awayScore,
      },
    );
    return Future.value(unit);
  }
}
