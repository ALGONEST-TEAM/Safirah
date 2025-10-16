import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../productManagement/reviews/presentation/pages/reviews_page.dart';
import '../../data/model/product_order_details_model.dart';

class OrderProductNameAndReviewsRowWidget extends StatelessWidget {
  final ProductOrderDetailsModel orderProducts;
  final int orderId;
  final int status;

  const OrderProductNameAndReviewsRowWidget({
    super.key,
    required this.orderProducts,
    required this.orderId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
