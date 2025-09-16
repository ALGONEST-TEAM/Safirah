import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../model/reviews_model.dart';

class ReviewsRemoteDataSource {
  Future<ReviewsModel> getAllReviews({
    required int productId,
    required int page,
    int limit = 10,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getAllReviews}/$productId",
      query: {
        'page': page,
        'perPage': limit,
      },
    );
    print(response.data);
    return ReviewsModel.fromJson(response.data);
  }

  Future<Unit> addReviews(
    int orderId,
    int productId,
    dynamic colorId,
    int sizeId,
    String comment,
    double evaluation,
    int proportion,
    List<File> images,
  ) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry('order_id', orderId.toString()));
    formData.fields.add(MapEntry('product_id', productId.toString()));
    formData.fields.add(MapEntry('color_id', colorId.toString()));
    formData.fields.add(MapEntry('parent_measuring_id', sizeId.toString()));
    formData.fields.add(MapEntry('comment', comment));
    formData.fields.add(MapEntry('value', evaluation.toString()));
    formData.fields.add(MapEntry('proportion', proportion.toString()));

    for (var image in images) {
      formData.files
          .add(MapEntry('images[]', await MultipartFile.fromFile(image.path)));
    }

    await RemoteRequest.postData(
      path: AppURL.addReview,
      data: formData,
    );

    return Future.value(unit);
  }

  Future<Unit> addLike(int id) async {
    await RemoteRequest.getData(
      url: "${AppURL.addLike}/$id",
    );
    return Future.value(unit);
  }

  Future<Unit> dislike(int id) async {
    await RemoteRequest.getData(
      url: "${AppURL.dislike}/$id",
    );
    return Future.value(unit);
  }
}
