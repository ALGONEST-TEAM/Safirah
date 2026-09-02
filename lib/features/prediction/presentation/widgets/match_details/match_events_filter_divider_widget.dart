import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class MatchEventsFilterDividerWidget extends StatelessWidget {
  const MatchEventsFilterDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      width: 1.w,
      color: AppColors.greySwatch.shade200,
    );
  }
}
