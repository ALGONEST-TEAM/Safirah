
import '../../../cart/data/model/cart_model.dart';

class ConfirmOrderModel {
  final List<CartModel> cartProducts;
  final int addressId;
  final int paymentId;
  final int deliveryTypeId;
  final String? note;
  final String unitPrice;
  final String phoneNumber;

  ConfirmOrderModel({
    required this.cartProducts,
    required this.addressId,
    required this.paymentId,
    required this.deliveryTypeId,
    required this.note,
    required this.unitPrice,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'products': List<Map<String, dynamic>>.from(
          cartProducts.map((cartProducts) => cartProducts.toJson())),
      'address_id': addressId,
      'payment_id': paymentId,
      'delivery_type_id': deliveryTypeId,
      // 'note': note ?? "",
      // 'unit_price': unitPrice,
      'phone_number': phoneNumber,
    };
  }
}
