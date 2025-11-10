import '../../../productManagement/detailsProducts/data/model/product_data.dart';
import 'offers_model.dart';

class OfferProductsModel {
  final OffersModel offer;
  final List<ProductData> products;

  OfferProductsModel({
    required this.offer,
    required this.products,
  });

  factory OfferProductsModel.fromJson(Map<String, dynamic> json) {
    return OfferProductsModel(
      offer: OffersModel.fromJson(json['banner']),
      products: ProductData.fromJsonProductList(json['products'] ?? []),
    );
  }

  factory OfferProductsModel.empty() {
    return OfferProductsModel(
      offer: OffersModel.empty(),
      products: [],
    );
  }
}
