import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchStandingsTableHeaderWidget extends StatelessWidget {
  const MatchStandingsTableHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Right Side: Rank #
          SizedBox(
            width: 12.w,
            child: AutoSizeTextWidget(
              text: '#',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              colorText: AppColors.fontColor2,
              textAlign: TextAlign.center,
            ),
          ),
          28.w.horizontalSpace, // Spacing matching the team logo/icon alignment
          
          const Spacer(),
          
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Matches Played (م)
              SizedBox(
                width: 18.w,
                child: AutoSizeTextWidget(
                  text: 'م',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 44.w,
                child: AutoSizeTextWidget(
                  text: '=',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                ),
              ),
              // Points (ن)
              SizedBox(
                width: 18.w,
                child: AutoSizeTextWidget(
                  text: 'ن',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
