import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/shop/productManagement/detailsProducts/data/model/discount_model.dart';
import '../../../features/shop/productManagement/detailsProducts/presentation/widget/line_through_price_widget.dart';
import '../../../features/shop/shoppingBag/cart/presentation/pages/add_to_cart_page.dart';
import '../../constants/app_icons.dart';
import '../../theme/app_colors.dart';
import '../buttons/ink_well_button_widget.dart';
import '../price_and_currency_widget.dart';
import '../show_modal_bottom_sheet_widget.dart';

class ProductPriceRowWidget extends StatelessWidget {
  final int id;
  final dynamic price;
  final DiscountModel? discountData;

  const ProductPriceRowWidget({
    super.key,
    required this.id,
    required this.price,
    required this.discountData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Visibility(
              visible: discountData == null,
              replacement: PriceAndCurrencyWidget(
                price: discountData == null
                    ? '0'
                    : discountData!.discountType != 'percent'
                        ? (price! - discountData!.discount ?? 0).toString()
                        : (((price! * (discountData!.discount! / 100) - price!)
                                    .round()) *
                                (-1))
                            .toString(),
                fontSize1: 12.sp,
                fontSize2: 8.5.sp,
              ),
              child: PriceAndCurrencyWidget(
                price: price,
                fontSize1: 12.sp,
                fontSize2: 8.5.sp,
              ),
            ),
            Visibility(
              visible: discountData != null,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PriceAndCurrencyWidget(
                      price: price,
                      fontSize1: 9.8.sp,
                      fontSize2: 7.sp,
                      colorText2: AppColors.fontColor2,
                      colorText1: AppColors.fontColor2,
                    ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: LineThroughPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWellButtonWidget(
          icon: AppIcons.cartActive,
          height: 22.6.h,
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
    );
  }
}
