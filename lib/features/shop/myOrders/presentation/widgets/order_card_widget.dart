import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';
import '../../data/model/order_data_model.dart';
import '../pages/order_details_page.dart';
import 'order_images_preview_widget.dart';

class OrderCardWidget extends ConsumerWidget {
  final OrderDataModel data;

  const OrderCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context, ref) {
    // var currencyState = ref.watch(currencyProvider);
    return GestureDetector(
      onTap: () {
        print(data.id);
        navigateTo(context, OrderDetailsPage(orderId: data.id));
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 10.h),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withValues(alpha: 0.03),
                    blurRadius: 1.r,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.h.verticalSpace,
                        AutoSizeTextWidget(
                          text: formatDate(data.date.toString()),
                          fontSize: 10.4.sp,
                          maxLines: 2,
                          colorText: AppColors.fontColor2,
                          fontWeight: FontWeight.w400,
                        ),
                        6.h.verticalSpace,
                        PriceAndCurrencyWidget(
                          price: data.total.toString(),
                          fontSize1: 11.6.sp,
                          fontSize2: 9.sp,
                          maxLines: 2,
                          colorText1: AppColors.secondaryColor,
                          colorText2: AppColors.secondaryColor,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        7.h.verticalSpace,
                        AutoSizeTextWidget(
                          text:data.trxId.toString(),
                          fontSize: 11.6.sp,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                   4.w.horizontalSpace,
                  Expanded(
                    child: SizedBox(
                      height: 84.h,
                      child: OrderImagesPreviewWidget(
                        images: data.orderProducts!
                            .map((item) => item.image.toString())
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.4.h),
              decoration: BoxDecoration(
                color: Color(int.parse("0xff${data.status!.color!}")),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: AutoSizeTextWidget(
                text: data.status!.name.toString(),
                fontSize: 9.6.sp,
                colorText: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
