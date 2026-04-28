import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/team_tile_widget.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../page/players_of_team_widget.dart';
import '../page/team_editor_page.dart';
import '../state_mangment/riverpod.dart';

class AllTeamOfLeagueWidget extends ConsumerStatefulWidget {
  AllTeamOfLeagueWidget(
      {super.key, required this.leagueSyncId, this.isNavToEditor = true});

  final String leagueSyncId;
  bool? isNavToEditor;

  @override
  ConsumerState<AllTeamOfLeagueWidget> createState() =>
      _AllTeamOfLeagueWidgetState();
}

class _AllTeamOfLeagueWidgetState extends ConsumerState<AllTeamOfLeagueWidget> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(teamsRefreshProvider(widget.leagueSyncId).notifier).refresh();
    });
  }
  @override
  Widget build(BuildContext context) {
    final teamState = ref.watch(teamsStreamProvider(widget.leagueSyncId));

    return CheckStateInStreamWidget<List<TeamModel>>(
      async: teamState,
      isEmpty: (team) => team.isEmpty,
      onRefresh: () => ref
          .read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier)
          .refresh(),
      keepPreviousDataWhileLoading: true,
      dataBuilder: (team) {
        return ListView.separated(
          itemCount: team.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (_, i) {
            final t = team[i];
            return TeamTileWidget(
              name: t.teamName,
              avatarUrl: t.logoUrl,
              onTap: () async {
                widget.isNavToEditor!
                    ? navigateTo(
                        context,
                        TeamEditorPage(
                          leagueSyncId: widget.leagueSyncId,
                          team: t,
                        ))
                    : navigateTo(
                        context,
                        PlayersOfTeamWidget(
                          teamSyncId: t.syncId!,
                          teamName: t.teamName,
                          leagueSyncId: widget.leagueSyncId,
                          teamModel: t,
                        ));
              },
            );
          },
        );
      },
    );
  }
}
