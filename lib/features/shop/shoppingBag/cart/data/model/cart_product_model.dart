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
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      colorId: json['color_id'],
      sizeId: json['parent_measuring_id'],
      sizeName: json['measuring_value'] ?? "",
      colorHex: json['color_hex'] ?? '',
      colorName: json['color_name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '',
    );
  }

  factory CartProductModel.empty() => CartProductModel(
        id: 0,
        productId: 0,
        quantity: 0,
        colorId: null,
        sizeId: 0,
        colorHex: '',
        colorName: '',
        sizeName: '',
        image: '',
        price: '',
      );
}
