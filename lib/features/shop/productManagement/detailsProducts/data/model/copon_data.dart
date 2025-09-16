class CoponData {
  final int? id;
  final String? discountType;
  final dynamic discount;
  final String? code;
  final dynamic minimumOrder;
  final dynamic basePrice;
  final dynamic discountPrice;

  final int? usageLimit;
  final String? expirationTime;
  final List<String>? categories;
  final List<String>? days;

  CoponData(
      {this.id,
      this.categories,
      this.discountType,
      this.expirationTime,
      this.discount,
      this.minimumOrder,
      this.usageLimit,
      this.days,
      this.code,
      this.basePrice,
      this.discountPrice});

  factory CoponData.fromJson(Map<String, dynamic> json) {
    return CoponData(
      id: json['id'] ?? 0,
      days: List<String>.from(json['days']?.map((item) => item['day']) ?? []),
      categories: List<String>.from(json['categories'] ?? []),
      discount: json['discount'],
      minimumOrder: json['minimum_order'],
      usageLimit: json['usage_limit'],
      expirationTime: json['expiration_time'],
      discountType: json['discount_type'],
      code: json['code'] ?? '',
      basePrice: json['base_price'],
      discountPrice: json['discounted_price'],

    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<CoponData> fromJsonCoponData(List<dynamic> json) {
    return json.map((e) => CoponData.fromJson(e)).toList();
  }

  factory CoponData.empty() => CoponData(
      usageLimit: 0,
      categories: [],
      id: 0,
      code: '',
      days: [],
      minimumOrder: 0,
      discountType: '',
      expirationTime: '',
      discount: 0);

// static final fakeProductData = List.filled(
// 4,
//     CoponData(
// )
}
