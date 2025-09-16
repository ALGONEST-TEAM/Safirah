
import 'package:dartz/dartz.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../shop/shoppingBag/cart/data/data_source/cart_remote_data_source.dart';
import '../model/auth_model.dart';
import '../model/check_user_model.dart';

class UserRemoteDataSource {
  UserRemoteDataSource();
  Future<CheckUserModel> checkUser(String phoneNumberOrEmail) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkUser,
      data: {
        "login": phoneNumberOrEmail,
      },
    );
    return CheckUserModel.fromJson(response.data);
  }

  Future<AuthModel> logInOrSignUp(
      String phoneNumberOrEmail,
      String password,
      String name,
      ) async {
    // String? fcmToken = await PushNotificationService().getToken();
    final response = await RemoteRequest.postData(
      path: '/auth/login',
      fcmToken: fcmToken,
      data: {
        "login": phoneNumberOrEmail,
        "name": name,
        "password": password,
      },
    );
    return AuthModel.fromJson(response.data);
  }

  Future<AuthModel> checkOTP(String phoneNumberOrEmail, String otp) async {
    // String? fcmToken = await PushNotificationService().getToken();
    final response = await RemoteRequest.postData(
      path: AppURL.checkOtp,
      fcmToken: fcmToken,
      data: {
        "login": phoneNumberOrEmail,
        "otp": otp,
      },
    );
    return AuthModel.fromJson(response.data);
  }

  Future<Unit> resendOTP(String phoneNumberOrEmail) async {
    await RemoteRequest.postData(
      path: AppURL.resendOtp,
      data: {
        "login": phoneNumberOrEmail,
      },
    );
    return Future.value(unit);
  }

  Future<Unit> forgetPassword(String phoneNumberOrEmail) async {
    await RemoteRequest.postData(
      path:'/auth/forget_password',
      data: {
        "login": phoneNumberOrEmail,
      },
    );
    return Future.value(unit);
  }

  Future<Unit> resetPassword(
      String phoneNumberOrEmail,
      String password,
      String confirmPassword,
      ) async {
    await RemoteRequest.postData(
      path: '/auth/reset_password',
      data: {
        "login": phoneNumberOrEmail,
        "password": password,
        "password_confirmation": confirmPassword,
      },
    );
    return Future.value(unit);
  }
}
