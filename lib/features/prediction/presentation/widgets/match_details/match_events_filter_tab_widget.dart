import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchEventsFilterTabWidget extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;

  const MatchEventsFilterTabWidget({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (selectedIndex != index) {
          onFilterChanged(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: title,
          fontSize: 12.sp,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          colorText: isSelected ? Colors.white : AppColors.fontColor,
        ),
      ),
    );
  }
}
