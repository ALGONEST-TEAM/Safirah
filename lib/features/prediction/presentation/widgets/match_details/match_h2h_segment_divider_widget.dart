import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class MatchH2hSegmentDividerWidget extends StatelessWidget {
  const MatchH2hSegmentDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      width: 1.w,
      color: AppColors.greySwatch.shade200,
    );
  }
}
