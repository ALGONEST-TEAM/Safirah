import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class ShimmerMatchesWidget extends StatelessWidget {
  const ShimmerMatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w)
          .copyWith(bottom: 38.h, top: 12.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
          margin: EdgeInsets.only(top: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  spacing: 6.w,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 16.h,
                      width: 20.w,
                      borderRadius: 4.r,
                    ),
                    ShimmerPlaceholderWidget(
                      height: 12.h,
                      width: 100.w,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 6.h,
                color: AppColors.fontColor2.withValues(alpha: .15),
              ),
              Column(
                children: List.generate(index + 2, (i) {
                  return Column(
                    children: [
                      4.h.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ShimmerPlaceholderWidget(
                              height: 12.h,
                              width:90.w,
                            ),
                          ),
                          6.w.horizontalSpace,
                          ShimmerPlaceholderWidget(
                            height: 18.h,
                            width: 20.w,
                            borderRadius: 4.r,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 4.w,
                              children: [
                                ShimmerPlaceholderWidget(
                                  height: 11.h,
                                  width: 14.w,
                                  borderRadius: 4.r,
                                ),
                                ShimmerWidget(
                                    child: AutoSizeTextWidget(
                                  text: "-",
                                  fontSize: 18.sp,
                                )),
                                ShimmerPlaceholderWidget(
                                  height: 11.h,
                                  width: 14.w,
                                  borderRadius: 4.r,
                                ),
                              ],
                            ),
                          ),
                          ShimmerPlaceholderWidget(
                            height: 18.h,
                            width: 20.w,
                            borderRadius: 4.r,
                          ),
                          6.w.horizontalSpace,
                          Flexible(
                            child: ShimmerPlaceholderWidget(
                              height: 12.h,
                              width: 90.w,
                            ),
                          ),
                          6.w.horizontalSpace,
                        ],
                      ),
                      if (i != (index + 2) - 1)
                        Divider(
                          height: 12.h,
                          color: AppColors.fontColor2.withValues(alpha: .14),
                        )
                      else
                        6.h.verticalSpace,
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
