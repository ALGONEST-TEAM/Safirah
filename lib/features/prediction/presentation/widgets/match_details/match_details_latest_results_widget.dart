import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_details_model.dart';
import '../../../data/model/team_matches_model.dart';
import '../../riverpod/team_matches_riverpod.dart';

enum MatchOutcome { win, draw, loss }

/// Card widget displaying the latest 5 match results for both teams
/// side by side with outcome colored pills (Win=Green, Draw=Grey, Loss=Red).
/// Non-clickable static display matching the exact scores orientation.
class MatchDetailsLatestResultsWidget extends ConsumerWidget {
  final int matchId;
  final MatchDetailsModel? matchDetails;

  const MatchDetailsLatestResultsWidget({
    super.key,
    required this.matchId,
    this.matchDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeTeam = matchDetails?.teams?.home;
    final awayTeam = matchDetails?.teams?.away;

    final int homeTeamId =
        (homeTeam?.sportmonksId != null && homeTeam!.sportmonksId! != 0)
            ? homeTeam.sportmonksId!
            : (homeTeam?.id ?? 0);

    final int awayTeamId =
        (awayTeam?.sportmonksId != null && awayTeam!.sportmonksId! != 0)
            ? awayTeam.sportmonksId!
            : (awayTeam?.id ?? 0);

    if (homeTeamId == 0 && awayTeamId == 0) {
      return const SizedBox.shrink();
    }

    final homeMatchesState =
        homeTeamId != 0 ? ref.watch(teamMatchesProvider(homeTeamId)) : null;
    final awayMatchesState =
        awayTeamId != 0 ? ref.watch(teamMatchesProvider(awayTeamId)) : null;

    final bool isHomeLoading = homeMatchesState?.stateData == States.loading &&
        (homeMatchesState?.data.previous.isEmpty ?? true);
    final bool isAwayLoading = awayMatchesState?.stateData == States.loading &&
        (awayMatchesState?.data.previous.isEmpty ?? true);

    if (isHomeLoading || isAwayLoading) {
      return const _LatestResultsShimmer();
    }

    final homeMatches =
        (homeMatchesState?.data.previous ?? []).take(5).toList();
    final awayMatches =
        (awayMatchesState?.data.previous ?? []).take(5).toList();

    if (homeMatches.isEmpty && awayMatches.isEmpty) {
      return const SizedBox.shrink();
    }

    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.greySwatch.shade200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: Title ("آخر النتائج")
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Center(
                child: AutoSizeTextWidget(
                  text: 'آخر النتائج',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  colorText: AppColors.fontColor,
                ),
              ),
            ),

            const Divider(height: 1, color: Color(0xfff5f3f9)),

            // Body: Two columns (Home Team on Right, Away Team on Left in RTL)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Home Team Column (Right in RTL)
                  Expanded(
                    child: _buildTeamColumn(
                      context,
                      matches: homeMatches,
                      teamId: homeTeamId,
                      fallbackLogo: homeTeam?.logo ?? '',
                    ),
                  ),

                  SizedBox(width: 14.w),

                  // Away Team Column (Left in RTL)
                  Expanded(
                    child: _buildTeamColumn(
                      context,
                      matches: awayMatches,
                      teamId: awayTeamId,
                      fallbackLogo: awayTeam?.logo ?? '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildTeamColumn(
    BuildContext context, {
    required List<TeamMatchItem> matches,
    required int teamId,
    required String fallbackLogo,
  }) {
    if (matches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < matches.length; i++)
          Padding(
            padding:
                EdgeInsets.only(bottom: i == matches.length - 1 ? 0 : 16.h),
            child: _buildMatchRow(
              context,
              match: matches[i],
              teamId: teamId,
              fallbackLogo: fallbackLogo,
              isFirstRow: i == 0,
            ),
          ),
      ],
    );
  }

