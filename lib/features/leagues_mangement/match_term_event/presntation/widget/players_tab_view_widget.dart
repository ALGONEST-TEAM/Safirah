import 'package:flutter/material.dart';
import 'list_of_player_in_event_match_widget.dart';


class PlayersTabViewWidget extends StatelessWidget {
  final String homeTeamSyncId;
  final String awayTeamSyncId;
  final String matchSyncId;
  final String matchTermSyncId;

  const PlayersTabViewWidget({
    super.key,
    required this.homeTeamSyncId,
    required this.awayTeamSyncId,
    required this.matchSyncId,
    required this.matchTermSyncId,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: ListOfPlayerInEventMatchWidget(
            teamSyncId: homeTeamSyncId,
            matchSyncId: matchSyncId,
            matchTermSyncId: matchTermSyncId,
          ),
        ),
        SingleChildScrollView(
          child: ListOfPlayerInEventMatchWidget(
            teamSyncId: awayTeamSyncId,
            matchSyncId: matchSyncId,
            matchTermSyncId: matchTermSyncId,
          ),
        ),
      ],
    );
  }
}
