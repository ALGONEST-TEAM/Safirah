import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import 'privacy_policy_bullet_text_widget.dart';
import 'privacy_policy_group_block_widget.dart';
import 'privacy_policy_models.dart';

class PrivacyPolicySectionCardWidget extends StatelessWidget {
  final String number;
  final String title;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<PrivacyPolicyGroup> groups;

  const PrivacyPolicySectionCardWidget({
    super.key,
    required this.number,
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
    this.groups = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 28.sp,
                width: 28.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
              ),
              10.w.horizontalSpace,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
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
              ),
            ],
          ),
          if (paragraphs.isNotEmpty) 12.h.verticalSpace,
          ...paragraphs.map(
            (paragraph) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                paragraph,
                style: TextStyle(
                  fontSize: 11.4.sp,
                  height: 1.8,
                  color: AppColors.fontColor,
                  fontFamily: 'IBMPlexSansArabic',
                ),
              ),
            ),
          ),
          if (bullets.isNotEmpty) ...[
            if (paragraphs.isEmpty) 12.h.verticalSpace,
            ...bullets.map(
              (bullet) => PrivacyPolicyBulletTextWidget(text: bullet),
            ),
          ],
          if (groups.isNotEmpty) ...[
            if (paragraphs.isEmpty && bullets.isEmpty) 12.h.verticalSpace,
            if (paragraphs.isNotEmpty || bullets.isNotEmpty) 4.h.verticalSpace,
            ...groups.map(
              (group) => Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: PrivacyPolicyGroupBlockWidget(group: group),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

