class DistrictModel {
  final int id;
  final String name;
  final int? cityId;

  DistrictModel({
    required this.id,
    required this.name,
    this.cityId,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      cityId: (json['city_id'] as num?)?.toInt() ?? 0,
    );
  }

  static List<DistrictModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => DistrictModel.fromJson(e)).toList();
  }

  static DistrictModel empty() {
    return DistrictModel(
      id: 0,
      cityId: 0,
      name: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': name,
      'city_id': cityId,
    };
  }
}
