class CartProductModel {
  final int id;
  final int productId;
  final int quantity;
  final dynamic colorId;
  final int sizeId;
  final String colorHex;
  final String colorName;
  final String sizeName;
  final String image;
  final dynamic price;
  final num? productPriceAfterDiscount;
  final num? discount;
  final int? numberId;
  final String? numberName;
  final int? isPrintable;
  final dynamic productPrintingPrice;
  final int printingPrice;

  CartProductModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.colorId,
    required this.sizeId,
    required this.colorHex,
    required this.colorName,
    required this.sizeName,
    required this.image,
    required this.price,
    required this.productPriceAfterDiscount,
    required this.discount,
    required this.numberId,
    required this.numberName,
    required this.isPrintable,
    required this.productPrintingPrice,
    required this.printingPrice,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: (json['id'] as num? ?? 0).toInt(),
      productId: (json['product_id'] as num? ?? 0).toInt(),
      quantity: (json['quantity'] as num? ?? 1).toInt(),
      colorId: json['color_id'],
      sizeId: (json['parent_measuring_id'] as num? ?? 0).toInt(),
      sizeName: (json['measuring_value'] ?? '').toString(),
      colorHex: (json['color_hex'] ?? '').toString(),
      colorName: (json['color_name'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      price: json['price'] ,
      productPriceAfterDiscount: json['product_price_after_discount'] ,
      discount: json['discount'] ,
      numberId: (json['number_id'] as num?)?.toInt(),
      numberName: (json['number_name'] ?? '').toString(),
      isPrintable: json['is_printable'],
      productPrintingPrice: json['product_printing_price'],
      printingPrice: json['printing_price'],
    );
  }

  factory CartProductModel.empty() => CartProductModel(
        id: 0,
        productId: 0,
        quantity: 0,
        colorId: 0,
        sizeId: 0,
        colorHex: '',
        colorName: '',
        sizeName: '',
        image: '',
        price: '',
        productPriceAfterDiscount: null,
        discount: null,
        isPrintable: 0,
        numberName: '',
        numberId: 0,
        productPrintingPrice: 0,
        printingPrice: 0,
      );
}
