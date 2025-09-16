import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../category/data/model/category_and_product_data.dart';
import '../data_source/local _data_source.dart';
import '../data_source/remote_data_source.dart';
import '../model/search_data.dart';

class SearchRepository {
  SearchRepository();

  Future<void> saveSearchHistory(String item) async {
    await SearchLocalDataSource().saveSearchHistory(item);
  }

  Future<List<String>> getSearchHistory() async {
    return await SearchLocalDataSource().getSearchHistory();
  }

  Future<void> clearSearchHistory() async {
    await SearchLocalDataSource().clearSearchHistory();
  }

  Future<void> clearItemSearchHistory(String item) async {
    await SearchLocalDataSource().deleteSearchHistoryItem(item);
  }

  Future<Either<DioException, List<SearchData>>> getNamesOfInformationSearch(
      String charcterSearch) async {
    try {
      final data = await SearchRemoteDataSource()
          .getNameOfInformationSearch(charcterSearch);
      return Right(data);
    } on DioException catch (erorr) {
      return Left(erorr);
    }
  }

  Future<Either<DioException, CategoryAndProductData>> getSearchInformation(
      String nameSearch, int page) async {
    try {
      final data =
          await SearchRemoteDataSource().getSearchInformation(nameSearch, page);
      return Right(data);
    } on DioException catch (erorr) {
      return Left(erorr);
    }
  }
}
