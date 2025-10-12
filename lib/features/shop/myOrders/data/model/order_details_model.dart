import '../../../address/data/model/address_model.dart';
import '../../../shoppingBag/confirmOrder/data/model/payment_methods_model.dart';
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
  final AddressModel? address;
  final PaymentMethodsModel? payMethod;

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
    required this.address,
    required this.payMethod,
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
          ProductOrderDetailsModel.fromJsonList(json['order_products'] ?? []),
      address: json['order_address'] == null
          ? null
          : AddressModel.fromJson(
              json['order_address'] as Map<String, dynamic>),
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
        deliveryDiscount: 0,
        total: 0,
        status: StatusModel.empty(),
        orderProducts: [],
        address: AddressModel.empty(),
        payMethod: PaymentMethodsModel.empty(),
      );
}
