class OrdersBillData {
  final num totalBeforeDiscount;
  final num productDiscount;
  final num couponDiscount;
  final num generalDiscount;
  final num totalDiscount;
  final num deliveryTotal;
  final num totalPayable;
  final num totalPrinting;

  const OrdersBillData({
    required this.totalBeforeDiscount,
    required this.productDiscount,
    required this.couponDiscount,
    required this.generalDiscount,
    required this.totalDiscount,
    required this.deliveryTotal,
    required this.totalPayable,
    required this.totalPrinting,
  });

  static const zero = OrdersBillData(
    totalBeforeDiscount: 0,
    productDiscount: 0,
    couponDiscount: 0,
    generalDiscount: 0,
    totalDiscount: 0,
    deliveryTotal: 0,
    totalPayable: 0,
    totalPrinting: 0,
  );

  factory OrdersBillData.empty() => zero;

  factory OrdersBillData.fromJson(Map<String, dynamic> json) {
    return OrdersBillData(
      totalBeforeDiscount: json['total_before_discount'] ?? 0,
      productDiscount: json['product_discount'] ?? 0,
      couponDiscount: json['coupon_discount'] ?? 0,
      generalDiscount: json['general_discount'] ?? 0,
      totalDiscount: json['total_discount'] ?? 0,
      deliveryTotal: json['delivery_total'] ?? 0,
      totalPayable: json['total_payable'] ?? 0,
      totalPrinting: json['total_printing'] ?? 0,
    );
  }
}
