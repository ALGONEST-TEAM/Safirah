import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';

class SizeLinearProgressIndicatorWidget extends StatelessWidget {
  final String sizeName;
  final double value;
  final bool showTextAtTheBeginningOnly;

  const SizeLinearProgressIndicatorWidget({
    super.key,
    required this.sizeName,
    required this.value,
    this.showTextAtTheBeginningOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    var percentageValue = value * 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: showTextAtTheBeginningOnly,
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 4.h),
            child: AutoSizeTextWidget(
              text: S.of(context).doesTheProductSizeFitWell,
              colorText: AppColors.fontColor,
              fontSize: 10.sp,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              width: 0.8.w,
              height: 24.h,
              color: AppColors.fontColor2.withValues(alpha: 0.4),
              margin: EdgeInsets.symmetric(horizontal: 14.w),
            ),
            SizedBox(
              width: 36.w,
              child: AutoSizeTextWidget(
                text: sizeName.toString(),
                fontSize: 9.6.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            2.w.horizontalSpace,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.sp),
                child: LinearProgressIndicator(
                  value: value,
                  valueColor: const AlwaysStoppedAnimation( Color(0xFFCA9A2C)),
                  minHeight: 4.5,
                  backgroundColor: AppColors.scaffoldColor,
                ),
              ),
            ),
            4.w.horizontalSpace,
            SizedBox(
              width: 28.w,
              child: AutoSizeTextWidget(
                text: "${percentageValue.toInt()}%",
                fontSize: 9.sp,
                minFontSize: 4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
