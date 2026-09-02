import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/state.dart';
import '../riverpod/match_details_riverpod.dart';
import '../riverpod/match_lineups_riverpod.dart';
import '../riverpod/prediction_riverpod.dart';

enum MatchDetailTabType {
  events,
  lineups,
  standings,
  statistics,
  h2h,
}

class MatchTabConfigItem {
  final String label;
  final MatchDetailTabType type;

  const MatchTabConfigItem({
    required this.label,
    required this.type,
  });
}

class MatchDetailsTabsConfig {
  final List<MatchTabConfigItem> tabs;
  final bool isNotStarted;
  final bool showLineups;
  final bool showStatistics;
  final bool isLoading;
  final bool isError;
  final Object? exception;

  const MatchDetailsTabsConfig({
    required this.tabs,
    required this.isNotStarted,
    required this.showLineups,
    required this.showStatistics,
    required this.isLoading,
    this.isError = false,
    this.exception,
  });

  factory MatchDetailsTabsConfig.initial() {
    return const MatchDetailsTabsConfig(
      tabs: [
        MatchTabConfigItem(label: 'احداث', type: MatchDetailTabType.events),
        MatchTabConfigItem(label: 'التشكيلة', type: MatchDetailTabType.lineups),
        MatchTabConfigItem(label: 'جدول الترتيب', type: MatchDetailTabType.standings),
        MatchTabConfigItem(label: 'احصائيات', type: MatchDetailTabType.statistics),
        MatchTabConfigItem(label: 'المواجهات المباشرة', type: MatchDetailTabType.h2h),
      ],
      isNotStarted: false,
      showLineups: true,
      showStatistics: true,
      isLoading: true,
    );
  }

  List<String> get tabLabels => tabs.map((t) => t.label).toList();
  int get tabCount => tabs.length;
}

final matchDetailsTabsConfigProvider =
    Provider.family.autoDispose<MatchDetailsTabsConfig, int>((ref, int matchId) {
  final matchDetailsState = ref.watch(matchDetailsProvider(matchId));
  final bool isLoading = matchDetailsState.stateData == States.loading ||
      matchDetailsState.stateData == States.initial;
  final bool isError = matchDetailsState.stateData == States.error;

  if (isError) {
    return MatchDetailsTabsConfig(
      tabs: const [],
      isNotStarted: false,
      showLineups: false,
      showStatistics: false,
      isLoading: true,
      isError: true,
      exception: matchDetailsState.exception,
    );
  }

  final statusHelper = ref.watch(matchStatusHelperProvider);
  final matchDetails = matchDetailsState.data;

  final statusNum = num.tryParse(matchDetails.status ?? '');
  final bool isNotStarted = statusHelper.isNotStarted(statusNum) ||
      matchDetails.status == '1' ||
      matchDetails.status == '13' ||
      matchDetails.status == '26' ||
      matchDetails.state?.code == 'NS' ||
      matchDetails.state?.hasStarted == false;

  final bool showStatistics = !isNotStarted;

  final lineupsState = ref.watch(matchLineupsProvider(matchId));
  final lineupsData = lineupsState.data;
  final bool hasLineupPlayers = lineupsData.teams.isNotEmpty &&
      lineupsData.teams.any(
          (team) => team.starters.isNotEmpty || team.bench.isNotEmpty);

  final bool showLineups = !isNotStarted || hasLineupPlayers;

  final List<MatchTabConfigItem> tabs = [
    const MatchTabConfigItem(label: 'احداث', type: MatchDetailTabType.events),
    if (showLineups)
      const MatchTabConfigItem(label: 'التشكيلة', type: MatchDetailTabType.lineups),
    const MatchTabConfigItem(label: 'جدول الترتيب', type: MatchDetailTabType.standings),
    if (showStatistics)
      const MatchTabConfigItem(label: 'احصائيات', type: MatchDetailTabType.statistics),
    const MatchTabConfigItem(label: 'المواجهات المباشرة', type: MatchDetailTabType.h2h),
  ];

  return MatchDetailsTabsConfig(
    tabs: tabs,
    isNotStarted: isNotStarted,
    showLineups: showLineups,
    showStatistics: showStatistics,
    isLoading: isLoading,
  );
});
