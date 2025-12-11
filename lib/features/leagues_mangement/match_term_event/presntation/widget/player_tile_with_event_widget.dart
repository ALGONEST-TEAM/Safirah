import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../data/model/goal_model.dart';
import '../page/var_page.dart';
import '../state_mangement/riverpod.dart';
import 'event_button_widget.dart';
import 'player_event_handler.dart';

final activeVarPlayerProvider = StateProvider<int?>((ref) => null);
final matchTermStateProvider =
    StateProvider.family<bool, int>((ref, termId) => false);
final stopTermStateProvider =
    StateProvider.family<bool, int>((ref, termId) => false);

final selectedIncomingSubstitutePlayerProvider =
    StateProvider<({int playerId, int teamId})?>((ref) => null);

class PlayerTileWithEventWidget extends ConsumerWidget {
  final String name, handle, avatar;
  final int playerId, matchId, matchTermId;
  final int teamId;
  final bool isSubstitute;

  const PlayerTileWithEventWidget({
    super.key,
    required this.name,
    required this.handle,
    required this.avatar,
    required this.playerId,
    required this.matchId,
    required this.matchTermId,
    required this.isSubstitute,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final statsState =
        ref.watch(playerStatsProvider((matchId: matchId, playerId: playerId)));
    final stats = statsState.data;

    final goals = stats.goals;
    final assist = stats.assists;
    final yellow = stats.yellow;
    final red = stats.red;
    final isTermRunning = ref.watch(matchTermStateProvider(matchTermId));
    final stopTerm = ref.watch(stopTermStateProvider(matchTermId));
    final activeVarPlayerId = ref.watch(activeVarPlayerProvider);
    final notifier = ref.read(matchTermCounterProvider(matchId).notifier);

    final varEvent = ref.watch(currentVarEventProvider);
    final playerParticipationStatusState = ref.watch(
        getPlayerParticipationStatusProvider(
            (matchId: matchId, matchTermId: matchTermId, playerId: playerId)));
    final int? lastGoalId =
        (varEvent?.type == 'goal') ? (varEvent?.event as GoalModel).id : null;

    final selectedIncoming =
        ref.watch(selectedIncomingSubstitutePlayerProvider);

    final handler = PlayerEventHandler(
      isTermRunning: isTermRunning,
      stopTerm: stopTerm,
      yellowCount: yellow,
      redCount: red,
      playerId: playerId,
      matchId: matchId,
      matchTermId: matchTermId,
      teamId: teamId,
    );

    final isParticipating = playerParticipationStatusState.data == 'SUB_IN' ||
        playerParticipationStatusState.data == 'STARTER' ||
        (!isSubstitute && playerParticipationStatusState.data != 'SUB_OUT');

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
                  text: 'لاعب وهمي $playerId',
                  fontSize: 11.sp,
                ),
                AutoSizeTextWidget(
                  text: handle,
                  fontSize: 11.sp,
                  colorText: Colors.grey,
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
              iconPath: AppIcons.ball,
              color: AppColors.secondaryColor,
              count: assist,
              onPressed: (ctx, r) async {
                if (lastGoalId == null) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('لا يوجد هدف مرتبط لإضافة الأسيست'),
                    ),
                  );
                  return;
                }
                await handler.addAssist(ctx, r, goalId: lastGoalId);
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
            if (selectedIncoming != null && selectedIncoming.teamId == teamId)
              GestureDetector(
                onTap: () async {
                  await handler.substituteWith(
                    context,
                    ref,
                    incomingPlayerId: selectedIncoming.playerId,
                  );
                  ref
                      .read(selectedIncomingSubstitutePlayerProvider.notifier)
                      .state = null;
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
          ] else ...[
            GestureDetector(
              onTap: () async {
                ref
                    .read(selectedIncomingSubstitutePlayerProvider.notifier)
                    .state = (playerId: playerId, teamId: teamId);
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
          12.w.horizontalSpace,
          if (activeVarPlayerId == playerId)
            GestureDetector(
              onTap: () {
                final currentVar = ref.read(currentVarEventProvider);
                if (currentVar != null) {
                  notifier.stop(matchTermId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VarReviewPage(varEvent: currentVar),
                    ),
                  ).then((_) {
                    notifier.resume(matchTermId);
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
        ],
      ),
    );
  }
}
