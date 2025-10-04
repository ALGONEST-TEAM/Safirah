import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_svg_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';
import '../../data/model/delivery_types_model.dart';

class DesignOfShippingMethodDataWidget extends StatelessWidget {
  final DeliveryTypesModel deliveryData;
  final VoidCallback onPressed;
  final String shippingMethodGroupValue;

  const DesignOfShippingMethodDataWidget({
    super.key,
    required this.deliveryData,
    required this.onPressed,
    required this.shippingMethodGroupValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          4.w.horizontalSpace,
          OnlineSvgWidget(
            imageUrl: deliveryData.image,
            size: Size(23.w, 23.h),
            fit: BoxFit.fill,
          ),
          12.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: deliveryData.name.toString(),
                  fontSize: 11.2.sp,
                  colorText: Colors.grey[700],
                  maxLines: 2,
                ),
                6.h.verticalSpace,
                Row(
                  spacing: 6.w,
                  children: [
                    PriceAndCurrencyWidget(
                      price: deliveryData.cost.toString(),
                      fontSize1: 11.6.sp,
                      fontSize2: 8.4.sp,
                    ),
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: "(${deliveryData.timeOfDelivery.toString()})",
                        fontSize: 8.sp,
                        colorText: AppColors.fontColor2,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          8.w.horizontalSpace,
          RadioWidget(
            selected: deliveryData.id.toString() == shippingMethodGroupValue,
            border: false,
            notSelectedColor: AppColors.scaffoldColor,
            selectedColor: AppColors.secondaryColor,
            height: 15.4,
            width: 15.4,
          ),
        ],
      ),
    );
  }
}
