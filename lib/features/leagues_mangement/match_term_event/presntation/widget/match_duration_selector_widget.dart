
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

class MatchDurationSelectorWidget extends StatelessWidget {
  const MatchDurationSelectorWidget({
    super.key,
    required this.matchDuration,
    required this.onChanged,
  });

  final int matchDuration;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: 'مدة الشوط (بالدقائق)',
          fontSize: 12.sp,
          colorText: AppColors.secondaryColor,
        ),
        12.h.verticalSpace,
        Container(
          width: double.infinity,
          padding:
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: '$matchDuration دقيقة',
              ),
              const Icon(Icons.timer_outlined, color: Colors.black),
            ],
          ),
        ),
        Slider(
          value: matchDuration.toDouble(),
          min: 1,
          max: 120,
          divisions: 23,
          activeColor: AppColors.secondaryColor,
          label: "$matchDuration دقيقة",
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}