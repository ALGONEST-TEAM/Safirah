import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../home/data/model/sections_and_offers_data.dart';
import '../../../home/data/model/section_with_product_data.dart';
import '../model/offer_products_model.dart';

class SectionsRemoteDataSource {
  SectionsRemoteDataSource();

  Future<SectionsAndOffersData> getAllSectionAndAllOffersData() async {
    final response = await RemoteRequest.getData(
      url: "/sections?page=1",
    );

    return SectionsAndOffersData.fromJson(response.data['data']);
  }

  Future<SectionAndProductData> getSectionData(
    int idSection,
    int page,
    int filterType,
  ) async {
    final response = await RemoteRequest.getData(
      url: "/sections/$idSection?page=$page&perPage=10&filter=$filterType",
    );
    return SectionAndProductData.fromJson(response.data['data']);
  }

  Future<OfferProductsModel> getOfferProducts(int offerId) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getOfferProducts}$offerId/products",
    );

    return OfferProductsModel.fromJson(response.data['data']);
  }
}
