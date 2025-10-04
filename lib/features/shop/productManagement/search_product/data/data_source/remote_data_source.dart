import '../../../../../../core/network/remote_request.dart';
import '../../../../category/data/model/category_and_product_data.dart';
import '../model/search_data.dart';

class SearchRemoteDataSource {
  SearchRemoteDataSource();

  Future<List<SearchData>> getNameOfInformationSearch(
      String charcterSearch) async {
    final response = await RemoteRequest.getData(
      url: "/categories_by_name?search=$charcterSearch",
    );

    return SearchData.fromJsonSearchList(response.data['data']);
  }

  Future<CategoryAndProductData> getSearchInformation(
      String nameSearch, int page) async {
    final response = await RemoteRequest.getData(
      url: "/categories_search?search=$nameSearch&page=$page&perPage=6",
    );
    return CategoryAndProductData.fromJson(response.data['data']);
  }
}
