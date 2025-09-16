import '../../../../../core/network/remote_request.dart';
import '../../../home/data/model/section_with_category_of_all_data.dart';
import '../../../home/data/model/section_with_product_data.dart';

class SectionsRemoteDataSource {
  SectionsRemoteDataSource();

  Future<SectionWithCategoryOfAllData> getAllSectionAndAllProductData() async {
    final response = await RemoteRequest.getData(
      url: "/sections?page=1",
    );

    return SectionWithCategoryOfAllData.fromJson(response.data);
  }

  Future<SectionAndProductData> getSectionData(
      int idSection, int page, int filterType) async {
    final response = await RemoteRequest.getData(
      url: "/sections/$idSection?page=$page&perPage=10&filter=$filterType",
    );

    return SectionAndProductData.fromJson(response.data);
  }
}
