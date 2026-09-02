import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/match_details_model.dart';
import '../../provider/match_details_providers.dart';
import 'match_details_stadium_info_widget.dart';
import 'match_details_info_card_widget.dart';
import 'match_details_who_will_win_widget.dart';
import 'match_events_key_stats_widget.dart';
import 'match_events_best_player_widget.dart';
import 'match_events_filter_widget.dart';
import 'match_events_list_widget.dart';

class MatchEventsContentWidget extends ConsumerWidget {
  final int matchId;
  final MatchDetailsModel matchDetails;
  final MatchEventsUIState eventsUI;
  final Color homeColor;
  final Color awayColor;

  const MatchEventsContentWidget({
    super.key,
    required this.matchId,
    required this.matchDetails,
    required this.eventsUI,
    required this.homeColor,
    required this.awayColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (eventsUI.isNotStarted) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            if (matchDetails.isInPredictionSystem) ...[
              MatchDetailsWhoWillWinWidget(
                leagueName: matchDetails.competition?.name ?? '',
                matchDetails: matchDetails,
              ),
              16.h.verticalSpace,
            ],
            MatchDetailsStadiumInfoWidget(
              venue: matchDetails.venue,
              attendance: matchDetails.attendance,
              hasStarted: eventsUI.hasStarted,
            ),
            16.h.verticalSpace,
            MatchDetailsInfoCardWidget(matchDetails: matchDetails),
            16.h.verticalSpace,
          ],
        ),
      );
    }

    // Find ball possession stat to determine dominant team color for the filter tabs
    final possessionStat = matchDetails.keyStatistics
        .where((s) => s.code == 'ball-possession' || (s.label != null && s.label!.contains('استحواذ')))
        .firstOrNull;

    int homePossession = 50;
    int awayPossession = 50;
    if (possessionStat != null) {
      homePossession = int.tryParse(double.tryParse(possessionStat.home ?? '50')?.toStringAsFixed(0) ?? '50') ?? 50;
      awayPossession = int.tryParse(double.tryParse(possessionStat.away ?? '50')?.toStringAsFixed(0) ?? '50') ?? 50;
    }

    // Default to app primary color, but if a team dominates possession, use their color!
    Color filterTabColor = const Color(0xFFCA9A2C); // AppColors.primaryColor
    if (homePossession > awayPossession) {
      filterTabColor = homeColor;
    } else if (awayPossession > homePossession) {
      filterTabColor = awayColor;
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (eventsUI.isFinished) ...[
            MatchEventsKeyStatsWidget(
              homeColor: homeColor,
              awayColor: awayColor,
              keyStatistics: matchDetails.keyStatistics,
            ),
            16.h.verticalSpace,
          ],
          if (eventsUI.isFinished && eventsUI.bestPlayerInfo != null) ...[
            MatchEventsBestPlayerWidget(
              bestPlayer: eventsUI.bestPlayerInfo!.bestPlayer,
              teamName: eventsUI.bestPlayerInfo!.teamName,
              teamLogo: eventsUI.bestPlayerInfo!.teamLogo,
              teamColor: eventsUI.bestPlayerInfo!.teamColor,
            ),
            16.h.verticalSpace,
          ],
          MatchEventsFilterWidget(
            selectedIndex: eventsUI.selectedFilterIndex,
            isFinish: eventsUI.isFinished,
            activeColor: filterTabColor,
            onFilterChanged: (index) {
              ref.read(matchEventsUIProvider(matchId).notifier).setFilterIndex(index);
            },
          ),
          16.h.verticalSpace,
          MatchEventsListWidget(
            events: eventsUI.currentEvents,
            periods: eventsUI.periods,
            precomputedTimelineItems: eventsUI.timelineItems,
          ),
          16.h.verticalSpace,
          if (!eventsUI.isFinished && eventsUI.hasStarted) ...[
            MatchEventsKeyStatsWidget(
              homeColor: homeColor,
              awayColor: awayColor,
              keyStatistics: matchDetails.keyStatistics,
            ),
            16.h.verticalSpace,
          ],
          MatchDetailsStadiumInfoWidget(
            venue: matchDetails.venue,
            attendance: matchDetails.attendance,
            hasStarted: eventsUI.hasStarted,
          ),
          16.h.verticalSpace,
          MatchDetailsInfoCardWidget(matchDetails: matchDetails),
        ],
      ),
    );
  }
}
