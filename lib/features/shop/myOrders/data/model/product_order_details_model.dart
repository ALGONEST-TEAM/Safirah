class ProductOrderDetailsModel {
  final int id;
  final String? image;
  final String? name;
  final dynamic price;
  final int? hasCopon;
  final int? quantity;
  final int? colorId;
  final num? totalDiscountCopon;
  final num? totalAfterCoupon;
  final String? colorHex;
  final String? colorName;
  final int? sizeId;
  final String? sizeValue;

  ProductOrderDetailsModel({
    required this.id,
    this.image,
    this.name,
    this.quantity,
    this.colorHex,
    this.colorName,
    this.sizeValue,
    this.price,
    this.colorId,
    this.sizeId,
    this.hasCopon,
    this.totalDiscountCopon,
    this.totalAfterCoupon
  });

  factory ProductOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderDetailsModel(
      id: json['id'],
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ,
      quantity: json['quantity'] ?? 0,
      colorId: json['color_id'] ,
      colorHex: json['hex_code'] ?? '',
      colorName: json['color_name'] ?? '',
      sizeId: json['measuring_id'] as int?,
      sizeValue: json['measuring_value'] ?? '',
      hasCopon: json['has_coupon'],
      totalDiscountCopon: json['total_coupon_discount'],
      totalAfterCoupon: json['total_after_coupon']

    );
  }

  static List<ProductOrderDetailsModel> fromJsonList(List json) {
    return json.map((e) => ProductOrderDetailsModel.fromJson(e)).toList();
  }

  factory ProductOrderDetailsModel.empty() => ProductOrderDetailsModel(
        id: 0,
        image: '',
        name: '',
        quantity: 0,
        colorHex: '',
        colorName: '',
        sizeValue: '',
        price: 0,
        sizeId: 0,
        colorId: 0,
      );
}
