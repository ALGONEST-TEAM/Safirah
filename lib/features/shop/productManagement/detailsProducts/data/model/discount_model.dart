import 'package:hive/hive.dart';
part 'discount_model.g.dart';

@HiveType(typeId: 11)

class DiscountModel {
  @HiveField(1)
  final String? discountType;
  @HiveField(2)
  final num? discount;
  @HiveField(3)
  final num? discountPrice;

  DiscountModel({this.discount, this.discountType, this.discountPrice});

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      discount: json['value'],
      discountType: json['type'],
      discountPrice: json['discounted_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<DiscountModel> fromJsonDiscountData(List<dynamic> json) {
    return json.map((e) => DiscountModel.fromJson(e)).toList();
  }

  factory DiscountModel.empty() => DiscountModel(discountType: '', discount: 0);

// static final fakeProductData = List.filled(
// 4,
//     CoponData(
// )
}
