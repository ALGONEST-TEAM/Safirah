


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/address_remote_data_source.dart';
import '../model/address_model.dart';
import '../model/city_model.dart';
import '../model/district_model.dart';

class AddressReposaitory {
  AddressReposaitory();

  Future<Either<DioException, List<AddressModel>>> getAllAddresses() async {
    try {
      final remote = await AddressRemoteDataSource().getAllAddresses();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<CityModel>>> getCities() async {
    try {
      final remote = await AddressRemoteDataSource().getCities();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<DistrictModel>>> getDistricts() async {
    try {
      final remote = await AddressRemoteDataSource().getDistricts();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> addOrUpdateAddress({
    int? id,
    required AddressModel addressModel,
  }) async {
    try {
      final remote = await AddressRemoteDataSource().addOrUpdateAddress(
        id: id,
        addressModel: addressModel,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteAddress(int id) async {
    try {
      final remote = await AddressRemoteDataSource().deleteAddress(id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
