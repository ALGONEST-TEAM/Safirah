import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchStatisticsShimmerWidget extends StatelessWidget {
  const MatchStatisticsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Detailed Period Tabs Bar Shimmer
          // Container(
          //   height: 40.h,
          //   padding: EdgeInsets.all(4.r),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(24.r),
          //     border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ShimmerPlaceholderWidget(
          //           height: 32.h,
          //           borderRadius: 20.r,
          //         ),
          //       ),
          //       4.w.horizontalSpace,
          //       Expanded(
          //         child: ShimmerPlaceholderWidget(
          //           height: 32.h,
          //           borderRadius: 20.r,
          //         ),
          //       ),
          //       4.w.horizontalSpace,
          //       Expanded(
          //         child: ShimmerPlaceholderWidget(
          //           height: 32.h,
          //           borderRadius: 20.r,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // 16.h.verticalSpace,

          // Detailed Stat Cards Shimmer (3 cards)
          for (int c = 0; c < 3; c++) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
              ),
              child: Column(
                children: [
                  // Card Header Title Shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Center(
                      child: ShimmerPlaceholderWidget(
                        height: 14.h,
                        width: 110.w,
                        borderRadius: 4.r,
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xfff5f3f9)),

                  // Stat Rows Shimmer (4 rows per card)
                  for (int r = 0; r < 4; r++) ...[
                    if (r > 0) const Divider(height: 1, color: Color(0xfff5f3f9)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Value Shimmer (Right in RTL)
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ShimmerPlaceholderWidget(
                                height: 20.h,
                                width: 32.w,
                                borderRadius: 12.r,
                              ),
                            ),
                          ),

                          // Stat Title Shimmer (Center)
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: ShimmerPlaceholderWidget(
                                height: 12.h,
                                width: 90.w,
                                borderRadius: 4.r,
                              ),
                            ),
                          ),

                          // Away Value Shimmer (Left in RTL)
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ShimmerPlaceholderWidget(
                                height: 20.h,
                                width: 32.w,
                                borderRadius: 12.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            16.h.verticalSpace,
          ],
        ],
      ),
    );
  }
}
