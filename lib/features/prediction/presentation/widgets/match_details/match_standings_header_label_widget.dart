import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchStandingsHeaderLabelWidget extends StatelessWidget {
  final String text;
  final bool isBold;

  const MatchStandingsHeaderLabelWidget({
    super.key,
    required this.text,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26.w,
      child: AutoSizeTextWidget(
        text: text,
        fontSize: 9.5.sp,
        fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
        colorText: AppColors.fontColor3,
        textAlign: TextAlign.center,
      ),
    );
  }
}
