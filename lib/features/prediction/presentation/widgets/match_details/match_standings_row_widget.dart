import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import 'match_standings_row_team_logo_widget.dart';

class MatchStandingsRowWidget extends StatelessWidget {
  final MatchTeamStandingItemModel item;

  const MatchStandingsRowWidget({
    super.key,
    required this.item,
  });

  Color _qualificationColor(int rank) {
    if (rank >= 1 && rank <= 4) {
      return const Color(0xff10b981); // Champions League (Green)
    } else if (rank == 5) {
      return const Color(0xff34d399); // Europa League (Light Green)
    } else if (rank == 6) {
      return const Color(0xff2563eb); // Conference Qualifiers (Dark Blue)
    } else if (rank == 7) {
      return const Color(0xff06b6d4); // Conference League (Light Blue)
    } else if (rank >= 18 && rank <= 20) {
      return const Color(0xffef4444); // Relegation zone (Red)
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final indicatorColor = _qualificationColor(item.position);
    final bool isHighlight = item.isMatchTeam;
    final teamName = item.team?.name ?? '';
    final logoUrl = item.team?.imagePath ?? '';

    return Container(
      color: isHighlight ? AppColors.secondaryColor.withValues(alpha: 0.08) : Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          // Qualification Indicator Bar on far edge
          Container(
            width: 3.5.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.r),
                bottomLeft: Radius.circular(2.r),
              ),
            ),
          ),
          SizedBox(width: 12.5.w),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                children: [
                  // Position #
                  SizedBox(
                    width: 20.w,
                    child: AutoSizeTextWidget(
                      text: "${item.position}",
                      fontSize: 12.sp,
                      fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
                      colorText: isHighlight ? AppColors.secondaryColor : AppColors.fontColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  10.w.horizontalSpace,

                  // Team Logo
                  MatchStandingsRowTeamLogoWidget(
                    logoUrl: logoUrl,
                    teamName: teamName,
                  ),
                  10.w.horizontalSpace,

                  // Team Name
                  Expanded(
                    child: AutoSizeTextWidget(
                      text: teamName,
                      fontSize: 12.sp,
                      fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
                      colorText: isHighlight ? AppColors.secondaryColor : AppColors.fontColor,
                      maxLines: 1,
                    ),
                  ),

                  // Played / Goal Diff / Points
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        child: AutoSizeTextWidget(
                          text: "${item.played}",
                          fontSize: 12.sp,
                          fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
                          colorText: AppColors.fontColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 44.w,
                        child: AutoSizeTextWidget(
                          text: item.goalDifference > 0 ? "+${item.goalDifference}" : "${item.goalDifference}",
                          fontSize: 12.sp,
                          fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
                          colorText: AppColors.fontColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                        child: AutoSizeTextWidget(
                          text: "${item.points}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          colorText: isHighlight ? AppColors.secondaryColor : AppColors.mainColorFont,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
