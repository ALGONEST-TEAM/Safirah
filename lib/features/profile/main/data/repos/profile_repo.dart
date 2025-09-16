import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/profile_remote_data_source.dart';


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
}
