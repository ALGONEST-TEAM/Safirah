import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../user/data/model/auth_model.dart';
import '../data_source/profile_remote_data_source.dart';
import '../model/currency_model.dart';
import '../model/profile_data_model.dart';

class ProfileReposaitory {
  final ProfileRemoteDataSource _profileRemoteDataSource =
      ProfileRemoteDataSource();

  Future<Either<DioException, Unit>> logout() async {
    try {
      final remote = await _profileRemoteDataSource.logout();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, ProfileDataModel>> getProfileData() async {
    try {
      final remote = await _profileRemoteDataSource.getProfileData();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, ProfileDataModel>> editProfile({
    required String name,
    // required  String email,
    required String gender,
    required int cityId,
    DateTime? dateOfBirth,
  }) async {
    try {
      final remote = await _profileRemoteDataSource.editProfile(
        name: name,
        gender: gender,
        cityId: cityId,
        dateOfBirth: dateOfBirth,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, AuthModel>> changePhoneNumber({
    required String phoneNumber,
    required String otp,

  }) async {
    try {
      final remote = await _profileRemoteDataSource.changePhoneNumber(
        phoneNumber: phoneNumber,
        otp: otp,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<CurrencyModel>>> getAllCurrencies() async {
    try {
      final remote = await _profileRemoteDataSource.getAllCurrencies();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteAccount() async {
    try {
      final remote = await _profileRemoteDataSource.deleteAccount();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
