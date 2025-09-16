import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_icons.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

void showModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: page,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        topRight: Radius.circular(12.r),
      ),
    ),
  );
}

void scrollShowModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  required String title,
  Color? backgroundColor,
  double? fontSize,

}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 4.h, top: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E6F3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Row(
            children: [
              12.w.horizontalSpace,
              AutoSizeTextWidget(
                text: title,
                colorText: AppColors.fontColor,
                fontSize:fontSize??14.sp ,
              ),
              const Spacer(),
              IconButtonWidget(
                icon: AppIcons.close,
                height: 15.h,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              4.w.horizontalSpace,
            ],
          ),
          Flexible(child: page),
        ],
      ),
    ),
  );
}
