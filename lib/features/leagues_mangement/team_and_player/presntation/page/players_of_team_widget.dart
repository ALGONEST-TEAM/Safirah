import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../match_term_event/presntation/widget/player_tile_with_event_widget.dart';
import '../state_mangment/riverpod.dart';

class PlayersOfTeamWidget extends ConsumerWidget {
  const PlayersOfTeamWidget(
      {super.key, required this.teamId, required this.teamName});

  final int teamId;
  final String teamName;

  @override
  Widget build(BuildContext context, ref) {
    final playerOfTeam = ref.watch(playersOfTeamProvider(teamId));
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
                    return PlayerTileWithEventWidget(
                        name: playerOfTeam.data[i].playerLeagueId.toString(),
                        handle: '@ldfxbn',
                        playerId: playerOfTeam.data[i].playerLeagueId!,
                        matchTermId: 1,
                        teamId: 0,
                        matchId: 1,
                        isSubstitute: false,
                        avatar: '');
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
