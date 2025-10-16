import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/bill_design_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/order_details_model.dart';

class OrderBillWidget extends StatelessWidget {
  final OrderDetailsModel billData;

  const OrderBillWidget({super.key, required this.billData});

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
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillDesignWidget(
            name: S.of(context).theTotal,
            price: billData.productsTotal,
          ),
          Visibility(
            visible: billData.totalPrinting != 0,
            child: BillDesignWidget(
              name: S.of(context).printingPrice,
              price: billData.totalPrinting,
            ),
          ),
          BillDesignWidget(
            name: S.of(context).deliveryCost,
            price: billData.deliveryTotal,
          ),
          BillDesignWidget(
            name: S.of(context).discountOnBill,
            price: billData.discount,
          ),
          Visibility(
            visible: billData.couponDiscount != 0,
            child: BillDesignWidget(
              name: S.of(context).couponDiscount,
              price: billData.couponDiscount,
            ),
          ),
          4.h.verticalSpace,
          Divider(
            color: AppColors.greySwatch.shade200.withOpacity(.6),
            height: 0,
          ),
          8.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).total,
            price: billData.totalPayable,
            fontSize1: 12.8.sp,
            fontSize2: 12.4.sp,
            color2: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
