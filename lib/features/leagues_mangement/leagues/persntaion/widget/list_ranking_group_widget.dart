import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/group/data/model/model.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../group/presntaion/state_managment/riverpod.dart';
import '../../../group/presntaion/widget/ranking_team_widget.dart';
import '../../../home/presntation/widgets/banners_widget.dart';
import '../riverpod/riverpod.dart';

class ListRankingGroupWidget extends ConsumerWidget {
  const ListRankingGroupWidget({super.key, required this.leagueSyncId});

  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    final rankingState = ref.watch(groupsStreamProvider(leagueSyncId));
    ref.watch(groupRefreshProvider(leagueSyncId));
    final bannersState = ref.watch(getLeagueBannersProvider(leagueSyncId));

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: BannersWidget(banners: bannersState.data ?? []),
        ),
        Expanded(
          child: CheckStateInStreamWidget<List<GroupModel>>(
              async: rankingState,
              isEmpty: (rounds) {
                return rounds.isEmpty;
              },
              emptyBuilder: () => Center(
                    child:  AutoSizeTextWidget(
                      text: ' لا توجد مجموعات بعد',
                      fontSize: 14.sp,
                    ),
                  ),
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
              }),
        ),
      ],
    );
  }
}
