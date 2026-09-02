import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/model/match_h2h_model.dart';
import '../riverpod/match_details_riverpod.dart';

class MatchH2hUIState {
  final int selectedFilterIndex;
  final List<MatchH2hFixtureItemModel> filteredFixtures;
  final MatchH2hTeamsModel? teams;
  final MatchH2hSummaryModel? summary;

  const MatchH2hUIState({
    required this.selectedFilterIndex,
    required this.filteredFixtures,
    this.teams,
    this.summary,
  });

  factory MatchH2hUIState.empty() {
    return const MatchH2hUIState(
      selectedFilterIndex: 1,
      filteredFixtures: [],
    );
  }
}

final matchH2hUIProvider = StateNotifierProvider.family.autoDispose<
    MatchH2hUINotifier, MatchH2hUIState, int>(
  (ref, int matchId) {
    final h2hState = ref.watch(matchH2HProvider(matchId));
    final notifier = MatchH2hUINotifier();
    if (h2hState.data != null) {
      notifier.updateFromData(h2hState.data!);
    }
    return notifier;
  },
);

class MatchH2hUINotifier extends StateNotifier<MatchH2hUIState> {
  MatchH2hUINotifier() : super(MatchH2hUIState.empty());

  int _selectedFilterIndex = 1; // 0: Home ground, 1: All (default), 2: Away ground
  MatchH2hModel? _lastData;

  void setFilterIndex(int index) {
    if (_selectedFilterIndex == index) return;
    _selectedFilterIndex = index;
    if (_lastData != null) {
      _recompute();
    }
  }

  void updateFromData(MatchH2hModel data) {
    _lastData = data;
    _recompute();
  }

  void _recompute() {
    if (_lastData == null) {
      state = MatchH2hUIState.empty();
      return;
    }

    final homeTeam = _lastData!.teams?.home;
    final awayTeam = _lastData!.teams?.away;
    final fixtures = _lastData!.fixtures;

    final mainHomeSportmonksId = homeTeam?.sportmonksId ?? homeTeam?.id;
    final mainAwaySportmonksId = awayTeam?.sportmonksId ?? awayTeam?.id;

    var filtered = fixtures;
    if (_selectedFilterIndex == 0 && mainHomeSportmonksId != null) {
      filtered = fixtures.where((f) {
        final fHomeId = f.homeTeam?.sportmonksId ?? f.homeTeam?.id;
        return fHomeId == mainHomeSportmonksId;
      }).toList();
    } else if (_selectedFilterIndex == 2 && mainAwaySportmonksId != null) {
      filtered = fixtures.where((f) {
        final fHomeId = f.homeTeam?.sportmonksId ?? f.homeTeam?.id;
        return fHomeId == mainAwaySportmonksId;
      }).toList();
    }

    state = MatchH2hUIState(
      selectedFilterIndex: _selectedFilterIndex,
      filteredFixtures: filtered,
      teams: _lastData!.teams,
      summary: _lastData!.summary,
    );
  }
}
