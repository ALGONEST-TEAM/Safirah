import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/presntation/widget/player_tile_with_event_widget.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/state/state.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart';
import '../../data/model/assist_model.dart';
import '../../data/model/goal_model.dart';
import '../../data/model/warring_model.dart';
import '../page/var_page.dart';
import '../state_mangement/riverpod.dart';

class PlayerEventHandler {
  final bool isTermRunning;
  final bool stopTerm;
  final int yellowCount;
  final int redCount;
  final int playerId;
  final int matchId;
  final int matchTermId;
  final int teamId;

  const PlayerEventHandler({
    required this.isTermRunning,
    required this.stopTerm,
    required this.yellowCount,
    required this.redCount,
    required this.playerId,
    required this.matchId,
    required this.matchTermId,
    required this.teamId,
  });

  bool _canProceed(BuildContext context) {
    if (!isTermRunning) {
      showFlashBarError(
        title: 'الشوط لم يبدا بعد',
        context: context,
        text: 'قم ببدء الشوط اولا لبدء الاحداث',
      );
      return false;
    }
    if (yellowCount >= 2 || redCount > 0) {
      showFlashBarError(
        title: 'لايمكن اضافة حدث لهذا اللاعب',
        context: context,
        text: 'اللاعب تم طرده لحصوله على كرت أحمر',
      );
      return false;
    }
    if (stopTerm) {
      showFlashBarError(
        title: 'المباراة متوقفة',
        context: context,
        text: 'قم باستئناف المباراة لإضافة حدث',
      );
      return false;
    }
    return true;
  }

  Future<void> addGoal(BuildContext context, WidgetRef ref) async {
    if (!_canProceed(context)) return;

    final goal = GoalModel(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      goalTime: DateTime.now().minute,
      goalType: 'normal',
    );

    await ref.read(addGoalNotifierProvider(goal).notifier).run();
    final result = ref.read(addGoalNotifierProvider(goal));

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        title: '',

        text: 'فشل في إضافة الهدف',
      );
      return;
    }

    await ref
        .read(playerStatsProvider((matchId: matchId, playerId: playerId)).notifier)
        .load();
    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'goal',
      event: result.data,
      playerId: playerId,
      matchId: matchId
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerId;

    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة الهدف',
    );
  }

  Future<void> addYellowCard(BuildContext context, WidgetRef ref) async {
    if (!_canProceed(context)) return;

    final warning = WarningModel(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      warningTime: DateTime.now().minute,
      warningType: 'yellow',
      reason: 'مخالفة بسيطة',
    );

    await ref.read(addWarningNotifierProvider(warning).notifier).run();
    final result = ref.read(addWarningNotifierProvider(warning));

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        title: '',
        text: 'فشل في إضافة الإنذار الأصفر',
      );
      return;
    }

   // ref.read(playerYellowCardsProvider(playerId).notifier).state++;
    await ref
        .read(playerStatsProvider((matchId: matchId, playerId: playerId)).notifier)
        .load();
    // إذا أصبحت بطاقتين → أحمر تلقائي
    if (yellowCount == 1) {
      await addRedCard(context, ref, autoFromYellow: true);
    }

    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'warning',
      event: result.data,
      playerId: playerId,
      matchId: matchId,
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerId;

    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة إنذار أصفر',
    );
  }

  Future<void> addRedCard(BuildContext context, WidgetRef ref,
      {bool autoFromYellow = false}) async {
    if (!autoFromYellow && !_canProceed(context)) return;

    final warning = WarningModel(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      warningTime: DateTime.now().minute,
      warningType: 'red',
      reason: autoFromYellow ? 'بطاقتين صفراوين' : 'سلوك غير رياضي',
    );

    await ref.read(addWarningNotifierProvider(warning).notifier).run();
    final result = ref.read(addWarningNotifierProvider(warning));

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        text: '',
        title: 'فشل في إضافة الإنذار الأحمر',
      );
      return;
    }
    await ref
        .read(playerStatsProvider((matchId: matchId, playerId: playerId)).notifier)
        .load();
  //  ref.read(playerRedCardsProvider(playerId).notifier).state++;
    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'warning',
      event: result.data,
      matchId: matchId,
      playerId: playerId,
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerId;

    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة إنذار أحمر',
    );
  }

    Future<void> addAssist(
      BuildContext context,
      WidgetRef ref, {
      required int goalId,
    }) async {
      if (!_canProceed(context)) return;

      final assist = AssistModel(
        matchId: matchId,
        playerId: playerId,
        matchTermId: matchTermId,
        goalId: goalId,
        assistTime: DateTime.now().minute,
      );

      await ref.read(addAssistNotifierProvider(assist).notifier).run();
      final result = ref.read(addAssistNotifierProvider(assist));

      if (result.stateData == States.error) {
        showFlashBarError(
          context: context,
          text: '',
          title: 'فشل في إضافة الأسيست',
        );
        return;
      }

      // ربط الأسيست بالـ VAR مثل الهدف
      await ref
          .read(playerStatsProvider((matchId: matchId, playerId: playerId)).notifier)
          .load();
      showFlashBarSuccess(
        context: context,
        message: 'تم إضافة الأسيست',
      );
    }

  Future<void> substituteWith(
    BuildContext context,
    WidgetRef ref, {
    required int incomingPlayerId,
  }) async {
    if (!_canProceed(context)) return;

    final currentTimer = ref.read(matchTimerProvider);

    // تنفيذ الاستبدال عبر الريبوبود
    final subNotifier = ref.read(substitutePlayerNotifierProvider.notifier);
    subNotifier.setParams(
      matchId: matchId,
      matchTermId: matchTermId,
      outgoingPlayerId: playerId,
      incomingPlayerId: incomingPlayerId,
      substitutionMinute: currentTimer ~/ 60,
    );

    await subNotifier.run();

    // بعد نجاح الاستبدال: تحديث حالة المشاركة للطرفين
    ref.invalidate(getPlayerParticipationStatusProvider((
      matchId: matchId,
      matchTermId: matchTermId,
      playerId: playerId,
    )));
    ref.invalidate(getPlayerParticipationStatusProvider((
      matchId: matchId,
      matchTermId: matchTermId,
      playerId: incomingPlayerId,
    )));

    // تحديث قائمة لاعبي الفريق (نفس teamId)
    ref.read(playersOfTeamProvider(teamId).notifier).load();

    // إعادة تحميل إحصائيات اللاعبين (اختياري لكن مفيد)
    await ref
        .read(playerStatsProvider((matchId: matchId, playerId: playerId)).notifier)
        .load();
    await ref
        .read(playerStatsProvider((matchId: matchId, playerId: incomingPlayerId)).notifier)
        .load();

    showFlashBarSuccess(
      context: context,
      message: 'تم التبديل بين اللاعبين',
    );
  }
}
