import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../../../../../generated/l10n.dart';

class DeliveryAddressForOrderDetailsWidget extends StatelessWidget {
  const DeliveryAddressForOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForOrderDetailsWidget(
      title: S.of(context).deliveryAddress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppIcons.deliveryAddress,
            height: 44.h,
          ),
          12.w.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: "المطار",
                  fontSize: 12.2.sp,
                  colorText: AppColors.fontColor,
                ),
                4.h.verticalSpace,
                AutoSizeTextWidget(
                  text: "صنعاء الدائري",
                  fontSize: 10.6.sp,
                  colorText: AppColors.fontColor2,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
