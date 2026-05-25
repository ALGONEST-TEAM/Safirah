import 'package:flutter/material.dart';

import '../../../shop/shoppingBag/confirmOrder/data/model/confirm_order_model.dart';

typedef PaymentTextBuilder = String Function(BuildContext context);
typedef PaymentPhoneValidator = String? Function(
  BuildContext context,
  String? value,
);
typedef PaymentPhoneMapper = String Function(String value);

String _defaultPaymentPhoneMapper(String value) => value.trim();

class PaymentRequestContextModel {
  final ConfirmOrderModel? confirmOrderModel;
  final Map<String, dynamic> extraRequestData;
  final double depositAmount;
  final String initialPhoneNumber;
  final int? phoneMaxLength;
  final bool showPhoneCounter;
  final PaymentPhoneValidator? phoneValidator;
  final PaymentPhoneMapper phoneNumberMapper;
  final PaymentPhoneMapper? floosakTargetPhoneMapper;
  final PaymentTextBuilder? floosakMinimumAmountErrorBuilder;

  PaymentRequestContextModel({
    this.confirmOrderModel,
    Map<String, dynamic>? extraRequestData,
    this.depositAmount = 0,
    this.initialPhoneNumber = '',
    this.phoneMaxLength,
    this.showPhoneCounter = false,
    this.phoneValidator,
    PaymentPhoneMapper? phoneNumberMapper,
    this.floosakTargetPhoneMapper,
    this.floosakMinimumAmountErrorBuilder,
  })  : extraRequestData = Map.unmodifiable(extraRequestData ?? const {}),
        phoneNumberMapper = phoneNumberMapper ?? _defaultPaymentPhoneMapper;

  Map<String, dynamic> get requestPayload {
    return {
      if (confirmOrderModel != null) ...confirmOrderModel!.toJson(),
      ...extraRequestData,
    };
  }

  String mapPhoneNumber(String value) {
    return phoneNumberMapper(value.trim());
  }

  String mapFloosakTargetPhone(String value) {
    final sanitized = value.trim();
    return (floosakTargetPhoneMapper ?? phoneNumberMapper)(sanitized);
  }

  String floosakMinimumAmountErrorText(BuildContext context) {
    return floosakMinimumAmountErrorBuilder?.call(context) ??
        'يجب أن يكون المبلغ المدخل مساويًا أو أكبر من مبلغ العربون';
  }
}

