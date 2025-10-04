import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;

  const ShimmerWidget({super.key, required this.child, this.baseColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greySwatch.shade100,
      highlightColor: Colors.grey.shade100,
      direction: ShimmerDirection.rtl,
      child: child,
    );
  }
}

class ShimmerPlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? baseColor;
  final double?borderRadius;

  const ShimmerPlaceholderWidget({
    super.key,
    this.width,
    this.height,
    this.baseColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greySwatch.shade100,

      highlightColor: Colors.grey.shade100,
      direction: ShimmerDirection.rtl,

      child: Container(
          width: width ?? double.infinity,
          height: height ?? 100.h,
          decoration: BoxDecoration(
            color: AppColors.greySwatch.shade100,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          )),
    );
  }
}
