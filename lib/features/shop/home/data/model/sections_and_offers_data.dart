import 'offers_model.dart';
import 'section_data.dart';

// part 'section_with_category_of_all_data.g.dart';

// @HiveType(typeId: 10)
class SectionsAndOffersData {
  // @HiveField(1)
  final List<SectionData>? section;

  // @HiveField(3)
  final List<OffersModel>? offers;

  // @HiveField(3)
  // final List<CategoryData>? category;
  // @HiveField(5)
  // final List<ProductData>? product;

  SectionsAndOffersData({
    // this.category,
    this.section,
    this.offers,
  });

  factory SectionsAndOffersData.fromJson(Map<String, dynamic> json) {
    return SectionsAndOffersData(
      // category: CategoryData.fromJsonCategoryList(json['categories'] ?? []),
      section: SectionData.fromJsonSectionList(json['sections'] ?? []),
      offers: OffersModel.fromJsonList(json['banners'] ?? []),

      // product: ProductData.fromJsonProductList(json['products']['data'] ?? []),
    );
  }



  static List<SectionsAndOffersData> fromJsonCategoryList(List json) {
    return json.map((e) => SectionsAndOffersData.fromJson(e)).toList();
  }

  factory SectionsAndOffersData.empty() => SectionsAndOffersData(
        section: [],
        offers: [],
      );
}
