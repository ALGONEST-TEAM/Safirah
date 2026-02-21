import 'package:safirah/features/leagues_mangement/match/data/model/match_model.dart';

import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../../model/round_model.dart';

class MatchRemoteDataSource {

  const MatchRemoteDataSource();
  Future<List<RoundModel>> getLeagueRounds(
      String leagueSyncId,
      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/rounds',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return  RoundModel.fromJsonList(response.data['data']);
  }
  Future<List<RoundModel>> getLeagueRoundsRole(
      String leagueSyncId,
      String role,

      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/rounds/my-role',
      query: {
        'league_sync_id': leagueSyncId,
        'role_type':role
      },
    );
    return  RoundModel.fromJsonList(response.data['data']);
  }
  Future<List<MatchModel>> getLeagueMatch(
      String leagueSyncId,
      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/matches',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return  MatchModel.fromJsonList(response.data['data']);
  }
}