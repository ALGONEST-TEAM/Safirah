import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../productManagement/reviews/presentation/pages/reviews_page.dart';
import '../../data/model/product_order_details_model.dart';

class OrderDetailsProductCardWidget extends StatelessWidget {
  final ProductOrderDetailsModel orderProducts;
  final int orderId;
  final int status;

  const OrderDetailsProductCardWidget({
    super.key,
    required this.orderProducts,
    required this.orderId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withValues(alpha: 0.02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OnlineImagesWidget(
            imageUrl: orderProducts.image.toString(),
            size: Size(84.w, 90.h),
            fit: BoxFit.cover,
          ),
          12.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 7.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: orderProducts.name.toString(),
                        maxLines: 2,
                        fontSize: 11.5.sp,
                        minFontSize: 10,
                        colorText: AppColors.mainColorFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.w.horizontalSpace,
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          ReviewsPage(
                            products: orderProducts,
                            orderId: orderId,
                            status: status,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AutoSizeTextWidget(
                            text: S.of(context).opinions,
                            fontSize: 10.sp,
                            colorText: AppColors.primaryColor,
                          ),
                          Icon(
                            Localizations.localeOf(context).languageCode == "ar"
                                ? Icons.keyboard_arrow_left
                                : Icons.keyboard_arrow_right,
                            color: AppColors.primaryColor,
                            size: 15.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (orderProducts.colorHex!.isNotEmpty)
                      Container(
                        height: 12.h,
                        width: 12.w,
                        decoration: BoxDecoration(
                          color: orderProducts.colorHex.toString().toColor(),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    Flexible(
                      child: AutoSizeTextWidget(
                        text:
                            " ${orderProducts.colorName.toString()}${orderProducts.colorName!.isNotEmpty ? " - " : ''}${S.of(context).size}: ${orderProducts.sizeValue.toString()}",
                        fontSize: 11.sp,
                        colorText: AppColors.fontColor2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AutoSizeTextWidget(
                      text:
                          "${S.of(context).quantity}: ${orderProducts.quantity.toString()}",
                      fontSize: 11.sp,
                      colorText: AppColors.fontColor2,
                    ),
                    8.w.horizontalSpace,
                    PriceAndCurrencyWidget(
                      price: orderProducts.price.toString(),
                      fontSize1: 11.sp,
                      fontSize2: 8.2.sp,
                      textWeight1: FontWeight.w500,
                      textWeight2: FontWeight.w600,
                      colorText1: AppColors.fontColor2,
                      colorText2: AppColors.fontColor2,
                    ),
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: " / ${S.of(context).forUnitPrice}",
                        fontSize: 10.6.sp,
                        colorText: AppColors.fontColor2,
                      ),
                    ),
                  ],
                ),
                // Visibility(
                //   visible: orderProducts.hasCopon == 1,
                //   child: Column(
                //     children: [
                //       OrderDetailsCardDataDesignWidget(
                //         title: "اجمالي خصم الكوبون:",
                //         subTitle: orderProducts.totalDiscountCopon.toString(),
                //         isPrice: true,
                //         colorTitleAndPrice: AppColors.primaryColor,
                //       ),
                //       4.h.verticalSpace,
                //     ],
                //   ),
                // ),
                Row(
                  children: [
                    AutoSizeTextWidget(
                      text: "${S.of(context).total}:",
                      fontSize: 11.sp,
                      colorText: AppColors.fontColor2,
                    ),
                    2.w.horizontalSpace,
                    Flexible(
                      child: PriceAndCurrencyWidget(
                        price: orderProducts.price.toString(),
                        fontSize1: 11.2.sp,
                        fontSize2: 8.2.sp,
                        textWeight1: FontWeight.w500,
                        textWeight2: FontWeight.w600,
                        colorText1: AppColors.primaryColor,
                        colorText2: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
