import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/bill_design_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/orders_bill_data.dart';

class BillWidget extends StatelessWidget {
  final OrdersBillData billData;
  final num? deliveryCost;

  const BillWidget({
    super.key,
    required this.billData,
    required this.deliveryCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillDesignWidget(
            name: S.of(context).theTotal,
            price: billData.totalBeforeDiscount,
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
            price: deliveryCost ?? 0,
          ),
          BillDesignWidget(
            name: S.of(context).discountOnBill,
            price: billData.productDiscount,
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
            color: AppColors.greySwatch.shade200.withValues(alpha: .6),
            height: 0,
          ),
          8.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).total,
            price: billData.totalPayable + deliveryCost!,
            fontSize1: 12.8.sp,
            fontSize2: 12.4.sp,
            color2: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
