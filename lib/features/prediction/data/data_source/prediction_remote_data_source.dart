import 'package:dartz/dartz.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../model/awards_model.dart';
import '../model/league_for_prediction_model.dart';
import '../model/standings_model.dart';

class PredictionRemoteDataSource {
  Future<List<LeaguesContainerModel>> getAllMatches(String scope) async {
    final response = await RemoteRequest.getData(
        url: AppURL.getAllMatches, query: {'scope': scope});
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

  Future<StandingsData> standings(String scope) async {
    final response = await RemoteRequest.getData(
        url: AppURL.standings, query: {'scope': scope});
    return StandingsData.fromJson(response.data['data']);
  }

  Future<AwardsData> awards(String scope) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.awards,
      );
      final parsed = AwardsData.fromJson(
        response.data['data'] ?? response.data,
        preferredScope: scope,
      );
      if (_shouldUseParsedAwards(parsed) && parsed.hasScope(scope)) return parsed;
    } catch (_) {
      // Fall through to scoped/new compatibility endpoint, then legacy/demo data.
    }

    try {
      final response = await RemoteRequest.getData(
        url: AppURL.awards,
        query: {'scope': scope},
      );
      final parsed = AwardsData.fromJson(
        response.data['data'] ?? response.data,
        preferredScope: scope,
      );
      if (_shouldUseParsedAwards(parsed)) return parsed;
    } catch (_) {
      // Fall through to legacy endpoint, then demo data.
    }

    try {
      final response = await RemoteRequest.getData(
        url: AppURL.awardsLegacy,
        query: {'scope': scope},
      );
      final parsed = AwardsData.fromJson(
        response.data['data'] ?? response.data,
        preferredScope: scope,
      );
      if (_shouldUseParsedAwards(parsed)) return parsed;
    } catch (_) {
      // Fall through to demo data.
    }

    return AwardsData.placeholder(scope);
  }

  bool _shouldUseParsedAwards(AwardsData data) {
    return data.hasRemoteStructure || data.items.any((item) => item.hasPrize);
  }
}
