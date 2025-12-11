import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/presntation/widget/player_tile_with_event_widget.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../data/model/goal_model.dart';
import '../../data/model/warring_model.dart';
import '../page/var_page.dart';
import '../state_mangement/riverpod.dart';

class VarReviewActionsWidget extends ConsumerWidget {
  const VarReviewActionsWidget({super.key,
    required this.varEvent,
    required this.isGoal,
    required this.isYellow,
    required this.isRed,
    required this.yellowCount,
    required this.playerId,
    required this.matchId,
  });

  final VarEvent varEvent;
  final bool isGoal;
  final bool isYellow;
  final bool isRed;
  final int yellowCount;
  final int playerId;
  final int matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: DefaultButtonWidget(
            text: 'تاكيد الحدث',
            background: AppColors.secondaryColor,
            onPressed: () {
              ref.read(activeVarPlayerProvider.notifier).state = null;
              ref.read(currentVarEventProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
        ),
        8.w.horizontalSpace,
        Expanded(
          child: DefaultButtonWidget(
            text: 'الغاء الحدث',
            background: AppColors.dangerColor,
            onPressed: () async {
              if (isGoal) {
                final goal = varEvent.event as GoalModel;

                await ref
                    .read(deleteGoalNotifierProvider(goal.id!).notifier)
                    .run();

                final deleteState =
                ref.read(deleteGoalNotifierProvider(goal.id!));
                if (deleteState.stateData == States.error) {
                  print('فشل في حذف الهدف');
                  return;
                }

                await ref
                    .read(playerStatsProvider(
                    (matchId: matchId, playerId: playerId))
                    .notifier)
                    .load();

                final int? assistPlayerId = deleteState.data;
                print('assist from delete goal: ${deleteState.data}');

                print(assistPlayerId);
                if (assistPlayerId != null) {
                  await ref
                      .read(
                    playerStatsProvider((
                    matchId: goal.matchId,
                    playerId: assistPlayerId,
                    )).notifier,
                  )
                      .load();
                }
              } else if (isYellow) {
                if (yellowCount == 2) {
                  final warning = varEvent.event as WarningModel;
                  await ref
                      .read(
                      deleteWarningNotifierProvider(warning.id! + 1)
                          .notifier)
                      .run();
                  await ref
                      .read(playerStatsProvider((
                  matchId: matchId, playerId: playerId))
                      .notifier)
                      .load();
                }

                final warning = varEvent.event as WarningModel;
                await ref
                    .read(deleteWarningNotifierProvider(warning.id!).notifier)
                    .run();
                await ref
                    .read(playerStatsProvider(
                    (matchId: matchId, playerId: playerId))
                    .notifier)
                    .load();
              } else if (isRed) {
                final warning = varEvent.event as WarningModel;
                await ref
                    .read(deleteWarningNotifierProvider(warning.id!).notifier)
                    .run();
                await ref
                    .read(playerStatsProvider(
                    (matchId: matchId, playerId: playerId))
                    .notifier)
                    .load();
                await ref
                    .read(playerStatsProvider(
                    (matchId: matchId, playerId: playerId))
                    .notifier)
                    .load();
              }

              ref.read(activeVarPlayerProvider.notifier).state = null;
              ref.read(currentVarEventProvider.notifier).state = null;

              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
