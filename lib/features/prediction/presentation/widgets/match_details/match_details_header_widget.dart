import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/state.dart';
import '../../provider/match_team_colors_provider.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_details_header_content_widget.dart';
import 'match_header_shimmer_widget.dart';

class MatchDetailsHeaderWidget extends ConsumerWidget {
  final int matchId;

  const MatchDetailsHeaderWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailsProvider(matchId));
    final teamColors = ref.watch(matchTeamColorsProvider(matchId));

    // Show shimmer for loading AND error states.
    // Error is handled once in MatchDetailsShimmerView body,
    // so the header should not show a duplicate error widget.
    if (state.stateData != States.loaded &&
        state.stateData != States.loadingMore) {
      return const MatchHeaderShimmerWidget();
    }

    return MatchDetailsHeaderContentWidget(
      matchDetails: state.data,
      rightGlowColor: teamColors.homeGlowColor,
      leftGlowColor: teamColors.awayGlowColor,
    );
  }
}