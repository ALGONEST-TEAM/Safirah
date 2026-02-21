import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/home_remote_data_source.dart';
import '../models/home_model.dart';
import '../models/news_item_model.dart';

class HomeReposaitory {
  final HomeRemoteDataSource _homeRemoteDataSource = HomeRemoteDataSource();

  Future<Either<DioException, HomeModel>> getAllItemsLeagueHome() async {
    try {
      final remote = await _homeRemoteDataSource.getAllItemsLeagueHome();
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, PaginationModel<NewsItemModel>>>
  getAllLatestNews(int page) async {
    try {
      final remote = await _homeRemoteDataSource.getAllLatestNews(page);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, NewsItemModel>> newsDetails({
    required int id,
  }) async {
    try {
      final remote = await _homeRemoteDataSource.newsDetails(id: id);
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
