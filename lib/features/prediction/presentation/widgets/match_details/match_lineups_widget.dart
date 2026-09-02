import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../provider/match_details_providers.dart';
import '../../riverpod/match_lineups_riverpod.dart';
import 'match_lineups_content_widget.dart';
import 'match_lineups_shimmer_widget.dart';

class MatchLineupsWidget extends ConsumerWidget {
  final int matchId;

  const MatchLineupsWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchLineupsProvider(matchId));
    final showHomeTeam = ref.watch(matchLineupTeamToggleProvider(matchId));

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () =>
          ref.read(matchLineupsProvider(matchId).notifier).getMatchLineups(),
      widgetOfLoading: const MatchLineupsShimmerWidget(),
      widgetOfData: state.data != null
          ? RefreshIndicator(
              onRefresh: () async {
                await ref.read(matchLineupsProvider(matchId).notifier).getMatchLineups(isRefresh: true);
              },
              color: AppColors.primaryColor,
              child: MatchLineupsContentWidget(
                matchId: matchId,
                lineupsData: state.data!,
                showHomeTeam: showHomeTeam,
              ),
            )
          : const SizedBox(),
    );
  }
}
