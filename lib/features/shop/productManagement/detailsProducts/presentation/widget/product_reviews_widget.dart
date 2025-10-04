import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../myOrders/data/model/product_order_details_model.dart';
import '../../../reviews/presentation/pages/reviews_page.dart';
import '../../../reviews/presentation/widgets/card_for_comments_widget.dart';
import '../../../reviews/presentation/widgets/reviews_widget.dart';
import '../../data/model/product_data.dart';

class ProductReviewsWidget extends StatelessWidget {
  final ProductData data;

  const ProductReviewsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          ReviewsWidget(
            rates: data.reviews!.rates ?? 0,
            total: data.reviews!.total.toDouble(),
            counter: data.reviews!.counter,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: S.of(context).comments,
                        fontSize: 13.sp,
                        colorText: AppColors.mainColorFont,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          ReviewsPage(
                            products: ProductOrderDetailsModel.empty(),
                            orderId: 0,
                            status: 0,
                            productId: data.id,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AutoSizeTextWidget(
                            text: S.of(context).viewAll,
                            fontSize: 9.4.sp,
                            colorText: AppColors.fontColor,
                          ),
                          Icon(
                            Localizations.localeOf(context).languageCode == "ar"
                                ? Icons.keyboard_arrow_left
                                : Icons.keyboard_arrow_right,
                            color: AppColors.fontColor,
                            size: 15.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                4.h.verticalSpace,
                Column(
                  children: data.productReviews!.map((items) {
                    return CardForCommentsWidget(
                      reviews: items,
                      detailsPage: true,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
