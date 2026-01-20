import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/shop/productManagement/detailsProducts/data/model/color_data.dart';
import '../../../features/shop/productManagement/detailsProducts/data/model/discount_model.dart';
import '../../helpers/navigateTo.dart';
import '../../theme/app_colors.dart';
import '../auto_size_text_widget.dart';
import '../rating_bar_widget.dart';
import '../../../features/shop/productManagement/detailsProducts/presentation/page/details_page.dart';
import 'product_photos_widget.dart';
import 'product_price_row_widget.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final List<String> image;
  final String name;
  final num averageRate;
  final dynamic price;
  final DiscountModel? discountData;
  final bool isFavorite;
  final int? productColorsCount;
  final List<ColorOfProductData>? colorsOfProduct;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.averageRate,
    required this.price,
    this.discountData,
    required this.isFavorite,
    this.productColorsCount,
    this.colorsOfProduct,
  });
  bool get _hasPercentDiscount =>
      discountData != null && discountData!.discountType == 'percent';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          DetailsPage(
            idProduct: id,
            image: image,
            name: name,
            price: price,
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: _hasPercentDiscount? 10.h
                      : 0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductPhotosWidget(
                    productId: id,
                    height: 200.h,
                    image: image,
                    colorsOfProduct: colorsOfProduct ?? [],
                    productColorsCount: productColorsCount ?? 0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: name,
                          maxLines: 2,
                          fontSize: 11.6.sp,
                          minFontSize: 11,
                          colorText: AppColors.mainColorFont,
                        ),
                        3.6.h.verticalSpace,
                        RatingBarWidget(
                          evaluation: averageRate.toDouble(),
                          itemSize: 11.6.sp,
                        ),
                        ProductPriceRowWidget(
                          id: id,
                          price: price,
                          discountData: discountData,
                        ),
                        1.6.h.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_hasPercentDiscount)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xffDD735A),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: AutoSizeTextWidget(
                  text: "${discountData!.discount!.toString()}%",
                  fontWeight: FontWeight.w400,
                  colorText: Colors.white,
                  fontSize: 9.4.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
