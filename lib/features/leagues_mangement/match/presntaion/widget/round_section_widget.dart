import 'package:flutter/material.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/round_model.dart';
import 'group_card_widget.dart';
import 'matches_schedule_widget.dart';

class RoundSectionWidget extends StatelessWidget {
  final RoundModel round;
  final int leagueId;
  final String matchFilter;

  const RoundSectionWidget(
      {super.key,
        required this.round,
        required this.leagueId,
        required this.matchFilter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AutoSizeTextWidget(text: round.roundName),
        ),
        ...round.groups.map<Widget>((groupWithMatches) {
          return groupWithMatches.matches.isEmpty
              ? const SizedBox()
              : GroupCardWidget(
            round: round,
            groupWithMatches: groupWithMatches,
            leagueId: leagueId,
            matchFilter: matchFilter,
          );
        }),
      ],
    );
  }
}
