import 'package:flutter/foundation.dart';
import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../model/match_details_model.dart';
import '../model/match_statistics_model.dart';
import '../model/match_fixture_standings_model.dart';
import '../model/match_lineups_model.dart';

import '../model/match_events_model.dart';
import '../model/match_h2h_model.dart';

class MatchDetailsRemoteDataSource {
  Future<MatchDetailsModel> getMatchDetails(int matchId) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchDetails(matchId),
      );
      final rawData = response.data;
      debugPrint('==> [MatchDetails API] URL: ${AppURL.matchDetails(matchId)}');
      if (rawData == null) return MatchDetailsModel.empty();
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) return MatchDetailsModel.empty();
      return MatchDetailsModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchDetails]: $e\n$stack');
      rethrow;
    }
  }

  Future<MatchStatisticsModel> getMatchStatistics(int matchId, {String? period}) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchStatistics(matchId, period: period),
      );
      final rawData = response.data;
      debugPrint(
          '==> [MatchStatistics API] URL: ${AppURL.matchStatistics(matchId, period: period)}');
      if (rawData == null) return MatchStatisticsModel.empty();
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) return MatchStatisticsModel.empty();
      return MatchStatisticsModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchStatistics]: $e\n$stack');
      rethrow;
    }
  }

  Future<MatchFixtureStandingsModel> getMatchStandings(int matchId, {String? scope}) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchStandings(matchId, scope: scope),
      );
      final rawData = response.data;
      debugPrint(
          '==> [MatchStandings API] URL: ${AppURL.matchStandings(matchId, scope: scope)} | Data: $rawData');
      if (rawData == null) return MatchFixtureStandingsModel.empty();
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) {
        return MatchFixtureStandingsModel.empty();
      }
      return MatchFixtureStandingsModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchStandings]: $e\n$stack');
      rethrow;
    }
  }

  Future<MatchLineupsModel> getMatchLineups(int matchId) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchLineups(matchId),
      );
      final rawData = response.data;
      debugPrint('==> [MatchLineups API] URL: ${AppURL.matchLineups(matchId)}');
      if (rawData == null) return MatchLineupsModel.empty(matchId);
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) {
        return MatchLineupsModel.empty(matchId);
      }
      return MatchLineupsModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchLineups]: $e\n$stack');
      rethrow;
    }
  }

  Future<MatchEventsModel> getMatchEvents(int matchId) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchEvents(matchId),
      );
      final rawData = response.data;
      debugPrint('==> [MatchEvents API] URL: ${AppURL.matchEvents(matchId)}');
      if (rawData == null) return MatchEventsModel.empty(matchId);
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) return MatchEventsModel.empty(matchId);
      return MatchEventsModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchEvents]: $e\n$stack');
      rethrow;
    }
  }

  Future<MatchH2hModel> getMatchH2H(int matchId) async {
    try {
      final response = await RemoteRequest.getData(
        url: AppURL.matchH2H(matchId),
      );
      final rawData = response.data;
      debugPrint('==> [MatchH2H API] URL: ${AppURL.matchH2H(matchId)}');
      if (rawData == null) return MatchH2hModel.empty(matchId);
      final data = (rawData is Map &&
              rawData.containsKey('data') &&
              rawData['data'] != null)
          ? rawData['data']
          : rawData;
      if (data is! Map) return MatchH2hModel.empty(matchId);
      return MatchH2hModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e, stack) {
      debugPrint('==> [ERROR in getMatchH2H]: $e\n$stack');
      rethrow;
    }
  }
}
