import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'price_and_currency_widget.dart';

class BillDesignWidget extends StatelessWidget {
  final String name;
  final num price;
  final double? fontSize1;
  final double? fontSize2;

  final Color? color1;
  final Color? color2;

  const BillDesignWidget({
    super.key,
    required this.name,
    required this.price,
    this.fontSize1,
    this.fontSize2,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: AutoSizeTextWidget(
              text: name,
              fontWeight: FontWeight.w600,
              colorText: color1 ?? AppColors.fontColor2,
              fontSize: fontSize1 ?? 12.sp,
            ),
          ),
          Expanded(
            child: PriceAndCurrencyWidget(
              price: price.toString(),
              fontSize1: fontSize2 ?? 12.sp,
              fontSize2: 9.sp,
              colorText1: color2 ?? AppColors.secondaryColor,
              colorText2: color2 ?? AppColors.secondaryColor,
              textAlign1: TextAlign.end,
              textAlign2: TextAlign.end,
              textWeight1: FontWeight.w600,
              textWeight2: FontWeight.w600,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          4.w.horizontalSpace,
        ],
      ),
    );
  }
}
