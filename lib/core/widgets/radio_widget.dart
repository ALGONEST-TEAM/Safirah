import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class RadioWidget extends StatelessWidget {
  final bool selected;
  final Color? selectedColor;
  final Color? notSelectedColor;
  final double width;
  final double height;

  final bool border;

  const RadioWidget({
    super.key,
    required this.selected,
    this.selectedColor,
    this.border = true,
    this.notSelectedColor,
    this.width = 15.5,
    this.height = 15.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: selected
            ? selectedColor ?? AppColors.primaryColor
            : notSelectedColor ?? AppColors.whiteColor,
        shape: BoxShape.circle,
        border: border
            ? Border.all(
                color: selected
                    ? AppColors.primaryColor.withOpacity(.35)
                    : const Color(0xFFE3E0F0),
                width: 2,
              )
            : Border.all(color: Colors.transparent, width: 0),
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: selected ? 7.w : 0,
        height: selected ? 7.h : 0,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
