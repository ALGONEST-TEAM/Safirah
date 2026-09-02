import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_statistics_model.dart';
import 'match_statistics_period_tab_widget.dart';
import 'match_statistics_period_divider_widget.dart';

class MatchStatisticsPeriodsBarWidget extends StatelessWidget {
  final List<StatPeriodModel> periods;
  final String selectedPeriodKey;
  final ValueChanged<String> onPeriodSelected;

  const MatchStatisticsPeriodsBarWidget({
    super.key,
    required this.periods,
    required this.selectedPeriodKey,
    required this.onPeriodSelected,
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
          for (int i = 0; i < periods.length; i++) ...[
            if (i > 0) const MatchStatisticsPeriodDividerWidget(),
            Expanded(
              child: MatchStatisticsPeriodTabWidget(
                period: periods[i],
                selectedPeriodKey: selectedPeriodKey,
                onPeriodSelected: onPeriodSelected,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
