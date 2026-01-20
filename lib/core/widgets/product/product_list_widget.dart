import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safirah/features/shop/productManagement/detailsProducts/data/model/product_data.dart';

import '../../theme/app_colors.dart';
import 'product_card.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductData> product;
  final bool isLoadingMore;

  const ProductListWidget({
    super.key,
    required this.product,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MasonryGridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          mainAxisSpacing: 6.h,
          crossAxisSpacing: 6.w,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: product.length,
          itemBuilder: (context, index) {
            return RepaintBoundary(
              key: ValueKey(product[index].id),
              child: ProductCard(
                id: product[index].id!,
                image: product[index].mainImage ?? [],
                name: product[index].name!,
                averageRate: product[index].averageRate ?? 0.0,
                price: product[index].price!,
                isFavorite: true,
                productColorsCount: product[index].productColorsCount,
                colorsOfProduct: product[index].colorsProduct,
                discountData: product[index].discountModel,
              ),
            );
          },
        ),
        if (isLoadingMore)
          Padding(
            padding: EdgeInsets.all(8.sp).copyWith(bottom: 18.h),
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2.r,
              ),
            ),
          ),
        34.h.verticalSpace,
      ],
    );
  }
}
