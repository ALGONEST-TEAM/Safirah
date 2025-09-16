class DetailsProductData {
  final String? detailName;
  final String? detailValue;

  DetailsProductData({this.detailName, this.detailValue});

  factory DetailsProductData.fromJson(Map<String, dynamic> json) {
    return DetailsProductData(
      detailValue: json['detail_value'] ?? "",
      detailName: json['detail_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<DetailsProductData> fromJsonDetailsProductList(List json) {
    return json.map((e) => DetailsProductData.fromJson(e)).toList();
  }

  factory DetailsProductData.empty() => DetailsProductData(
    detailName: "",
    detailValue: "",
  );
}
