import 'dart:io';
import 'package:dio/dio.dart';
import '../../../generated/l10n.dart';
import 'erorr_model.dart';

class MessageOfErorrApi {
  static List<String> getExeptionMessage(DioException exception) {
    // إذا فيه response من الباكند
    if (exception.response != null) {
      final data = exception.response?.data;

      if (data is Map && data.containsKey('message')) {
        final message = data['message'];
        if (message != null) {
          try {
            final error = ErrorsModel.fromJson(message);
            return [error.title.toString(), error.subTittle.toString()];
          } catch (_) {
            return [S.current.somethingWentWrong, S.current.pleaseTryAgain];
          }
        }
      }
    }

    // إذا ما فيه response من الباكند، أو الطلب ما وصل
    switch (exception.type) {
      case DioExceptionType.connectionError:
        if (exception.error is SocketException) {
          return [S.current.network, S.current.network2];
        }
        return [
          S.current.cannotReachServer,
          S.current.checkInternetOrServiceUrl
        ];

      case DioExceptionType.connectionTimeout:
        return [S.current.timeout, S.current.pleaseTryAgain];

      case DioExceptionType.receiveTimeout:
        return [S.current.receiveTimeout, S.current.receiveTimeout2];

      case DioExceptionType.sendTimeout:
        return [S.current.sendTimeout, S.current.sendTimeout2];

      case DioExceptionType.badCertificate:
        return [S.current.sslError, S.current.sslError2];

      case DioExceptionType.cancel:
        return [S.current.requestCancelled, S.current.requestCancelled2];

      case DioExceptionType.unknown:
        final err = exception.error;
        if (err is HandshakeException) {
          return [S.current.sslError, S.current.sslError2];
        }
        if (err is SocketException) {
          return [S.current.network, S.current.network2];
        }
        if (err is FormatException) {
          return [S.current.invalidApiUrl, S.current.invalidApiUrl2];
        }
        return [
          S.current.cannotReachServer,
          S.current.checkInternetOrServiceUrl
        ];

      case DioExceptionType.badResponse:
        final code = exception.response?.statusCode ?? -1;
        switch (code) {
          case 440:
            return [
              S.current.incorrectVerificationCode,
              S.current.incorrectVerificationCode2
            ];
          case 441:
            return [
              S.current.pleaseCheckThePhoneNumberOrEmail,
              S.current.pleaseTryAgain
            ];
          case 442:
            return [S.current.incorrectPassword, S.current.pleaseTryAgain];
          case 443:
            return [
              S.current.accountNotFound,
              S.current.pleaseVerifyTheAccount
            ];
          case 444:
            return [
              S.current.incorrectVerificationCode,
              S.current.incorrectVerificationCode2
            ];
          case 445:
            return [
              S.current.verificationCodeExpired,
              S.current.verificationCodeExpired2
            ];
          case 446:
            return [
              S.current.thePasswordDoesNotMeetTheConditions,
              S.current.pleaseTryAgain
            ];
          case 447:
            return [
              S.current.passwordIsSameUserPassword,
              S.current.pleaseTryAgain
            ];
          case 461:
            return [
              S.current.theProductIsAlreadyInTheCart,
              S.current.ifYouWantToModifyTheProductGoToTheShoppingBag
            ];
          case 472:
            return [
              S.current.userCannot,
              S.current.addMoreThanOneReviewOnOneProduct
            ];
          case 500:
            return [
              S.current.internalServerError,
              S.current.internalServerError2
            ];
          case 501:
            return [S.current.notImplemented, S.current.notImplemented2];
          case 502:
            return [S.current.badGateway, S.current.badGateway2];
          case 503:
            return [
              S.current.serviceUnavailable,
              S.current.serviceUnavailable2
            ];
          case 504:
            return [S.current.gatewayTimeout, S.current.gatewayTimeout2];
          case 505:
            return [
              S.current.httpVersionNotSupported,
              S.current.httpVersionNotSupported2
            ];
          default:
            return [S.current.somethingWentWrong, S.current.pleaseTryAgain];
        }
    }
  }
}
