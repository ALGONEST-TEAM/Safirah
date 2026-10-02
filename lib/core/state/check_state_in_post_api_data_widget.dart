import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../generated/l10n.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/app_exception_message.dart';
import '../state/state.dart';
import '../state/data_state.dart';

class CheckStateInPostApiDataWidget extends StatelessWidget {
  final Widget? bottonWidget;
  final DataState state;
  final Function? functionSuccess;
  final String? messageSuccess;
  final bool hasMessageSuccess;

  const CheckStateInPostApiDataWidget({
    super.key,
    required this.bottonWidget,
    required this.state,
    this.messageSuccess,
    this.hasMessageSuccess = true,
    this.functionSuccess,
  });

  @override
  Widget build(BuildContext context) {
    //print(state.stateData.toString());
    if (state.stateData == States.loaded) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        functionSuccess!();

        hasMessageSuccess
            ? showFlashBarSuccess(
                context: context,
                message: messageSuccess ?? S.of(context).successfully,
              )
            : const SizedBox.shrink();
        state.stateData = States.initial;
      });
    } else if (state.stateData == States.error) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          showFlashBarError(
            context: context,
            title: MessageOfError.get(state.exception as Object).first,
            text: MessageOfError.get(state.exception as Object).last,
          );
          state.stateData = States.initial;
        },
      );
    }
    return bottonWidget!;
  }
}
