import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_events_list_widget.dart'; // For MatchEventType and MatchEventItem
import 'match_event_icon_widget.dart';

class MatchEventAwayContentWidget extends StatelessWidget {
  final MatchEventItem event;

  const MatchEventAwayContentWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final showSub = event.type == MatchEventType.substitution;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Icon on the far left
        MatchEventIconWidget(type: event.type),
        8.w.horizontalSpace,
        
        // Text details (aligned to the left)
        Expanded(
          child: showSub
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: event.playerName ?? '',
                      fontSize: 11.sp,
                      colorText: const Color(0xff058967), // Green for incoming
                      fontWeight: FontWeight.w600,
                    ),
                    2.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: event.extraName ?? '',
                      fontSize: 10.sp,
                      colorText: const Color(0xffC00000), // Red for outgoing
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (event.type == MatchEventType.canceledGoal) ...[
                      AutoSizeTextWidget(
                        text: 'هدف ملغي',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.dangerColor,
                        textAlign: TextAlign.start,
                      ),
                      2.h.verticalSpace,
                    ],
                    AutoSizeTextWidget(
                      text: event.playerName ?? '',
                      fontWeight: event.type == MatchEventType.canceledGoal ? FontWeight.w500 : FontWeight.w600,
                      fontSize: event.type == MatchEventType.canceledGoal ? 10.sp : 11.sp,
                      colorText: event.type == MatchEventType.canceledGoal ? AppColors.fontColor2 : AppColors.fontColor,
                    ),
                    if (event.extraName != null && event.type != MatchEventType.canceledGoal) ...[
                      2.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: event.extraName!,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        colorText: AppColors.fontColor2,
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
