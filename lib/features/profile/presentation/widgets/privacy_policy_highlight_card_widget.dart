import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import 'privacy_policy_bullet_text_widget.dart';

class PrivacyPolicyHighlightCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> bullets;

  const PrivacyPolicyHighlightCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: .18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 22.sp),
              8.w.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainColorFont,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
              ),
            ],
          ),
          10.h.verticalSpace,
          ...bullets.map(
            (bullet) => PrivacyPolicyBulletTextWidget(
              text: bullet,
              isHighlighted: true,
            ),
          ),
        ],
      ),
    );
  }
}

