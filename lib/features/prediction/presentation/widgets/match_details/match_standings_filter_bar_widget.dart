import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';

class MatchStandingsFilterBarWidget extends StatelessWidget {
  final List<MatchStandingsGroupModel> filterTabs;
  final String selectedGroupKey;
  final ValueChanged<String> onGroupSelected;

  const MatchStandingsFilterBarWidget({
    super.key,
    required this.filterTabs,
    required this.selectedGroupKey,
    required this.onGroupSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Row(
        children: [
          for (final group in filterTabs) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => onGroupSelected(group.key),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedGroupKey == group.key
                        ? AppColors.secondaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeTextWidget(
                    text: group.labelAr,
                    fontSize: 12.sp,
                    fontWeight: selectedGroupKey == group.key ? FontWeight.w700 : FontWeight.w500,
                    colorText: selectedGroupKey == group.key ? Colors.white : AppColors.fontColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
