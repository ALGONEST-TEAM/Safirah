import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';

class ShimmerCardWidget extends ConsumerWidget {
  const ShimmerCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(12.sp),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .02),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 17.h,
                  width: 17.w,
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.fontColor2.withValues(alpha: .6),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 80.h,
                    width: 90.w,
                    borderRadius: 8.r,
                  ),
                  // Image.asset(
                  //   AppImages.logoWithText,
                  //   height: 54.h,
                  //   width: 54.w,
                  // ),
                ],
              ),
              8.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerPlaceholderWidget(
                      width: 180.w,
                      height: 15.h,
                    ),
                    6.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 13.h,
                      width: 140.w,
                    ),
                    6.h.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ShimmerPlaceholderWidget(
                            height: 14.h,
                            width: 40.w,
                          ),
                        ),
                        6.w.horizontalSpace,
                        Row(
                          children: [
                            ShimmerPlaceholderWidget(
                              height: 22.h,
                              width: 25.w,
                              borderRadius: 6.6.r,
                            ),
                            4.w.horizontalSpace,
                            ShimmerPlaceholderWidget(
                              height: 22.h,
                              width: 25.w,
                              borderRadius: 6.6.r,
                            ),
                            4.w.horizontalSpace,
                            ShimmerPlaceholderWidget(
                              height: 22.h,
                              width: 25.w,
                              borderRadius: 6.6.r,
                            ),
                          ],
                        ),
                        6.w.horizontalSpace,
                        ShimmerPlaceholderWidget(
                          height: 22.h,
                          width: 25.w,
                          borderRadius: 6.6.r,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              4.w.horizontalSpace,
            ],
          ),
        );
      },
    );
  }
}
