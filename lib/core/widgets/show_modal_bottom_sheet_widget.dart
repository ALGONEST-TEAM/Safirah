import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/leagues_mangement/leagues/persntaion/widget/radio_dot_widget.dart';
import '../constants/app_icons.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

class DismissibleBottomSheetFrame extends StatelessWidget {
  const DismissibleBottomSheetFrame({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              key: const ValueKey('bottom-sheet-dismiss-area'),
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: const SizedBox.expand(),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// يحرك الـ BottomSheet بسلاسة فوق الكيبورد بدون تعديل صفحات الإدخال نفسها.
class KeyboardAwareBottomSheet extends StatelessWidget {
  const KeyboardAwareBottomSheet({
    super.key,
    required this.child,
    this.topSafeArea = false,
  });

  final Widget child;
  final bool topSafeArea;

  @override
  Widget build(BuildContext context) {
    // استخدام viewInsetsOf(context) المخصص لعدم إعادة بناء الشجرة عند تغير خصائص MediaQuery الأخرى
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: topSafeArea,
        child: child,
      ),
    );
  }
}

Future<T?> showModalBottomSheetWidget<T>({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
  bool dismissOnOuterTap = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor:
        dismissOnOuterTap ? Colors.transparent : backgroundColor ?? Colors.white,
    shape: dismissOnOuterTap
        ? null
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
    builder: (sheetContext) {
      final bottomSheetChild = KeyboardAwareBottomSheet(
        child: page,
      );

      if (dismissOnOuterTap) {
        return DismissibleBottomSheetFrame(
          child: bottomSheetChild,
        );
      }

      return bottomSheetChild;
    },
  );
}

Future<T?> scrollShowModalBottomSheetWidget<T>({
  required BuildContext context,
  required Widget page,
  required String title,
  Color? backgroundColor,
  double? fontSize,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: backgroundColor ?? Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (sheetContext) {
      return KeyboardAwareBottomSheet(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.92,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(
                  bottom: 4.h,
                  top: 8.h,
                ),
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
                    fontSize: fontSize ?? 14.sp,
                  ),
                  const Spacer(),
                  IconButtonWidget(
                    icon: AppIcons.close,
                    height: 15.h,
                    onPressed: () {
                      Navigator.pop(sheetContext);
                    },
                  ),
                  4.w.horizontalSpace,
                ],
              ),
              Flexible(
                child: page,
              ),
            ],
          ),
        ),
      );
    },
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

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return KeyboardAwareBottomSheet(
        topSafeArea: false,
        child: Container(
          padding: EdgeInsets.all(12.w),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.85,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              topLeft: Radius.circular(16.r),
            ),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: title,
                    fontSize: 12.sp,
                    colorText: Colors.grey[600],
                  ),
                  SizedBox(height: 10.h),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((opt) {
                          final selected = temp == opt;

                          return GestureDetector(
                            onTap: () => setState(() => temp = opt),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFFEFF3FF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeTextWidget(
                                    text: labelOf(opt),
                                  ),
                                  RadioDotWidget(
                                    selected: selected,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
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
                        final selectedValue = temp;
                        if (selectedValue != null) {
                          onConfirm(selectedValue);
                        }

                        Navigator.of(sheetContext).pop();
                      },
                      child: AutoSizeTextWidget(
                        text: 'تم',
                        fontSize: 15.sp,
                        colorText: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

Future<T?> showTitledBottomSheet<T>({
  required BuildContext context,
  required Widget page,
  required String title,
  Color? backgroundColor,
  double? fontSize,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: backgroundColor ?? Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (sheetContext) {
      return KeyboardAwareBottomSheet(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.92,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42.w,
                height: 4.4.h,
                margin: EdgeInsets.only(
                  bottom: 4.h,
                  top: 8.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.fontColor2.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Row(
                children: [
                  12.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: title,
                    colorText: AppColors.mainColorFont,
                    fontSize: fontSize ?? 14.sp,
                  ),
                  const Spacer(),
                  IconButtonWidget(
                    icon: AppIcons.close,
                    height: 15.h,
                    onPressed: () {
                      Navigator.pop(sheetContext);
                    },
                  ),
                  4.w.horizontalSpace,
                ],
              ),
              Flexible(
                child: page,
              ),
            ],
          ),
        ),
      );
    },
  );
}