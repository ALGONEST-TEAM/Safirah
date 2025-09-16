import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/confirm_order_remote_data_source.dart';
import '../model/check_copon_model.dart';
import '../model/confirm_order_data_model.dart';
import '../model/confirm_order_model.dart';
import '../model/discount_copon_data.dart';

class ConfirmOrderReposaitory {
  Future<Either<DioException, ConfirmOrderDataModel>>
      getConfirmOrderData() async {
    try {
      final remote = await ConfirmOrderRemoteDataSource().getConfirmOrderData();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, DiscountProductFromCoponModel>>
  checkCopon(CheckCoponModel checkCoponModel) async {
    try {
      final remote = await ConfirmOrderRemoteDataSource().checkCodeCopon(checkCoponModel);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> confirmOrder(
      {required ConfirmOrderModel confirmOrderModel}) async {
    try {
      final remote =
          await ConfirmOrderRemoteDataSource().confirmOrder(confirmOrderModel);
      return Right(remote);
    } on DioException catch (e) {
      print(e);
      return Left(e);
    }
  }
}
