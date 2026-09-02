import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_event_icon_widget.dart';
import 'match_events_list_widget.dart';

class MatchEventDetailWidget extends StatelessWidget {
  final MatchEventItem event;
  final bool alignRight;

  const MatchEventDetailWidget({
    super.key,
    required this.event,
    required this.alignRight,
  });

  @override
  Widget build(BuildContext context) {
    String actionName = '';

    switch (event.type) {
      case MatchEventType.goal:
        actionName = 'هدف';
      case MatchEventType.penaltyGoal:
        actionName = 'ضربة جزاء';
      case MatchEventType.penaltyMissed:
        actionName = 'ركلة جزاء ضائعة';
      case MatchEventType.canceledGoal:
        actionName = 'هدف ملغي';
      case MatchEventType.yellowCard:
        actionName = 'بطاقة صفراء';
      case MatchEventType.redCard:
        actionName = 'بطاقة حمراء';
      case MatchEventType.substitution:
        actionName = 'تبديل';
      default:
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment:
            alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          12.h.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!alignRight) ...[
                MatchEventIconWidget(
                  type: event.type,
                ),
                6.w.horizontalSpace,
              ],
              AutoSizeTextWidget(
                text: event.playerName ?? '',
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w700,
                colorText: AppColors.mainColorFont,
              ),
              if (alignRight) ...[
                6.w.horizontalSpace,
                MatchEventIconWidget(
                  type: event.type,
                ),
              ],
            ],
          ),
          if (event.type == MatchEventType.canceledGoal) ...[
            2.h.verticalSpace,
            AutoSizeTextWidget(
              text: actionName,
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.dangerColor, // Show in red for emphasis
            ),
          ] else if (event.extraName != null) ...[
            2.h.verticalSpace,
            AutoSizeTextWidget(
              text: event.type == MatchEventType.substitution
                  ? "بديل لـ: ${event.extraName}"
                  : "صناعة: ${event.extraName}",
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor2,
            ),
          ] else ...[
            2.h.verticalSpace,
            AutoSizeTextWidget(
              text: actionName,
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor3,
            ),
          ],
        ],
      ),
    );
  }
}
