class DeliveryTypesModel {
  final int id;
  final String name;
  final num cost;
  final bool scope;
  final String timeOfDelivery;
  final String image;

  DeliveryTypesModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.scope,
    required this.timeOfDelivery,
    required this.image,
  });

  factory DeliveryTypesModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTypesModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      cost: json['cost'] ?? 0,
      scope: json['scope'],
      timeOfDelivery: json['time_of_delivery'] ?? '',
      image: json['image_url'] ?? '',
    );
  }

  static List<DeliveryTypesModel> fromJsonDeliveryList(List json) {
    return json.map((e) => DeliveryTypesModel.fromJson(e)).toList();
  }

  static DeliveryTypesModel empty() {
    return DeliveryTypesModel(
      id: 0,
      name: "",
      cost: 0,
      scope: false,
      timeOfDelivery: '',
      image: '',
    );
  }
}
