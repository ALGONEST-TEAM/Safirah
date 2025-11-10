import 'package:dartz/dartz.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/auth_model.dart';

class UserRemoteDataSource {
  UserRemoteDataSource();

  Future<Unit> logIn(String phoneNumber) async {
    await RemoteRequest.postData(
      path: AppURL.logIn,
      data: {
        "login": phoneNumber,
      },
    );
    return Future.value(unit);
  }

  Future<AuthModel> signUp(
    String phoneNumber,
    String name,
    // String email,
    String gender,
    int cityId,
    DateTime? dateOfBirth,
    String fcmToken,
  ) async {
    final response = await RemoteRequest.postData(
      path: AppURL.signUp,
      data: {
        "phone": phoneNumber,
        "name": name,
        // if (email.isNotEmpty) 'email': email,
        "gender": gender,
        "city_id": cityId,
        if (dateOfBirth != null) "date_of_birth": dateOfBirth.toIso8601String(),
        "fcm_token": fcmToken,
      },
    );
    return AuthModel.fromJson(response.data['data']);
  }

  Future<AuthModel> checkOTP(
    String phoneNumber,
    String otp,
    String fcmToken,
  ) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkOtp,
      data: {
        "login": phoneNumber,
        "otp": otp,
        "fcm_token": fcmToken,
      },
    );
    return AuthModel.fromJson(response.data['data']);
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
}
