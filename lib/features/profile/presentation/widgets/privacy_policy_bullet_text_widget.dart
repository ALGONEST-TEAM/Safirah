import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

class PrivacyPolicyBulletTextWidget extends StatelessWidget {
  final String text;
  final bool isHighlighted;

  const PrivacyPolicyBulletTextWidget({
    super.key,
    required this.text,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isHighlighted ? AppColors.mainColorFont : AppColors.fontColor;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 5.sp,
              height: 5.sp,
              decoration: BoxDecoration(
                color: isHighlighted
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor.withValues(alpha: .8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          8.w.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.3.sp,
                height: 1.8,
                color: color,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

