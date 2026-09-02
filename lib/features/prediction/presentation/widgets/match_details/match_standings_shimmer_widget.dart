import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchStandingsShimmerWidget extends StatelessWidget {
  const MatchStandingsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Competition Header Shimmer
          Row(
            children: [
              ShimmerPlaceholderWidget(
                height: 24.r,
                width: 24.r,
                borderRadius: 12.r,
              ),
              8.w.horizontalSpace,
              ShimmerPlaceholderWidget(
                height: 14.h,
                width: 140.w,
                borderRadius: 4.r,
              ),
            ],
          ),
        //  16.h.verticalSpace,

          // Table Header Shimmer
          // Container(
          //   height: 36.h,
          //   padding: EdgeInsets.symmetric(horizontal: 12.w),
          //   decoration: BoxDecoration(
          //     color: AppColors.greySwatch.shade100.withValues(alpha: 0.5),
          //     borderRadius: BorderRadius.circular(8.r),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ShimmerPlaceholderWidget(height: 12.h, width: 24.w, borderRadius: 4.r),
          //       ShimmerPlaceholderWidget(height: 12.h, width: 80.w, borderRadius: 4.r),
          //       ShimmerPlaceholderWidget(height: 12.h, width: 20.w, borderRadius: 4.r),
          //       ShimmerPlaceholderWidget(height: 12.h, width: 30.w, borderRadius: 4.r),
          //       ShimmerPlaceholderWidget(height: 12.h, width: 24.w, borderRadius: 4.r),
          //     ],
          //   ),
          // ),
          8.h.verticalSpace,

          // Standings Rows Shimmer (10 rows)
          for (int i = 0; i < 10; i++) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Row(
                children: [
                  ShimmerPlaceholderWidget(height: 12.h, width: 16.w, borderRadius: 4.r),
                  12.w.horizontalSpace,
                  ShimmerPlaceholderWidget(height: 20.r, width: 20.r, borderRadius: 10.r),
                  10.w.horizontalSpace,
                  Expanded(
                    child: ShimmerPlaceholderWidget(height: 12.h, width: 100.w, borderRadius: 4.r),
                  ),
                  ShimmerPlaceholderWidget(height: 12.h, width: 20.w, borderRadius: 4.r),
                  16.w.horizontalSpace,
                  ShimmerPlaceholderWidget(height: 12.h, width: 24.w, borderRadius: 4.r),
                  16.w.horizontalSpace,
                  ShimmerPlaceholderWidget(height: 14.h, width: 20.w, borderRadius: 4.r),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.greySwatch.shade100),
          ],
        ],
      ),
    );
  }
}
