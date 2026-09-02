import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/model/match_details_model.dart';
import '../../data/model/match_events_model.dart';
import '../riverpod/match_details_riverpod.dart';
import 'match_team_colors_provider.dart';

enum MatchEventType {
  goal,
  yellowCard,
  redCard,
  substitution,
  addedTime,
  halfTime,
  fullTime,
  penaltyGoal,
  penaltyMissed,
  canceledGoal,
}

class MatchEventItem {
  final dynamic minute;
  final MatchEventType type;
  final String? playerName;
  final String? extraName;
  final bool isHome;
  final String? label;
  final String? score;

  const MatchEventItem({
    this.minute,
    required this.type,
    this.playerName,
    this.extraName,
    this.isHome = false,
    this.label,
    this.score,
  });
}

class BestPlayerTeamInfo {
  final MatchBestPlayerModel bestPlayer;
  final String? teamName;
  final String? teamLogo;
  final Color teamColor;
  final bool isHome;

  const BestPlayerTeamInfo({
    required this.bestPlayer,
    this.teamName,
    this.teamLogo,
    required this.teamColor,
    required this.isHome,
  });
}

class MatchEventsUIState {
  final int selectedFilterIndex;
  final bool isNotStarted;
  final bool isFinished;
  final bool hasStarted;
  final List<MatchSingleEventModel> currentEvents;
  final List<MatchEventItem> timelineItems;
  final List<MatchEventPeriodModel> periods;
  final BestPlayerTeamInfo? bestPlayerInfo;

  const MatchEventsUIState({
    required this.selectedFilterIndex,
    required this.isNotStarted,
    required this.isFinished,
    required this.hasStarted,
    required this.currentEvents,
    required this.timelineItems,
    required this.periods,
    this.bestPlayerInfo,
  });

  factory MatchEventsUIState.empty() {
    return const MatchEventsUIState(
      selectedFilterIndex: 0,
      isNotStarted: false,
      isFinished: false,
      hasStarted: false,
      currentEvents: [],
      timelineItems: [],
      periods: [],
    );
  }

  MatchEventsUIState copyWith({
    int? selectedFilterIndex,
    bool? isNotStarted,
    bool? isFinished,
    bool? hasStarted,
    List<MatchSingleEventModel>? currentEvents,
    List<MatchEventItem>? timelineItems,
    List<MatchEventPeriodModel>? periods,
    BestPlayerTeamInfo? bestPlayerInfo,
  }) {
    return MatchEventsUIState(
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      isNotStarted: isNotStarted ?? this.isNotStarted,
      isFinished: isFinished ?? this.isFinished,
      hasStarted: hasStarted ?? this.hasStarted,
      currentEvents: currentEvents ?? this.currentEvents,
      timelineItems: timelineItems ?? this.timelineItems,
      periods: periods ?? this.periods,
      bestPlayerInfo: bestPlayerInfo ?? this.bestPlayerInfo,
    );
  }
}

final matchEventsUIProvider = StateNotifierProvider.family.autoDispose<
    MatchEventsUINotifier, MatchEventsUIState, int>(
  (ref, int matchId) {
    final detailsState = ref.watch(matchDetailsProvider(matchId));
    final eventsState = ref.watch(matchEventsProvider(matchId));
    final colorsState = ref.watch(matchTeamColorsProvider(matchId));

    final notifier = MatchEventsUINotifier();
    notifier.recompute(
      matchDetails: detailsState.data,
      eventsData: eventsState.data,
      homeColor: colorsState.homeColor,
      awayColor: colorsState.awayColor,
    );
    return notifier;
  },
);

class MatchEventsUINotifier extends StateNotifier<MatchEventsUIState> {
  MatchEventsUINotifier() : super(MatchEventsUIState.empty());

  int _currentFilterIndex = 0;
  MatchDetailsModel? _lastDetails;
  MatchEventsModel? _lastEvents;
  Color _lastHomeColor = const Color(0xFFC40010);
  Color _lastAwayColor = const Color(0xFF79ADE2);

  void setFilterIndex(int index) {
    if (_currentFilterIndex == index) return;
    _currentFilterIndex = index;
    if (_lastDetails != null) {
      recompute(
        matchDetails: _lastDetails!,
        eventsData: _lastEvents,
        homeColor: _lastHomeColor,
        awayColor: _lastAwayColor,
      );
    }
  }

