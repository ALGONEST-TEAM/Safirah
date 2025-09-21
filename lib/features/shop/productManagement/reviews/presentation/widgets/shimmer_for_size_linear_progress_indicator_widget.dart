import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';


class ShimmerForEvaluationLinearProgressIndicatorWidget
    extends StatelessWidget {
  const ShimmerForEvaluationLinearProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Row(
            children: [
              ShimmerWidget(
                child: Container(
                  width: 0.8.w,
                  height: 24.h,
                  color: AppColors.fontColor2.withValues(alpha: 0.65),
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                ),
              ),
              ShimmerPlaceholderWidget(
                height: 8.8.h,
                width: 40.w,
              ),
              6.w.horizontalSpace,
              Expanded(
                child: ShimmerWidget(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.sp),
                    child: const LinearProgressIndicator(
                      minHeight: 5,
                    ),
                  ),
                ),
              ),
              6.w.horizontalSpace,
              ShimmerWidget(
                baseColor: AppColors.greySwatch.shade900,
                child: AutoSizeTextWidget(
                  text: "0%",
                  fontSize: 8.5.sp,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}
