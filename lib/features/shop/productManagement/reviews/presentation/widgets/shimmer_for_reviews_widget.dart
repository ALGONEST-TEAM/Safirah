import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_images.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';
import 'shimmer_for_comments_widget.dart';
import 'shimmer_for_size_linear_progress_indicator_widget.dart';

class ShimmerForReviewsWidget extends StatelessWidget {
  const ShimmerForReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.02),
                  blurRadius: 1.r,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 78.h,
                      width: 90.w,
                    ),
                    Image.asset(
                      AppImages.logoWithText,
                      height: 58.h,
                      width: 58.w,
                    ),
                  ],
                ),
                12.w.horizontalSpace,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 16.h,
                        width: 180.w,
                      ),
                      12.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 15.h,
                        width: 140.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.02),
                  blurRadius: 1.r,
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    ShimmerWidget(
                      child: AutoSizeTextWidget(
                        text: "0.0",
                        fontSize: 23.sp,
                        maxFontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    6.h.verticalSpace,
                    ShimmerWidget(
                      child: RatingBarWidget(
                        evaluation: 5.0,
                        itemSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                ShimmerForEvaluationLinearProgressIndicatorWidget(),
              ],
            ),
          ),
          8.h.verticalSpace,
          ShimmerForCommentsWidget(),
        ],
      ),
    );
  }
}
