class SizeData {
  final dynamic sizeTypeName;
  final dynamic price;
  final int? id;
  SizeData({this.sizeTypeName,this.price,this.id});

  factory SizeData.fromJson(Map<String, dynamic> json) {
    return SizeData(
      sizeTypeName: json['measuring_value'] ??"",
      price: json['price'],
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<SizeData> fromJsonSizeList(List json) {
    return json.map((e) => SizeData.fromJson(e)).toList();
  }

  factory SizeData.empty() => SizeData(
        sizeTypeName: "",
      );
}
