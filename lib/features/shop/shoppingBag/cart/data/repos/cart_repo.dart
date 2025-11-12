import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/cart_remote_data_source.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';

class CartReposaitory {
  final _remote = CartRemoteDataSource();

  Future<Either<DioException, List<CartModel>>> getAllCart() async {
    try {
      final remote = await _remote.getAllCart();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, int>> getCartCount() async {
    try {
      final c = await _remote.getCartCount();
      return Right(c);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> addToCart(
    int prodectId,
    dynamic colorId,
    int sizeId,
    dynamic price,
    int quantity,
    int? numberId,
    int isPrintable,
  ) async {
    try {
      final remote = await _remote.addToCart(
        prodectId,
        colorId,
        sizeId,
        price,
        quantity,
        numberId,
        isPrintable,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, CartProductModel>> updateCart(
    int id,
    int prodectId,
    dynamic colorId,
    int sizeId,
    dynamic price,
    int quantity,
    int? numberId,
    int isPrintable,
  ) async {
    try {
      final remote = await _remote.updateCart(
        id,
        prodectId,
        colorId,
        sizeId,
        price,
        quantity,
        numberId,
        isPrintable,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteAProductFromTheCart(
    int id,
  ) async {
    try {
      final remote = await _remote.deleteAProductFromTheCart(id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
