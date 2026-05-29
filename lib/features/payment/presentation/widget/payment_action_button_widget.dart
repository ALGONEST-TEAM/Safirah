import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';

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
    final state= ref.watch(confirmPaymentProvider);
    return CheckStateInPostApiDataWidget(
      state: state,
      functionSuccess: (){
        onPaymentSuccess
            ?.call(context, ref, '00000');
      },
      bottonWidget: DefaultButtonWidget(
        text: buttonText,
        height: height,
        isLoading: state.stateData==States.loading,
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

          if(selectedPayMethod.name=='cash_on_delivery'){
            ref.read(confirmPaymentProvider.notifier).confirmPayment(
              paymentRequest: request,
              payMethodName:selectedPayMethod.name,
              voucher: '',
              amount: 0,
              phoneNumber: '',
              purchaseId: '00000',
            );

          }
          else{
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
          }

        },
      ),
    );
  }
}

