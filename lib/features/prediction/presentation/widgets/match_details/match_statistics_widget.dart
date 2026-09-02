import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/model/match_statistics_model.dart';
import '../../riverpod/match_details_riverpod.dart';
import 'match_statistics_content_widget.dart';
import 'match_statistics_shimmer_widget.dart';

class MatchStatisticsWidget extends ConsumerWidget {
  final int matchId;

  const MatchStatisticsWidget({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchStatisticsProvider(matchId));
    final currentPeriod = ref.watch(matchStatisticsProvider(matchId).notifier).currentPeriod;

    if (state.stateData == States.loading && state.data != null) {
      return MatchStatisticsContentWidget(
        matchId: matchId,
        statsModel: state.data!,
        selectedPeriodKey: currentPeriod,
        isLoading: true,
      );
    }

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () => ref.read(matchStatisticsProvider(matchId).notifier).getMatchStatistics(forceRefresh: true),
      widgetOfLoading: const MatchStatisticsShimmerWidget(),
      widgetOfData: RefreshIndicator(
        onRefresh: () async {
          await ref.read(matchStatisticsProvider(matchId).notifier).getMatchStatistics(forceRefresh: true);
        },
        color: AppColors.primaryColor,
        child: MatchStatisticsContentWidget(
          matchId: matchId,
          statsModel: state.data ?? MatchStatisticsModel.empty(),
          selectedPeriodKey: currentPeriod,
          isLoading: false,
        ),
      ),
    );
  }
}
