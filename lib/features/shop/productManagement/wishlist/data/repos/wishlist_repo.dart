import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../detailsProducts/data/model/product_data.dart';
import '../data_source/wishlist_remote_data_source.dart';
import '../model/list_model.dart';

class WishlistReposaitory {
  final WishlistRemoteDataSource _wishlistRemoteDataSource =
      WishlistRemoteDataSource();

  Future<Either<DioException, List<ProductData>>> getAllWishesProducts() async {
    try {
      final remote = await _wishlistRemoteDataSource.getAllWishesProducts();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> addWishlist(int productId) async {
    try {
      final remote = await _wishlistRemoteDataSource.addWishlist(productId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteWishlist(
    List<int> productsIds,
  ) async {
    try {
      final remote =
          await _wishlistRemoteDataSource.deleteWishlist(productsIds);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<ListModel>>> getAllList() async {
    try {
      final remote = await _wishlistRemoteDataSource.getAllList();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> createAnewListAndAddProducts(
    int listId,
    String listName,
    List<int> productsIds,
  ) async {
    try {
      final remote =
          await _wishlistRemoteDataSource.createAnewListAndAddProducts(
        listId,
        listName,
        productsIds,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> renameTheList(
    int listId,
    String listName,
  ) async {
    try {
      final remote =
          await _wishlistRemoteDataSource.renameTheList(listId, listName);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteList(int listId) async {
    try {
      final remote = await _wishlistRemoteDataSource.deleteList(listId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, List<ProductData>>> getProductsByList(
      int listId) async {
    try {
      final remote = await _wishlistRemoteDataSource.getProductsByList(listId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> deleteListProducts(
    int listId,
    List<int> productsIds,
  ) async {
    try {
      final remote = await _wishlistRemoteDataSource.deleteListProducts(
        listId,
        productsIds,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
