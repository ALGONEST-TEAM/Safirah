import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchLineupsCoachRowWidget extends StatelessWidget {
  final String coachName;

  const MatchLineupsCoachRowWidget({
    super.key,
    required this.coachName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person_pin_rounded, color: AppColors.secondaryColor, size: 24.sp),
              12.w.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: coachName,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    colorText: AppColors.mainColorFont,
                  ),
                  2.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: 'المدير الفني',
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    colorText: AppColors.fontColor3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
