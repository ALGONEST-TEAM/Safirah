import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/all_players_of_league_widget.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/widget/player_tile_with_event_widget.dart';
import '../state_mangment/riverpod.dart';

class PlayersOfTeamWidget extends ConsumerWidget {
  const PlayersOfTeamWidget(
      {super.key, required this.teamSyncId, required this.teamName});

  final String teamSyncId;
  final String teamName;

  @override
  Widget build(BuildContext context, ref) {
    final playerOfTeam = ref.watch(playersOfTeamProvider(teamSyncId));
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: AutoSizeTextWidget(text: teamName, colorText: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
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
                      // playerSyncId: p.syncId??'',
                      // teamSyncId: teamSyncId,
                      // matchSyncId: '',
                      // matchTermSyncId: '',
                      // isSubstitute: false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
