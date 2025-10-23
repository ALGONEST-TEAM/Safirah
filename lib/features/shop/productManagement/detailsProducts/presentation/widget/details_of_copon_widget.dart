import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../data/model/copon_data.dart';



class DetailsOfCoponWidget extends StatelessWidget {
  const DetailsOfCoponWidget(
      {super.key,
      this.basePrice,
      this.discountCopon,
      this.typeCopon,
      this.coponData,
      this.inOrder,required this.discount});

   final num discount;
  final num? discountCopon;
  final List<CoponData>? coponData;
  final bool? inOrder;
  final String? typeCopon;
  final num? basePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AutoSizeTextWidget(
              text: "تفاصيل العروض الترويجية",
              fontWeight: FontWeight.bold,
            ),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha:0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const AutoSizeTextWidget(
                    text: "السعر بعد الكوبون",
                    colorText: AppColors.primaryColor,
                  ),
                  6.verticalSpace,
                  PriceAndCurrencyWidget(
                    mainAxisAlignment: MainAxisAlignment.center,
                    price: typeCopon != 'percent'
                        ? ((basePrice!-discount) - discountCopon!).toString()
                        : ((((basePrice!-discount) * (discountCopon! / 100) - (basePrice!-discount))
                                    .round()) *
                                (-1))
                            .toString(),
                    colorText1: Colors.red,
                    colorText2: Colors.red,
                    fontSize1: 15,
                    fontSize2: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AutoSizeTextWidget(text: "السعر الأصلي", fontSize: 13),
                const Spacer(),
                Expanded(
                  child: PriceAndCurrencyWidget(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      price: basePrice.toString(),
                      textAlign1: TextAlign.end,
                      textAlign2: TextAlign.end,
                      fontSize1: 12,
                      fontSize2: 11,
                      colorText2: Colors.black,
                      colorText1: Colors.black),
                ),
              ],
            ),
            Visibility(
              visible:discount!=0 ,
              child: Padding(
                padding:  EdgeInsets.only(top: 10.sp),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const AutoSizeTextWidget(
                          text: "سعر التخفيض", fontSize: 13, colorText: Colors.red),
                      const Spacer(),
                  PriceAndCurrencyWidget(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      price: discount.toString(),
                      textAlign1: TextAlign.end,
                      textAlign2: TextAlign.end,
                      fontSize1: 12,
                      fontSize2: 11,
                      colorText2: Colors.red,
                      colorText1: Colors.red),

                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const AutoSizeTextWidget(
                      text: "صفقة خصم", fontSize: 13, colorText: Colors.red),
                  const Spacer(),
                  Visibility(
                    visible: typeCopon != 'percent',
                    replacement: AutoSizeTextWidget(
                      text: '$discountCopon%',
                      fontSize: 13,
                      colorText: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Expanded(
                      child: PriceAndCurrencyWidget(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          price: discountCopon.toString(),
                          textAlign1: TextAlign.end,
                          textAlign2: TextAlign.end,
                          fontSize1: 12,
                          fontSize2: 11,
                          colorText2: Colors.red,
                          colorText1: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AutoSizeTextWidget(
                  text: "السعر بعد الكوبون",
                  fontSize: 13,
                ),
                const Spacer(),
                Expanded(
                  child: PriceAndCurrencyWidget(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      price: typeCopon != 'percent'
                          ? ((basePrice!-discount) - discountCopon!).toString()
                          : ((((basePrice!-discount) * (discountCopon! / 100) - (basePrice!-discount))
                                      .round()) *
                                  (-1))
                              .toString(),
                      textAlign1: TextAlign.end,
                      textAlign2: TextAlign.end,
                      fontSize1: 12,
                      fontSize2: 11,
                      colorText2: Colors.black,
                      colorText1: Colors.black),
                ),
              ],
            ),
            30.verticalSpace,
            AutoSizeTextWidget(
              text: "الخصومات المعروضة تقديرية وتخضع لقواعد كوبونات الخصم.",
              fontSize: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
