import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/presentation/page/details_page.dart';

class NameDescriptionAndPriceOfTheProductWidget extends StatelessWidget {
  final int idProduct;
  final List<String>? image;
  final String name;
  final String description;
  final dynamic price;
  final bool updateCart;

  const NameDescriptionAndPriceOfTheProductWidget({
    super.key,
    required this.idProduct,
    this.image,
    required this.name,
    required this.description,
    required this.price,
    this.updateCart=false,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDescription = description.replaceAll('\n', ' ');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         updateCart?AutoSizeTextWidget(
           text: "$name $formattedDescription",
           fontSize: 12.sp,
           colorText: AppColors.fontColor,
           minFontSize: 13,
           maxLines: 20,
         ): Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeTextWidget(
                  text: "$name $formattedDescription",
                  fontSize: 13.sp,
                  colorText: AppColors.fontColor,
                  minFontSize: 14,
                  maxLines: 1,
                ),
              ),
              6.w.horizontalSpace,
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  navigateTo(
                      context,
                      DetailsPage(
                        name: name,
                        price: price,
                        idProduct: idProduct,
                        image: image,
                      ));
                },
                child: Row(
                  children: [
                    AutoSizeTextWidget(
                      text: S.of(context).moreDetails,
                      fontSize: 9.5.sp,
                      colorText: AppColors.primaryColor,
                    ),
                    4.w.horizontalSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.12),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Localizations.localeOf(context).languageCode == "ar"
                            ? Icons.keyboard_arrow_left
                            : Icons.keyboard_arrow_right,
                        color: AppColors.primaryColor,
                        size: 13.5.r,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          8.h.verticalSpace,
          PriceAndCurrencyWidget(
            price:price,
            fontSize1: 15.sp,
            fontSize2: 12.sp,
            textWeight1: FontWeight.w500,
            textWeight2: FontWeight.w500,
          ),
          8.h.verticalSpace,
        ],
      ),
    );
  }
}
