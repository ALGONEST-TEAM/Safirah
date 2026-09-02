import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'match_events_key_stats_value_widget.dart';

class MatchEventsKeyStatsRowWidget extends StatelessWidget {
  final String title;
  final String homeValueText;
  final String awayValueText;
  final double homeVal;
  final double awayVal;
  final bool lowerIsBetter;
  final Color homeColor;
  final Color awayColor;

  const MatchEventsKeyStatsRowWidget({
    super.key,
    required this.title,
    required this.homeValueText,
    required this.awayValueText,
    required this.homeVal,
    required this.awayVal,
    this.lowerIsBetter = false,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    bool homeWins = homeVal > awayVal;
    bool awayWins = awayVal > homeVal;

    if (lowerIsBetter) {
      homeWins = homeVal < awayVal;
      awayWins = awayVal < homeVal;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home Value (Right in RTL)
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: MatchEventsKeyStatsValueWidget(
                text: homeValueText,
                isHighlighted: homeWins,
                isHome: true,
                homeColor: homeColor,
                awayColor: awayColor,
              ),
            ),
          ),

          // Stat Title (Center)
          Expanded(
            flex: 2,
            child: AutoSizeTextWidget(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.mainColorFont,
              textAlign: TextAlign.center,
            ),
          ),

          // Away Value (Left in RTL)
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: MatchEventsKeyStatsValueWidget(
                text: awayValueText,
                isHighlighted: awayWins,
                isHome: false,
                homeColor: homeColor,
                awayColor: awayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
