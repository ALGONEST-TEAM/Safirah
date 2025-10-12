import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/line_through_price_widget.dart';
import '../../../cart/data/model/cart_model.dart';

class OrderConfirmationProductCardWidget extends StatelessWidget {
  final CartModel data;
  final TextEditingController? printableController;

  const OrderConfirmationProductCardWidget({
    super.key,
    required this.data,
    this.printableController,
  });

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];
    if (data.colorName?.isNotEmpty ?? false) {
      parts.add(' ${data.colorName.toString()}');
    }
    final sizeLabel = S.of(context).size;
    if ((data.sizeName ?? '').isNotEmpty) {
      parts.add('$sizeLabel ${data.sizeName}');
    }
    final numLabel = S.of(context).number;
    if ((data.numberName ?? '').isNotEmpty) {
      parts.add('$numLabel ${data.numberName}');
    }
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnlineImagesWidget(
                imageUrl: data.images.toString(),
                size: Size(
                    86.w,
                    data.discount != 0 || data.couponDiscount != 0
                        ? 100.h
                        : 90.h),
                fit: BoxFit.cover,
                borderRadius: 8.r,
              ),
              10.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    AutoSizeTextWidget(
                      text: data.productName.toString(),
                      maxLines: 2,
                      fontSize: 12.2.sp,
                      minFontSize: 10,
                      colorText: AppColors.mainColorFont,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        if (data.colorHex!.isNotEmpty)
                          Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                              color: data.colorHex.toString().toColor(),
                              borderRadius: BorderRadius.circular(2.6.r),
                            ),
                          ),
                        Flexible(
                          child: AutoSizeTextWidget(
                            text: parts.join(' / '),
                            fontSize: 10.8.sp,
                            colorText: AppColors.fontColor2,
                          ),
                        ),
                      ],
                    ),
                    AutoSizeTextWidget(
                      text:
                          "${S.of(context).quantity}: ${data.quantity.toString()}",
                      fontSize: 11.sp,
                      colorText: AppColors.fontColor2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceAndCurrencyWidget(
                          price: double.parse(
                                  data.productPriceAfterDiscount.toString())
                              .toString(),
                          fontSize1: 12.2.sp,
                          fontSize2: 9.sp,
                        ),
                        6.w.horizontalSpace,
                        if (data.discount != 0 || data.couponDiscount != 0)
                          Stack(
                            children: [
                              PriceAndCurrencyWidget(
                                price: data.price.toString(),
                                fontSize1: 9.4.sp,
                                fontSize2: 7.sp,
                                colorText1: AppColors.fontColor2,
                                colorText2: AppColors.fontColor2,
                              ),
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: LineThroughPainter(),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (data.discount != 0 || data.couponDiscount != 0)
                      Row(
                        children: [
                          if (data.discount != 0)
                            Row(
                              children: [
                                AutoSizeTextWidget(
                                  text: "${S.of(context).discountOnBill}: ",
                                  fontSize: 10.2.sp,
                                  colorText: AppColors.fontColor2,
                                ),
                                PriceAndCurrencyWidget(
                                  price: data.discount.toString(),
                                  fontSize1: 10.sp,
                                  fontSize2: 6.sp,
                                  maxLines: 2,
                                ),
                                4.w.horizontalSpace,
                              ],
                            ),
                          if (data.couponDiscount != 0)
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeTextWidget(
                                      text: "${S.of(context).couponDiscount}: ",
                                      fontSize: 10.2.sp,
                                      maxLines: 2,
                                      colorText: AppColors.fontColor2,
                                    ),
                                  ),
                                  Flexible(
                                    child: PriceAndCurrencyWidget(
                                      price: data.couponDiscount.toString(),
                                      fontSize1: 10.sp,
                                      fontSize2: 6.sp,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
          if (data.isPrintable != 0)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: TextFormFieldWidget(
                controller: printableController!,
                hintText: S.of(context).enterProductPrintDescription,
                hintFontSize: 10.sp,
                fillColor: AppColors.scaffoldColor,
                maxLine: 2,
                fieldValidator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return S.of(context).pleaseEnterProductPrintDescription;
                  }
                  return null;
                },
              ),
            ),
        ],
      ),
    );
  }
}
