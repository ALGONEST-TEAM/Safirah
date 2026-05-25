import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/radio_widget.dart';

class PayMethodCardWidget extends StatelessWidget {
  final String name;
  final String value;
  final String paymentMethodGroupValue;
  final String image;
  final VoidCallback onPressed;

  const PayMethodCardWidget({
    super.key,
    required this.name,
    required this.value,
    required this.paymentMethodGroupValue,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          OnlineImagesWidget(
            size: Size(48.w, 32.h),
            imageUrl: image,
            fit: BoxFit.contain,
            logoWidth: 20.w,
          ),
          12.w.horizontalSpace,
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: AutoSizeTextWidget(
                text: name.toString(),
                fontSize: 11.4.sp,
                colorText: Colors.grey[700],
                maxLines: 2,
              ),
            ),
          ),
          8.w.horizontalSpace,
          RadioWidget(
            selected: value == paymentMethodGroupValue,
            border: false,
          ),
        ],
      ),
    );
  }
}

