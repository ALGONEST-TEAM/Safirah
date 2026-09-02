import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import 'match_standings_pinned_team_logo_widget.dart';

import '../../pages/team_matches_page.dart';

class MatchStandingsPinnedRowWidget extends StatelessWidget {
  final MatchTeamStandingItemModel item;
  final Color highlightColor;
  final Color qualificationColor;

  const MatchStandingsPinnedRowWidget({
    super.key,
    required this.item,
    required this.highlightColor,
    required this.qualificationColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHighlight = item.isMatchTeam;
    final logoUrl = item.team?.imagePath ?? '';
    final teamName = item.team?.name ?? '';
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
        decoration: BoxDecoration(
          color: isHighlight ? highlightColor.withValues(alpha: 0.08) : Colors.white,
        ),
        child: Row(
          children: [
            // Qualification / Highlight Indicator Bar
            Container(
              width: 3.5.w,
              height: 36.h,
              color: qualificationColor,
            ),
            SizedBox(width: 2.w),

            // Rank #
            SizedBox(
              width: 14.w,
              child: AutoSizeTextWidget(
                text: '${item.position}',
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                colorText: textColor,
                textAlign: TextAlign.center,
              ),
            ),
            2.w.horizontalSpace,

            // Team Logo
            MatchStandingsPinnedTeamLogoWidget(logoUrl: logoUrl),
            2.w.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
