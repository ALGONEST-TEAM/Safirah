import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../constants/app_icons.dart';
import '../helpers/navigateTo.dart';
import 'auto_size_text_widget.dart';
import 'buttons/ink_well_button_widget.dart';
import 'price_and_currency_widget.dart';
import 'rating_bar_widget.dart';
import 'show_modal_bottom_sheet_widget.dart';
import '../../features/shop/productManagement/detailsProducts/presentation/page/details_page.dart';
import '../../features/shop/shoppingBag/cart/presentation/pages/add_to_cart_page.dart';
import '../../features/shop/home/presentation/widgets/product_photos_widget.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final List<String> image;
  final String name;
  final double rates;
  final dynamic price;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.rates,
    required this.price,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(id.toString() + "-------------------");
        navigateTo(
            context,
            DetailsPage(
              idProduct: id,
              image: image,
              name: name,
              price: price,
            ));
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.0),
                    blurRadius: 1.r,
                  ),
                ],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductPhotosWidget(
                    height: 180.h,
                    image: image,
                  ),
                  Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        2.h.verticalSpace,
                        AutoSizeTextWidget(
                          text: name,
                          maxLines: 2,
                          fontSize: 11.6.sp,
                          colorText: AppColors.mainColorFont,
                        ),
                        8.h.verticalSpace,
                        RatingBarWidget(
                          evaluation: 2,
                          itemSize: 12.sp,
                        ),
                        8.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: PriceAndCurrencyWidget(
                                price: price.toString(),
                                fontSize1: 12.sp,
                                textWeight1: FontWeight.w400,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            InkWellButtonWidget(
                              icon: AppIcons.cartActive,
                              height: 23.h,
                              onPressed: () {
                                showModalBottomSheetWidget(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  page: AddToCartPage(
                                    productId: id,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        2.h.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: const Color(0xffDD735A),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: AutoSizeTextWidget(
                text: "50%",
                fontWeight: FontWeight.w400,
                colorText: Colors.white,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
