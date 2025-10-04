import '../../../../../core/network/remote_request.dart';
import '../model/category_and_product_data.dart';

class CategoryRemoteDataSource {
  CategoryRemoteDataSource();

  Future<CategoryAndProductData> getMainCategoryAndAllProductData(
      int idCategory, int page) async {
    String id;
    idCategory == 0 ? id = '' : id = idCategory.toString();

    final response = await RemoteRequest.getData(
      url: "/categories/$id?page=$page&perPage=10&filter=1",
    );

    return CategoryAndProductData.fromJson(response.data['data']);
  }
}
