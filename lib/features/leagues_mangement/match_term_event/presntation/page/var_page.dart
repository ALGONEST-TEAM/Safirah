import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/warring_model.dart';
import '../state_mangement/riverpod.dart';
import '../widget/var_review_actions_widget.dart';
import '../widget/var_review_app_bar_page.dart';
import '../widget/var_review_description_widget.dart';
import '../widget/var_review_header_widget.dart';

class VarEvent {
  final String type;
  final dynamic event;
  final int playerId;
  final int matchId;

  VarEvent({
    required this.type,
    required this.event,
    required this.playerId,
    required this.matchId,
  });
}

final currentVarEventProvider = StateProvider<VarEvent?>((ref) => null);

class VarReviewPage extends ConsumerWidget {
  const VarReviewPage({super.key, required this.varEvent});

  final VarEvent varEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGoal = varEvent.type == 'goal';
    final isYellow = varEvent.type == 'warning' &&
        (varEvent.event as WarningModel).warningType == 'yellow';
    final isRed = varEvent.type == 'warning' &&
        (varEvent.event as WarningModel).warningType == 'red';

    final int playerId = varEvent.playerId;
    final int matchId = varEvent.matchId;

    final statsState =
        ref.watch(playerStatsProvider((matchId: matchId, playerId: playerId)));
    final yellowCount = statsState.data.yellow;

    return Scaffold(
      appBar: const VarReviewAppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VarReviewHeaderWidget(
              isGoal: isGoal,
              isYellow: isYellow,
              isRed: isRed,
            ),
            15.h.verticalSpace,
            const VarReviewDescriptionWidget(),
            20.h.verticalSpace,
            VarReviewActionsWidget(
              varEvent: varEvent,
              isGoal: isGoal,
              isYellow: isYellow,
              isRed: isRed,
              yellowCount: yellowCount,
              playerId: playerId,
              matchId: matchId,
            ),
          ],
        ),
      ),
    );
  }
}




