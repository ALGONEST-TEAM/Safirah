import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_events_content_widget.dart';
import 'match_events_shimmer_widget.dart';

class MatchEventsWidget extends ConsumerWidget {
  final int matchId;
  final VoidCallback? onViewMoreStandings;
  final VoidCallback? onViewMoreH2H;

  const MatchEventsWidget({
    super.key,
    required this.matchId,
    this.onViewMoreStandings,
    this.onViewMoreH2H,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(matchDetailsProvider(matchId));
    final eventsState = ref.watch(matchEventsProvider(matchId));
    final eventsUI = ref.watch(matchEventsUIProvider(matchId));
    final teamColors = ref.watch(matchTeamColorsProvider(matchId));

    // If details loaded but events have never completed loading yet,
    // show shimmer instead of prematurely showing "No events".
    final bool isEventsLoadingInitial = eventsState.data.allEvents.isEmpty &&
        eventsState.stateData != States.loaded &&
        eventsState.stateData != States.error;

    final effectiveState = (detailsState.stateData == States.loaded && isEventsLoadingInitial)
        ? eventsState.copyWith(state: States.loading)
        : detailsState;

    return CheckStateInGetApiDataWidget(
      state: effectiveState,
      refresh: () {
        ref.read(matchDetailsProvider(matchId).notifier).getMatchDetails(isRefresh: true);
        ref.read(matchEventsProvider(matchId).notifier).getMatchEvents(isRefresh: true);
      },
      widgetOfLoading: const MatchEventsShimmerWidget(),
      widgetOfData: RefreshIndicator(
        onRefresh: () async {
          ref.read(matchDetailsProvider(matchId).notifier).getMatchDetails(isRefresh: true);
          await ref.read(matchEventsProvider(matchId).notifier).getMatchEvents(isRefresh: true);
        },
        color: AppColors.primaryColor,
        child: MatchEventsContentWidget(
          matchId: matchId,
          matchDetails: detailsState.data,
          eventsUI: eventsUI,
          homeColor: teamColors.homeColor,
          awayColor: teamColors.awayColor,
          onViewMoreStandings: onViewMoreStandings,
          onViewMoreH2H: onViewMoreH2H,
        ),
      ),
    );
  }
}
