import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../group/presntaion/state_managment/riverpod.dart';
import '../../../group/presntaion/widget/ranking_team_widget.dart';

class ListRankingGroupWidget extends ConsumerWidget {
  const ListRankingGroupWidget({super.key,required this.leagueId});
  final int leagueId;
  @override
  Widget build(BuildContext context,ref) {

    final rankingState =
    ref.watch(groupsWithQualifiedTeamsProvider(leagueId));
    return SafeArea(
      top: false,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount:  rankingState.data.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (_, i) {
          final group = rankingState.data[i].$1;
          final qts = rankingState.data[i].$2;
          return RankingTeamWidget(
            rows: qts,
            groupName: group.groupName,
            topQualifiers: group.qualifiedTeamNumber,
          );
        },
      ),
    );
  }
}
