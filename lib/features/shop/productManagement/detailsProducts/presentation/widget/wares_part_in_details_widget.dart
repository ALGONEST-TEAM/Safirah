import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/product_data.dart';
import '../state_mangment/riverpod_details.dart';
import 'best_copon_widget.dart';
import 'description_in_model_sheet_widget.dart';
import 'image_slider_widget.dart';
import 'list_of_colors_product_widget.dart';
import 'list_of_number_product_widget.dart';
import 'list_of_size_product_widget.dart';
import 'more_details_widget.dart';
import 'number_of_image_widget.dart';
import 'price_with_discount_price_widget.dart';
import 'printing_on_the_product_widget.dart';

class WaresPartInDetailsWidget extends ConsumerWidget {
  const WaresPartInDetailsWidget({super.key, required this.productData});

  final ProductData productData;

  @override
  Widget build(BuildContext context, ref) {
    var indexColorImage = ref.watch(changeIndexOfColorImageAndSizeProvider);
    var indexImage = ref.watch(showNumberOfScrollImageProvider);
    dynamic price = ref.watch(changePriceProvider(productData));

    String formattedDescription =
        productData.description!.replaceAll('\n', ' ');
    return Column(
      children: [
        ImageSliderWidget(
          productData: productData,
          indexColorImage: indexColorImage,
        ),
        if (productData.colorsProduct!.isNotEmpty ||
            productData.allImage!.isNotEmpty)
          productData.colorHasImage == false
              ? NumberOfImageWidget(
                  numImageAndIndex:
                      "${productData.allImage!.length} / ${indexImage ?? 1}",
                )
              : productData.colorsProduct!.isNotEmpty
                  ? NumberOfImageWidget(
                      numImageAndIndex:
                          "${productData.colorsProduct![indexColorImage ?? 0].image!.length} / ${indexImage ?? 1}",
                    )
                  : const SizedBox(),
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(12.sp),
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: productData.name!,
                colorText: AppColors.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                maxLines: 2,
              ),
              6.verticalSpace,
              Visibility(
                visible: productData.description != '',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: formattedDescription,
                      colorText: AppColors.fontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      maxLines: 15,
                    ),
                    6.h.verticalSpace,
                  ],
                ),
              ),
              Row(
                children: [
                  PriceWithDiscountPriceWidget(
                    price: price,
                    discountModel: productData.discountModel,
                  ),
                  Visibility(
                    visible: productData.coponData!.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0.sp),
                      child: BestCoponWidget(
                          copon: productData.coponData ?? [],
                          basePrice: price,
                          discount: productData.discountModel == null
                              ? 0
                              : productData.discountModel!.discountType !=
                                      'percent'
                                  ? productData.discountModel!.discount
                                  : price! *
                                      (productData.discountModel!.discount! /
                                          100)),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Visibility(
                visible: productData.colorsProduct?.isNotEmpty == true,
                child: ListOfColorsProductWidget(
                  colorsProduct: productData,
                ),
              ),
              Visibility(
                visible: productData.sizeProduct!.isNotEmpty,
                child: ListOfSizeProductWidget(
                  sizeProduct: productData,
                ),
              ),
              Visibility(
                visible: productData.numbersOfProduct!.isNotEmpty,
                child: ListOfNumberProductWidget(
                  product: productData,
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: productData.isPrintable == true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w)
                    .copyWith(bottom: 8.h),
                child: PrintingOnTheProductWidget(
                  stateKey: 'details:${productData.id}',
                  printingPrice: productData.productPrintingPrice.toString(),
                ),
              ),
            ),
            MoreDetailsWidget(
              page: DescriptionInModelSheetWidget(
                detailsProduct: productData.detailsProduct ?? [],
              ),
              describe: S.of(context).size_details,
              icon: AppIcons.sizeDetails,
            ),
            MoreDetailsWidget(
              page: DescriptionInModelSheetWidget(
                detailsProduct: productData.detailsProduct ?? [],
              ),
              describe: S.of(context).shipping_details,
              icon: AppIcons.shippingDetails,
            ),
            MoreDetailsWidget(
              page: DescriptionInModelSheetWidget(
                detailsProduct: productData.detailsProduct ?? [],
              ),
              describe: S.of(context).return_policy,
              icon: AppIcons.returnPolicy,
            ),
          ],
        ),
      ],
    );
  }
}
