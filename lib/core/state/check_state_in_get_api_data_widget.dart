import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/remote_exception.dart';
import '../state/state.dart';
import '../theme/app_colors.dart';
import '../widgets/error_widget.dart';
import 'data_state.dart';

class CheckStateInGetApiDataWidget extends StatelessWidget {
  final Widget? widgetOfData;
  final Widget? widgetOfLoading;
  final VoidCallback? refresh;
  final DataState state;
  final bool errorMessage;

  const CheckStateInGetApiDataWidget({
    super.key,
    required this.state,
    this.widgetOfData,
    this.widgetOfLoading,
    this.refresh,
    this.errorMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    print(state.stateData);

    if (state.stateData == States.loaded ||
        state.stateData == States.loadingMore) {
      return widgetOfData!;
    } else if (state.stateData == States.error) {
      if (errorMessage) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showFlashBarError(
            context: context,
            title: MessageOfErorrApi.getExeptionMessage(state.exception!).first,
            text: MessageOfErorrApi.getExeptionMessage(state.exception!).last,
          );
          state.stateData = States.initial;
        });
      } else {
        return Center(
          child: ErrorsWidget(
            title: MessageOfErorrApi.getExeptionMessage(state.exception!).first,
            subTitle: MessageOfErorrApi.getExeptionMessage(state.exception!).last,
            onPressed: refresh,
          ),
        );
      }
    } else if (state.stateData == States.loading) {
      return widgetOfLoading ??
          const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
    } else {
      return const SizedBox();
    }
    return const SizedBox();
  }
}
