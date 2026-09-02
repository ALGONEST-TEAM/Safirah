import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_events_list_widget.dart'; // For MatchEventType and MatchEventItem
import 'match_event_icon_widget.dart';

class MatchEventHomeContentWidget extends StatelessWidget {
  final MatchEventItem event;

  const MatchEventHomeContentWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final showSub = event.type == MatchEventType.substitution;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Text details (aligned to the right)
        Expanded(
          child: showSub
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (event.type == MatchEventType.canceledGoal) ...[
                      AutoSizeTextWidget(
                        text: 'هدف ملغي',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        colorText: AppColors.dangerColor,
                        textAlign: TextAlign.end,
                      ),
                      2.h.verticalSpace,
                    ],
                    AutoSizeTextWidget(
                      text: event.playerName ?? '',
                      fontSize: event.type == MatchEventType.canceledGoal ? 10.sp : 11.sp,
                      colorText: event.type == MatchEventType.canceledGoal ? AppColors.fontColor2 : AppColors.fontColor,
                      textAlign: TextAlign.end,
                    ),
                    if (event.extraName != null && event.type != MatchEventType.canceledGoal) ...[
                      2.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: event.extraName!,
                        fontSize:10.sp,
                        colorText: AppColors.fontColor2,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ],
                ),
        ),
        
        8.w.horizontalSpace,
        // Icon on the far right
        MatchEventIconWidget(type: event.type),
      ],
    );
  }
}
