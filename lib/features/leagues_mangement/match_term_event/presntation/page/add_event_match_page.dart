import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../team_and_player/data/model/team_model.dart';
import '../../data/model/match_term_model.dart';
import '../state_mangement/riverpod.dart';
import '../widget/control_button_widget.dart';
import '../widget/match_app_bar_widget.dart';
import '../widget/players_tab_view_widget.dart';
import '../widget/team_tabs_widget.dart';

class AddEventMatchPage extends ConsumerStatefulWidget {
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final List<MatchTermModel> matchTerm;
  final String matchSyncId;
  final String roundSyncId;
  final String leagueSyncId;

  const AddEventMatchPage({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchTerm,
    required this.matchSyncId,
    required this.roundSyncId,
    required this.leagueSyncId,
  });

  @override
  ConsumerState<AddEventMatchPage> createState() => _AddEventMatchPageState();
}

class _AddEventMatchPageState extends ConsumerState<AddEventMatchPage> {
  @override
  Widget build(BuildContext context) {
    final currentTermState =
        ref.watch(getCurrentMatchTermProvider(widget.matchSyncId));

    final termId = currentTermState.data?.id ?? 0;
    final matchTermSyncId = currentTermState.data?.syncId ?? '';

    return Scaffold(
      appBar: MatchAppBarWidget(matchSyncId: widget.matchSyncId),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TeamTabsWidget(
              homeTeam: widget.homeTeam,
              awayTeam: widget.awayTeam,
            ),
            Expanded(
              child: PlayersTabViewWidget(
                homeTeamSyncId: widget.homeTeam.syncId,
                awayTeamSyncId: widget.awayTeam.syncId,
                matchSyncId: widget.matchSyncId,
                matchTermSyncId: matchTermSyncId,
              ),
            ),
            ControlButtonWidget(
              matchSyncId: widget.matchSyncId,
              leagueSyncId: widget.leagueSyncId,
              roundSyncId: widget.roundSyncId,
            ),
          ],
        ),
      ),
    );
  }
}
