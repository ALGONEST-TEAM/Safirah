import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../group/data/model/model.dart';
import '../../data/model/round_model.dart';
import 'match_tile_widget.dart';
import 'matches_schedule_widget.dart';

class GroupCardWidget extends StatelessWidget {
  final GroupModel groupWithMatches;
  final int leagueId;
  final RoundModel round;
  final String matchFilter;

  const GroupCardWidget(
      {super.key,
        required this.groupWithMatches,
        required this.leagueId,
        required this.round,
        required this.matchFilter});

  String _groupHeaderDate() {
    if (matchFilter == 'unscheduled' || groupWithMatches.matches.isEmpty) {
      return '';
    }
    final dt = groupWithMatches.matches.first.matchDate;
    return DateFormat.yMMMMd('ar').format(dt!);
  }

  @override
  Widget build(BuildContext context) {
    final matches = groupWithMatches.matches;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeTextWidget(
              text: matches.isNotEmpty
                  ? "المجموعة ${groupWithMatches.groupName}   ${_groupHeaderDate()}"
                  : "",
            ),
          ),
          const Divider(height: 1, color: Color(0xffF2F0FB)),
          ...List.generate(matches.length, (i) {
            final match = matches[i];
            return Column(
              children: [
                MatchTileWidget(
                  roundId: round.id!,
                  match: match,
                  leagueId: leagueId,
                  matchFilter: matchFilter,
                ),
                if (i != matches.length - 1)
                  const Divider(height: 1, color: Color(0xffF2F0FB))
              ],
            );
          }),
        ],
      ),
    );
  }
}
