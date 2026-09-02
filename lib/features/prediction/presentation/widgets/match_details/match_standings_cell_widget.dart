import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchStandingsCellWidget extends StatelessWidget {
  final String text;
  final double width;
  final bool isHeader;
  final bool isHighlight;
  final Color? textColor;

  const MatchStandingsCellWidget({
    super.key,
    required this.text,
    required this.width,
    this.isHeader = false,
    this.isHighlight = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return SizedBox(
        width: width,
        child: AutoSizeTextWidget(
          text: text,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          colorText: AppColors.fontColor2,
          textAlign: TextAlign.center,
        ),
      );
    }

    final Color defaultColor = isHighlight ? AppColors.secondaryColor : AppColors.fontColor;

    return SizedBox(
      width: width,
      child: AutoSizeTextWidget(
        text: text,
        fontSize: 11.5.sp,
        fontWeight: FontWeight.w500,
        colorText: (isHighlight && textColor != null) ? textColor : defaultColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}
