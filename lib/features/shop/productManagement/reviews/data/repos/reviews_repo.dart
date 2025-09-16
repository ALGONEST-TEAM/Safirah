import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/reviews_remote_data_source.dart';
import '../model/reviews_model.dart';

class ReviewsReposaitory {
  final ReviewsRemoteDataSource _reviewsRemoteDataSource =
      ReviewsRemoteDataSource();

  Future<Either<DioException, ReviewsModel>> getAllReviews({
    required int productId,
    required int page,
  }) async {
    try {
      final remote = await _reviewsRemoteDataSource.getAllReviews(
          page: page, productId: productId);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> addReviews(
    int orderId,
    int productId,
    dynamic colorId,
    int sizeId,
    String comment,
    double evaluation,
    int proportion,
    List<File> images,
  ) async {
    try {
      final remote = await _reviewsRemoteDataSource.addReviews(
        orderId,
        productId,
        colorId,
        sizeId,
        comment,
        evaluation,
        proportion,
        images,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> addLike(
    int id,
  ) async {
    try {
      final remote = await _reviewsRemoteDataSource.addLike(id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> dislike(
    int id,
  ) async {
    try {
      final remote = await _reviewsRemoteDataSource.dislike(id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
