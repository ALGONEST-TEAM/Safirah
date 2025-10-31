import 'package:dartz/dartz.dart';
import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../user/data/model/auth_model.dart';
import '../model/currency_model.dart';
import '../model/profile_data_model.dart';

class ProfileRemoteDataSource {
  Future<Unit> logout() async {
    await RemoteRequest.postData(
      path: AppURL.logout,
    );
    return Future.value(unit);
  }

  Future<ProfileDataModel> getProfileData() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getProfileData,
    );
    return ProfileDataModel.fromJson(response.data['data']);
  }

  Future<ProfileDataModel> editProfile({
    required String name,
    // required  String email,
    required String gender,
    required int cityId,
    DateTime? dateOfBirth,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.editProfile,
      data: {
        "name": name,
        // if (email.isNotEmpty) 'email': email,
        "gender": gender,
        "city_id": cityId,
        if (dateOfBirth != null) "date_of_birth": dateOfBirth.toIso8601String(),
      },
    );
    return ProfileDataModel.fromJson(response.data['data']);
  }

  Future<AuthModel> changePhoneNumber({
    required String phoneNumber,
    required String otp,
  }) async {
    final response =  await RemoteRequest.postData(
      path: AppURL.changePhoneNumber,
      data: {
        "phone_number": phoneNumber,
        if (otp.isNotEmpty) "otp": otp,
      },
    );
    return AuthModel.fromJson(response.data['data']);
  }

  Future<List<CurrencyModel>> getAllCurrencies() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllCurrencies,
    );
    return CurrencyModel.fromJsonList(response.data['data']);
  }

  Future<Unit> deleteAccount() async {
    await RemoteRequest.deleteData(
      path: AppURL.deleteAccount,
    );
    return Future.value(unit);
  }
}
