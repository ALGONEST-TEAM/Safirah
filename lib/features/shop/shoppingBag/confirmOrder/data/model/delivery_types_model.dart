class DeliveryTypesModel {
  final int id;
  final String name;
  final String? costOfKilo;

  DeliveryTypesModel({
    required this.id,
    required this.name,
    this.costOfKilo,
  });

  factory DeliveryTypesModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTypesModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      costOfKilo: json['cost_of_kilo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cost_of_kilo': costOfKilo,
    };
  }

  static DeliveryTypesModel empty() {
    return DeliveryTypesModel(
      id: 0,
      name: "",
      costOfKilo: "",
    );
  }
}
