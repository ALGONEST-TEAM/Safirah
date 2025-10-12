import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/order_riverpod.dart';
import '../widgets/order_details_widget.dart';
import '../widgets/delivery_address_for_order_details_widget.dart';
import '../widgets/order_bill_widget.dart';
import '../widgets/order_details_product_card_widget.dart';

class OrderDetailsPage extends ConsumerWidget {
  final int orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(orderDetailsProvider(orderId));
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: S.of(context).myOrders,
      ),
      body: CheckStateInGetApiDataWidget(
        state: state,
        refresh: () {
          ref.refresh(orderDetailsProvider(orderId));
        },
        widgetOfLoading: const LogoShimmerWidget(),
        widgetOfData: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              OrderDetailsWidget(
                data: state.data,
                numberOfItems: state.data.orderProducts.length.toString(),
              ),
              if (state.data.address != null)
                DeliveryAddressForOrderDetailsWidget(
                  address: state.data.address!,
                ),
              GeneralDesignForOrderDetailsWidget(
                title: S.of(context).paymentMethod,
                child: Row(
                  children: [
                    OnlineImagesWidget(
                      imageUrl: '',
                      size: Size(60.w, 40.h),
                      logoWidth: 20.w,
                    ),
                    10.w.horizontalSpace,
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: state.data.payMethod?.title ?? '',
                        fontSize: 12.sp,
                        colorText: AppColors.fontColor,
                      ),
                    ),
                  ],
                ),
              ),
              7.h.verticalSpace,
              AutoSizeTextWidget(
                text: S.of(context).products,
                fontSize: 11.6.sp,
                fontWeight: FontWeight.w400,
                colorText: AppColors.mainColorFont,
              ),
              Column(
                children: state.data.orderProducts.map((items) {
                  return OrderDetailsProductCardWidget(
                    orderProducts: items,
                    orderId: orderId,
                    status: state.data.status.id!,
                  );
                }).toList(),
              ),
              OrderBillWidget(data: state.data),
            ],
          ),
        ),
      ),
    );
  }
}
