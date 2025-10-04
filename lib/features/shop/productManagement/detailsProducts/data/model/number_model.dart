class NumberModel {
  final int? id;
  final String? number;
  final String? stock;

  NumberModel({
    this.id,
    this.number,
    this.stock,
  });

  factory NumberModel.fromJson(Map<String, dynamic> json) {
    return NumberModel(
      id: json['id'] ?? 0,
      number: json['number'] ?? "",
      stock: json['stock'] ?? "",
    );
  }

  static List<NumberModel> fromJsonNumbersList(List json) {
    return json.map((e) => NumberModel.fromJson(e)).toList();
  }

  factory NumberModel.empty() => NumberModel(
        id: 0,
        number: '',
        stock: '',
      );
}
