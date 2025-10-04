import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';

class CancelPrintingWidget extends StatelessWidget {
  final VoidCallback onConfirm;

  const CancelPrintingWidget({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Dialog(
              alignment: Alignment.center,
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeTextWidget(
                      text:
                          "هل أنت متأكد من انك تريد إلغاء الطباعة على هذا المنتج!",
                      maxLines: 2,
                      colorText: AppColors.fontColor,
                      fontSize: 13.sp,
                      textAlign: TextAlign.center,
                    ),
                    14.h.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButtonWidget(
                            text: S.of(context).yes,
                            height: 32.h,
                            borderRadius: 12.r,
                            textSize: 12.sp,
                            background: AppColors.whiteColor,
                            textColor: AppColors.secondaryColor,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onConfirm();
                            },
                          ),
                        ),
                        16.w.horizontalSpace,
                        Expanded(
                          child: DefaultButtonWidget(
                            text: S.of(context).no,
                            height: 32.h,
                            borderRadius: 12.r,
                            textSize: 12.sp,
                            onPressed: () {
                              Navigator.of(context).pop();

                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.6.h),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r))),
        child: AutoSizeTextWidget(
          text: S.of(context).cancelPrinting,
          colorText: Colors.white,
          fontSize: 8.sp,
          minFontSize: 8,
        ),
      ),
    );
  }
}
