import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';

class OrderDetailsCardDataDesignWidget extends StatelessWidget {
  final String? title;
  final String subTitle;
  final Color? color;
  final bool isColor;
  final bool isPrice;
  final Color? colorTitleAndPrice;

  const OrderDetailsCardDataDesignWidget(
      {super.key,
       this.title,
      required this.subTitle,
      this.color,
      this.isColor = false,
      this.isPrice = false,
      this.colorTitleAndPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: title!=null,
          child: AutoSizeTextWidget(
            text: title.toString(),
            fontSize: 11.5.sp,
            colorText: colorTitleAndPrice ?? AppColors.fontColor,
          ),
        ),
        Visibility(
          visible: isColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: CircleAvatar(
              backgroundColor: color ?? Colors.transparent,
              radius: 5.r,
            ),
          ),
        ),
     2.w.horizontalSpace,
        Flexible(
          child: Visibility(
            visible: !isPrice,
            replacement: PriceAndCurrencyWidget(
              price: subTitle,
              fontSize1: 11.sp,
              fontSize2: 8.sp,
              textWeight1: FontWeight.w500,
              textWeight2: FontWeight.w600,
              colorText1: colorTitleAndPrice ?? AppColors.primaryColor,
              colorText2: colorTitleAndPrice ?? AppColors.primaryColor,
            ),
            child: AutoSizeTextWidget(
              text: subTitle,
              fontSize: 11.5.sp,
              colorText: AppColors.fontColor,
            ),
          ),
        ),
      ],
    );
  }
}
