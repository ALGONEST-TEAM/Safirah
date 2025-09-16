import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/product_list_widget.dart';
import '../../../../../core/widgets/shimmer_widget.dart';
import '../../../../../core/widgets/skeletonizer_widget.dart';
import '../../../productManagement/detailsProducts/data/model/product_data.dart';

class ShimmerSubCategoryWidget extends StatelessWidget {
  const ShimmerSubCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              itemCount: 8,
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 2.h),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ShimmerPlaceholderWidget(
                width: 84.w,
              ),
              separatorBuilder: (context, index) => 8.w.horizontalSpace,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.sp).copyWith(top: 14.h),
            child: Row(
              spacing: 8.w,
              children: [
                Expanded(child: ShimmerPlaceholderWidget(height: 30.h)),
                Expanded(child: ShimmerPlaceholderWidget(height: 30.h)),
                Expanded(child: ShimmerPlaceholderWidget(height: 30.h)),
                Expanded(child: ShimmerPlaceholderWidget(height: 30.h)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerPlaceholderWidget(
                  height: 22.h,
                  width: 90.w,
                ),
                ShimmerPlaceholderWidget(
                  height: 23.h,
                  width: 130.w,
                ),
              ],
            ),
          ),
          SkeletonizerWidget(
            child: ProductListWidget(
              product: ProductData.fakeProductData,
            ),
          ),
        ],
      ),
    );
    // return CustomScrollView(
    //   slivers: [
    //     appBarToFilterSubcategoryProductsWidget(
    //       context: context,
    //       hintTextSearch: '',
    //       idCategory: 0,
    //       viewType: 2,
    //       flexibleSpace: ListView.separated(
    //         itemCount: 8,
    //         padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 2.h),
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (context, index) => ShimmerPlaceholderWidget(
    //           height: 130.h,
    //           width: 80.w,
    //         ),
    //         separatorBuilder: (context, index) => 8.w.horizontalSpace,
    //       ),
    //       bottom: const PreferredSize(
    //         preferredSize: Size(0, 0),
    //         child: SizedBox.shrink(),
    //       ),
    //     ),
    //     SliverToBoxAdapter(
    //       child:
    //     )
    //   ],
    // );
  }
}
