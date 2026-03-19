import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/page/team_editor_page.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/all_players_of_league_widget.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../authorization/persntaion/widgets/authorization_gate_hide_if_denied.dart';
import '../state_mangment/riverpod.dart';

class PlayersOfTeamWidget extends ConsumerWidget {
  const PlayersOfTeamWidget(
      {super.key, required this.teamModel,required this.teamSyncId, required this.teamName,required this.leagueSyncId});

  final String leagueSyncId;
  final String teamSyncId;
  final String teamName;
  final TeamModel teamModel;
  @override
  Widget build(BuildContext context, ref) {
    final playerOfTeam = ref.watch(playersOfTeamProvider(teamSyncId));
    return Scaffold(
      appBar:SecondaryAppBarWidget(title: teamName,),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeTextWidget(text: 'لاعبين الفريق'),
              4.h.verticalSpace,
              CheckStateInGetApiDataWidget(
                state: playerOfTeam,
                widgetOfData: Expanded(
                  child: ListView.separated(
                    itemCount: playerOfTeam.data.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final p = playerOfTeam.data[i];
                      return PlayerTile(
                        name: p.fullName.toString(),
                        avatar: '',
                      );
                    },
                  ),
                ),
              ),
              AuthorizationGateHideIfDenied(
                leagueSyncId: leagueSyncId,
                permissionKey: 'league.edit',
                child: DefaultButtonWidget(
                  text: 'تعديل بيانات الفريق',
                  onPressed: () {
                   navigateTo(context, TeamEditorPage(
                     leagueSyncId: leagueSyncId,
                     team: teamModel,
                   ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
