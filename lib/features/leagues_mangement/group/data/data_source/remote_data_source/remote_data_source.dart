

import 'package:safirah/features/leagues_mangement/group/data/model/model.dart';

import '../../../../../../core/network/remote_request.dart';

class GroupRemoteDataSource {
  const GroupRemoteDataSource();

  Future<List<GroupModel>> fetchGroupWithRankingTeam() async {
    final res = await RemoteRequest.getData(
      url: '/league-application/groups',
    );
    return GroupModel.fromJsonGroupList(res.data['data']);
  }
}
