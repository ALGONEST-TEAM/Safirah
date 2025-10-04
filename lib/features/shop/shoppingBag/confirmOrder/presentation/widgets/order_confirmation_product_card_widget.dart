import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import 'package:safirah/core/widgets/text_form_field.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../myOrders/presentation/widgets/order_details_card_data_design_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/details_of_copon_widget.dart';
import '../../../cart/data/model/cart_model.dart';
import 'order_details_card_data_design_widget.dart';

class OrderConfirmationProductCardWidget extends StatelessWidget {
  final CartModel data;
  final bool isCheckCopon;
  final bool productInCopon;
  final TextEditingController? printableController;
  final FormFieldValidator? printableValidator;
  const OrderConfirmationProductCardWidget({
    super.key,
    required this.data,
    required this.isCheckCopon,
    required this.productInCopon,
    this.printableController,
    this.printableValidator,
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
            color: Colors.black.withOpacity(.02),
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
                size: Size(86.w, 90.h),
                fit: BoxFit.cover,
                borderRadius: 8.r,
              ),
              10.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
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

                    ///
                    Visibility(
                      visible: !isCheckCopon && !productInCopon,
                      // replacement: PriceAndCurrencyWidget(
                      //   price: (num.tryParse(data.originalPrice.toString()) ??
                      //           1 * data.quantity!)
                      //       .toString(),
                      //   fontSize1: 12.2.sp,
                      //   fontSize2: 9.sp,
                      // ),
                      child: PriceAndCurrencyWidget(
                        price: (num.tryParse(data.price.toString()) ??
                                1 * data.quantity!)
                            .toString(),
                        fontSize1: 12.2.sp,
                        fontSize2: 9.sp,
                      ),
                    ),
                    ////
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
                hintText: 'وصف الطباعة لهذا المنتج',
                hintFontSize: 10.sp,
                fillColor: AppColors.scaffoldColor,
                maxLine: 2,
                fieldValidator: (value){
                  if (value == null || value.toString().isEmpty) {
                    return S.of(context).pleaseEnterPhoneNumber;
                  }
                  final phone = value.trim();

                  if (phone.length < 20) {
                    return S.of(context).phoneMustBe9Digits;
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

// Visibility(
//   visible: isCheckCopon && productInCopon,
//   child: Column(
//     children: [
//       8.h.verticalSpace,
//       Container(
//         padding: EdgeInsets.all(3.sp),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.primaryColor),
//         ),
//         child: AutoSizeTextWidget(
//           text: 'كوبون خاص',
//           fontSize: 8.sp,
//           minFontSize: 3,
//           colorText: AppColors.primaryColor,
//         ),
//       ),
//     ],
//   ),
// ),

// Visibility(
//   visible: isCheckCopon && productInCopon,
//   child: GestureDetector(
//     onTap: () {
//       // ShowDetailsOfCoponWidget(inOrder: true,coponData: ,);
//     },
//     child: Column(
//       children: [
//         8.verticalSpace,
//         Row(
//           children: [
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(20)),
//                   ),
//                   builder: (context) => DetailsOfCoponWidget(
//                       discount: 0,
//                       inOrder: true,
//                       discountCopon: data.totalDiscount!,
//                       basePrice: num.parse(
//                               data.originalPrice!) *
//                           num.parse(data.quantity.toString())),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.all(3.sp),
//                 decoration: BoxDecoration(
//                   color:
//                       AppColors.primaryColor.withOpacity(0.1),
//                   // border: Border.all(color: AppColors.primaryColor),
//                 ),
//                 child: Row(
//                   children: [
//                     PriceAndCurrencyWidget(
//                       price: data.finalPrice.toString(),
//                       fontSize1: 8.5.sp,
//                       fontSize2: 8.5.sp,
//                       textWeight1: FontWeight.normal,
//                       textWeight2: FontWeight.normal,
//                     ),
//                     AutoSizeTextWidget(
//                       text: ' | ',
//                       fontSize: 8.sp,
//                       minFontSize: 3,
//                       colorText: AppColors.primaryColor,
//                     ),
//                     AutoSizeTextWidget(
//                       text: 'بعد الكوبون ',
//                       fontSize: 8.sp,
//                       minFontSize: 3,
//                       colorText: AppColors.primaryColor,
//                     ),
//                     1.horizontalSpace,
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       color: AppColors.primaryColor,
//                       size: 10.sp,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
