import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
class GeneralDesignForOrderDetailsWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Widget child;

  const GeneralDesignForOrderDetailsWidget({
    super.key,
    required this.title,
    required this.child,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
          child: AutoSizeTextWidget(
            text: title,
            fontSize: fontSize ?? 11.6.sp,
            fontWeight: FontWeight.w400,
            colorText: AppColors.mainColorFont,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all( 8.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.015),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
