import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchEventScoreRowWidget extends StatelessWidget {
  final String prefix; // 'HT' or 'FT'
  final String score;

  const MatchEventScoreRowWidget({
    super.key,
    required this.prefix,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.greySwatch.shade200,
              thickness: 0.8,
              endIndent: 8.w,
            ),
          ),
          AutoSizeTextWidget(
            text: '$prefix $score',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            colorText: AppColors.fontColor,
          ),
          Expanded(
            child: Divider(
              color: AppColors.greySwatch.shade200,
              thickness: 0.8,
              indent: 8.w,
            ),
          ),
        ],
      ),
    );
  }
}
