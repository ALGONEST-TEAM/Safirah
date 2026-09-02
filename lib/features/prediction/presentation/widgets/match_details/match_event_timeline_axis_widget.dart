import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_events_list_widget.dart';

class MatchEventTimelineAxisWidget extends StatelessWidget {
  final MatchEventItem event;
  final bool isFirst;
  final bool isLast;

  const MatchEventTimelineAxisWidget({
    super.key,
    required this.event,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Upper line connector
        Container(
          width: 2.w,
          height: 15.h,
          color: isFirst ? Colors.transparent : AppColors.fontColor2.withValues(alpha: 0.15),
        ),
        // Minute Circle
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryColor.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
              )
            ],
          ),
          alignment: Alignment.center,
          child: AutoSizeTextWidget(
            text: "${event.minute}'",
            fontSize: 9.5.sp,
            fontWeight: FontWeight.w700,
            colorText: AppColors.secondaryColor,
          ),
        ),
        // Lower line connector
        Container(
          width: 2.w,
          height: 40.h,
          color: isLast ? Colors.transparent : AppColors.fontColor2.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}
