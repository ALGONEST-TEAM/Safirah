import 'package:hive/hive.dart';

import '../../../category/data/model/category_data.dart';
import '../../../productManagement/detailsProducts/data/model/product_data.dart';
import 'section_data.dart';
part 'section_with_category_of_all_data.g.dart';

@HiveType(typeId: 10)
class SectionWithCategoryOfAllData {

  @HiveField(1)
  final List<SectionData>? section;
  @HiveField(3)
  final List<CategoryData>? category;
  @HiveField(5)
  final List<ProductData>? product;

  SectionWithCategoryOfAllData({
    this.category,
    this.section,this.product
  });

  factory SectionWithCategoryOfAllData.fromJson(Map<String, dynamic> json) {
    return SectionWithCategoryOfAllData(
      category: CategoryData.fromJsonCategoryList(json['categories']??[] ),
      section: SectionData.fromJsonSectionList(json['sections']??[]),
      product: ProductData.fromJsonProductList(json['products']['data']??[]),


      // product: (json['products'] as List)
      //     .map((product) => ProductData.fromJson(product))
      //     .toList(),
      // category: (json['categories'] as List )
      //     .map((category) => CategoryData.fromJson(category))
      //     .toList(),
      //product: ProductData.fromJson(json[products]);
    );
  }

  Map<String, dynamic> toJson() {
    return {

    };
  }
  bool isValid() {
    return section!.isNotEmpty;  // التحقق أن هناك أقسام موجودة
  }
  static List<SectionWithCategoryOfAllData> fromJsonCategoryList(List json) {
    return json.map((e) => SectionWithCategoryOfAllData.fromJson(e)).toList();
  }

  factory SectionWithCategoryOfAllData.empty() => SectionWithCategoryOfAllData(
    category: [],
    section: [],
  );
// static final fakeSharesData = List.filled(
//     3,
//     ProductData(
//       walletId: 0,
//       name: "hh",
//       avgSellAmountShares:0.0,
//       avgPayAmountShares: 0.0,
//       companyId: 0,
//       id: 0,
//       numPayShares: "0",
//       numSellShares: "0",
//       userId: 0,
//       totalSaleProcess: 10,
//       totalBuyProcess: 10
//
//     ));
}
