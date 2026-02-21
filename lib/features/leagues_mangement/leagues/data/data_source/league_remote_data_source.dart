import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';

class LeagueRemoteDataSource {
  const LeagueRemoteDataSource();

  Future<PaginationModel<LeagueModel>> fetchLeagues({
    required int page,
    int perPage = 5,
    bool? isPrivate,
  }) async {
    final res = await RemoteRequest.getData(
      url: '/league-application/leagues',
      query: {
        'page': page,
        // support common backend key names
        'perPage': perPage,
        'per_page': perPage,
        'pageSize': perPage,
        'limit': perPage,
        if (isPrivate != null) ...{
          'is_private': isPrivate,
          'isPrivate': isPrivate,
          'private': isPrivate,
        },
      },
    );

    // Many APIs wrap pagination metadata under "data" or return it at root.
    final envelope = (res.data is Map<String, dynamic>)
        ? (res.data as Map<String, dynamic>)
        : <String, dynamic>{'data': res.data};

    final pageJson = (envelope['data'] is Map<String, dynamic>)
        ? (envelope['data'] as Map<String, dynamic>)
        : envelope;

    return PaginationModel<LeagueModel>.fromJson(
      pageJson,
      (leagues) => LeagueModel.fromJson(leagues),
    );
  }
  Future<LeagueStatusModel> getStatusOfLeague(
      String leagueSyncId,
      )async {
    final  response = await RemoteRequest.getData(
      url: '/league-application/league-status',
      query: {
        'league_sync_id': leagueSyncId,
      },
    );
    return LeagueStatusModel.fromJson(response.data['data']);
  }
  Future<LeagueBundleModel> getLeagueBundle(
      String leagueSyncId,
      )async {
    final  response = await RemoteRequest.getData(
      url: '${AppURL
          .baseURL}/league-application/leagues/$leagueSyncId',
    );
    print(response.data);
    return  LeagueBundleModel.fromJson(response.data);
  }
}
