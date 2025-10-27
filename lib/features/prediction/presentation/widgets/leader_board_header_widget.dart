import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';


class LeaderBoardHeaderWidget extends StatelessWidget {
  const LeaderBoardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(top: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 56.w,
            child: AutoSizeTextWidget(
              text: 'الترتيب',
              fontSize: 12.sp,
              colorText: AppColors.fontColor,
            ),
          ),
          Expanded(
            child: AutoSizeTextWidget(
              text: 'اسم اللاعب',
              fontSize: 12.sp,
              colorText: AppColors.fontColor,
            ),
          ),
          Expanded(
            child: AutoSizeTextWidget(
              text: 'عدد المباريات',
              fontSize: 12.sp,
              colorText: AppColors.fontColor,
            ),
          ),
          SizedBox(
            width: 54.w,
            child: AutoSizeTextWidget(
              text: 'النقاط',
              fontSize: 12.sp,
              colorText: AppColors.fontColor,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
