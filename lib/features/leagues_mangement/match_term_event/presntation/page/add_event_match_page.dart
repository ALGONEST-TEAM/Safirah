import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../team_and_player/data/model/team_model.dart';
import '../../data/model/match_term_model.dart';
import '../state_mangement/riverpod.dart';
import '../widget/control_button_widget.dart';
import '../widget/match_app_bar_widget.dart';
import '../widget/penalty_score_finish_widget.dart';
import '../widget/players_tab_view_widget.dart';
import '../widget/team_tabs_widget.dart';

bool shouldUsePenaltyShootoutOnlyLayout(MatchTermModel? currentTerm) {
  return currentTerm?.termType == 'penalty' &&
      currentTerm?.termName != 'انتهت المباراة';
}

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
    final matchState = ref.watch(getFullMatchDataProvider(widget.matchSyncId));

    final matchTermSyncId = currentTermState.data?.syncId ?? '';
    final currentTerm = currentTermState.data;
    final match = matchState.data;
    final isPenaltyTerm = shouldUsePenaltyShootoutOnlyLayout(currentTerm);

    return Scaffold(
      appBar: MatchAppBarWidget(matchSyncId: widget.matchSyncId),
      body: isPenaltyTerm
          ? SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight - 32),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: PenaltyScoreFinishWidget(
                            homeTeamName: widget.homeTeam.teamName,
                            awayTeamName: widget.awayTeam.teamName,
                            matchSyncId: widget.matchSyncId,
                            matchTermSyncId: matchTermSyncId,
                            initialHomePenaltyScore: match.homePenaltyScore,
                            initialAwayPenaltyScore: match.awayPenaltyScore,
                            isStandaloneScreen: true,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : DefaultTabController(
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
                      allowGoalEvents: true,
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
