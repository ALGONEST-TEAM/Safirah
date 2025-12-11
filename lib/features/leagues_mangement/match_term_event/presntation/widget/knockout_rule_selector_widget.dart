import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

class KnockoutRuleSelectorWidget extends StatelessWidget {
  const KnockoutRuleSelectorWidget({
    super.key,
    required this.includeExtraAndPenalties,
    required this.onChanged,
  });

  final bool includeExtraAndPenalties;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: 'في دور خروج المغلوب',
          fontSize: 12.sp,
          colorText: AppColors.secondaryColor,
        ),
        8.h.verticalSpace,
        Row(
          children: [
            _RadioOptionWidget(
              title: 'بلنتيات مباشرة',
              value: false,
              groupValue: includeExtraAndPenalties,
              onChanged: onChanged,
            ),
            12.w.horizontalSpace,
            _RadioOptionWidget(
              title: 'مع أشواط إضافية',
              value: true,
              groupValue: includeExtraAndPenalties,
              onChanged: onChanged,
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
  });

  final String title;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color:
                selected ? AppColors.secondaryColor.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color:
                  selected ? AppColors.secondaryColor : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Radio<bool>(
                value: value,
                groupValue: groupValue,
                onChanged: (_) => onChanged(value),
                activeColor: AppColors.secondaryColor,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: selected
                        ? AppColors.secondaryColor
                        : Colors.black87,
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