  Widget _buildMatchRow(
    BuildContext context, {
    required TeamMatchItem match,
    required int teamId,
    required String fallbackLogo,
    required bool isFirstRow,
  }) {
    final focusLogo = _getFocusTeamLogo(match, teamId, fallbackLogo);
    final opponentLogo = _getOpponentLogo(match, teamId);
    final outcome = _resolveOutcome(match, teamId);
    final outcomeColor = _getOutcomeColor(outcome);
    final scoreText = _formatScore(match, teamId);

    // Non-clickable static match display
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Focus Team Logo (Left in LTR)
              OnlineImagesWidget(
                imageUrl: focusLogo,
                size: Size(24.r, 24.r),
                circularImage: true,
                fit: BoxFit.contain,
                backgroundColor: Colors.transparent,
              ),
              8.w.horizontalSpace,

              // Score Pill: Focus Team score on left, Opponent score on right
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.5.h),
                decoration: BoxDecoration(
                  color: outcomeColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: AutoSizeTextWidget(
                  text: scoreText,
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  colorText: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              8.w.horizontalSpace,

              // Opponent Team Logo (Right in LTR)
              OnlineImagesWidget(
                imageUrl: opponentLogo,
                size: Size(24.r, 24.r),
                circularImage: true,
                fit: BoxFit.contain,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          if (isFirstRow) ...[
            3.h.verticalSpace,
            Container(
              width: 20.w,
              height: 2.5.h,
              decoration: BoxDecoration(
                color: outcomeColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _isHomeTeam(TeamMatchItem match, int teamId) {
    if (match.teamSide.isNotEmpty) {
      final side = match.teamSide.toLowerCase();
      if (side == 'home') return true;
      if (side == 'away') return false;
    }
    if (teamId != 0) {
      if (match.homeTeam.id == teamId ||
          match.homeTeam.sportmonksId == teamId) {
        return true;
      }
      if (match.awayTeam.id == teamId ||
          match.awayTeam.sportmonksId == teamId) {
        return false;
      }
    }
    return true;
  }

  MatchOutcome _resolveOutcome(TeamMatchItem match, int teamId) {
    // 1. Try explicit outcome string from API if present
    final outcomeStr = match.outcome?.toLowerCase().trim();
    if (outcomeStr != null && outcomeStr.isNotEmpty) {
      if (outcomeStr == 'win' ||
          outcomeStr == 'won' ||
          outcomeStr == 'w' ||
          outcomeStr == 'فوز') {
        return MatchOutcome.win;
      }
      if (outcomeStr == 'loss' ||
          outcomeStr == 'lost' ||
          outcomeStr == 'l' ||
          outcomeStr == 'خسارة') {
        return MatchOutcome.loss;
      }
      if (outcomeStr == 'draw' ||
          outcomeStr == 'drawn' ||
          outcomeStr == 'd' ||
          outcomeStr == 'تعادل') {
        return MatchOutcome.draw;
      }
    }

    // 2. Resolve from score and team side
    final score = match.score;
    if (score != null) {
      final home = score.home;
      final away = score.away;
      if (home == away) {
        return MatchOutcome.draw;
      }

      final bool isHome = _isHomeTeam(match, teamId);
      final int focusScore = isHome ? home : away;
      final int opponentScore = isHome ? away : home;

      return focusScore > opponentScore
          ? MatchOutcome.win
          : MatchOutcome.loss;
    }

    return MatchOutcome.draw;
  }

  Color _getOutcomeColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return const Color(0xff058967);
      case MatchOutcome.loss:
        return const Color(0xffC00000);
      case MatchOutcome.draw:
        return const Color(0xFF8E95A5);
    }
  }

  /// Formats the score so that the number on the left matches the Focus Team (left logo)
  /// and the number on the right matches the Opponent (right logo).
  String _formatScore(TeamMatchItem match, int teamId) {
    final score = match.score;
    if (score != null) {
      final bool isHome = _isHomeTeam(match, teamId);
      final int focusScore = isHome ? score.home : score.away;
      final int opponentScore = isHome ? score.away : score.home;
      return '$focusScore - $opponentScore';
    }
    return '-';
  }

  String _getFocusTeamLogo(
      TeamMatchItem match, int teamId, String fallbackLogo) {
    final bool isHome = _isHomeTeam(match, teamId);
    final logo = isHome ? match.homeTeam.imagePath : match.awayTeam.imagePath;
    return logo.isNotEmpty ? logo : fallbackLogo;
  }

  String _getOpponentLogo(TeamMatchItem match, int teamId) {
    final bool isHome = _isHomeTeam(match, teamId);
    return isHome ? match.awayTeam.imagePath : match.homeTeam.imagePath;
  }
}

class _LatestResultsShimmer extends StatelessWidget {
  const _LatestResultsShimmer();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.greySwatch.shade200,
              width: 1,
            ),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Shimmer
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  child: Center(
                    child: Container(
                      width: 70.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: Color(0xfff5f3f9)),

                // Columns Shimmer
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Expanded(child: _buildColumnShimmer()),
                      SizedBox(width: 14.w),
                      Expanded(child: _buildColumnShimmer()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnShimmer() {
    return Column(
      children: [
        for (int i = 0; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == 4 ? 0 : 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                8.w.horizontalSpace,
                Container(
                  width: 44.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                8.w.horizontalSpace,
                Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
