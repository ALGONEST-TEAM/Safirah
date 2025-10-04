import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class UserPageTitlesWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? fontSize;

  const UserPageTitlesWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        AutoSizeTextWidget(
          text: title,
          fontSize:fontSize?? 18.sp,
          fontWeight: FontWeight.w600,
          colorText: Colors.white,
        ),
        6.h.verticalSpace,
        AutoSizeTextWidget(
          text: subTitle,
          fontSize: 12.4.sp,
           fontWeight: FontWeight.w400,
          colorText: Colors.white,

        ),
      ],
    );
  }
}
