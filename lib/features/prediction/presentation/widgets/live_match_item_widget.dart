import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/team_color_extractor.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../data/model/matches_predictions_model.dart';
import '../pages/match_details_page.dart';
import '../riverpod/match_details_riverpod.dart';
import 'live_match_timer_widget.dart';
import 'live_goal_flash_widget.dart';

class LiveMatchItemWidget extends ConsumerWidget {
  final MatchesPredictionsModel item;
  bool? isInMatchesTeam;

  LiveMatchItemWidget(
      {super.key, required this.item, this.isInMatchesTeam = false});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: isInMatchesTeam == true
          ? null
          : () {
              TeamColorExtractor.preloadColors(
                item.homeTeam.logo,
                item.awayTeam.logo,
              );

              ref
                  .read(matchEventsProvider(item.matchId).notifier)
                  .getMatchEvents();
              navigateTo(
                context,
                MatchDetailsPage(
                  matchId: item.matchId,
                ),
              );
            },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Home Team (Vertical: Big Logo over Name)
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OnlineImagesWidget(
                    imageUrl: item.homeTeam.logo,
                    size: Size(34.w, 34.h),
                    fit: BoxFit.contain,
                    backgroundColor: Colors.transparent,
                  ),
                  6.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: item.homeTeam.name,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    colorText: AppColors.fontColor,
                  ),
                ],
              ),
            ),

            // Center: Live Timer Badge + Prominent Score
            Expanded(
              flex: 4,
              child: LiveGoalFlashWidget(
                liveTimerWidget: LiveMatchTimerWidget(
                  status: item.status,
                  minute: item.minute,
                  second: item.second,
                  ticking: item.ticking,
                  timeAdded: item.timeAdded,
                ),
                scoreWidget: AutoSizeTextWidget(
                  text:
                      "${item.homeTeam.score ?? 0} - ${item.awayTeam.score ?? 0}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  colorText: AppColors.fontColor,
                  textAlign: TextAlign.center,
                ),
                lastGoalSide: item.lastGoalSide,
                lastGoalTime: item.lastGoalTime,
              ),
            ),

            // Away Team (Vertical: Big Logo over Name)
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OnlineImagesWidget(
                    imageUrl: item.awayTeam.logo,
                    size: Size(34.w, 34.h),
                    fit: BoxFit.contain,
                    backgroundColor: Colors.transparent,
                  ),
                  6.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: item.awayTeam.name,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    colorText: AppColors.fontColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
