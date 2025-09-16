class PaymentMethodsModel {
  final int id;
  final String name;
  // final String? image;

  PaymentMethodsModel({
    required this.id,
    required this.name,
    // this.image,
  });

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      // image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'image': image,
    };
  }

  static PaymentMethodsModel empty() {
    return PaymentMethodsModel(
      id: 0,
      name: '',
      // image: '',
    );
  }
}