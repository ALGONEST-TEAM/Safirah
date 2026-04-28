import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../page/var_page.dart';
import '../state_mangement/riverpod.dart';
import 'event_button_widget.dart';
import 'player_event_handler.dart';

final activeVarPlayerProvider = StateProvider<String?>((ref) => null);
final matchTermStateProvider =
    StateProvider.family<bool, String>((ref, matchTermSyncId) => false);
final stopTermStateProvider =
    StateProvider.family<bool, String>((ref, matchTermSyncId) => false);

/// While selecting a substitution, we keep which player is chosen as incoming.
final selectedIncomingSubstitutePlayerProvider =
    StateProvider<({String playerSyncId, String teamSyncId})?>((ref) => null);

class PlayerTileWithEventWidget extends ConsumerWidget {
  final String name, avatar;
  final String matchSyncId;
  final String matchTermSyncId;
  final String playerSyncId;
  final String teamSyncId;
  final bool isSubstitute;

  const PlayerTileWithEventWidget({
    super.key,
    required this.name,
    required this.avatar,
    required this.playerSyncId,
    required this.matchSyncId,
    required this.matchTermSyncId,
    required this.isSubstitute,
    required this.teamSyncId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final statsState = ref.watch(
      playerStatsProvider(
          (matchSyncId: matchSyncId, playerSyncId: playerSyncId)),
    );
    final stats = statsState.data;

    final goals = stats.goals;
    final assist = stats.assists;
    final yellow = stats.yellow;
    final red = stats.red;

    final isTermRunning = ref.watch(matchTermStateProvider(matchTermSyncId));
    final stopTerm = ref.watch(stopTermStateProvider(matchTermSyncId));

    final notifier = ref.read(matchTermCounterProvider(matchSyncId).notifier);

    final playerParticipationStatusState = ref.watch(
      getPlayerParticipationStatusProvider((
        matchSyncId: matchSyncId,
        matchTermSyncId: matchTermSyncId,
        playerSyncId: playerSyncId,
      )),
    );

    final participation = playerParticipationStatusState.value;

    final handler = PlayerEventHandler(
      isTermRunning: isTermRunning,
      stopTerm: stopTerm,
      yellowCount: yellow,
      redCount: red,
      playerSyncId: playerSyncId,
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
      teamSyncId: teamSyncId,
    );

    final isParticipating = participation == 'SUB_IN' ||
        participation == 'STARTER' ||
        (!isSubstitute && participation != 'SUB_OUT');

    final selectedIncoming =
        ref.watch(selectedIncomingSubstitutePlayerProvider);

    // Used by assist button. We store last goal sync id on var state, so read it from current var event if present.
    final currentVar = ref.watch(currentVarEventProvider);
    final String? lastGoalSyncId = (currentVar?.type == 'goal')
        ? (currentVar!.event as dynamic).syncId as String?
        : null;

    final activeVarPlayerSyncId = ref.watch(activeVarPlayerProvider);

    final currentWarning = currentVar?.type == 'warning'
        ? currentVar?.event as dynamic
        : null;
    final currentWarningType = currentWarning?.warningType as String?;

    final bool shouldShowVarButton =
        activeVarPlayerSyncId == playerSyncId &&
            (currentVar?.type == 'goal' ||
                currentWarningType == 'yellow' ||
                currentWarningType == 'red');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: yellow >= 2 || red > 0 ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.secondaryColor.withAlpha(50),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              spacing: 2.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: ' $name',
                  fontSize: 11.sp,
                ),
              ],
            ),
          ),
          // Spacer()  ,
          if (isParticipating) ...[
            EventButtonWidget(
              iconPath: AppIcons.ball,
              color: Colors.black,
              count: goals,
              onPressed: (ctx, r) async {
                await handler.addGoal(ctx, r);
              },
            ),
            12.w.horizontalSpace,
            EventButtonWidget(
              iconPath: AppIcons.assist,



              color: AppColors.secondaryColor,
              count: assist,
              onPressed: (ctx, r) async {
                if (lastGoalSyncId == null) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('لا يوجد هدف مرتبط لإضافة الأسيست'),
                    ),
                  );
                  return;
                }
                await handler.addAssist(ctx, r, goalSyncId: lastGoalSyncId);
              },
            ),
            12.w.horizontalSpace,
            EventButtonWidget(
              iconPath: AppIcons.redWarring,
              color: Colors.yellow,
              count: yellow,
              onPressed: (ctx, r) async {
                await handler.addYellowCard(ctx, r);
              },
            ),
            12.w.horizontalSpace,
            EventButtonWidget(
              iconPath: AppIcons.redWarring,
              color: Colors.red,
              count: red,
              onPressed: (ctx, r) async {
                await handler.addRedCard(ctx, r);
              },
            ),
            12.w.horizontalSpace,
            if (selectedIncoming != null &&
                selectedIncoming.teamSyncId == teamSyncId)
              GestureDetector(
                onTap: () async {
                  final incomingPlayerSyncId = selectedIncoming.playerSyncId;
                  ref
                      .read(selectedIncomingSubstitutePlayerProvider.notifier)
                      .state = null;

                  await handler.substituteWith(
                    context,
                    ref,
                    incomingPlayerSyncId: incomingPlayerSyncId,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondaryColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: AutoSizeTextWidget(
                    text: 'تبديل مع هذا اللاعب',
                    fontSize: 11.sp,
                    colorText: AppColors.secondaryColor,
                  ),
                ),
              ),
            12.w.horizontalSpace,
            if (shouldShowVarButton)
              GestureDetector(
                onTap: () {
                  final currentVarEvent = ref.read(currentVarEventProvider);
                  if (currentVarEvent != null) {
                    notifier.stop(matchTermSyncId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VarReviewPage(varEvent: currentVarEvent),
                      ),
                    ).then((_) {
                      notifier.resume(matchTermSyncId);
                      ref.read(activeVarPlayerProvider.notifier).state = null;
                      ref.read(currentVarEventProvider.notifier).state = null;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondaryColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: AutoSizeTextWidget(
                    text: 'VAR',
                    fontSize: 11.sp,
                  ),
                ),
              ),
          ] else ...[
            GestureDetector(
              onTap: () async {
                ref
                        .read(selectedIncomingSubstitutePlayerProvider.notifier)
                        .state =
                    (playerSyncId: playerSyncId, teamSyncId: teamSyncId);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AutoSizeTextWidget(
                  text: 'استبدال',
                  fontSize: 11.sp,
                  colorText: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
