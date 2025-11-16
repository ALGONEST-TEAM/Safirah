import 'number_model.dart';

class SizeData {
  final int? id;
  final dynamic sizeTypeName;
  final dynamic price;
  final bool? hasNumbers;
  final String? stock;
  final bool? stockStatus;
  final List<NumberModel>? numberData;

  SizeData({
    this.sizeTypeName,
    this.price,
    this.id,
    this.hasNumbers,
    this.stock,
    this.stockStatus,
    this.numberData,
  });

  factory SizeData.fromJson(Map<String, dynamic> json) {
    return SizeData(
      id: json['id'],
      sizeTypeName: json['measuring_value'] ?? "",
      price: json['price'] ?? 0,
      hasNumbers: json['has_children'] ?? false,
      stock: json['stock'] ?? "",
      stockStatus: json['stock_status'] ?? true,
      numberData:
          NumberModel.fromJsonNumbersList(json['cheldren_number'] ?? []),
    );
  }

  static List<SizeData> fromJsonSizeList(List json) {
    return json.map((e) => SizeData.fromJson(e)).toList();
  }

  factory SizeData.empty() => SizeData(
        id: 0,
        sizeTypeName: "",
        price: 0,
        hasNumbers: false,
        stock: '',
        stockStatus: true,
        numberData: <NumberModel>[],
      );
}
