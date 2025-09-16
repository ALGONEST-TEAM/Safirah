class OrderProductModel {
  final int id;
  final String? name;
  final String? description;
  final String? image;
  final String? basePrice;
  final int? quantity;
  final int? total;

  OrderProductModel({
    required this.id,
    this.name,
    this.description,
    this.image,
    this.basePrice,
    this.quantity,
    this.total,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      basePrice: json['base_price'] ?? '',
      quantity: json['quantity'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
