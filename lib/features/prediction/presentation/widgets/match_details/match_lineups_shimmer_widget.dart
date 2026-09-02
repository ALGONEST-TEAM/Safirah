import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchLineupsShimmerWidget extends StatelessWidget {
  const MatchLineupsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          // 1. Team Toggle Bar Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 44.h,
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ShimmerPlaceholderWidget(
                      height: 36.h,
                      borderRadius: 20.r,
                    ),
                  ),
                  4.w.horizontalSpace,
                  Expanded(
                    child: ShimmerPlaceholderWidget(
                      height: 36.h,
                      borderRadius: 20.r,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.h.verticalSpace,

          // 2. Tactical Pitch Shimmer Container
          Container(
            height: 380.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A2B),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.greySwatch.shade300, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // GK Node
                Center(
                  child: ShimmerPlaceholderWidget(
                    height: 40.r,
                    width: 40.r,
                    borderRadius: 20.r,
                  ),
                ),
                // DF Row (4 nodes)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => ShimmerPlaceholderWidget(
                      height: 40.r,
                      width: 40.r,
                      borderRadius: 20.r,
                    ),
                  ),
                ),
                // MF Row (4 nodes)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => ShimmerPlaceholderWidget(
                      height: 40.r,
                      width: 40.r,
                      borderRadius: 20.r,
                    ),
                  ),
                ),
                // FW Row (2 nodes)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    2,
                    (index) => ShimmerPlaceholderWidget(
                      height: 40.r,
                      width: 40.r,
                      borderRadius: 20.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.h.verticalSpace,

          // 3. Coach Card Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Row(
                children: [
                  ShimmerPlaceholderWidget(height: 40.r, width: 40.r, borderRadius: 20.r),
                  12.w.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceholderWidget(height: 12.h, width: 100.w, borderRadius: 4.r),
                      6.h.verticalSpace,
                      ShimmerPlaceholderWidget(height: 10.h, width: 60.w, borderRadius: 4.r),
                    ],
                  ),
                ],
              ),
            ),
          ),
          16.h.verticalSpace,

          // 4. Bench Shimmer List
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    if (i > 0) 10.h.verticalSpace,
                    Row(
                      children: [
                        ShimmerPlaceholderWidget(height: 32.r, width: 32.r, borderRadius: 16.r),
                        10.w.horizontalSpace,
                        ShimmerPlaceholderWidget(height: 12.h, width: 110.w, borderRadius: 4.r),
                        const Spacer(),
                        ShimmerPlaceholderWidget(height: 18.h, width: 30.w, borderRadius: 8.r),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
