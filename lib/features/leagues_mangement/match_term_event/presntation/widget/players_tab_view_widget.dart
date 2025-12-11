import 'package:flutter/material.dart';
import 'list_of_player_in_event_match_widget.dart';


class PlayersTabViewWidget extends StatelessWidget {
  final int homeTeamId;
  final int awayTeamId;
  final int matchId;
  final int termId;
  const PlayersTabViewWidget({
    super.key,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.matchId,
    required this.termId
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: ListOfPlayerInEventMatchWidget(
            teamId: homeTeamId,
            matchId: matchId, termId: termId,
          ),
        ),
        SingleChildScrollView(
          child: ListOfPlayerInEventMatchWidget(
            teamId: awayTeamId,
            matchId: matchId,
            termId: termId,
          ),
        ),
      ],
    );
  }
}
