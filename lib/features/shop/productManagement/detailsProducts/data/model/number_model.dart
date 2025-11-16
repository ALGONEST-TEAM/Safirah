class NumberModel {
  final int? id;
  final String? number;
  final String? stock;
  final bool? stockStatus;

  NumberModel({
    this.id,
    this.number,
    this.stock,
    this.stockStatus,
  });

  factory NumberModel.fromJson(Map<String, dynamic> json) {
    return NumberModel(
      id: json['id'] ?? 0,
      number: json['number'] ?? "",
      stock: json['stock'] ?? "",
      stockStatus: json['stock_status'] ?? true,
    );
  }

  static List<NumberModel> fromJsonNumbersList(List json) {
    return json.map((e) => NumberModel.fromJson(e)).toList();
  }

  factory NumberModel.empty() => NumberModel(
        id: 0,
        number: '',
        stock: '',
        stockStatus: true,
      );
}
