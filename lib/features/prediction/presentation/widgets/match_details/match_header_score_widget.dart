import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../live_goal_flash_widget.dart';
import 'match_date_countdown_widget.dart';

import '../live_match_timer_widget.dart';


class MatchHeaderScoreWidget extends StatelessWidget {
  final int homeScore;
  final int awayScore;
  final bool isNotStarted;
  final double scoreFontSize;
  final double expandRatio;
  final String matchTimeState;
  final String matchDate;
  final String matchTime;
  final num? status;
  final int? minute;
  final int? second;
  final bool? ticking;
  final int? timeAdded;
  final String? lastGoalSide;
  final DateTime? lastGoalTime;

  const MatchHeaderScoreWidget({
    super.key,
    required this.homeScore,
    required this.awayScore,
    required this.isNotStarted,
    required this.scoreFontSize,
    required this.expandRatio,
    required this.matchTimeState,
    this.matchDate = '',
    this.matchTime = '',
    this.status,
    this.minute,
    this.second,
    this.ticking,
    this.timeAdded,
    this.lastGoalSide,
    this.lastGoalTime,
  });

  @override
  Widget build(BuildContext context) {
    final statusId = status?.toInt() ?? 0;
    final isLive = statusId == 2 ||
        statusId == 3 ||
        statusId == 4 ||
        statusId == 6 ||
        statusId == 9 ||
        statusId == 21 ||
        statusId == 22 ||
        statusId == 23;

    final scoreWidget = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Home Score (Right side under Home Logo in RTL)
            AutoSizeTextWidget(
              text: homeScore.toString(),
              fontSize: scoreFontSize,
              fontWeight: FontWeight.w700,
              colorText: AppColors.mainColorFont,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: AutoSizeTextWidget(
                text: '-',
                fontSize: scoreFontSize,
                fontWeight: FontWeight.w700,
                colorText: AppColors.mainColorFont,
              ),
            ),
            // Away Score (Left side under Away Logo in RTL)
            AutoSizeTextWidget(
              text: awayScore.toString(),
              fontSize: scoreFontSize,
              fontWeight: FontWeight.w700,
              colorText: AppColors.mainColorFont,
            ),
          ],
        ),
        if (!isLive)
          AutoSizeTextWidget(
            text: _resolveStatusText(matchTimeState, statusId),
            fontSize: 9.sp,
            colorText: const Color(0xff454545),
          ),
      ],
    );

    if (isNotStarted) {
      final lowerState = matchTimeState.trim().toLowerCase();
      final isNormalNS = statusId == 1 || statusId == 0 || lowerState == 'ns' || lowerState == 'not started';

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MatchDateCountdownWidget(
            dateStr: matchDate,
            timeStr: matchTime,
            expandRatio: expandRatio,
          ),
          if (!isNormalNS) ...[
            SizedBox(height: 6.h * expandRatio),
            AutoSizeTextWidget(
              text: _resolveStatusText(matchTimeState, statusId),
              fontSize: 9.sp,
              colorText: const Color(0xff454545),
            ),
          ],
        ],
      );
    }

    return LiveGoalFlashWidget(
      liveTimerWidget: isLive
          ? LiveMatchTimerWidget(
              status: status,
              minute: minute,
              second: second,
              ticking: ticking,
              timeAdded: timeAdded,
            )
          : const SizedBox(),
      scoreWidget: scoreWidget,
      lastGoalSide: lastGoalSide,
      lastGoalTime: lastGoalTime,
      expandRatio: expandRatio,
    );
  }

  String _resolveStatusText(String stateText, int statusId) {
    final lower = stateText.trim().toLowerCase();

    // 1. Finished cases -> انتهت
    if (statusId == 5 ||
        statusId == 7 ||
        statusId == 8 ||
        lower == 'ft' ||
        lower == 'full time' ||
        lower == 'finished' ||
        lower.contains('full') ||
        lower.contains('finish')) {
      return 'انتهت';
    }

    // 2. Half time -> استراحة
    if (statusId == 3 || lower == 'ht' || lower.contains('half')) {
      return 'استراحة';
    }

    // 3. Extra time finished -> بعد التمديد
    if (statusId == 14 || lower == 'aet' || lower.contains('extra')) {
      return 'بعد التمديد';
    }

    // 4. Penalty shootout -> ركلات ترجيح
    if (statusId == 17 || lower.contains('pen')) {
      return 'ركلات ترجيح';
    }

    // 5. Postponed -> تأجلت
    if (statusId == 13 || lower.contains('postp')) {
      return 'تأجلت';
    }

    // 6. Cancelled / Abandoned -> ألغيت
    if (statusId == 26 || lower.contains('cancel') || lower.contains('abnd')) {
      return 'ألغيت';
    }

    // 7. Not started (just in case it's used elsewhere)
    if (statusId == 1 || lower == 'ns' || lower == 'not started') {
      return 'لم تبدأ';
    }

    // 8. If stateText is already in Arabic, return it
    if (stateText.isNotEmpty) {
      return stateText;
    }

    return 'انتهت';
  }
}
