import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/match_lineups_model.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../provider/match_details_providers.dart';
import 'match_lineups_team_toggle_widget.dart';
import 'match_lineups_tactical_pitch_widget.dart';
import 'match_lineups_coach_card_widget.dart';
import 'match_lineups_bench_widget.dart';
import 'match_lineups_absent_players_widget.dart';

class MatchLineupsContentWidget extends ConsumerWidget {
  final int matchId;
  final MatchLineupsModel lineupsData;
  final bool showHomeTeam;

  const MatchLineupsContentWidget({
    super.key,
    required this.matchId,
    required this.lineupsData,
    required this.showHomeTeam,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeTeam = lineupsData.homeTeam ?? MatchLineupTeamModel.empty('home');
    final awayTeam = lineupsData.awayTeam ?? MatchLineupTeamModel.empty('away');

    final activeTeam = showHomeTeam ? homeTeam : awayTeam;
    final startingXI = activeTeam.starters;
    final bench = activeTeam.bench;
    final coach = activeTeam.coach;
    final substitutions = activeTeam.substitutions;
    final unavailablePlayers = activeTeam.unavailablePlayers;
    final formation = activeTeam.formation;
    final teamName = activeTeam.name;

    if (startingXI.isEmpty && bench.isEmpty && coach == null) {
      return Padding(
        padding: EdgeInsets.only(top: 100.h),
        child: const Center(
          child: AutoSizeTextWidget(
            text: 'التشكيلة غير متوفرة حالياً',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            colorText: AppColors.fontColor2,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          // Team Toggle Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: MatchLineupsTeamToggleWidget(
              homeTeamName: homeTeam.name,
              awayTeamName: awayTeam.name,
              homeTeamLogo: homeTeam.logo,
              awayTeamLogo: awayTeam.logo,
              showHomeTeam: showHomeTeam,
              onToggle: (val) {
                ref.read(matchLineupTeamToggleProvider(matchId).notifier).toggle(val);
              },
            ),
          ),

          // Tactical Pitch Widget
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: MatchLineupsTacticalPitchWidget(
              startingXI: startingXI,
              showHomeTeam: showHomeTeam,
              formation: formation,
              teamName: teamName,
              matchId: matchId,
            ),
          ),
          24.h.verticalSpace,

          // Coach Card Widget
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: MatchLineupsCoachCardWidget(
              coach: coach,
              teamName: teamName,
            ),
          ),
          16.h.verticalSpace,

          // Bench Players Widget
          if (bench.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MatchLineupsBenchWidget(
                bench: bench,
                starters: startingXI,
                substitutions: substitutions,
              ),
            ),
            16.h.verticalSpace,
          ],

          // Absent / Unavailable Players Widget
          if (unavailablePlayers.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MatchLineupsAbsentPlayersWidget(
                unavailablePlayers: unavailablePlayers,
              ),
            ),
            20.h.verticalSpace,
          ],
        ],
      ),
    );
  }
}
