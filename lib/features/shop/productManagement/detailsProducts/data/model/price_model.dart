class PriceData {
  final dynamic sizeTypeName;
  final dynamic price;
  final int? colorId;
  PriceData({this.sizeTypeName,this.price,this.colorId});

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
        sizeTypeName: json['measuring_value'] ??"",
        price: json['price'],
      colorId: json['color_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<PriceData> fromJsonPriceList(List json) {
    return json.map((e) => PriceData.fromJson(e)).toList();
  }

  factory PriceData.empty() => PriceData(
    sizeTypeName: "",
  );
}
