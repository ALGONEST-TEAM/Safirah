import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../../core/network/remote_request.dart';
import '../model/authorization_models.dart';
import '../model/user_has_role_model.dart';

class AuthorizationRemoteDataSource {
  const AuthorizationRemoteDataSource();

  Future<UserAccessForAllLeaguesModel> fetchUserAccessForAllLeagues() async {
    final res = await RemoteRequest.getData(
      url: '/league-application/league-participant-role-league/my-leagues',
    );
    return UserAccessForAllLeaguesModel.fromJsonList(res.data['data']);
  }

  Future<List<UserModelForAuthorization>> searchUserToMakeAuthorization(
      final String search) async {
    final res = await RemoteRequest.getData(
        url: '/league-application/league-participant-role-league/search-users',
        query: {'search': search});
    return UserModelForAuthorization.fromJsonList(res.data['data']);
  }
  Future<List<UserHasRoleModel>> getUsersRole(
      final String leagueSyncId) async {
    final res = await RemoteRequest.getData(
        url: '/league-application/league-participant-role-league',
        query: {'league_sync_id': leagueSyncId});
    return UserHasRoleModel.fromJsonList(res.data['data']);
  }

  Future<Unit> assignRoleForUser(final UserModelForAuthorization user) async {
    await RemoteRequest.postData(
        path: '/league-application/league-participant-role-league',
        query: user.toJson());
    return Future.value(unit);
  }
}