  void recompute({
    required MatchDetailsModel? matchDetails,
    required MatchEventsModel? eventsData,
    required Color homeColor,
    required Color awayColor,
  }) {
    _lastDetails = matchDetails;
    _lastEvents = eventsData;
    _lastHomeColor = homeColor;
    _lastAwayColor = awayColor;

    if (matchDetails == null) {
      state = MatchEventsUIState.empty();
      return;
    }

    final bool isNotStarted = matchDetails.status == '1' ||
        matchDetails.status == '13' ||
        matchDetails.status == '26' ||
        matchDetails.state?.code == 'NS';

    final bool isFinished = matchDetails.status == '3' ||
        matchDetails.status == '100' ||
        matchDetails.state?.code == 'FT' ||
        matchDetails.state?.code == 'AET' ||
        matchDetails.state?.code == 'FT_PEN';

    final bool hasStarted = !isNotStarted;

    // Filter current events based on selected filter
    final List<MatchSingleEventModel> currentEvents = eventsData != null
        ? ((isFinished
            ? _currentFilterIndex == 0
                ? (eventsData.highlights.isNotEmpty
                    ? eventsData.highlights
                    : eventsData.allEvents)
                : eventsData.allEvents
            : _currentFilterIndex == 1
                ? (eventsData.highlights.isNotEmpty
                    ? eventsData.highlights
                    : eventsData.allEvents)
                : eventsData.allEvents))
        : [];

    final List<MatchEventPeriodModel> currentPeriods =
        eventsData?.periods ?? [];

    final List<MatchEventItem> timelineItems =
        _generateTimelineItems(currentEvents, currentPeriods);

    // Determine Best Player Team Info
    BestPlayerTeamInfo? bestPlayerInfo;
    final bestPlayer = matchDetails.bestPlayer;
    if (bestPlayer != null) {
      final int homeTeamId = matchDetails.teams?.home?.id ?? 0;
      final int awayTeamId = matchDetails.teams?.away?.id ?? 0;

      bool isBestPlayerHome = true;
      if (bestPlayer.teamId > 0) {
        if (bestPlayer.teamId == awayTeamId) {
          isBestPlayerHome = false;
        } else if (bestPlayer.teamId == homeTeamId) {
          isBestPlayerHome = true;
        }
      }

      final String? bestPlayerTeamName = isBestPlayerHome
          ? matchDetails.teams?.home?.name
          : matchDetails.teams?.away?.name;

      final String? bestPlayerTeamLogo = isBestPlayerHome
          ? matchDetails.teams?.home?.logo
          : matchDetails.teams?.away?.logo;

      final Color bestPlayerTeamColor = isBestPlayerHome ? homeColor : awayColor;

      bestPlayerInfo = BestPlayerTeamInfo(
        bestPlayer: bestPlayer,
        teamName: bestPlayerTeamName,
        teamLogo: bestPlayerTeamLogo,
        teamColor: bestPlayerTeamColor,
        isHome: isBestPlayerHome,
      );
    }

    state = MatchEventsUIState(
      selectedFilterIndex: _currentFilterIndex,
      isNotStarted: isNotStarted,
      isFinished: isFinished,
      hasStarted: hasStarted,
      currentEvents: currentEvents,
      timelineItems: timelineItems,
      periods: currentPeriods,
      bestPlayerInfo: bestPlayerInfo,
    );
  }

  static List<MatchEventItem> _generateTimelineItems(
    List<MatchSingleEventModel> events,
    List<MatchEventPeriodModel> periods,
  ) {
    if (events.isEmpty) return [];

    final List<MatchEventItem> items = [];

    // Separate events by half
    final firstHalfEvents = events.where((e) => e.parsedMinute <= 45).toList();
    final secondHalfEvents = events.where((e) => e.parsedMinute > 45).toList();

    // 1. Second half period (FT)
    final p2 = periods.firstWhere(
      (p) => p.code == '2nd-half' || p.code.contains('2'),
      orElse: () => MatchEventPeriodModel(
        sportmonksPeriodId: 0,
        code: '',
        name: '',
      ),
    );
    if (p2.scoreAtEnd != null && p2.scoreAtEnd!.isNotEmpty) {
      items.add(MatchEventItem(
        type: MatchEventType.fullTime,
        score: p2.scoreAtEnd,
      ));
    }
    if (p2.timeAdded != null && p2.timeAdded! > 0) {
      items.add(MatchEventItem(
        type: MatchEventType.addedTime,
        label: 'تم إضافة ${p2.timeAdded}+ دقائق',
      ));
    }

    // 2. Second half events (descending / newest top)
    for (final e in secondHalfEvents.reversed) {
      items.add(e.toUIItem());
    }

    // 3. First half period (HT)
    final p1 = periods.firstWhere(
      (p) => p.code == '1st-half' || p.code.contains('1'),
      orElse: () => MatchEventPeriodModel(
        sportmonksPeriodId: 0,
        code: '',
        name: '',
      ),
    );
    if (p1.scoreAtEnd != null && p1.scoreAtEnd!.isNotEmpty) {
      items.add(MatchEventItem(
        type: MatchEventType.halfTime,
        score: p1.scoreAtEnd,
      ));
    } else if (events.isNotEmpty) {
      items.add(const MatchEventItem(type: MatchEventType.halfTime, score: 'HT'));
    }
    if (p1.timeAdded != null && p1.timeAdded! > 0) {
      items.add(MatchEventItem(
        type: MatchEventType.addedTime,
        label: 'تم إضافة ${p1.timeAdded}+ دقائق',
      ));
    }

    // 4. First half events (descending / newest top)
    for (final e in firstHalfEvents.reversed) {
      items.add(e.toUIItem());
    }

    return items;
  }
}
