import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/presntation/widget/player_tile_with_event_widget.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/network/errors/app_exception_message.dart';
import '../../../../../core/state/state.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart'
    as team_player_riverpod;
import '../../data/model/assist_model.dart';
import '../../data/model/goal_model.dart';
import '../../data/model/warring_model.dart';
import '../page/var_page.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/presntation/state_mangement/riverpod.dart';

class PlayerEventHandler {
  final bool isTermRunning;
  final bool stopTerm;
  final int yellowCount;
  final int redCount;
  final String playerSyncId;
  final String matchSyncId;
  final String matchTermSyncId;
  final String teamSyncId;

  const PlayerEventHandler({
    required this.isTermRunning,
    required this.stopTerm,
    required this.yellowCount,
    required this.redCount,
    required this.playerSyncId,
    required this.matchSyncId,
    required this.matchTermSyncId,
    required this.teamSyncId,
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
      syncId: const Uuid().v7(),
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      goalTime: DateTime.now().minute,
      goalType: 'normal',
    );

    await ref.read(addGoalNotifierProvider(goal).notifier).run();
    final result = ref.read(addGoalNotifierProvider(goal));

    if (!context.mounted) return;

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        title: '',
        text: 'فشل في إضافة الهدف',
      );
      return;
    }

    await ref
        .read(playerStatsProvider((matchSyncId: matchSyncId, playerSyncId: playerSyncId)).notifier)
        .load();
    if (!context.mounted) return;
    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'goal',
      event: result.data,
      playerId: 0,
      matchSyncId: matchSyncId,
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerSyncId;
    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة الهدف',
    );
  }

  Future<void> addYellowCard(BuildContext context, WidgetRef ref) async {
    if (!_canProceed(context)) return;

    final warning = WarningModel(
      syncId: const Uuid().v7(),
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      warningTime: DateTime.now().minute,
      warningType: 'yellow',
      reason: 'مخالفة بسيطة',
    );

    await ref.read(addWarningNotifierProvider(warning).notifier).run();
    final result = ref.read(addWarningNotifierProvider(warning));

    if (!context.mounted) return;

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        title: '',
        text: 'فشل في إضافة الإنذار الأصفر',
      );
      return;
    }

    await ref
        .read(playerStatsProvider((matchSyncId: matchSyncId, playerSyncId: playerSyncId)).notifier)
        .load();
    if (!context.mounted) return;

    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'warning',
      event: result.data,
      playerId: 0,
      matchSyncId: matchSyncId,
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerSyncId;

    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة إنذار أصفر',
    );
  }

  Future<void> addRedCard(BuildContext context, WidgetRef ref,
      {bool autoFromYellow = false}) async {
    if (!autoFromYellow && !_canProceed(context)) return;

    final warning = WarningModel(
      syncId: const Uuid().v7(),
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      warningTime: DateTime.now().minute,
      warningType: 'red',
      reason: autoFromYellow ? 'بطاقتين صفراوين' : 'سلوك غير رياضي',
    );

    await ref.read(addWarningNotifierProvider(warning).notifier).run();
    final result = ref.read(addWarningNotifierProvider(warning));

    if (!context.mounted) return;

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        text: '',
        title: 'فشل في إضافة الإنذار الأحمر',
      );
      return;
    }

    await ref
        .read(playerStatsProvider((matchSyncId: matchSyncId, playerSyncId: playerSyncId)).notifier)
        .load();
    if (!context.mounted) return;

    ref.read(currentVarEventProvider.notifier).state = VarEvent(
      type: 'warning',
      event: result.data,
      playerId: 0,
      matchSyncId: matchSyncId,
    );
    ref.read(activeVarPlayerProvider.notifier).state = playerSyncId;

    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة إنذار أحمر',
    );
  }

  Future<void> addAssist(
    BuildContext context,
    WidgetRef ref, {
    required String goalSyncId,
  }) async {
    if (!_canProceed(context)) return;

    final assist = AssistModel(
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      goalSyncId: goalSyncId,
      assistTime: DateTime.now().minute,
    );

    final provider = addAssistNotifierProvider(assist);
    await ref.read(provider.notifier).run();
    final result = ref.read(provider);

    if (!context.mounted) return;

    if (result.stateData == States.error) {
      showFlashBarError(
        context: context,
        title: MessageOfError.get(result.exception as Object).first,
        text: MessageOfError.get(result.exception as Object).last,
      );
      return;
    }

    await ref
        .read(playerStatsProvider((matchSyncId: matchSyncId, playerSyncId: playerSyncId)).notifier)
        .load();
    if (!context.mounted) return;


    showFlashBarSuccess(
      context: context,
      message: 'تم إضافة الأسيست',
    );
  }

  Future<void> substituteWith(
    BuildContext context,
    WidgetRef ref, {
    required String incomingPlayerSyncId,
  }) async {
    if (!_canProceed(context)) return;

    final container = ProviderScope.containerOf(context, listen: false);
    final currentTimer = ref.read(matchTimerProvider);

    final subNotifier = ref.read(substitutePlayerNotifierProvider.notifier);
    subNotifier.setParams(
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
      outgoingPlayerSyncId: playerSyncId,
      incomingPlayerSyncId: incomingPlayerSyncId,
      substitutionMinute: currentTimer ~/ 60,
    );

    await subNotifier.run();

    container.invalidate(getPlayerParticipationStatusProvider((
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
      playerSyncId: playerSyncId,
    )));
    container.invalidate(getPlayerParticipationStatusProvider((
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
      playerSyncId: incomingPlayerSyncId,
    )));

    container.invalidate(team_player_riverpod.playersOfTeamStreamProvider(teamSyncId));

    await container
        .read(playerStatsProvider((matchSyncId: matchSyncId, playerSyncId: playerSyncId)).notifier)
        .load();

    if (!context.mounted) return;

    showFlashBarSuccess(
      context: context,
      message: 'تم التبديل بين اللاعبين',
    );
  }
}
