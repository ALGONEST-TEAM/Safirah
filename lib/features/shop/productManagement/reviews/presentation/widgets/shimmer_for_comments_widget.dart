import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';

class ShimmerForCommentsWidget extends StatelessWidget {
  const ShimmerForCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.01),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerPlaceholderWidget(
                    width: 160.w,
                    height: 11.5.h,
                  ),
                  6.w.horizontalSpace,
                  ShimmerWidget(
                    child: RatingBarWidget(
                      evaluation: 4.5,
                      itemSize: 14.sp,
                    ),
                  ),
                ],
              ),
              4.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 110.w,
                height: 10.h,
              ),
              6.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 140.w,
                height: 10.8.h,
              ),
              10.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 300.w,
                height: 11.5.h,
              ),
              4.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 200.w,
                height: 11.5.h,
              ),
              10.h.verticalSpace,
              Row(
                children: [
                  ShimmerWidget(
                    child: SvgPicture.asset(
                      AppIcons.like,
                    ),
                  ),
                  4.w.horizontalSpace,
                  ShimmerWidget(
                    child: AutoSizeTextWidget(
                      text: "0",
                      fontSize: 10.4.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
