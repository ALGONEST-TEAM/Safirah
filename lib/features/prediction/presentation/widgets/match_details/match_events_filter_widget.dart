import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import 'match_events_filter_tab_widget.dart';
import 'match_events_filter_divider_widget.dart';

class MatchEventsFilterWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;
  final bool isFinish;
  final Color activeColor;

  const MatchEventsFilterWidget({
    super.key,
    required this.isFinish,
    required this.selectedIndex,
    required this.onFilterChanged,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: MatchEventsFilterTabWidget(
              title: 'الأبرز',
              index: isFinish ? 0 : 1,
              selectedIndex: selectedIndex,
              onFilterChanged: onFilterChanged,
             // activeColor: activeColor,
            ),
          ),
          const MatchEventsFilterDividerWidget(),
          Expanded(
            child: MatchEventsFilterTabWidget(
              title: 'عرض الكل',
              index: isFinish ? 1 : 0,
              selectedIndex: selectedIndex,
              onFilterChanged: onFilterChanged,
            //  activeColor: activeColor,
            ),
          ),
        ],
      ),
    );
  }
}
