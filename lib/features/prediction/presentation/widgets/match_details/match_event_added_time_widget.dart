import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchEventAddedTimeWidget extends StatelessWidget {
  final String label;

  const MatchEventAddedTimeWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: AutoSizeTextWidget(
          text: label,
          fontSize: 12.sp,
          colorText: AppColors.fontColor3,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
