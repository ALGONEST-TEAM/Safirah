import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import 'legal_contact_info.dart';
import 'privacy_policy_badge_widget.dart';

class PrivacyPolicyHeroCardWidget extends StatelessWidget {
  final VoidCallback onEmailTap;
  final String supportEmail;

  const PrivacyPolicyHeroCardWidget({
    super.key,
    required this.onEmailTap,
    required this.supportEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryColor,
            AppColors.secondarySwatch.shade700,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44.sp,
            width: 44.sp,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.privacy_tip_outlined,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          14.h.verticalSpace,
          Text(
            'سياسة الخصوصية',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
          8.h.verticalSpace,
          Text(
            'توضح هذه السياسة كيفية جمع واستخدام وحماية المعلومات عند استخدامك لتطبيق صافرة. تطبيق صافرة مملوك ومدار من قبل متجر صافرة. باستخدامك للتطبيق فإنك توافق على هذه السياسة.',
            style: TextStyle(
              fontSize: 11.5.sp,
              height: 1.8,
              color: Colors.white.withValues(alpha: .92),
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
          14.h.verticalSpace,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              const PrivacyPolicyBadgeWidget(
                icon: Icons.event_note_outlined,
                label: 'آخر تحديث: ${LegalContactInfo.lastUpdated}',
              ),
              PrivacyPolicyBadgeWidget(
                icon: Icons.mail_outline,
                label: 'التواصل: $supportEmail',
                onTap: onEmailTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

