import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/settings_remote_data_source.dart';
import '../model/currency_model.dart';

class SettingsReposaitory {
  final SettingsRemoteDataSource _settingsRemoteDataSource =
      SettingsRemoteDataSource();

  Future<Either<DioException, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final remote = await _settingsRemoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<CurrencyModel>>> getAllCurrencies() async {
    try {
      final remote = await _settingsRemoteDataSource.getAllCurrencies();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
