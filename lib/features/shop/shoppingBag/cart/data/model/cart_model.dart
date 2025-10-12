import 'cart_product_model.dart';

class CartModel {
  final int id;
  final int? productId;
  final String? productName;
  int? quantity;
  dynamic colorId;
  final String? colorName;
  final String? colorHex;
  final int? sizeId;
  final String? sizeName;
  final String? images;
  final dynamic price;
  final num? productPriceAfterDiscount;
  final num? discount;
  final num? couponDiscount;
  final int? numberId;
  final String? numberName;
  final int? productPrintingPrice;
  final int? printingPrice;
  final int? isPrintable;

  CartModel({
    required this.id,
    this.productId,
    this.productName,
    this.quantity,
    this.colorId,
    this.colorName,
    this.colorHex,
    this.sizeId,
    this.sizeName,
    required this.images,
    this.price,
    this.productPriceAfterDiscount,
    this.discount,
    this.couponDiscount,
    this.numberId,
    this.numberName,
    this.productPrintingPrice,
    this.printingPrice,
    this.isPrintable,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ??0,
      productId: json['product_id'] as int?,
      productName: json['product_name'] ?? '',
      quantity: json['quantity'] as int?,
      colorId: json['color_id'],
      colorName: json['color_name'] ?? '',
      colorHex: json['color_hex'] ?? '',
      sizeId: json['parent_measuring_id'] as int?,
      sizeName: json['measuring_value'] ?? '',
      images: json['image'] ?? "",
      price: json['product_price'],
      productPriceAfterDiscount: json['product_price_after_discount'],
      discount: json['discount'],
      couponDiscount: json['coupon_discount'] ?? 0,
      numberId: json['number_id'] as int?,
      numberName: json['number_name'] ?? "",
      productPrintingPrice: json['product_printing_price'],
      printingPrice: json['printing_price'],
      isPrintable: json['is_printable'],
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
        images: '',
        price: '',
        productPriceAfterDiscount: 0,
        discount: null,
        productName: '',
        numberId: null,
        isPrintable: 0,
        numberName: '',
        productPrintingPrice: 0,
        printingPrice: 0,
      );

  static List<CartModel> fromJsonList(List json) {
    return json.map((e) => CartModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson({String? printNote}) {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'image': images,
      'parent_measuring_id': sizeId,
      'color_id': colorId,
      if (numberId != null) 'number_id': numberId,
      'is_printable': isPrintable,
      'quantity': quantity,
      "print_note": (printNote ?? '').trim(),
    };
  }

  CartModel copyWith({
    int? id,
    int? productId,
    String? productName,
    int? quantity,
    String? images,
    int? price,
    num? productPriceAfterDiscount,
    num? discount,
    String? colorName,
    String? colorHex,
    int? colorId,
    int? sizeId,
    String? sizeName,
    int? numberId,
    String? numberName,
    int? isPrintable,
    int? productPrintingPrice,
    int? printingPrice,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      price: price ?? this.price,
      productPriceAfterDiscount:
          productPriceAfterDiscount ?? this.productPriceAfterDiscount,
      discount: discount ?? this.discount,
      colorName: colorName ?? this.colorName,
      colorHex: colorHex ?? this.colorHex,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      sizeName: sizeName ?? this.sizeName,
      numberId: numberId ?? this.numberId,
      numberName: numberName ?? this.numberName,
      isPrintable: isPrintable ?? this.isPrintable,
      productPrintingPrice: productPrintingPrice ?? this.productPrintingPrice,
      printingPrice: printingPrice ?? this.printingPrice,
    );
  }

  CartModel updateCartProduct(CartProductModel updatedProduct) {
    if (id == updatedProduct.id) {
      return CartModel(
        id: id,
        productId: productId,
        productName: productName,
        price: updatedProduct.price,
        productPriceAfterDiscount: updatedProduct.productPriceAfterDiscount,
        discount: updatedProduct.discount,
        quantity: updatedProduct.quantity,
        colorId: updatedProduct.colorId,
        colorName: updatedProduct.colorName,
        colorHex: updatedProduct.colorHex,
        sizeId: updatedProduct.sizeId,
        sizeName: updatedProduct.sizeName,
        images: updatedProduct.image,
        numberId: updatedProduct.numberId,
        numberName: updatedProduct.numberName,
        isPrintable: updatedProduct.isPrintable,
        productPrintingPrice: updatedProduct.productPrintingPrice,
        printingPrice: updatedProduct.printingPrice,
      );
    }
    return this;
  }
}
