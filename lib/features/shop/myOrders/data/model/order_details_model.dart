import '../../../shoppingBag/confirmOrder/data/model/payment_methods_model.dart';
import 'product_order_details_model.dart';
import 'status_model.dart';

class OrderDetailsModel {
  final int id;
  final String trxId;
  final String date;
  final num productsTotal;
  final num deliveryTotal;
  final num discount;
  final num couponDiscount;
  final num totalPrinting;
  final num totalPayable;
  final StatusModel status;
  final List<ProductOrderDetailsModel> orderProducts;
  final String? address;
  final PaymentMethodsModel? payMethod;

  OrderDetailsModel({
    required this.id,
    required this.trxId,
    required this.date,
    required this.productsTotal,
    required this.deliveryTotal,
    required this.discount,
    required this.couponDiscount,
    required this.totalPrinting,
    required this.totalPayable,
    required this.status,
    required this.orderProducts,
    required this.address,
    required this.payMethod,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      trxId: json['trx_id'] ?? '',
      date: json['date'] ?? '',
      productsTotal: json['products_total'] ?? 0,
      deliveryTotal: json['delivery_total'] ?? 0,
      discount: json['discount'] ?? 0,
      couponDiscount: json['coupon_discount'] ?? 0,
      totalPrinting: json['total_printing'] ?? 0,
      totalPayable: json['total_payable'] ?? 0,
      status: StatusModel.fromJson(json['status']),
      orderProducts:
          ProductOrderDetailsModel.fromJsonList(json['order_products'] ?? []),
      address: json['order_address'] ?? '',
      payMethod: json['order_payment'] == null
          ? null
          : PaymentMethodsModel.fromJson(
              json['order_payment'] as Map<String, dynamic>),
    );
  }

  factory OrderDetailsModel.empty() => OrderDetailsModel(
        id: 0,
        trxId: '',
        date: '',
        productsTotal: 0,
        discount: 0,
        deliveryTotal: 0,
        totalPayable: 0,
        totalPrinting: 0,
        couponDiscount: 0,
        status: StatusModel.empty(),
        orderProducts: [],
        address: '',
        payMethod: PaymentMethodsModel.empty(),
      );
}
