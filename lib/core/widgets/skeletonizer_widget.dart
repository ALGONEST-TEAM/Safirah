import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../theme/app_colors.dart';

class SkeletonizerWidget extends StatelessWidget {
  const SkeletonizerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: ShimmerEffect.raw(
          colors: [
            AppColors.greySwatch.shade200,
            Colors.grey.shade100,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          duration: const Duration(seconds: 2),
          tileMode: TileMode.mirror,
        ),
        child: child);
  }
}
