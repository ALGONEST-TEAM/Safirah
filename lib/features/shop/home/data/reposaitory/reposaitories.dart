import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../model/section_with_category_of_all_data.dart';
import '../model/section_with_product_data.dart';

class SectionReposaitory {
  SectionReposaitory();

  Future<Either<DioException, SectionWithCategoryOfAllData>>
      getAllSectionAndAllProductData() async {
    try {
      final data =
          await SectionsRemoteDataSource().getAllSectionAndAllProductData();
      return Right(data);
    } on DioException catch (error) {
      return Left(error);
    }
  }

  Future<Either<DioException, SectionAndProductData>> getSectionData(
      int idSection, int page, bool isRefresh, int filterType) async {
    try {
      if (isRefresh) {
        var data = await SectionsRemoteDataSource()
            .getSectionData(idSection, page, filterType);
        await SectionLocalDataSource().updateCacheWithPagination(
            imageBanner: data.imageBanner,
            section: data.sections!,
            products: data.product!,
            idSection: idSection,
            idFilter: filterType,
            pageNumber: page);
        return Right(data);
      } else {
        var cachedCategories = await SectionLocalDataSource()
            .getSectionFromCache(idSection, filterType, page);
        if (cachedCategories != null) {
          return Right(cachedCategories);
        } else {
          final data = await SectionsRemoteDataSource()
              .getSectionData(idSection, page, filterType);
          await SectionLocalDataSource().updateCacheWithPagination(
              section: data.sections!,
              products: data.product!,
              idSection: idSection,
              idFilter: filterType,
              imageBanner: data.imageBanner,
              pageNumber: page);
          return Right(data);
        }
      }
    } on DioException catch (error) {
      return Left(error);
    }
  }
}
