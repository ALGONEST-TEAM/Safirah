import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../../../../../generated/l10n.dart';

class DeliveryAddressForOrderDetailsWidget extends StatelessWidget {
  final String address;
  const DeliveryAddressForOrderDetailsWidget({super.key, required this.address});

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
            child: AutoSizeTextWidget(
              text: address,
              fontSize: 11.6.sp,
              maxLines: 2,
              colorText: AppColors.fontColor,
            ),
          ),
        ],
      ),
    );
  }
}
