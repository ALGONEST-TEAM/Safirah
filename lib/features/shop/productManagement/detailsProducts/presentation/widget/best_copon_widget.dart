import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../data/model/copon_data.dart';
import 'details_of_copon_widget.dart';

class BestCoponWidget extends StatelessWidget {
  const BestCoponWidget({super.key, required this.copon, this.basePrice, this.discount});

  final dynamic basePrice;
  final List<CoponData> copon;
  final num? discount;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => DetailsOfCoponWidget(
              discountCopon: copon[0].discount!,
              typeCopon: copon[0].discountType,
              discount: discount??0,
              coponData: copon,
              inOrder: false,
              basePrice: basePrice),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
        child: Row(
          children: [
            PriceAndCurrencyWidget(
              price: copon[0].discountType != 'percent'
                  ? ((basePrice-discount)! - copon[0].discount!).toString()
                  : ((((basePrice-discount)! * (copon[0].discount / 100) - (basePrice-discount)!)
                              .round()) *
                          (-1))
                      .toString(),
              fontSize1: 9.sp,
              fontSize2: 9.sp,
              textWeight1: FontWeight.normal,
              textWeight2: FontWeight.normal,
            ),
            AutoSizeTextWidget(
              text: ' | ',
              fontSize: 8.sp,
              minFontSize: 3,
              colorText: AppColors.primaryColor,
            ),
            AutoSizeTextWidget(
              text: 'بعد الكوبون ',
              fontSize: 8.sp,
              minFontSize: 3,
              colorText: AppColors.primaryColor,
            ),
            1.horizontalSpace,
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
              size: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
