import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/radio_widget.dart';

class LanguageWidget extends StatelessWidget {
  final String language;
  final String value;
  final String languageGroupValue;
  final VoidCallback onPressed;

  const LanguageWidget({
    super.key,
    required this.language,
    required this.value,
    required this.languageGroupValue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 46.h,
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
                text: language.toString(),
                fontSize: 12.5.sp,
                colorText: const Color(0xFF4F4A59),
              ),
            ),
            RadioWidget(selected: value == languageGroupValue),
          ],
        ),
      ),
    );
  }
}
