import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class ChipSelectorWidget extends StatelessWidget {
  const ChipSelectorWidget({super.key,required this.selectedIndex,required this.items,required this.onSelected});
  final List<String> items;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      height: 56.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = selectedIndex == i;
          return ChoiceChip(
            label: Text(items[i]),
            selected: isSelected,
            onSelected: (_) => onSelected(i),
            selectedColor: AppColors.secondaryColor,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
            showCheckmark: true,
            checkmarkColor: Colors.white,
            backgroundColor: AppColors.scaffoldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          );
        },
      ),
    );
  }
}
