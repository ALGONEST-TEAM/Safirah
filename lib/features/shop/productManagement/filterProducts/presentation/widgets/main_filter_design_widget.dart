import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';

class MainFilterDesignWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? color;
  final GestureTapCallback onTap;
  final bool border;

  const MainFilterDesignWidget({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    required this.onTap,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            border: border ? Border.all(color: AppColors.secondaryColor,width: 0.8.w) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeTextWidget(
                  text: title,
                  colorText: AppColors.fontColor,
                  fontSize: 10.8.sp,
                  minFontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              2.w.horizontalSpace,
              Padding(
                padding:  EdgeInsets.only(top: 2.h),
                child: SvgPicture.asset(
                  icon,
                  color: AppColors.fontColor.withValues(alpha: 0.8),
                  height: 10.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
