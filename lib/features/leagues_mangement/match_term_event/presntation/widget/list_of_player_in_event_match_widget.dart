
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart';
import '../state_mangement/riverpod.dart';
import 'player_tile_with_event_widget.dart';

class ListOfPlayerInEventMatchWidget extends ConsumerStatefulWidget {
  const ListOfPlayerInEventMatchWidget({
    super.key,
    required this.teamId,
    required this.matchId,
    required this.termId,
  });

  final int teamId;
  final int matchId;
  final int termId;

  @override
  ConsumerState<ListOfPlayerInEventMatchWidget> createState() => _ListOfPlayerInEventMatchWidgetState();
}

class _ListOfPlayerInEventMatchWidgetState extends ConsumerState<ListOfPlayerInEventMatchWidget> {
  @override
  Widget build(BuildContext context) {
    final playerOfTeam = ref.watch(playersOfTeamProvider(widget.teamId));


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
      child: CheckStateInGetApiDataWidget(
        state: playerOfTeam,
        widgetOfData: Builder(
          builder: (_) {
            final players = playerOfTeam.data;

            // نقسم اللاعبين اعتماداً على حالة مشاركتهم في المباراة (داخل/خارج الملعب)
            final participating = <PlayerModel>[];
            final bench = <PlayerModel>[];

            for (final p in players) {

              final participationState = ref.watch(
                getPlayerParticipationStatusProvider((
                matchId: widget.matchId,
                matchTermId: widget.termId,
                playerId: p.id!,
                )),
              );

              final status = participationState.data; // null أو STARTER / SUB_IN / SUB_OUT

              // اللاعب مشارك إذا كان أساسي بدون مشاركة مسجلة بعد، أو حالته STARTER/SUB_IN
              final isParticipating =
                  status == 'STARTER' ||
                      status == 'SUB_IN' ||
                      (status == null && p.status == 'main');
              print('player=${p.id}, baseStatus=${p.status}, participationStatus=$status, isParticipating=$isParticipating');

              if (isParticipating) {
                participating.add(p);
              } else {
                bench.add(p);
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeTextWidget(text: 'اللعبين المشاركين'),
                8.h.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: participating.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final p = participating[i];
                    // إذا كان status == 'sub' لكنه مشارك، فهو احتياطي تم إشراكه
                    final isSub = p.status == 'sub';
                    return PlayerTileWithEventWidget(
                      name: p.fullName,
                      teamId: widget.teamId,
                      handle: '@playe' + p.id.toString(),
                      avatar: '',
                      playerId: p.id!,
                      matchId: widget.matchId,
                      matchTermId: widget.termId,
                      isSubstitute:isSub,
                    );
                  },
                ),

                const AutoSizeTextWidget(text: 'اللاعبين الاحتياط'),
                8.h.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bench.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final p = bench[i];
                    final isSub = p.status == 'sub';
                    return PlayerTileWithEventWidget(
                      name: p.fullName,
                      teamId: widget.teamId,

                      handle: '@playe' + p.id.toString(),
                      avatar: '',
                      playerId: p.id!,
                      matchId: widget.matchId,
                      matchTermId: widget.termId,
                      isSubstitute: isSub,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}