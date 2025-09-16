import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/bill_design_widget.dart';
import '../../../../../../generated/l10n.dart';

class BillWidget extends StatelessWidget {
  final double total;
  final bool hasCopon;
  final double totalAfterDiscount;
  final double coponValue;
  final double deliveryCost;

  const BillWidget(
      {super.key,
      required this.total,
      required this.hasCopon,
      required this.coponValue,
      required this.deliveryCost,
      required this.totalAfterDiscount});

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
            price: total,
          ),
          4.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).deliveryCost,
            price: deliveryCost,
          ),
          4.h.verticalSpace,
          BillDesignWidget(
            name: S.of(context).discountOnBill,
            price: 0.0,
          ),
          4.h.verticalSpace,
          Visibility(
            visible: hasCopon,
            child: BillDesignWidget(
              name: 'خصم الكوبون',
              price: coponValue,
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
            price: totalAfterDiscount,
            fontSize1: 12.8.sp,
            fontSize2: 12.4.sp,
            color2: AppColors.primaryColor
          ),
        ],
      ),
    );
  }
}
