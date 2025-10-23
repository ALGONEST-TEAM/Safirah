import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';

class ShimmerWishProductsWidget extends StatelessWidget {
  const ShimmerWishProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(14.sp),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 12.0,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .0),
                blurRadius: 1.r,
              ),
            ],
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            children: [
              ShimmerPlaceholderWidget(
                height: 140.h,
                width: double.infinity,
              ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      3.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerPlaceholderWidget(
                            height: 12.h,
                            width: 90.w,
                          ),
                          ShimmerWidget(
                            baseColor: Colors.grey[300]!,
                            child: SvgPicture.asset(AppIcons.cart),
                          ),
                        ],
                      ),
                      3.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerPlaceholderWidget(
                            height: 12.h,
                            width: 110.w,
                          ),
                          ShimmerWidget(
                            baseColor: Colors.grey[300]!,
                            child: Icon(
                              Icons.more_horiz,
                              size: 18.r,
                              // color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      4.h.verticalSpace,
                    ],
                  ),
                ),
            ],
          ),
        );
      },
      itemCount: 6,
    );
  }
}
