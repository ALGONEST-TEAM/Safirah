import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/pay_spec.dart';
import '../../data/model/payment_request_context_model.dart';
import '../riverpod/payment_riverpod.dart';
import 'pay_method_widget.dart';

class PaymentActionButtonWidget extends ConsumerWidget {
  final PaymentRequestContextModel? paymentRequest;
  final PaymentRequestContextModel Function(BuildContext context, WidgetRef ref)?
      paymentRequestBuilder;
  final String buttonText;
  final double? height;
  final bool isLoading;
  final bool Function(BuildContext context, WidgetRef ref)? onBeforeOpen;
  final void Function(BuildContext context, WidgetRef ref, String? purchaseId)?
      onPaymentSuccess;

  const PaymentActionButtonWidget({
    super.key,
    this.paymentRequest,
    this.paymentRequestBuilder,
    required this.buttonText,
    this.height,
    this.isLoading = false,
    this.onBeforeOpen,
    this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultButtonWidget(
      text: buttonText,
      height: height,
      isLoading: isLoading,
      onPressed: () {
        if (onBeforeOpen?.call(context, ref) == false) {
          return;
        }

        final selectedPayMethod = ref.read(selectedPayMethodProvider);
        final paySpec = paySpecForPaymentMethod(selectedPayMethod);

        if (selectedPayMethod == null) {
          ref.read(selectedPayMethodErrorProvider.notifier).state =
              S.of(context).pleaseChoseAPaymentMethod;
          return;
        }

        ref.read(selectedPayMethodErrorProvider.notifier).state = null;

        final request = paymentRequest ?? paymentRequestBuilder?.call(context, ref);
        if (request == null) {
          return;
        }

        showTitledBottomSheet(
          context: context,
          title: paySpec?.requiresCodeField == false
              ? selectedPayMethod.title
              : (paySpec?.codeLabel.isNotEmpty == true
                  ? paySpec!.codeLabel
                  : selectedPayMethod.title),
          page: PayMethodWidget(
            paymentRequest: request,
            onPaymentSuccess: onPaymentSuccess,
          ),
        );
      },
    );
  }
}

