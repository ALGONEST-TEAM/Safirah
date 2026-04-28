import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

class PrivacyPolicyContactCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEmailTap;
  final String supportEmail;

  const PrivacyPolicyContactCardWidget({
    super.key,
    this.title = '11. التواصل معنا',
    this.description = 'للاستفسارات المتعلقة بسياسة الخصوصية يمكنك التواصل معنا عبر البريد الإلكتروني التالي:',
    required this.onEmailTap,
    required this.supportEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.secondaryColor.withValues(alpha: .08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.contact_support_outlined,
                  color: AppColors.primaryColor,
                  size: 22.sp,
                ),
              ),
              10.w.horizontalSpace,
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
          12.h.verticalSpace,
          Text(
            description,
            style: TextStyle(
              fontSize: 11.5.sp,
              height: 1.8,
              color: AppColors.fontColor,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
          12.h.verticalSpace,
          InkWell(
            onTap: onEmailTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Ink(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.alternate_email,
                    color: AppColors.secondaryColor,
                    size: 18.sp,
                  ),
                  10.w.horizontalSpace,
                  Expanded(
                    child: Text(
                      supportEmail,
                      style: TextStyle(
                        fontSize: 11.6.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor,
                        fontFamily: 'IBMPlexSansArabic',
                      ),
                    ),
                  ),
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 17.sp,
                    color: AppColors.fontColor2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

