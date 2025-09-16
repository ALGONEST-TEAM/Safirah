import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/auth_model.dart';
import '../model/check_user_model.dart';

class UserReposaitory {
  UserReposaitory();

  Future<Either<DioException, CheckUserModel>> checkUser(
      String phoneNumberOrEmail) async {
    try {
      final remote = await UserRemoteDataSource().checkUser(phoneNumberOrEmail);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, AuthModel>> logInOrSignUp(
      String phoneNumberOrEmail, String password,String name) async {
    try {
      final remote = await UserRemoteDataSource()
          .logInOrSignUp(phoneNumberOrEmail, password,name);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, AuthModel>> checkOTP(
      String phoneNumberOrEmail, String otp) async {
    try {
      final remote =
          await UserRemoteDataSource().checkOTP(phoneNumberOrEmail, otp);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> resendOTP(
    String phoneNumberOrEmail,
  ) async {
    try {
      final remote = await UserRemoteDataSource().resendOTP(phoneNumberOrEmail);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> forgetPassword(
    String phoneNumberOrEmail,
  ) async {
    try {
      final remote =
          await UserRemoteDataSource().forgetPassword(phoneNumberOrEmail);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> resetPassword(
    String phoneNumberOrEmail,
    String password,
    String confirmPassword,
  ) async {
    try {
      final remote = await UserRemoteDataSource()
          .resetPassword(phoneNumberOrEmail, password, confirmPassword);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
