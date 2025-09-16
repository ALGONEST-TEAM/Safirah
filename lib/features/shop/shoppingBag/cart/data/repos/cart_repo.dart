import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/cart_remote_data_source.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';

class CartReposaitory {
  CartReposaitory();
  Future<Either<DioException, List<CartModel>>> getAllCart() async {
    try {
      final remote = await CartRemoteDataSource().getAllCart();
      return Right(remote);
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
  ) async {
    try {
      final remote = await CartRemoteDataSource().addToCart(
        prodectId,
        colorId,
        sizeId,
        price,
        quantity,
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
  ) async {
    try {
      final remote = await CartRemoteDataSource().updateCart(
        id,
        prodectId,
        colorId,
        sizeId,
        price,
        quantity,
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
      final remote = await CartRemoteDataSource().deleteAProductFromTheCart(id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
