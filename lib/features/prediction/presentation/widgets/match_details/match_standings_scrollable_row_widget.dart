import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import 'match_standings_cell_widget.dart';

import '../../pages/team_matches_page.dart';

class MatchStandingsScrollableRowWidget extends StatelessWidget {
  final MatchTeamStandingItemModel item;
  final double dynamicGap;
  final Color highlightColor;

  const MatchStandingsScrollableRowWidget({
    super.key,
    required this.item,
    required this.dynamicGap,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHighlight = item.isMatchTeam;
    final teamName = item.team?.name ?? '';
    final logoUrl = item.team?.imagePath ?? '';
    final teamId = item.team?.id ?? 0;
    
    final Color textColor = isHighlight
        ? (Color.lerp(highlightColor, Colors.black, 0.3) ?? highlightColor)
        : AppColors.fontColor;

    return GestureDetector(
      onTap: () {
        if (teamId != 0) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TeamMatchesPage(
              teamId: teamId,
            ),
          ));
        }
      },
      child: Container(
        height: 36.h,
        padding: EdgeInsets.only(right: 8.w, left: 8.w),
        decoration: BoxDecoration(
          color: isHighlight ? highlightColor.withValues(alpha: 0.08) : Colors.white,
        ),
        child: Row(
          children: [
            // Team Name
            SizedBox(
              width: 105.w,
              child: AutoSizeTextWidget(
                text: teamName,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                colorText: textColor,
                maxLines: 1,
              ),
            ),
            // Screen-responsive dynamic gap
            SizedBox(width: dynamicGap),

            // First 3 visible stats before scroll: لعب, +/-, نقاط
            MatchStandingsCellWidget(text: '${item.played}', width: 32.w, isHighlight: isHighlight, textColor: textColor),
            MatchStandingsCellWidget(text: '${item.goalsAgainst}:${item.goalsFor}', width: 48.w, isHighlight: isHighlight, textColor: textColor),
            MatchStandingsCellWidget(text: '${item.points}', width: 36.w, isHighlight: isHighlight, textColor: textColor),

            // Remaining stats pushed off-screen until user scrolls: ف, ت, خ, فارق
            MatchStandingsCellWidget(text: '${item.won}', width: 28.w, isHighlight: isHighlight, textColor: textColor),
            MatchStandingsCellWidget(text: '${item.drawn}', width: 28.w, isHighlight: isHighlight, textColor: textColor),
            MatchStandingsCellWidget(text: '${item.lost}', width: 28.w, isHighlight: isHighlight, textColor: textColor),
            MatchStandingsCellWidget(text: '${item.goalDifference}', width: 36.w, isHighlight: isHighlight, textColor: textColor),
          ],
        ),
      ),
    );
  }
}
