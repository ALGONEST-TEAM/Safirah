import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/product/products_shimmer_widget.dart';
import '../../../../../core/widgets/shimmer_widget.dart';


class LoadingHomeWidget extends StatelessWidget {
  final bool subSection;

  const LoadingHomeWidget({super.key, this.subSection = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Visibility(
            visible: !subSection,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: ShimmerPlaceholderWidget(height: 126.h),
                ),
                SizedBox(
                  height: 71.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                    physics: const PageScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ShimmerPlaceholderWidget(
                        height: 48.h,
                        width: 90.w,
                      );
                    },
                    separatorBuilder: (context, index) => 8.w.horizontalSpace,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 42.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w)
                  .copyWith(bottom: 12.h, top: 2.h),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ShimmerPlaceholderWidget(width: 70.w);
              },
              separatorBuilder: (context, index) => 8.w.horizontalSpace,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 14.h,
                      width: 80.w,
                      borderRadius: 4.r,
                    ),
                    ShimmerPlaceholderWidget(
                      height: 14.h,
                      width: 120.w,
                    ),
                  ],
                ),
              ),
              const ProductsShimmerWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
