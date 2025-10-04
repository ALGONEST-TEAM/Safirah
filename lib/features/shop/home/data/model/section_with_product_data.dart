import 'package:hive_flutter/adapters.dart';
import '../../../productManagement/detailsProducts/data/model/paginated_products_list_data.dart';
import 'section_data.dart';
part 'section_with_product_data.g.dart';

@HiveType(typeId: 0)
class SectionAndProductData {

  @HiveField(1)
  final List<SectionData>? sections;
  @HiveField(2)
  final PaginatedProductsList? product;
  // @HiveField(3)
  // final List<dynamic>? imageBanner;
  SectionAndProductData({
    this.sections,
    this.product,
    // this.imageBanner
  });

  factory SectionAndProductData.fromJson(Map<String, dynamic> json) {
    return SectionAndProductData(
      sections: SectionData.fromJsonSectionList(json['sections']??[]),
      product: PaginatedProductsList.fromJson(json['products']??PaginatedProductsList.empty()),
      // imageBanner: List<dynamic>.from(json['panner_images']?.map((item) => item['image']) ?? []),
    );
  }
  bool isValid() {
    return sections!.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {

    };
  }

  static List<SectionAndProductData> fromJsonSectionAndProductList(List json) {
    return json.map((e) => SectionAndProductData.fromJson(e)).toList();
  }

  factory SectionAndProductData.empty() => SectionAndProductData(
    sections: [],
    product: PaginatedProductsList.empty(),
  );

  SectionAndProductData copyWith({
    List<SectionData>? section,
    PaginatedProductsList? products,
    List<dynamic>? imagesBanner
  }) {
    return SectionAndProductData(

      product: products ?? product,
      sections: section ?? sections,
      // imageBanner: imagesBanner??imageBanner
    );
  }
}