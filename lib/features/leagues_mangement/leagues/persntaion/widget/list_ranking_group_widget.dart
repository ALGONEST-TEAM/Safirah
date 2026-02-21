import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/group/data/model/model.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../group/presntaion/state_managment/riverpod.dart';
import '../../../group/presntaion/widget/ranking_team_widget.dart';

class ListRankingGroupWidget extends ConsumerWidget {
  const ListRankingGroupWidget({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    final rankingState = ref.watch(groupsStreamProvider(leagueSyncId));
    ref.watch(groupRefreshProvider(leagueSyncId));

    return CheckStateInStreamWidget<List<GroupModel>>(
        async: rankingState,
        isEmpty: (rounds) {
          return rounds.isEmpty;
        },
        onRefresh: () => ref
            .read(groupRefreshProvider(leagueSyncId).notifier)
            .refresh(),
        keepPreviousDataWhileLoading: true,
        dataBuilder: (ranking) {
         return SafeArea(
            top: false,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: ranking.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) {
                final group = ranking[i];
                // final qts = rankingState.data[i].$2;
                return RankingTeamWidget(
                  rows: group.qualifiedTeams,
                  groupName: group.groupName,
                  topQualifiers: group.qualifiedTeamNumber,
                );
              },
            ),
          );
        });
  }
}
