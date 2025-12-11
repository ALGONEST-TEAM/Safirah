import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/leagues_mangement/leagues/persntaion/widget/radio_dot_widget.dart';
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
    builder: (context) => SafeArea(
      top: false,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: page,
      ),
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
    builder: (context) => SafeArea(
      top: false,
      child: Padding(
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
    ),
  );
}

Future<void> showSelectorSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> options,
  required T? initialValue,
  required String Function(T) labelOf,
  required void Function(T) onConfirm,
}) async {
  T? temp = initialValue;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: title,
                  fontSize: 12.sp,
                  colorText: Colors.grey[600],
                ),
                SizedBox(height: 10.h),
                ...options.map((opt) {
                  final selected = temp == opt;
                  return GestureDetector(
                    onTap: () => setState(() => temp = opt),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFFEFF3FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeTextWidget(
                            text: labelOf(opt),
                          ),
                          RadioDotWidget(selected: selected),
                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 6.h),

                // زر "تم"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1846),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: () {
                      if (temp != null) onConfirm(temp as T);
                      Navigator.of(context).pop();
                    },
                    child: AutoSizeTextWidget(
                      text: "تم",
                      fontSize: 15.sp,
                      colorText: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
