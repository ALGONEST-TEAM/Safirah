import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class MatchesScopeTabsWidget extends StatelessWidget {
  const MatchesScopeTabsWidget({
    super.key,
    required this.selectedScope,
    required this.onChanged,
  });

  final String selectedScope; // 'yesterday' | 'today' | 'tomorrow'
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final items = <_DayTabItem>[
      _DayTabItem(
          scope: 'yesterday',
          date: now.subtract(const Duration(days: 1)),
          label: 'أمس'),
      _DayTabItem(scope: 'today', date: now, label: 'اليوم'),
      _DayTabItem(
          scope: 'tomorrow',
          date: now.add(const Duration(days: 1)),
          label: 'غدًا'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((e) {
        final isSelected = e.scope == selectedScope;
        final month = DateFormat('MMMM', 'ar').format(e.date);
        final dayNum = e.date.day.toString();

        return _DayTab(
          month: month,
          dayNum: dayNum,
          label: e.label,
          selected: isSelected,
          onTap: () => onChanged(e.scope),
        );
      }).toList(),
    );
  }
}

class _DayTabItem {
  final String scope;
  final DateTime date;
  final String label;

  _DayTabItem({required this.scope, required this.date, required this.label});
}

class _DayTab extends StatelessWidget {
  const _DayTab({
    required this.month,
    required this.dayNum,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String month;
  final String dayNum;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: selected ? 102.w : 92.w,
        height: selected ? 60.h : 54.h,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 1.h,
          children: [
            AutoSizeTextWidget(
              text: month,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              colorText: selected ? Colors.white : Colors.black,
            ),
            Flexible(
              child: AutoSizeTextWidget(
                text: dayNum,
                colorText: selected ? Colors.white : Colors.black,
                fontSize: 14.sp,
              ),
            ),
            AutoSizeTextWidget(
              text: label,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              colorText: selected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
