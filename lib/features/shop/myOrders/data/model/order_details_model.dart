import 'product_order_details_model.dart';
import 'status_model.dart';

class OrderDetailsModel {
  final int id;
  final String trxId;
  final String date;
  final dynamic productsTotal;
  final dynamic discount;
  final dynamic deliveryTotal;
  final dynamic deliveryDiscount;
  final dynamic total;
  final StatusModel status;
  final List<ProductOrderDetailsModel> orderProducts;

  OrderDetailsModel({
    required this.id,
    required this.trxId,
    required this.date,
    required this.productsTotal,
    required this.discount,
    required this.deliveryTotal,
    required this.deliveryDiscount,
    required this.status,
    required this.orderProducts,
    required this.total,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      trxId: json['trx_id'] ?? '',
      date: json['date'] ?? '',
      productsTotal: json['products_total'] ?? 0.0,
      discount: json['discount'] ?? 0,
      deliveryTotal: json['delivery_total'] ?? 0,
      deliveryDiscount: json['delivery_discount'] ?? 0,
      total: json['total'] ?? 0,
      status: StatusModel.fromJson(json['status']),
      orderProducts:
          ProductOrderDetailsModel.fromJsonList(json['order_products']),
    );
  }

  factory OrderDetailsModel.empty() => OrderDetailsModel(
      id: 0,
      trxId: '',
      date: '',
      productsTotal: 0,
      discount: 0,
      deliveryTotal: 0,
      deliveryDiscount: 0,
      total: 0,
      status: StatusModel.empty(),
      orderProducts: []);
}
