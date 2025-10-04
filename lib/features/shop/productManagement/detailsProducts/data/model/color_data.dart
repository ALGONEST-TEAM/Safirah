import 'package:hive/hive.dart';
import 'size_data.dart';

part 'color_data.g.dart';

@HiveType(typeId: 8)
class ColorOfProductData {
  final int? idColor;
  @HiveField(0)
  final String? colorName;
  @HiveField(1)
  final String? colorHex;
  @HiveField(2)
  final List<dynamic>? image;
  @HiveField(3)
  final int? isMain;
  final dynamic price;
  final List<SizeData>? sizeData;

  ColorOfProductData({
    this.idColor,
    this.colorHex,
    this.colorName,
    this.image,
    this.isMain,
    this.price,
    this.sizeData,
  });

  factory ColorOfProductData.fromJson(Map<String, dynamic> json) {
    return ColorOfProductData(
      idColor: json['id'] ?? 0,
      colorName: json['name'] ?? "",
      colorHex: json['hex_code'] ?? "",
      image: List<dynamic>.from(
          json['images']?.map((item) => item['image']) ?? []),
      isMain: json['is_main'] ?? 0,
      price: json['price'] ?? '',
      sizeData: SizeData.fromJsonSizeList(json['sizes'] ?? []),

    );
  }

  static List<ColorOfProductData> fromJsonColorList(List json) {
    return json.map((e) => ColorOfProductData.fromJson(e)).toList();
  }
}
