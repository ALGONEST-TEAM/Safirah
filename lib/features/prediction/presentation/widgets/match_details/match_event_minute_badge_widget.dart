import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchEventMinuteBadgeWidget extends StatelessWidget {
  final dynamic minute;

  const MatchEventMinuteBadgeWidget({super.key, required this.minute});

  @override
  Widget build(BuildContext context) {
    final String cleanMinute = minute.toString().replaceAll("'", "");
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: const BoxDecoration(
        color: Color(0xfff1f1f5),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: AutoSizeTextWidget(
        text: cleanMinute,
        colorText: AppColors.fontColor,
        fontWeight: FontWeight.w600,
        fontSize: 10.sp,
      ),
    );
  }
}
