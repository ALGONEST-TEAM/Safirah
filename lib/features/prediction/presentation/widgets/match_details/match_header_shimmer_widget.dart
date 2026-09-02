import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class MatchHeaderShimmerWidget extends StatelessWidget {
  const MatchHeaderShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, statusBarHeight + 4.h, 16.w, 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Title & Buttons Shimmer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerPlaceholderWidget(
                height: 28.r,
                width: 28.r,
                borderRadius: 14.r,
              ),
              ShimmerPlaceholderWidget(
                height: 14.h,
                width: 100.w,
                borderRadius: 4.r,
              ),
              ShimmerPlaceholderWidget(
                height: 28.r,
                width: 28.r,
                borderRadius: 14.r,
              ),
            ],
          ),
          8.h.verticalSpace,

          // Logos & Center Score/Time Shimmer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Home Team Logo & Name Shimmer
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 42.r,
                      width: 42.r,
                      borderRadius: 21.r,
                    ),
                    4.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 10.h,
                      width: 60.w,
                      borderRadius: 3.r,
                    ),
                  ],
                ),
              ),

              // Center Score / Date Time Shimmer
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 18.h,
                    width: 55.w,
                    borderRadius: 6.r,
                  ),
                  4.h.verticalSpace,
                  ShimmerPlaceholderWidget(
                    height: 10.h,
                    width: 40.w,
                    borderRadius: 3.r,
                  ),
                ],
              ),

              // Away Team Logo & Name Shimmer
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 42.r,
                      width: 42.r,
                      borderRadius: 21.r,
                    ),
                    4.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 10.h,
                      width: 60.w,
                      borderRadius: 3.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
