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
            padding: EdgeInsets.only(left: 38.w, right: 38.w, bottom: 4.h),
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
              color: const Color(0xffe0e0e0),
              margin: EdgeInsets.only(right: 20.w, left: 16.w),
            ),
            SizedBox(
              width: 34.w,
              child: AutoSizeTextWidget(
                text: sizeName.toString(),
                fontSize: 9.6.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            6.w.horizontalSpace,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.sp),
                child: LinearProgressIndicator(
                  value: value,
                  valueColor: const AlwaysStoppedAnimation(Color(0xff8A1538)),
                  minHeight: 5,
                  backgroundColor: const Color(0xffe0e0e0),
                ),
              ),
            ),
            4.w.horizontalSpace,
            SizedBox(
              width: 34.w,
              child: AutoSizeTextWidget(
                text: " ${(percentageValue * 10).truncate() / 10}%",
                fontSize: 8.5.sp,
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
