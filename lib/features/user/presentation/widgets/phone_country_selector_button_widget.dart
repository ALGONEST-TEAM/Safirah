import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class PhoneCountrySelectorButtonWidget extends StatelessWidget {
  final String flagEmoji;
  final String dialCode;
  final VoidCallback onTap;

  const PhoneCountrySelectorButtonWidget({
    super.key,
    required this.flagEmoji,
    required this.dialCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 10.w,
          top: 10.h,
          bottom: 8.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              flagEmoji,
              style: TextStyle(fontSize: 15.sp),
            ),
            4.w.horizontalSpace,
            AutoSizeTextWidget(
              text: '+$dialCode',
              colorText: AppColors.primaryColor,
              fontSize: 12.sp,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

