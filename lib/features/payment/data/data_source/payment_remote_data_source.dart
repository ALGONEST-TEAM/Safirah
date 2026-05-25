import 'package:dartz/dartz.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/floosak_payment_session_model.dart';
import '../model/pay_spec.dart';
import '../model/payment_methods_model.dart';
import '../model/payment_request_context_model.dart';

class PaymentRemoteDataSource {
  Future<List<PaymentMethodsModel>> getAllPaymentMethods() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllPaymentMethods,
    );
    final methods = PaymentMethodsModel.fromJsonList(
      response.data['data'],
    );

    return methods;
  }

  Future<Unit> confirmPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
    String? purchaseId,
  }) async {
    final normalizedMethodName = normalizePayMethodName(payMethodName);
    final requestMethodName = payMethodName.trim().toLowerCase();
    final isJawaliLikeMethod =
        isJawaliPayMethod(payMethodName) || isJaibPayMethod(payMethodName);
    final normalizedPhoneNumber = paymentRequest.mapPhoneNumber(phoneNumber);

    await RemoteRequest.postData(
      path: AppURL.confirmOrder,
      data: {
        ...paymentRequest.requestPayload,
        'payment_method_name': requestMethodName.isNotEmpty
            ? requestMethodName
            : normalizedMethodName,
        if (purchaseId != null && purchaseId.trim().isNotEmpty)
          'purchase_id': purchaseId.trim(),
        if (isJawaliLikeMethod) 'voucher': voucher,
        if (isJawaliLikeMethod) 'receiver_mobile': normalizedPhoneNumber,
        if (normalizedMethodName == 'kuraimi') 'pin_pass': voucher,
        if (normalizedMethodName == 'kuraimi') 'amount': amount,
      },
    );
    return Future.value(unit);
  }

  Future<FloosakPaymentSessionModel> startFloosakPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String phoneNumber,
    required int amount,
  }) async {
    final methodName = normalizePayMethodName(payMethodName);
    final normalizedPhoneNumber = paymentRequest.mapPhoneNumber(phoneNumber);
    final targetPhone = paymentRequest.mapFloosakTargetPhone(phoneNumber);

    final response = await RemoteRequest.postData(
      path: AppURL.startFloosakPayment,
      data: {
        'payment_method_name': methodName,
        'target_phone': targetPhone,
        'amount': amount,
      },
    );

    final data = response.data['data'];
    return FloosakPaymentSessionModel.fromJson(
      data is Map<String, dynamic> ? data : <String, dynamic>{},
      paymentMethodName: methodName,
      phoneNumber: normalizedPhoneNumber,
      amount: amount,
    );
  }

  Future<Unit> confirmFloosakPayment({
    required PaymentRequestContextModel paymentRequest,
    required FloosakPaymentSessionModel session,
    required String otp,
  }) async {
    await RemoteRequest.postData(
      path: AppURL.confirmFloosakPayment,
      data: {
        ...paymentRequest.requestPayload,
        'payment_method_name': normalizePayMethodName(session.paymentMethodName),
        'target_phone': session.phoneNumber,
        'amount': session.amount,
        'purchase_id': session.purchaseId,
        'otp': otp,
      },
    );
    return Future.value(unit);
  }
}

