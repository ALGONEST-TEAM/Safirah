import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';

class RadioForTheRightSizeWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final String sizeMethodGroupValue;

  const RadioForTheRightSizeWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    required this.sizeMethodGroupValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          value == sizeMethodGroupValue
              ? SizedBox(
                  width: 14.w,
                  height: 12.h,
                  child: Transform.scale(
                    scale: 0.9,
                    child: Radio(
                      value: value,
                      groupValue: sizeMethodGroupValue,
                      activeColor: AppColors.primaryColor,
                      onChanged: (_) {},
                      splashRadius: 20,
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: const Color(0xffe4eae8),
                  radius: 7.r,
                ),
          4.w.horizontalSpace,
          AutoSizeTextWidget(
            text: title,
            fontSize: 11.4.sp,
          ),
        ],
      ),
    );
  }
}
