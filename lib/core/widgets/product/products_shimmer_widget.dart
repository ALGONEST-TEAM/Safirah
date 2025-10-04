import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_icons.dart';
import '../../theme/app_colors.dart';
import '../rating_bar_widget.dart';
import '../shimmer_widget.dart';

class ProductsShimmerWidget extends StatelessWidget {
  const ProductsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      mainAxisSpacing: 6.h,
      crossAxisSpacing: 6.w,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 1.r,
              ),
            ],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: ShimmerPlaceholderWidget(
                  height: 200.h,
                  borderRadius: 0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    1.h.verticalSpace,

                    ShimmerPlaceholderWidget(
                      height: 12.h,
                      width: 130.w,
                    ),
                    5.h.verticalSpace,
                    ShimmerWidget(
                      child: RatingBarWidget(
                        evaluation: 5,
                        itemSize: 11.6.sp,
                      ),
                    ),
                    3.h.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ShimmerPlaceholderWidget(
                            height: 10.6.h,
                            width: 80.w,
                          ),
                        ),
                        ShimmerWidget(
                          // baseColor: AppColors.greySwatch.shade400,
                          child: SvgPicture.asset(
                            AppIcons.cartActive,
                            height: 22.6.h,
                            color: AppColors.greySwatch.shade800,
                          ),
                        ),
                      ],
                    ),
                    1.h.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
