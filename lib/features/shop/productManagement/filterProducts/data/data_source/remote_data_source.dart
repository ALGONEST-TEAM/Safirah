import '../../../../../../core/network/remote_request.dart';
import '../../../detailsProducts/data/model/paginated_products_list_data.dart';

class RemoteFilterDataSource {
  Future<PaginatedProductsList> getProductOfFilter({
    required int idCategory,
    List<int>? idSize,
    List<int>? idColor,
    int? idSubCategory,
    required int page,
    String? nameSearch,
    int? sortOption,
  }) async {
    final sizeQuery = (idSize != null && idSize.isNotEmpty)
        ? '&size=${idSize.join(',')}'
        : '';
    final colorQuery = (idColor != null && idColor.isNotEmpty)
        ? '&color=${idColor.join(',')}'
        : '';
    final checkIdCategory = idCategory == 1 ? null : idCategory;
    final String categoryQuery;
    if (idSubCategory != null) {
      categoryQuery = '&category_id=$idSubCategory';
    } else if (idSubCategory == null && checkIdCategory != null) {
      categoryQuery = '&category_id=$idCategory';
    } else {
      categoryQuery = '';
    }
    final searchQuery =
        (nameSearch != null && nameSearch != '') ? '&search=$nameSearch' : '';
    final sortOptionQuery = (sortOption != null) ? '&filter=${1}' : '';

    final url =
        "/product_filter/?page=$page&perPage=10$sizeQuery$colorQuery$categoryQuery$sortOptionQuery$searchQuery";

    final response = await RemoteRequest.getData(url: url);
    return PaginatedProductsList.fromJson(response.data);
  }
}
