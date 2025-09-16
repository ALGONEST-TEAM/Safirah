import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/order_remote_data_source.dart';
import '../model/order_details_model.dart';
import '../model/order_model.dart';

class OrderReposaitory {
  final OrderRemoteDataSource _orderRemoteDataSource = OrderRemoteDataSource();

  Future<Either<DioException, OrdersModel>> getAllOrders({
    required int page,
  }) async {
    try {
      final remote = await _orderRemoteDataSource.getAllOrders(page: page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, OrderDetailsModel>> orderDetails({
    required int id,
  }) async {
    try {
      final remote = await _orderRemoteDataSource.orderDetails(id: id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
