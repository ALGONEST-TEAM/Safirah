import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/order_details_model.dart';


class OrderDetailsWidget extends StatelessWidget {
  // final String orderNumber;
  //
  // // final String orderStatus;
  // // final Color orderStatusColor;
  // final String date;
  final String numberOfItems;
 final OrderDetailsModel data;
  const OrderDetailsWidget({
    super.key,
    required this.data,
    required this.numberOfItems,

  });

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForOrderDetailsWidget(
      title: S.of(context).orderDetails,
      child: Column(
        children: [
          _buildInfoRow(
            icon: AppIcons.orderNumber,
            label: S.of(context).orderNumber,
            value: data.trxId,
            onCopy: () async {
              await Clipboard.setData(ClipboardData(text: data.trxId));
            },
          ),
          _buildInfoRow(
            icon: AppIcons.orderStatus,
            label: S.of(context).orderStatus,
            valueWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: data.status.color!.toColor(),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AutoSizeTextWidget(
                text: data.status.name.toString(),
                fontSize: 10.sp,
                colorText: Colors.white,
              ),
            ),
          ),
          _buildInfoRow(
            icon: AppIcons.date,
            label: S.of(context).date,
            value: data.date,
          ),
          _buildInfoRow(
            icon: AppIcons.numberOfProducts,
            label: S.of(context).numberOfProducts,
            value: numberOfItems,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String label,
    String? value,
    Widget? valueWidget,
    VoidCallback? onCopy,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          SizedBox(
            width: 128.w,
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: AppColors.fontColor,
                ),
                8.w.horizontalSpace,
                Flexible(
                  child: AutoSizeTextWidget(
                    text: label,
                    fontSize: 11.sp,
                    colorText: AppColors.fontColor.withValues(alpha: 0.7),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          8.w.horizontalSpace,
          if (onCopy != null)
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: AutoSizeTextWidget(
                      text: value ?? '',
                      fontSize: 11.6.sp,
                      colorText: AppColors.fontColor,
                      maxLines: 2,
                    ),
                  ),
                  6.w.horizontalSpace,
                  InkWellButtonWidget(
                    onPressed: onCopy,
                    icon: AppIcons.copy,
                    iconColor: AppColors.fontColor2,
                    height: 18.h,
                  ),
                ],
              ),
            )
          else if (valueWidget != null)
            Flexible(child: valueWidget)
          else
            Flexible(
              child: AutoSizeTextWidget(
                text: value ?? '',
                fontSize: 11.6.sp,
                colorText: AppColors.fontColor,
                textAlign: TextAlign.end,
                maxLines: 2,
              ),
            ),
        ],
      ),
    );
  }
}
