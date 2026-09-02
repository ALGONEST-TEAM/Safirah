import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchStatisticsStatValueWidget extends StatelessWidget {
  final String text;
  final bool isHighlighted;
  final bool isHome;
  final Color homeColor;
  final Color awayColor;

  const MatchStatisticsStatValueWidget({
    super.key,
    required this.text,
    required this.isHighlighted,
    required this.isHome,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isHighlighted) {
      return AutoSizeTextWidget(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        colorText: AppColors.fontColor,
      );
    }

    final Color bgColor = isHome ? homeColor : awayColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: bgColor.withOpacity(0.25), width: 1),
      ),
      child: AutoSizeTextWidget(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        colorText: TeamColorHelper.getVibrantTextColor(bgColor),
      ),
    );
  }
}
