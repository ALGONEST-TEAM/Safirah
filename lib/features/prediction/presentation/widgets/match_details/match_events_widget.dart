import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const MatchEventsWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(matchDetailsProvider(matchId));
    final eventsState = ref.watch(matchEventsProvider(matchId));
    final eventsUI = ref.watch(matchEventsUIProvider(matchId));
    final teamColors = ref.watch(matchTeamColorsProvider(matchId));

    // Use events state for loading check: if details loaded but events
    // are still loading, we should show the shimmer instead of empty content.
    final effectiveState = (detailsState.stateData == States.loaded &&
            eventsState.stateData == States.loading)
        ? eventsState
        : detailsState;

    return CheckStateInGetApiDataWidget(
      state: effectiveState,
      refresh: () {
        ref.read(matchDetailsProvider(matchId).notifier).getMatchDetails();
        ref.read(matchEventsProvider(matchId).notifier).getMatchEvents();
      },
      widgetOfLoading: const MatchEventsShimmerWidget(),
      widgetOfData: RefreshIndicator(
        onRefresh: () async {
          ref.read(matchDetailsProvider(matchId).notifier).getMatchDetails();
          await ref.read(matchEventsProvider(matchId).notifier).getMatchEvents();
        },
        color: AppColors.primaryColor,
        child: MatchEventsContentWidget(
          matchId: matchId,
          matchDetails: detailsState.data!,
          eventsUI: eventsUI,
          homeColor: teamColors.homeColor,
          awayColor: teamColors.awayColor,
        ),
      ),
    );
  }
}
