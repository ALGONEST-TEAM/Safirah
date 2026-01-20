import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../generated/l10n.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/remote_exception.dart';
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
    print(state.stateData.toString());
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
            title: MessageOfErorrApi.getExeptionMessage(state.exception!).first,
            text: MessageOfErorrApi.getExeptionMessage(state.exception!).last,
          );
          state.stateData = States.initial;
        },
      );
    }
    return bottonWidget!;
  }
}

//
// class CheckStateInPostApiDataWidget extends StatefulWidget {
//   final Widget child;
//   final DataState state;
//   final VoidCallback? onSuccess;
//   final VoidCallback? onReset;          // نفّذ reset في الـ Notifier/Repo خارجياً
//   final String? successMessage;
//   final bool showSuccessMessage;
//
//   const CheckStateInPostApiDataWidget({
//     super.key,
//     required this.child,
//     required this.state,
//     this.onSuccess,
//     this.onReset,
//     this.successMessage,
//     this.showSuccessMessage = true,
//   });
//
//   @override
//   State<CheckStateInPostApiDataWidget> createState() => _CheckStateInPostApiDataWidgetState();
// }
//
// class _CheckStateInPostApiDataWidgetState extends State<CheckStateInPostApiDataWidget> {
//   States? _last;
//
//   @override
//   void didUpdateWidget(covariant CheckStateInPostApiDataWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     final current = widget.state.stateData;
//     if (_last == current) return;
//
//     if (current == States.loaded) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         if (widget.showSuccessMessage) {
//           showFlashBarSuccess(
//             context: context,
//             message: widget.successMessage ?? 'تم اكمال العملية بنجاح',
//           );
//         }
//         widget.onSuccess?.call();
//         widget.onReset?.call(); // لا نعدّل state هنا
//       });
//     } else if (current == States.error) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         final parts = MessageOfErorrApi.getExeptionMessage(widget.state.exception!);
//         showFlashBarError(context: context, title: parts.first, text: parts.last);
//         widget.onReset?.call();
//       });
//     }
//     _last = current;
//   }
//
//   @override
//   Widget build(BuildContext context) => widget.child;
// }
