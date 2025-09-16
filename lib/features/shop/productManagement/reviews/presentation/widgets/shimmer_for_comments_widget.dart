import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 0.8.h),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerPlaceholderWidget(
                    width: 140.w,
                    height: 13.h,
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
              6.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 110.w,
                height: 10.5.h,
              ),
              10.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 300.w,
                height: 12.h,
              ),
              4.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 200.w,
                height: 12.h,
              ),
              10.h.verticalSpace,
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const ShimmerWidget(
                        child: Icon(
                          Icons.favorite_sharp,
                          size: 24,
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
                  ShimmerPlaceholderWidget(
                    width: 140.w,
                    height: 11.h,
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
