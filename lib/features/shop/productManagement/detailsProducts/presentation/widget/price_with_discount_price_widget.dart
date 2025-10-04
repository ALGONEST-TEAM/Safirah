import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../data/model/discount_model.dart';
import 'line_through_price_widget.dart';

class PriceWithDiscountPriceWidget extends StatelessWidget {
  final dynamic price;
  final DiscountModel? discountModel;

  const PriceWithDiscountPriceWidget({
    super.key,
    required this.price,
    required this.discountModel,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: discountModel == null,
          replacement: PriceAndCurrencyWidget(
            price: discountModel == null
                ? '0'
                : discountModel!.discountType != 'percent'
                    ? (price! - discountModel!.discount ?? 0).toString()
                    : (((price! * (discountModel!.discount! / 100) - price!).round()) * (-1))
                        .toString(),
            fontSize1: 14.6.sp,
            fontSize2: 10.sp,
          ),
          child: PriceAndCurrencyWidget(
            price: price,
            fontSize1: 14.6.sp,
            fontSize2: 10.sp,
          ),
        ),
        Visibility(
          visible: discountModel != null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                PriceAndCurrencyWidget(
                  price:price,
                  fontSize1: 10.sp,
                  fontSize2: 8.sp,
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
    );
  }
}
