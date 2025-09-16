class CityModel {
  final int id;
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
    );
  }

  static List<CityModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => CityModel.fromJson(e)).toList();
  }

  static CityModel empty() {
    return CityModel(id: 0,  name: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
