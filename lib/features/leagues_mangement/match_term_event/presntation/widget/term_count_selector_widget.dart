
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

class TermCountSelectorWidget extends StatelessWidget {
  const TermCountSelectorWidget({
    super.key,
    required this.selectedTermsCount,
    required this.onChanged,
    this.enabled = true,
  });

  final int? selectedTermsCount;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: 'عدد الأشواط',
          fontSize: 12.sp,
          colorText: AppColors.secondaryColor,
        ),
        8.h.verticalSpace,
        Row(
          children: [
            _RadioOptionWidget(
              title: 'شوط واحد',
              value: 1,
              groupValue: selectedTermsCount,
              onChanged: onChanged,
              enabled: enabled,
            ),
            12.w.horizontalSpace,
            _RadioOptionWidget(
              title: 'شوطين',
              value: 2,
              groupValue: selectedTermsCount,
              onChanged: onChanged,
              enabled: enabled,
            ),
          ],
        ),
      ],
    );
  }
}

class _RadioOptionWidget extends StatelessWidget {
  const _RadioOptionWidget({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.enabled,
  });

  final String title;
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return Expanded(
      child: InkWell(
        onTap: enabled ? () => onChanged(value) : null,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.secondaryColor.withValues(
                    alpha: enabled ? 0.1 : 0.06,
                  )
                : Colors.white,
            border: Border.all(
              color: selected
                  ? AppColors.secondaryColor
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected
                      ? AppColors.secondaryColor
                      : Colors.grey.shade400,
                  size: 22.sp,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: selected
                        ? AppColors.secondaryColor
                        : enabled
                            ? Colors.black87
                            : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}