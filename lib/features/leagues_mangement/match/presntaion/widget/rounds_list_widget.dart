import 'package:flutter/material.dart';

import '../../data/model/round_model.dart';
import 'round_section_widget.dart';

class RoundsListWidget extends StatelessWidget {
  final List<RoundModel> rounds;
  final int leagueId;
  final String matchFilter;

  const RoundsListWidget(
      {super.key,
        required this.rounds,
        required this.leagueId,
        required this.matchFilter});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: rounds.length,
      itemBuilder: (context, roundIndex) {
        final round = rounds[roundIndex];
        return RoundSectionWidget(
          round: round,
          leagueId: leagueId,
          matchFilter: matchFilter,
        );
      },
    );
  }
}
