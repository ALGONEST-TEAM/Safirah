
class DiscountProductData {
  final int id;
  final int? productId;
  final String? productName;
  final dynamic price;
  final String? currency;
  final int? quantity;
  dynamic colorId;
  final String? colorName;
  final String? colorHex;
  final int? sizeId;
  final String? sizeName;
  final String? images;
  final String? originalPrice;
  final num? discountPerUnit;
  final num? totalDiscount;
  final num? finalPrice;

  DiscountProductData({
    required this.id,
    this.productId,
    this.productName,
    this.price,
    this.currency,
    this.quantity,
    this.colorId,
    this.colorName,
    this.colorHex,
    this.sizeId,
    this.sizeName,
    required this.images,
    this.discountPerUnit,
    this.finalPrice,
    this.originalPrice,
    this.totalDiscount
  });

  factory DiscountProductData.fromJson(Map<String, dynamic> json) {
    return DiscountProductData(
      id: json['id']??0,
      productId: json['product_id'] as int?,
      productName: json['product_name'] ?? '',
      price: json['product_price'] ,
      // currency: json['product_currency'] ?? '',
      quantity: json['quantity'] as int?,
      colorId: json['color_id'],
      colorName: json['color_name'] ?? '',
      colorHex: json['color_hex'] ?? '',
      sizeId: json['parent_measuring_id'] as int?,
      sizeName: json['measuring_value'] ?? '',
      images: json['image'] ?? "",
      discountPerUnit: json['discount_per_unit']??0,
      finalPrice: json['final_price']??0,
      originalPrice: json['original_price']??'',
      totalDiscount: json['total_discount']??0,
    );
  }

  static List<DiscountProductData> fromJsonList(List json) {
    return json.map((e) => DiscountProductData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'parent_measuring_id': sizeId,
      'color_id': colorId,
      'quantity': quantity,
      'price': price.toString(),
    };
  }

  DiscountProductData copyWith({
    int? id,
    int? productId,
    String? productName,
    int? price,
    String? currency,
    int? quantity,
    String? images,
    String? colorName,
    String? colorHex,
    int? colorId,
    int? sizeId,
    String? sizeName,
  }) {
    return DiscountProductData(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      colorName: colorName ?? this.colorName,
      colorHex: colorHex ?? this.colorHex,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      sizeName: sizeName ?? this.sizeName,
    );
  }

}
