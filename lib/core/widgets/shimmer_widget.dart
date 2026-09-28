import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ShimmerScope extends InheritedWidget {
  const ShimmerScope({super.key, required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShimmerScope>() != null;
  }

  @override
  bool updateShouldNotify(ShimmerScope oldWidget) => false;
}

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (ShimmerScope.of(context)) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.greySwatch.shade100,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      direction: ShimmerDirection.rtl,
      child: ShimmerScope(child: child),
    );
  }
}

class ShimmerPlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? baseColor;
  final double? borderRadius;

  const ShimmerPlaceholderWidget({
    super.key,
    this.width,
    this.height,
    this.baseColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width ?? double.infinity,
      height: height ?? 100.h,
      decoration: BoxDecoration(
        color: baseColor ?? AppColors.greySwatch.shade100,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
    );

    if (ShimmerScope.of(context)) {
      return container;
    }

    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.greySwatch.shade100,
      highlightColor: Colors.grey.shade100,
      direction: ShimmerDirection.rtl,
      child: container,
    );
  }
}
