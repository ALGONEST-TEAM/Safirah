import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../features/profile/presentation/riverpod/currency_riverpod.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';

class PriceAndCurrencyWidget extends ConsumerWidget {
  final dynamic price;
  final double? fontSize1;
  final double? fontSize2;
  final Color? colorText1;
  final Color? colorText2;
  final TextAlign? textAlign1;
  final TextAlign? textAlign2;
  final FontWeight? textWeight1;
  final FontWeight? textWeight2;

  final int? maxLines;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const PriceAndCurrencyWidget(
      {super.key,
      required this.price,
      this.fontSize1,
      this.fontSize2,
      this.colorText1,
      this.colorText2,
      this.textAlign1,
      this.textAlign2,
      this.maxLines,
      this.crossAxisAlignment,
      this.mainAxisAlignment,
      this.textWeight1,
      this.textWeight2});

  @override
  Widget build(BuildContext context, ref) {
    var currencyState = ref.watch(currencyProvider);
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');

    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AutoSizeTextWidget(
            text: formatter.format(double.tryParse(price.toString())),
            colorText: colorText1 ?? AppColors.primaryColor,
            fontSize: fontSize1 ?? 11.4.sp,
            fontWeight: textWeight1 ?? FontWeight.w500,
            textAlign: textAlign1 ?? TextAlign.start,
            minFontSize: 9,
            maxLines: maxLines ?? 1,
          ),
        ),
        2.w.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: AutoSizeTextWidget(
            text: currencyState.toString(),
            colorText: colorText2 ?? AppColors.primaryColor,
            fontSize: fontSize2 ?? 8.5.sp,
            fontWeight: textWeight2 ?? FontWeight.w500,
            minFontSize: 8,
            textAlign: textAlign2 ?? TextAlign.start,
          ),
        ),
      ],
    );
  }
}
