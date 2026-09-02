import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/model/match_lineups_model.dart';
import '../riverpod/match_lineups_riverpod.dart';

/// Represents a single player's computed coordinates on the pitch.
class TacticalPitchPlayerItem {
  final MatchLineupPlayerModel player;
  final double rawFracX;
  final double fracY;
  final int rowIndex;
  final int colIndex;
  final int rowTotal;

  const TacticalPitchPlayerItem({
    required this.player,
    required this.rawFracX,
    required this.fracY,
    required this.rowIndex,
    required this.colIndex,
    required this.rowTotal,
  });

  double getComputedFracX(bool isRtl) {
    return isRtl ? (1.0 - rawFracX) : rawFracX;
  }
}

/// Represents the entire computed tactical pitch state for rendering.
class TacticalPitchState {
  final List<List<MatchLineupPlayerModel>> groups;
  final List<TacticalPitchPlayerItem> positionedPlayers;
  final String formation;
  final String teamName;
  final bool isHome;

  const TacticalPitchState({
    required this.groups,
    required this.positionedPlayers,
    required this.formation,
    required this.teamName,
    required this.isHome,
  });

  factory TacticalPitchState.empty() {
    return const TacticalPitchState(
      groups: [],
      positionedPlayers: [],
      formation: '4-4-2',
      teamName: '',
      isHome: true,
    );
  }
}

/// Provider managing Home (true) vs Away (false) team toggle in lineups
final matchLineupTeamToggleProvider = StateNotifierProvider.family.autoDispose<
    MatchLineupTeamToggleNotifier, bool, int>(
  (ref, int matchId) => MatchLineupTeamToggleNotifier(),
);

class MatchLineupTeamToggleNotifier extends StateNotifier<bool> {
  MatchLineupTeamToggleNotifier() : super(true);

  void toggle(bool showHome) {
    state = showHome;
  }

  void switchTeam() {
    state = !state;
  }
}

/// Computes tactical groups, positions, and formations cleanly outside UI build()
final matchTacticalPitchProvider =
    Provider.family.autoDispose<TacticalPitchState, int>((ref, int matchId) {
  final lineupsState = ref.watch(matchLineupsProvider(matchId));
  final showHomeTeam = ref.watch(matchLineupTeamToggleProvider(matchId));

  final lineupsData = lineupsState.data;
  if (lineupsData == null) {
    return TacticalPitchState.empty();
  }

  final homeTeam = lineupsData.homeTeam ?? MatchLineupTeamModel.empty('home');
  final awayTeam = lineupsData.awayTeam ?? MatchLineupTeamModel.empty('away');
  final activeTeam = showHomeTeam ? homeTeam : awayTeam;

  final startingXI = activeTeam.starters;
  final formation = activeTeam.formation.isNotEmpty ? activeTeam.formation : '4-4-2';
  final teamName = activeTeam.name;

  final groups = _buildRowGroups(startingXI, formation);
  final positionedPlayers = _calculatePlayerPositions(groups);

  return TacticalPitchState(
    groups: groups,
    positionedPlayers: positionedPlayers,
    formation: formation,
    teamName: teamName,
    isHome: showHomeTeam,
  );
});

// ── Pure Tactical Calculation Functions ────────────────────────────────────────

List<List<MatchLineupPlayerModel>> _buildRowGroups(
  List<MatchLineupPlayerModel> startingXI,
  String formation,
) {
  final groups = <List<MatchLineupPlayerModel>>[];

  // 1. Find Goalkeeper
  final gk = startingXI.where((p) => p.shortPositionCategory == 'GK').toList();
  if (gk.isNotEmpty) {
    groups.add(gk);
  }

  // 2. Get outfield players
  final outfield = startingXI.where((p) => p.shortPositionCategory != 'GK').toList();

  // 3. Parse formation string (e.g. "4-2-3-1" or "4-1-4-1" or "4-4-2")
  final parts = formation.split('-');

  int currentIndex = 0;
  for (final part in parts) {
    final count = int.tryParse(part.trim()) ?? 0;
    if (count > 0 && currentIndex < outfield.length) {
      final take = (currentIndex + count <= outfield.length)
          ? count
          : (outfield.length - currentIndex);
      groups.add(outfield.sublist(currentIndex, currentIndex + take));
      currentIndex += take;
    }
  }

  // Leftovers if formation numbers sum to less than outfield
  if (currentIndex < outfield.length) {
    groups.add(outfield.sublist(currentIndex));
  }

  return groups;
}

double _centreX(int index, int total) {
  if (total == 1) return 0.5;

  double margin;
  if (total == 2) {
    margin = 0.35;
  } else if (total == 3) {
    margin = 0.18;
  } else if (total == 4) {
    margin = 0.14;
  } else {
    margin = 0.10;
  }

  return margin + (index / (total - 1)) * (1.0 - 2 * margin);
}

List<TacticalPitchPlayerItem> _calculatePlayerPositions(
  List<List<MatchLineupPlayerModel>> groups,
) {
  final n = groups.length;
  final rowYs = <double>[];
  if (n == 1) {
    rowYs.add(0.85);
  } else if (n == 2) {
    rowYs.addAll([0.85, 0.075]);
  } else if (n == 3) {
    rowYs.addAll([0.85, 0.46, 0.075]);
  } else if (n == 4) {
    rowYs.addAll([0.85, 0.60, 0.34, 0.075]);
  } else {
    // 5 rows (e.g. GK + 4-2-3-1 -> DF, DM, AM, FW)
    rowYs.addAll([0.85, 0.67, 0.47, 0.27, 0.075]);
  }

  final items = <TacticalPitchPlayerItem>[];
  for (int r = groups.length - 1; r >= 0; r--) {
    final rowGroup = groups[r];
    final totalInRow = rowGroup.length;
    final fracY = (r < rowYs.length) ? rowYs[r] : 0.5;

    for (int i = 0; i < totalInRow; i++) {
      final rawFracX = _centreX(i, totalInRow);
      items.add(TacticalPitchPlayerItem(
        player: rowGroup[i],
        rawFracX: rawFracX,
        fracY: fracY,
        rowIndex: r,
        colIndex: i,
        rowTotal: totalInRow,
      ));
    }
  }

  return items;
}
