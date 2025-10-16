import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../detailsProducts/data/model/paginated_products_list_data.dart';
import '../data_source/remote_data_source.dart';

class FilterReposaitory {
  Future<Either<DioException, PaginatedProductsList>> getProductOfFilter(
      {List<int>? idSize,
      String? nameSearch,
      required int page,
      required int idCategory,
      int? sortOption,
      int? idSubCategory,
      var idColor}) async {
    try {
      final data = await RemoteFilterDataSource().getProductOfFilter(
        nameSearch: nameSearch,
        page: page,
        idSize: idSize,
        idCategory: idCategory,
        idColor: idColor,
        idSubCategory: idSubCategory,
        sortOption: sortOption,
      );
      return Right(data);
    } on DioException catch (erorr) {
      return Left(erorr);
    }
  }
}
