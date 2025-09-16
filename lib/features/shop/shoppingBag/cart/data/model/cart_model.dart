import 'cart_product_model.dart';

class CartModel {
  final int id;
  final int? productId;
  final String? productName;
  final dynamic price;
  int? quantity;
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
  final bool? hasCopon;

  CartModel(
      {required this.id,
      this.productId,
      this.productName,
      this.price,
      this.quantity,
      this.colorId,
      this.colorName,
      this.colorHex,
      this.sizeId,
      this.sizeName,
      required this.images,
      this.hasCopon,
      this.originalPrice,
      this.finalPrice,
      this.totalDiscount,
      this.discountPerUnit});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] as int?,
      productName: json['product_name'] ?? '',
      price: json['product_price'],
      quantity: json['quantity'] as int?,
      colorId: json['color_id'],
      colorName: json['color_name'] ?? '',
      colorHex: json['color_hex'] ?? '',
      sizeId: json['parent_measuring_id'] as int?,
      sizeName: json['measuring_value'] ?? '',
      images: json['image'] ?? "",
      discountPerUnit: json['discount_per_unit'] ?? 0,
      finalPrice: json['final_price'] ?? 0,
      originalPrice: json['original_price'] ?? '',
      totalDiscount: json['total_discount'] ?? 0,
      hasCopon: json['has_coupon'] ?? false,
    );
  }

  factory CartModel.empty() => CartModel(
        id: 0,
        productId: 0,
        quantity: 0,
        colorId: null,
        sizeId: 0,
        colorHex: '',
        colorName: '',
        sizeName: '',
        price: '',
        images: '',
        discountPerUnit: 0,
        finalPrice: 0,
        hasCopon: false,
        originalPrice: '',
        productName: '',
        totalDiscount: 0,
      );

  static List<CartModel> fromJsonList(List json) {
    return json.map((e) => CartModel.fromJson(e)).toList();
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

  CartModel copyWith({
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
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      colorName: colorName ?? this.colorName,
      colorHex: colorHex ?? this.colorHex,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      sizeName: sizeName ?? this.sizeName,
    );
  }

  CartModel updateCartProduct(CartProductModel updatedProduct) {
    if (id == updatedProduct.id) {
      return CartModel(
        id: id,
        productId: productId,
        productName: productName,
        price: updatedProduct.price,
        quantity: updatedProduct.quantity,
        colorId: updatedProduct.colorId,
        colorName: updatedProduct.colorName,
        colorHex: updatedProduct.colorHex,
        sizeId: updatedProduct.sizeId,
        sizeName: updatedProduct.sizeName,
        images: updatedProduct.image,
      );
    }
    return this;
  }
}
