import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/auth_model.dart';

class UserReposaitory {
  final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSource();

  Future<Either<DioException, Unit>> logIn(
    String phoneNumber,
  ) async {
    try {
      final remote = await _userRemoteDataSource.logIn(phoneNumber);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, AuthModel>> signUp(
    String phoneNumber,
    String name,
    // String email,
    String gender,
    int cityId,
    DateTime? dateOfBirth,
    String fcmToken,
  ) async {
    try {
      final remote = await _userRemoteDataSource.signUp(
        phoneNumber,
        name,
        gender,
        cityId,
        dateOfBirth,
        fcmToken,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, AuthModel>> checkOTP(
    String phoneNumber,
    String otp,
    String fcmToken,
  ) async {
    try {
      final remote = await _userRemoteDataSource.checkOTP(
        phoneNumber,
        otp,
        fcmToken,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> resendOTP(
    String phoneNumberOrEmail,
  ) async {
    try {
      final remote = await _userRemoteDataSource.resendOTP(phoneNumberOrEmail);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
