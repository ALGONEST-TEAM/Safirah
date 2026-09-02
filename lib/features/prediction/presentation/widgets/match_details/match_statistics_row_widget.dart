import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/team_color_helper.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_statistics_model.dart';
import 'match_statistics_stat_value_widget.dart';

class MatchStatisticsRowWidget extends StatelessWidget {
  final StatItemModel stat;
  final Color homeColor;
  final Color awayColor;

  const MatchStatisticsRowWidget({
    super.key,
    required this.stat,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context) {
    bool homeWins = stat.homeVal > stat.awayVal;
    bool awayWins = stat.awayVal > stat.homeVal;
    
    if (stat.lowerIsBetter) {
      homeWins = stat.homeVal < stat.awayVal;
      awayWins = stat.awayVal < stat.homeVal;
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
              child: MatchStatisticsStatValueWidget(
                text: stat.homeText,
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
              text: stat.title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor,
              textAlign: TextAlign.center,
            ),
          ),

          // Away Value (Left in RTL)
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: MatchStatisticsStatValueWidget(
                text: stat.awayText,
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
