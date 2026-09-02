import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchDateCountdownFadingLabelWidget extends StatelessWidget {
  final String text;
  final double expandRatio;

  const MatchDateCountdownFadingLabelWidget({
    super.key,
    required this.text,
    required this.expandRatio,
  });

  @override
  Widget build(BuildContext context) {
    final double opacity = ((expandRatio - 0.4) / 0.6).clamp(0.0, 1.0);
    if (opacity <= 0.0) return const SizedBox.shrink();

    return ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: opacity,
        child: Opacity(
          opacity: opacity,
          child: AutoSizeTextWidget(
            text: text,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            colorText: AppColors.fontColor2,
          ),
        ),
      ),
    );
  }
}
