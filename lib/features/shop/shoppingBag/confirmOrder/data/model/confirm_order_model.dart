import '../../../cart/data/model/cart_model.dart';

class ConfirmOrderModel {
  final List<CartModel> cartProducts;
  final int addressId;
  final int paymentId;
  final int deliveryTypeId;
  final String copon;
  final Map<int, String> printNotesById;

  ConfirmOrderModel({
    required this.cartProducts,
    required this.addressId,
    required this.paymentId,
    required this.deliveryTypeId,
    required this.copon,
    required this.printNotesById,

  });

  Map<String, dynamic> toJson() {
    final productsBody = cartProducts.map((p) {
      final note = (p.isPrintable ?? 0) != 0 ? (printNotesById[p.id] ?? '') : '';
      return p.toJson(printNote: note);
    }).toList();
    return {
      'products': productsBody,
      'address_id': addressId,
      'payment_id': paymentId,
      'delivery_type_id': deliveryTypeId,
      if (copon.isNotEmpty) 'coupon_code': copon,
    };
  }
}
