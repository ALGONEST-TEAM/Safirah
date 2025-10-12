import '../../../../address/data/model/address_model.dart';
import '../../../cart/data/model/cart_model.dart';
import 'delivery_types_model.dart';
import 'orders_bill_data.dart';
import 'payment_methods_model.dart';

class ConfirmOrderDataModel {
  final List<AddressModel> userAddresses;
  final List<PaymentMethodsModel> paymentMethods;
  final List<DeliveryTypesModel> deliveryTypes;
  final List<CartModel> products;
  final OrdersBillData? billData;

  ConfirmOrderDataModel({
    required this.userAddresses,
    required this.paymentMethods,
    required this.deliveryTypes,
    required this.products,
    required this.billData,
  });

  factory ConfirmOrderDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderDataModel(
      userAddresses: AddressModel.fromJsonList(json['user_addresses'] ?? []),
      paymentMethods:
          PaymentMethodsModel.fromJsonPayList(json['payment_methods'] ?? []),
      deliveryTypes:
          DeliveryTypesModel.fromJsonDeliveryList(json['delivery_types'] ?? []),
      products: CartModel.fromJsonList(json['products'] ?? []),
      billData: json['order_summary'] == null
          ? null
          : OrdersBillData.fromJson(json['order_summary'] as Map<String, dynamic>),
    );
  }

  static ConfirmOrderDataModel empty() {
    return ConfirmOrderDataModel(
      userAddresses: [],
      paymentMethods: [],
      deliveryTypes: [],
      products: [],
      billData: OrdersBillData.empty(),
    );
  }
}
