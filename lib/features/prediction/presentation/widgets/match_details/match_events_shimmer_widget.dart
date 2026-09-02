import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchEventsShimmerWidget extends StatelessWidget {
  const MatchEventsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Key Statistics Card Shimmer
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            child: Column(
              children: [
                Center(
                  child: ShimmerPlaceholderWidget(
                    height: 14.h,
                    width: 100.w,
                    borderRadius: 4.r,
                  ),
                ),
                8.h.verticalSpace,
                const Divider(height: 1, color: Color(0xfff5f3f9)),
                8.h.verticalSpace,
                ShimmerPlaceholderWidget(
                  height: 12.h,
                  width: 120.w,
                  borderRadius: 4.r,
                ),
                10.h.verticalSpace,
                ShimmerPlaceholderWidget(
                  height: 28.h,
                  borderRadius: 12.r,
                ),
                16.h.verticalSpace,
                for (int i = 0; i < 3; i++) ...[
                  if (i > 0) 10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 20.h,
                        width: 36.w,
                        borderRadius: 12.r,
                      ),
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 90.w,
                        borderRadius: 4.r,
                      ),
                      ShimmerPlaceholderWidget(
                        height: 20.h,
                        width: 36.w,
                        borderRadius: 12.r,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          16.h.verticalSpace,

          // 2. Best Player Card Shimmer
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            child: Row(
              children: [
                ShimmerPlaceholderWidget(
                  height: 48.r,
                  width: 48.r,
                  borderRadius: 24.r,
                ),
                12.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 14.h,
                        width: 130.w,
                        borderRadius: 4.r,
                      ),
                      6.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 11.h,
                        width: 90.w,
                        borderRadius: 4.r,
                      ),
                    ],
                  ),
                ),
                ShimmerPlaceholderWidget(
                  height: 28.h,
                  width: 44.w,
                  borderRadius: 8.r,
                ),
              ],
            ),
          ),
          16.h.verticalSpace,

          // 3. Events Filter Tabs Shimmer
          Container(
            height: 38.h,
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  if (i > 0) 4.w.horizontalSpace,
                  Expanded(
                    child: ShimmerPlaceholderWidget(
                      height: 30.h,
                      borderRadius: 16.r,
                    ),
                  ),
                ],
              ],
            ),
          ),
          16.h.verticalSpace,

          // 4. Events Timeline Items Shimmer (2 items)
          for (int i = 0; i < 2; i++) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ShimmerPlaceholderWidget(
                          height: 20.r,
                          width: 20.r,
                          borderRadius: 10.r,
                        ),
                        8.w.horizontalSpace,
                        ShimmerPlaceholderWidget(
                          height: 12.h,
                          width: 80.w,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                  ),
                  ShimmerPlaceholderWidget(
                    height: 24.r,
                    width: 24.r,
                    borderRadius: 12.r,
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
            12.h.verticalSpace,
          ],

          // 5. Stadium Info Card Shimmer
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ShimmerPlaceholderWidget(height: 20.r, width: 20.r, borderRadius: 4.r),
                    12.w.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerPlaceholderWidget(height: 12.h, width: 120.w, borderRadius: 4.r),
                        6.h.verticalSpace,
                        ShimmerPlaceholderWidget(height: 10.h, width: 80.w, borderRadius: 4.r),
                      ],
                    ),
                  ],
                ),
                12.h.verticalSpace,
                ShimmerPlaceholderWidget(height: 4.h, borderRadius: 2.r),
              ],
            ),
          ),
          16.h.verticalSpace,

          // 6. Match Info Card Shimmer
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
            ),
            child: Column(
              children: [
                for (int i = 0; i < 3; i++) ...[
                  if (i > 0) 10.h.verticalSpace,
                  Row(
                    children: [
                      ShimmerPlaceholderWidget(height: 18.r, width: 18.r, borderRadius: 4.r),
                      12.w.horizontalSpace,
                      ShimmerPlaceholderWidget(height: 12.h, width: 140.w, borderRadius: 4.r),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
