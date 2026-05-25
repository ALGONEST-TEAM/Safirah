import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/payment_remote_data_source.dart';
import '../model/floosak_payment_session_model.dart';
import '../model/payment_methods_model.dart';
import '../model/payment_request_context_model.dart';

class PaymentReposaitory {
  final PaymentRemoteDataSource paymentRemoteDataSource =
      PaymentRemoteDataSource();

  Future<Either<DioException, List<PaymentMethodsModel>>> getAllPaymentMethods() async {
    try {
      final remote = await paymentRemoteDataSource.getAllPaymentMethods();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> confirmPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
    String? purchaseId,
  }) async {
    try {
      final remote = await paymentRemoteDataSource.confirmPayment(
        paymentRequest: paymentRequest,
        payMethodName: payMethodName,
        voucher: voucher,
        amount: amount,
        phoneNumber: phoneNumber,
        purchaseId: purchaseId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, FloosakPaymentSessionModel>>
      startFloosakPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String phoneNumber,
    required int amount,
  }) async {
    try {
      final remote = await paymentRemoteDataSource.startFloosakPayment(
        paymentRequest: paymentRequest,
        payMethodName: payMethodName,
        phoneNumber: phoneNumber,
        amount: amount,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> confirmFloosakPayment({
    required PaymentRequestContextModel paymentRequest,
    required FloosakPaymentSessionModel session,
    required String otp,
  }) async {
    try {
      final remote = await paymentRemoteDataSource.confirmFloosakPayment(
        paymentRequest: paymentRequest,
        session: session,
        otp: otp,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}

