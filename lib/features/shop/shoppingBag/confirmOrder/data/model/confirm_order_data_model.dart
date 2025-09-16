import 'confirm_order_address_data_model.dart';
import 'delivery_types_model.dart';
import 'payment_methods_model.dart';

class ConfirmOrderDataModel {
  final List<ConfirmOrderAddressDataModel> userAddresses;
  final List<PaymentMethodsModel> paymentMethods;
  final List<DeliveryTypesModel> deliveryTypes;

  ConfirmOrderDataModel({
    required this.userAddresses,
    required this.paymentMethods,
    required this.deliveryTypes,
  });

  factory ConfirmOrderDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderDataModel(
      userAddresses: (json['user_addresses'] as List<dynamic>)
          .map((e) =>
              ConfirmOrderAddressDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['payment_methods'] as List<dynamic>)
          .map((e) => PaymentMethodsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryTypes: (json['delivery_types'] as List<dynamic>)
          .map((e) => DeliveryTypesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_addresses': userAddresses,
      'payment_methods': paymentMethods,
      'delivery_types': deliveryTypes,
    };
  }

  static ConfirmOrderDataModel empty() {
    return ConfirmOrderDataModel(
      userAddresses: [],
      paymentMethods: [],
      deliveryTypes: [],
    );
  }
}
