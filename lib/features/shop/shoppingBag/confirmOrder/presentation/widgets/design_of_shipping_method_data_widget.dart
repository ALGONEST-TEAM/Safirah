import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';

class DesignOfShippingMethodDataWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;
  final String shippingMethodGroupValue;

  const DesignOfShippingMethodDataWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    required this.shippingMethodGroupValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          OnlineImagesWidget(
            size: Size(48.w, 36.h),
            imageUrl: "",
            fit: BoxFit.contain,
            logoWidth: 24.w,
          ),
           12.w.horizontalSpace,
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: AutoSizeTextWidget(
                text: title.toString(),
                fontSize: 11.4.sp,
                colorText: Colors.grey[700],
                maxLines: 2,
              ),
            ),
          ),
          8.w.horizontalSpace,
          RadioWidget(
            selected: value == shippingMethodGroupValue,
            border: false,
            notSelectedColor: AppColors.scaffoldColor,
            selectedColor: AppColors.secondaryColor,
            height: 15.4,
            width: 15.4,
          ),
        ],
      ),
    );
  }
}
