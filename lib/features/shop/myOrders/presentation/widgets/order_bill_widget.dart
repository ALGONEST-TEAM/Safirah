import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/bill_design_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/order_details_model.dart';

class OrderBillWidget extends StatelessWidget {
  final OrderDetailsModel data;

  const OrderBillWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillDesignWidget(
            name: S.of(context).theTotal,
            price: data.productsTotal.toDouble(),
          ),
          4.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).deliveryCost,
            price: data.deliveryTotal.toDouble(),
          ),
          4.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).discountOnBill,
            price: data.discount.toDouble(),
          ),
          Divider(
            color: AppColors.greySwatch.shade100,
            height: 12.h,
          ),
          4.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).total,
            price: data.total.toDouble(),
            fontSize1: 12.8.sp,
            fontSize2: 12.8.sp,
            color2: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
