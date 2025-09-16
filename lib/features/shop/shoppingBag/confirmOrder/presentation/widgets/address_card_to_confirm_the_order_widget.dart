import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';

class AddressCardToConfirmTheOrderWidget extends ConsumerWidget {
  final String address;
  final String city;
  final String district;

  final String value;
  final VoidCallback onPressed;

  final String addressGroupValue;

  const AddressCardToConfirmTheOrderWidget({
    super.key,
    required this.address,
    required this.city,
    required this.district,
    required this.value,
    required this.onPressed,
    required this.addressGroupValue,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.cardAddress,
                ),
                8.w.horizontalSpace,
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: address.toString(),
                          fontSize: 13.sp,
                          colorText: AppColors.mainColorFont,
                        ),
                        4.h.verticalSpace,
                        AutoSizeTextWidget(
                          text: "$city - $district",
                          fontSize: 9.6.sp,
                          colorText: AppColors.fontColor2,
                        ),
                      ],
                    ),
                  ),
                ),
                RadioWidget(selected: value == addressGroupValue),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
