import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class ShimmerOrderCardWidget extends StatelessWidget {
  const ShimmerOrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 38.h),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 10.h),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withValues(alpha: 0.03),
                      blurRadius: 1.r,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          6.h.verticalSpace,
                          ShimmerPlaceholderWidget(
                            width: 66.w,
                            height: 12.4.h,
                          ),
                          8.h.verticalSpace,
                          ShimmerPlaceholderWidget(height: 14.h),
                          8.h.verticalSpace,
                          ShimmerPlaceholderWidget(
                            width: 200.w,
                            height: 14.h,
                          ),
                        ],
                      ),
                    ),
                    4.w.horizontalSpace,
                    Expanded(
                      child: SizedBox(
                        height: 82.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 4.w,
                          children: [
                            ShimmerPlaceholderWidget(
                              width: 84.w,
                              height: 82.h,
                            ),
                            ShimmerPlaceholderWidget(
                              width: 84.w,
                              height: 82.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: ShimmerPlaceholderWidget(
                  width: 60.w,
                  height: 16.h,
                  borderRadius: 6.r,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
