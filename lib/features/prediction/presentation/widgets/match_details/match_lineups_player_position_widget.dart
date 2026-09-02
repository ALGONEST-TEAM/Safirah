import 'package:flutter/material.dart';

import '../../provider/match_details_providers.dart';
import 'match_lineups_player_on_pitch_widget.dart';

class MatchLineupsPlayerPositionWidget extends StatelessWidget {
  final TacticalPitchPlayerItem item;
  final double w;
  final double h;
  final double slotW;
  final bool isRtl;
  final bool showHomeTeam;
  final int index;

  const MatchLineupsPlayerPositionWidget({
    super.key,
    required this.item,
    required this.w,
    required this.h,
    required this.slotW,
    required this.isRtl,
    required this.showHomeTeam,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final fracX = item.getComputedFracX(isRtl);
    final screenY = h * item.fracY;
    final screenX = w * fracX;
    const double scale = 0.9;

    return AnimatedPositioned(
      key: ValueKey('player_slot_$index'),
      duration: const Duration(milliseconds: 460),
      curve: Curves.easeInOutCubic,
      left: screenX - (slotW / 2),
      top: screenY - 25,
      width: slotW,
      child: Transform.scale(
        scale: scale,
        child: MatchLineupsPlayerOnPitchWidget(
          player: item.player,
          showHomeTeam: showHomeTeam,
        ),
      ),
    );
  }
}
