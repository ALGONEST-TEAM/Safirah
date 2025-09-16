import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';


class PriceAndCurrencyDesignWidget extends StatelessWidget {
  final String price;
  final String currency;
  final double? fontSize1;
  final double? fontSize2;

  const PriceAndCurrencyDesignWidget({
    super.key,
    required this.price,
    required this.currency,
    this.fontSize1,
    this.fontSize2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: AutoSizeTextWidget(
            text: price,
            colorText: AppColors.primaryColor,
            fontSize: fontSize1 ?? 11.sp,
            fontWeight: FontWeight.w700,
            minFontSize: 11,
          ),
        ),
        2.w.horizontalSpace,
        AutoSizeTextWidget(
          text: currency,
          colorText: AppColors.primaryColor,
          fontSize: fontSize2 ?? 8.5.sp,
          fontWeight: FontWeight.w700,
          minFontSize: 8,
        ),
      ],
    );
  }
}
