import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import 'privacy_policy_bullet_text_widget.dart';
import 'privacy_policy_models.dart';

class PrivacyPolicyGroupBlockWidget extends StatelessWidget {
  final PrivacyPolicyGroup group;

  const PrivacyPolicyGroupBlockWidget({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryColor,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
          8.h.verticalSpace,
          ...group.bullets.map(
            (bullet) => PrivacyPolicyBulletTextWidget(text: bullet),
          ),
        ],
      ),
    );
  }
}

