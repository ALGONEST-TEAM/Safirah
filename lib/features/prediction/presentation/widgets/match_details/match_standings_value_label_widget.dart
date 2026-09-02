import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchStandingsValueLabelWidget extends StatelessWidget {
  final String text;
  final bool isHighlight;
  final bool isPoints;

  const MatchStandingsValueLabelWidget({
    super.key,
    required this.text,
    required this.isHighlight,
    this.isPoints = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.fontColor;
    if (isHighlight) {
      color = AppColors.mainColorFont;
    }
    if (isPoints) {
      color = isHighlight ? AppColors.secondaryColor : AppColors.mainColorFont;
    }

    return SizedBox(
      width: 26.w,
      child: AutoSizeTextWidget(
        text: text,
        fontSize: 11.sp,
        fontWeight: (isHighlight || isPoints) ? FontWeight.w800 : FontWeight.w600,
        colorText: color,
        textAlign: TextAlign.center,
      ),
    );
  }
}
