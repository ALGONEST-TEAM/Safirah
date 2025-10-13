import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';

class AppIntroCardWidget extends StatelessWidget {
  const AppIntroCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withValues(alpha: 0.01),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100.w,
            height: 94.w,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.h,
              children: [
                SvgPicture.asset(
                  AppIcons.logo,
                  width: 36.w,
                ),
                AutoSizeTextWidget(
                  text: S.of(context).appName,
                  colorText: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.all(10.sp),
              child: AutoSizeTextWidget(
                text: S.of(context).appDescription,
                colorText: AppColors.fontColor,
                fontSize: 11.6.sp,
                fontWeight: FontWeight.w400,
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
