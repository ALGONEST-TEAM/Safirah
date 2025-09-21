import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';

class RadioForTheRightSizeWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final String sizeMethodGroupValue;

  const RadioForTheRightSizeWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    required this.sizeMethodGroupValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeTextWidget(
                text: title,
                fontSize: 11.6.sp,
                colorText: AppColors.fontColor,
              ),
            ),
            RadioWidget(selected: value == sizeMethodGroupValue),
          ],
        ),
      ),
    );

  }
}
