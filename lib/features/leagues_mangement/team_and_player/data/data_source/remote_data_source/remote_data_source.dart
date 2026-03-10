import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../../model/team_model.dart';

class TeamAndPlayerRemoteDataSource {
  const TeamAndPlayerRemoteDataSource();

  Future<List<LeaguePlayerModel>> getLeaguePlayers({
    required String leagueSyncId,
  }) async {
    final response = await RemoteRequest.getData(
      url:
          '${AppURL.baseURL}/league-application/leagues/$leagueSyncId/league-players',
    );
    return LeaguePlayerModel.fromJsonLeaguePlayerList(
        response.data['data']['data']);
  }

  Future<List<TeamModel>> getTeams({
    required String leagueSyncId,
  }) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/teams',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return TeamModel.fromJsonList(response.data['data']);
  }

  Future<List<InvitationsPlayersModel>> getLeagueInvitationsPlayers({
    required String leagueSyncId,
  }) async {
    final response = await RemoteRequest.getData(
      url:
          '${AppURL.baseURL}/league-application/leagues/$leagueSyncId/invitations',
    );
    return InvitationsPlayersModel.fromJsonInvitationsPlayersList(
        response.data['data']['data']);
  }

  Future<LeaguePlayerStatsModel> getLeaguePlayersStatistics({
    required String leagueSyncId,
  }) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.baseURL}/league-application/league-statistics',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return LeaguePlayerStatsModel.fromJson(response.data['data']);
  }
}
