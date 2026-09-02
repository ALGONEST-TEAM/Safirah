import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import 'match_lineups_team_toggle_tab_widget.dart';
import 'match_lineups_team_toggle_divider_widget.dart';

class MatchLineupsTeamToggleWidget extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final bool showHomeTeam;
  final ValueChanged<bool> onToggle;

  const MatchLineupsTeamToggleWidget({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    this.homeTeamLogo = '',
    this.awayTeamLogo = '',
    required this.showHomeTeam,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Row(
        children: [
          // true = Home Team (على اليمين في RTL)
          Expanded(
            child: MatchLineupsTeamToggleTabWidget(
              title: homeTeamName,
              isHome: true,
              showHomeTeam: showHomeTeam,
              onToggle: onToggle,
            ),
          ),
          const MatchLineupsTeamToggleDividerWidget(),
          // false = Away Team (على اليسار في RTL)
          Expanded(
            child: MatchLineupsTeamToggleTabWidget(
              title: awayTeamName,
              isHome: false,
              showHomeTeam: showHomeTeam,
              onToggle: onToggle,
            ),
          ),
        ],
      ),
    );
  }
}
