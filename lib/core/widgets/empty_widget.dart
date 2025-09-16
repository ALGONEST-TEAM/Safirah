import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_images.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String? subTitle;

  const EmptyWidget({
    super.key,
    required this.title,
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.noData,
          height: 200.h,
        ),
        14.h.verticalSpace,
        AutoSizeTextWidget(
          text: title,
        ),
        4.h.verticalSpace,
        AutoSizeTextWidget(
          text: subTitle.toString(),
          colorText: AppColors.fontColor,
          fontSize: 12.4.sp,
        ),
      ],
    );
  }
}
