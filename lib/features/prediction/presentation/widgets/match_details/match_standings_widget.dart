import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/model/match_fixture_standings_model.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_standings_content_widget.dart';
import 'match_standings_shimmer_widget.dart';

class MatchStandingsWidget extends ConsumerWidget {
  final int matchId;

  const MatchStandingsWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchStandingsProvider(matchId));
    final detailsState = ref.watch(matchDetailsProvider(matchId));
    final currentScope = ref.watch(matchStandingsProvider(matchId).notifier).currentScope;

    final String? homeHex = detailsState.data?.teams?.home?.color;
    final String? awayHex = detailsState.data?.teams?.away?.color;

    if (state.stateData == States.loading && state.data != null) {
      return MatchStandingsContentWidget(
        matchId: matchId,
        standingsModel: state.data!,
        selectedGroupKey: currentScope,
        homeColorHex: homeHex,
        awayColorHex: awayHex,
        isLoading: true,
      );
    }

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () => ref.read(matchStandingsProvider(matchId).notifier).getMatchStandings(forceRefresh: true),
      widgetOfLoading: const MatchStandingsShimmerWidget(),
      widgetOfData: RefreshIndicator(
        onRefresh: () async {
          await ref.read(matchStandingsProvider(matchId).notifier).getMatchStandings(forceRefresh: true);
        },
        color: AppColors.primaryColor,
        child: MatchStandingsContentWidget(
          matchId: matchId,
          standingsModel: state.data ?? MatchFixtureStandingsModel.empty(),
          selectedGroupKey: currentScope,
          homeColorHex: homeHex,
          awayColorHex: awayHex,
          isLoading: false,
        ),
      ),
    );
  }
}
