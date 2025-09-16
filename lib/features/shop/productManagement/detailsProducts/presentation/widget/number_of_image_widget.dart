import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';


class NumberOfImageWidget extends StatelessWidget {
  const NumberOfImageWidget({super.key,required this.numImageAndIndex});
  final String numImageAndIndex;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        decoration: BoxDecoration(
          color:AppColors.primaryColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        child: AutoSizeTextWidget(
          text:numImageAndIndex,
          colorText: Colors.white,
          textAlign: TextAlign.center,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
