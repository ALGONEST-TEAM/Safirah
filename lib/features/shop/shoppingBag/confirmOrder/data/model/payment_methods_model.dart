class PaymentMethodsModel {
  final int id;
  final String name;
  final String title;

  // final String? image;

  PaymentMethodsModel({
    required this.id,
    required this.name,
    required this.title,

    // this.image,
  });

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      // image: json['image'] as String?,
    );
  }

  static List<PaymentMethodsModel> fromJsonPayList(List json) {
    return json.map((e) => PaymentMethodsModel.fromJson(e)).toList();
  }

  static PaymentMethodsModel empty() {
    return PaymentMethodsModel(
      id: 0,
      name: '',
      title: '',
      // image: '',
    );
  }
}
