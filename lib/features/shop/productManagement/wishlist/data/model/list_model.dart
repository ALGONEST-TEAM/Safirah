class ListModel {
  final int id;
  final String name;
  final dynamic productCount;
  final List<String> image;

  ListModel({
    required this.id,
    required this.name,
    required this.productCount,
    required this.image,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'],
      name: json['name'] ?? '',
      productCount: json['product_count'] ?? 0,
      image: List<String>.from(json['product_images'] ?? []),
    );
  }

  static List<ListModel> fromJsonList(List json) {
    return json.map((e) => ListModel.fromJson(e)).toList();
  }
}
