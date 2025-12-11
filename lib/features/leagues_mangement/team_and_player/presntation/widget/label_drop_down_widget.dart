// common_dropdown_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class LabeledDropdownField<T> extends StatelessWidget {
  const LabeledDropdownField({
    super.key,
    required this.title,
    required this.items,
    required this.idOf,
    required this.labelOf,
    this.selectedId,
    this.onChanged,
    this.validator,
    this.hintText,
    this.enabled = true,
  });

  final String title;
  final List<T> items;
  final int? Function(T item) idOf;
  final String Function(T item) labelOf;

  final int? selectedId;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final validSelected =
        (selectedId != null) && items.any((e) => idOf(e) == selectedId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(text: title),
        4.h.verticalSpace,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color:Colors.white,
          ),
          padding: EdgeInsets.all(10.w),
          child: DropdownButtonFormField<int>(
            dropdownColor: Colors.white,
            value: validSelected ? selectedId : null,
            items: items
                .map((e) => DropdownMenuItem<int>(
              value: idOf(e),
              child: Text(labelOf(e)),
            ))
                .toList(),
            onChanged: !enabled
                ? null
                : (id) {
              final picked = id == null
                  ? null
                  : items.firstWhere(
                    (e) => idOf(e) == id,
                orElse: () => items.first,
              );
              onChanged?.call(picked);
            },
            validator: validator == null
                ? null
                : (id) {
              final picked = id == null
                  ? null
                  : items.firstWhere(
                    (e) => idOf(e) == id,
                orElse: () => items.first,
              );
              return validator!(picked);
            },
            hint: AutoSizeTextWidget(
              text: hintText ?? '',
              colorText: AppColors.fontColor2,
              fontSize: 13.sp,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
