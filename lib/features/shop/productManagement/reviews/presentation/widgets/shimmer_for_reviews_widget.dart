import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.01),
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
                const ShimmerForEvaluationLinearProgressIndicatorWidget(),
              ],
            ),
          ),
          12.h.verticalSpace,
           const ShimmerForCommentsWidget(),
        ],
      ),
    );
  }
}
