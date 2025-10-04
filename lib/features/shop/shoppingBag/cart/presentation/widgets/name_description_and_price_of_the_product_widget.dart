import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/data/model/discount_model.dart';
import '../../../../productManagement/detailsProducts/presentation/page/details_page.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/price_with_discount_price_widget.dart';

class NameDescriptionAndPriceOfTheProductWidget extends StatelessWidget {
  final int idProduct;
  final List<String>? image;
  final String name;
  final String description;
  final dynamic price;
  final bool updateCart;
  final DiscountModel? discountModel;

  const NameDescriptionAndPriceOfTheProductWidget({
    super.key,
    required this.idProduct,
    this.image,
    required this.name,
    required this.description,
    required this.price,
    this.updateCart=false,
    this.discountModel,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDescription = description.replaceAll('\n', ' ');

    return Column(
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
        PriceWithDiscountPriceWidget(
          price: price,
          discountModel: discountModel,
        ),
        8.h.verticalSpace,
      ],
    );
  }
}
