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
    required this.teamSyncId,
    required this.matchSyncId,
    required this.matchTermSyncId,
  });
  final String teamSyncId;
  final String matchSyncId;
  final String matchTermSyncId;

  @override
  ConsumerState<ListOfPlayerInEventMatchWidget> createState() =>
      _ListOfPlayerInEventMatchWidgetState();
}

class _ListOfPlayerInEventMatchWidgetState
    extends ConsumerState<ListOfPlayerInEventMatchWidget> {
  @override
  Widget build(BuildContext context) {
    final playerOfTeam = ref.watch(playersOfTeamProvider(widget.teamSyncId));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
      child: CheckStateInGetApiDataWidget(
        state: playerOfTeam,
        widgetOfData: Builder(
          builder: (_) {
            final matchTermSyncId = widget.matchTermSyncId;
            if (matchTermSyncId.isEmpty) {
              return const SizedBox.shrink();
            }

            final players = playerOfTeam.data;

            final participating = <PlayerModel>[];
            final bench = <PlayerModel>[];

            for (final p in players) {
              final playerSyncId = p.syncId;
              if (playerSyncId == null || playerSyncId.isEmpty) {
                // If player has no syncId, we can't query participation status.
                // Keep them out of the list to avoid invalid provider args.
                continue;
              }

              final participationState = ref.watch(
                getPlayerParticipationStatusProvider((
                  matchSyncId: widget.matchSyncId,
                  matchTermSyncId: matchTermSyncId,
                  playerSyncId: playerSyncId,
                )),
              );

              final status = participationState.asData?.value;

              final isParticipating = status == 'STARTER' ||
                  status == 'SUB_IN' ||
                  (status == null && p.status == 'main');

              if (isParticipating) {
                participating.add(p);
              } else {
                bench.add(p);
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeTextWidget(text: 'اللاعبين المشاركين'),
                8.h.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: participating.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final p = participating[i];
                    final isSub = p.status == 'sub';
                    return PlayerTileWithEventWidget(
                      name: p.fullName ?? '',
                      teamSyncId: widget.teamSyncId,
                      avatar: '',
                      playerSyncId: p.syncId ?? '',
                      matchSyncId: widget.matchSyncId,
                      matchTermSyncId: matchTermSyncId,
                      isSubstitute: isSub,
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
                      name: p.fullName ?? '',
                      teamSyncId: widget.teamSyncId,
                      avatar: '',
                      playerSyncId: p.syncId ?? '',
                      matchSyncId: widget.matchSyncId,
                      matchTermSyncId: matchTermSyncId,
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