import 'package:flutter/foundation.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/team_matches_model.dart';

class TeamRemoteDataSource {
  Future<TeamMatchesModel> getTeamMatches(int teamId) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.teamMatches(teamId),
      );
      final rawData = response.data;
      if (rawData == null) return TeamMatchesModel.empty();
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map<String, dynamic>) {
        return TeamMatchesModel.empty();
      }
      return TeamMatchesModel.fromJson(data);
    } catch (e, stack) {
      debugPrint('==> [ERROR in getTeamMatches]: $e\n$stack');
      rethrow;
    }
  }
}
