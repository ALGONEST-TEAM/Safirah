import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/team_tile_widget.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../page/players_of_team_widget.dart';
import '../page/team_editor_page.dart';
import '../state_mangment/riverpod.dart';

class AllTeamOfLeagueWidget extends ConsumerWidget {
  AllTeamOfLeagueWidget(
      {super.key, required this.leagueId, this.isNavToEditor=true});

  final int leagueId;
  bool? isNavToEditor ;

  @override
  Widget build(BuildContext context, ref) {
    final teamState = ref.watch(teamsProvider(leagueId));

    return CheckStateInGetApiDataWidget(
      state: teamState,
      widgetOfData: ListView.separated(
        itemCount: teamState.data.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, i) {
          final t = teamState.data[i];
          return TeamTileWidget(
            name: t.teamName,
            avatarUrl: t.logoUrl,
            onTap: () async {
              isNavToEditor!
                  ? navigateTo(
                      context,
                      TeamEditorPage(
                        leagueId: leagueId,
                        team: t,
                      ))
                  : navigateTo(
                      context,
                      PlayersOfTeamWidget(
                        teamId: t.id!,
                        teamName: t.teamName,
                      ));
            },
          );
        },
      ),
    );
  }
}
