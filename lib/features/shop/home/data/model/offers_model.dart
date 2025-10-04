class OffersModel {
  final int id;
  final String? title;
  final String image;

  OffersModel({
    required this.id,
    this.title,
    required this.image,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) {
    return OffersModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image_url'] ?? '',
    );
  }

  static List<OffersModel> fromJsonList(List json) {
    return json.map((e) => OffersModel.fromJson(e)).toList();
  }

  factory OffersModel.empty() {
    return OffersModel(
      id: 0,
      title: '',
      image: '',
    );
  }
}
