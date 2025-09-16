import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../data/model/copon_data.dart';
import 'details_of_copon_widget.dart';

class ShowDetailsOfCoponWidget extends StatelessWidget {
  const ShowDetailsOfCoponWidget(
      {super.key,
      required this.coponData,
      required this.inOrder,
        required this.discount,
      required this.basePrice});
 final num? discount;
  final List<CoponData>? coponData;
  final bool? inOrder;
  final dynamic basePrice;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: coponData != null,
      child: Row(
        children: [
          Wrap(
              children: coponData!
                  .map(
                    (copon) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => DetailsOfCoponWidget(
                              discount: discount??0,
                              discountCopon: copon.discount!,
                              typeCopon: copon.discountType,
                              coponData: coponData!,
                              inOrder: false,
                              basePrice: basePrice),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.5.sp),
                        margin: EdgeInsets.only(left: 2.0.sp, right: 2.sp),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Row(
                          children: [
                            AutoSizeTextWidget(
                              text: 'كوبون خاص خصم ',
                              fontSize: 8.sp,
                              minFontSize: 3,
                              colorText: AppColors.primaryColor,
                            ),
                            Visibility(
                              visible: copon.discountType != 'percent',
                              replacement: AutoSizeTextWidget(
                                text: '${copon.discount.toString()}%',
                                fontSize: 9.sp,
                                minFontSize: 3,
                                colorText: AppColors.primaryColor,
                              ),
                              child: PriceAndCurrencyWidget(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  textWeight2: FontWeight.normal,
                                  textWeight1: FontWeight.normal,
                                  fontSize1: 8.sp,
                                  fontSize2: 8.sp,
                                  price: copon.discount.toString() ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
          6.horizontalSpace,
          CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.primaryColor.withOpacity(0.05),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
              size: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
