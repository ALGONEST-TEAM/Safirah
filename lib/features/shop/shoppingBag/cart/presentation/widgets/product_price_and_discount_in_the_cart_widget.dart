import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/line_through_price_widget.dart';

class ProductPriceAndDiscountInTheCartWidget extends StatelessWidget {
  final String price;
  final String productPriceAfterDiscount;
  final num? discount;

  const ProductPriceAndDiscountInTheCartWidget({
    super.key,
    required this.price,
    required this.productPriceAfterDiscount,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          if (discount != null)
            Stack(
              children: [
                PriceAndCurrencyWidget(
                  price: price.toString(),
                  fontSize1: 9.sp,
                  fontSize2: 6.sp,
                  colorText1: AppColors.fontColor,
                  colorText2: AppColors.fontColor,
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: LineThroughPainter(),
                  ),
                ),
              ],
            ),
          PriceAndCurrencyWidget(
            price: productPriceAfterDiscount,
            fontSize1: 11.8.sp,
            fontSize2: 8.sp,
          ),
        ],
      ),
    );
  }
}
