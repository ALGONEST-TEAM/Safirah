import 'package:safirah/features/leagues_mangement/match_term_event/data/model/terms_model.dart';

import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../../../../match/data/model/round_model.dart';

class MatchTermRemoteDataSource{
  MatchTermRemoteDataSource();
  Future<List<RoundModel>> getLeagueRoundsKnockout(
      String leagueSyncId,
      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/rounds/knockout',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return  RoundModel.fromJsonList(response.data['data']);
  }

  Future<List<RoundModel>> getLeagueRoundsKnockoutRole(
      String leagueSyncId,
      String role,

      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/rounds/knockout/my-role',
      query: {
        'league_sync_id': leagueSyncId,
        'role_type': 'referee'
      },
    );
    print(response.data['data']);
    return  RoundModel.fromJsonList(response.data['data']);
  }

  Future<List<TermModel>> getTerms()async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/terms',
    );
    print(response.data['data']);
    return  TermModel.fromJsonList(response.data['data']);
  }
}