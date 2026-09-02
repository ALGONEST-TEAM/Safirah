import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchTabBarShimmerWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const MatchTabBarShimmerWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(46.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            ShimmerPlaceholderWidget(
              width: 58.w,
              height: 26.h,
              borderRadius: 6.r,
            ),
            8.w.horizontalSpace,
            ShimmerPlaceholderWidget(
              width: 68.w,
              height: 26.h,
              borderRadius: 6.r,
            ),
            8.w.horizontalSpace,
            ShimmerPlaceholderWidget(
              width: 82.w,
              height: 26.h,
              borderRadius: 6.r,
            ),
            8.w.horizontalSpace,
            ShimmerPlaceholderWidget(
              width: 65.w,
              height: 26.h,
              borderRadius: 6.r,
            ),
            8.w.horizontalSpace,
            ShimmerPlaceholderWidget(
              width: 90.w,
              height: 26.h,
              borderRadius: 6.r,
            ),
          ],
        ),
      ),
    );
  }
}
