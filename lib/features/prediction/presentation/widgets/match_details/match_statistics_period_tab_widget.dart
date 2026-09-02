import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_statistics_model.dart';

class MatchStatisticsPeriodTabWidget extends StatelessWidget {
  final StatPeriodModel period;
  final String selectedPeriodKey;
  final ValueChanged<String> onPeriodSelected;

  const MatchStatisticsPeriodTabWidget({
    super.key,
    required this.period,
    required this.selectedPeriodKey,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedPeriodKey == period.key;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onPeriodSelected(period.key);
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
          text: period.labelAr.isNotEmpty ? period.labelAr : period.labelEn,
          fontSize: 12.sp,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          colorText: isSelected ? Colors.white : AppColors.fontColor,
        ),
      ),
    );
  }
}
