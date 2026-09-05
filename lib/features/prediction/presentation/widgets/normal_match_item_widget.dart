import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/utils/team_color_extractor.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../data/model/matches_predictions_model.dart';
import '../pages/match_details_page.dart';
import '../riverpod/match_details_riverpod.dart';
import '../riverpod/prediction_riverpod.dart';
import 'team_widget.dart';

class NormalMatchItemWidget extends ConsumerWidget {
  final MatchesPredictionsModel item;
  bool? isInMatchesTeam;

   NormalMatchItemWidget({
    super.key,
    required this.item,
  this.  isInMatchesTeam=false

  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusHelper = ref.watch(matchStatusHelperProvider);

    String _formatTime(String time) {
      if (time.isEmpty || time.contains('ص') || time.contains('م')) return time;
      try {
        final parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          final String minute = parts[1].substring(0, 2);
          String amPm = 'ص';
          if (hour >= 12) {
            amPm = 'م';
            if (hour > 12) hour -= 12;
          } else if (hour == 0) {
            hour = 12;
          }
          final String hourStr = hour.toString().padLeft(2, '0');
          return '$hourStr:$minute $amPm';
        }
      } catch (_) {}
      if (time.length >= 5) return time.substring(0, 5);
      return time;
    }

    return GestureDetector(
      onTap:isInMatchesTeam==true? null:() {
        TeamColorExtractor.preloadColors(
          item.homeTeam.logo,
          item.awayTeam.logo,
        );
        ref.read(matchEventsProvider( item.matchId).notifier).getMatchEvents();

        navigateTo(
          context,
          MatchDetailsPage(
            matchId: item.matchId,
          ),
        );
      },
        behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            if (statusHelper.isFinished(item.status)) ...[
            //  2.w.horizontalSpace,
              AutoSizeTextWidget(
                text: S.of(context).finished,
                fontSize: 7.sp,
                minFontSize: 8.sp,
                colorText: const Color(0xff454545),
              ),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if (statusHelper.isNotStarted(item.status) &&
                //     item.hasPrediction == false &&
                //     Auth().loggedIn) ...[
                //   6.w.horizontalSpace,
                //   Icon(
                //     Icons.arrow_circle_right_outlined,
                //     color: const Color(0xff5e5e84).withValues(alpha: .8),
                //     size: 14.8.sp,
                //   ),
                //   4.w.horizontalSpace,
                // ],
                TeamWidget(
                  name: item.homeTeam.name,
                  image: item.homeTeam.logo,
                  alignRight: true,
                  padding:  EdgeInsets.symmetric(vertical: 4.h),
                ),
                Expanded(
                  child: AutoSizeTextWidget(
                    text: statusHelper.isNotStarted(item.status)
                        ? _formatTime(item.matchTime)
                        : "${item.homeTeam.score} - ${item.awayTeam.score}",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                TeamWidget(
                  name: item.awayTeam.name,
                  image: item.awayTeam.logo,
                  alignRight: false,
                  padding:  EdgeInsets.symmetric(vertical: 4.h),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
