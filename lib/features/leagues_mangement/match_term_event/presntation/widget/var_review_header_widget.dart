import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';

class VarReviewHeaderWidget extends StatelessWidget {
  const VarReviewHeaderWidget({super.key,
    required this.isGoal,
    required this.isYellow,
    required this.isRed,
  });

  final bool isGoal;
  final bool isYellow;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    final String text = isGoal
        ? "🏁 مراجعة الهدف المسجل من اللاعب حسين الأشول"
        : isYellow
        ? "🟨 مراجعة الإنذار الأصفر ضد اللاعب حسين الأشول"
        : "🟥 مراجعة الإنذار الأحمر ضد اللاعب حسين الأشول";

    return AutoSizeTextWidget(
      text: text,
      textAlign: TextAlign.center,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    );
  }
}
