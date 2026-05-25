import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/pay_spec.dart';
import '../../data/model/payment_request_context_model.dart';
import '../riverpod/payment_riverpod.dart';
import 'floosak_payment_otp_widget.dart';
import 'manual_payment_widget.dart';

class PayMethodWidget extends ConsumerStatefulWidget {
  final PaymentRequestContextModel paymentRequest;
  final void Function(BuildContext context, WidgetRef ref, String? purchaseId)?
      onPaymentSuccess;

  const PayMethodWidget({
    super.key,
    required this.paymentRequest,
    this.onPaymentSuccess,
  });

  @override
  ConsumerState<PayMethodWidget> createState() => _PayMethodWidgetState();
}

class _PayMethodWidgetState extends ConsumerState<PayMethodWidget> {
  final TextEditingController voucherController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int _amountValue(String value) => int.tryParse(value.trim()) ?? 0;

  String _formatDepositValue(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }

  @override
  void dispose() {
    voucherController.dispose();
    amountController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPayMethod = ref.watch(selectedPayMethodProvider);
    if (selectedPayMethod == null || selectedPayMethod.name.isEmpty) {
      return const SizedBox.shrink();
    }

    final isManual = isManualPayMethod(selectedPayMethod);
    if (isManual) {
      return ManualPaymentWidget(
        paymentMethod: selectedPayMethod,
        paymentRequest: widget.paymentRequest,
        onPaymentSuccess: widget.onPaymentSuccess,
      );
    }

    final spec = paySpecForPaymentMethod(selectedPayMethod);
    if (spec == null) return const SizedBox.shrink();

    final confirmState = ref.watch(confirmPaymentProvider);
    final floosakState = ref.watch(startFloosakPaymentProvider);
    final isFloosak = !isManual && isFloosakPayMethod(selectedPayMethod.name);
    final activeState = isFloosak ? floosakState : confirmState;
    final depositAmount = widget.paymentRequest.depositAmount;

    if (spec.requiresPhoneNumber && phoneNumberController.text.isEmpty) {
      phoneNumberController.text = widget.paymentRequest.initialPhoneNumber;
    }
    if (isFloosak && amountController.text.isEmpty && depositAmount > 0) {
      amountController.text = _formatDepositValue(depositAmount);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w)
          .copyWith(bottom: 12.h, top: 2.h),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: spec.instruction,
              fontSize: 11.sp,
              colorText: AppColors.mainColorFont,
              maxLines: 2,
              fontWeight: FontWeight.w400,
            ),
            12.h.verticalSpace,
            Visibility(
              visible: spec.requiresPhoneNumber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: S.of(context).phoneNumber,
                    fontSize: 10.4.sp,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w400,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: phoneNumberController,
                    type: TextInputType.phone,
                    maxLength: widget.paymentRequest.phoneMaxLength,
                    buildCounter: widget.paymentRequest.showPhoneCounter,
                    fillColor: AppColors.scaffoldColor,
                    hintText: S.of(context).enterPhoneNumber,
                    fieldValidator: (value) {
                      final phone = value?.trim() ?? '';
                      if (phone.isEmpty) {
                        return 'قم بإدخال رقم الهاتف';
                      }
                      return widget.paymentRequest.phoneValidator
                          ?.call(context, value);
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: spec.requiresAmount,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: S.of(context).amountLabel,
                    fontSize: 10.4.sp,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w400,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: amountController,
                    type: TextInputType.number,
                    fillColor: AppColors.scaffoldColor,
                    hintText: '0.0',
                    fieldValidator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return S.of(context).amountValidation;
                      }
                      final amount = double.tryParse(value.trim());
                      if (amount == null) {
                        return S.of(context).amountValidation;
                      }
                      if (isFloosak && amount < depositAmount) {
                        return widget.paymentRequest
                            .floosakMinimumAmountErrorText(context);
                      }
                      return null;
                    },
                  ),
                  if (isFloosak) ...[
                    6.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: widget.paymentRequest
                          .floosakMinimumAmountErrorText(context),
                      fontSize: 9.2.sp,
                      colorText: AppColors.greySwatch,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ],
                ],
              ),
            ),
            Visibility(
              visible: spec.requiresCodeField,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: spec.codeLabel,
                    fontSize: 10.4.sp,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w400,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: voucherController,
                    type: TextInputType.text,
                    fillColor: AppColors.scaffoldColor,
                    hintText: spec.codeHint,
                    fieldValidator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return spec.codeEmptyError;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            16.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: activeState,
              hasMessageSuccess: false,
              functionSuccess: () {
                if (isFloosak) {
                  showTitledBottomSheet(
                    context: context,
                    title: selectedPayMethod.title,
                    page: FloosakPaymentOtpWidget(
                      paymentRequest: widget.paymentRequest,
                      session: floosakState.data,
                      onPaymentSuccess: (context, ref, purchaseId) {
                        Navigator.of(context).pop();
                        widget.onPaymentSuccess
                            ?.call(context, ref, purchaseId);
                      },
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                widget.onPaymentSuccess?.call(context, ref, null);
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirmPayment,
                height: 40.h,
                textSize: 12.sp,
                isLoading: activeState.stateData == States.loading,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;

                  final amount = _amountValue(amountController.text);

                  FocusManager.instance.primaryFocus?.unfocus();
                  if (isFloosak) {
                    ref.read(startFloosakPaymentProvider.notifier).startPayment(
                          paymentRequest: widget.paymentRequest,
                          payMethodName: selectedPayMethod.name,
                          phoneNumber: phoneNumberController.text.trim(),
                          amount: amount,
                        );
                    return;
                  }

                  ref.read(confirmPaymentProvider.notifier).confirmPayment(
                        paymentRequest: widget.paymentRequest,
                        payMethodName: selectedPayMethod.name,
                        voucher: voucherController.text,
                        amount: amount,
                        phoneNumber: phoneNumberController.text,
                        purchaseId: null,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

