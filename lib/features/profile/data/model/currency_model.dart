class CurrencyModel {
  final int id;
  final String code;
  final String symbol;
  final String name;

  CurrencyModel({
    required this.id,
    required this.code,
    required this.symbol,
    required this.name,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      code: json['code'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
    );
  }

  static List<CurrencyModel> fromJsonList(List json) {
    return json.map((e) => CurrencyModel.fromJson(e)).toList();
  }
}
