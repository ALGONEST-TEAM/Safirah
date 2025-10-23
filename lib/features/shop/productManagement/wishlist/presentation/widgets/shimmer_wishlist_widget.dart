import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';


class ShimmerWishlistWidget extends StatelessWidget {
  const ShimmerWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .0),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 136.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(12.sp),
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ShimmerPlaceholderWidget(
                          height: 140.h,
                          width: 82.w,
                          borderRadius: 6.r,
                        ),
                        // Image.asset(
                        //   AppImages.logoWithText,
                        //   height: 34.h,
                        //   width: 42.w,
                        // ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 6.w),
                  itemCount: index == 1
                      ? 6
                      : index == 2
                          ? 2
                          : 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 14.h,
                      width: 140.w,
                    ),
                    Row(
                      children: [
                        ShimmerWidget(
                          baseColor: Colors.grey[300]!,
                          child: Icon(
                            Icons.share_outlined,
                            size: 18.5.r,
                          ),
                        ),
                        8.w.horizontalSpace,
                        ShimmerWidget(
                          baseColor: Colors.grey[300]!,
                          child: Icon(
                            Icons.more_horiz,
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                ),
                child: ShimmerPlaceholderWidget(
                  height: 14.h,
                  width: 220.w,
                ),
              ),
              8.h.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
