import '../../../cart/data/model/cart_model.dart';
import 'discount_product_data.dart';

class DiscountProductFromCoponModel{
  final bool? status;
  final num? orderTotalBeforeDiscount;
  final num? orderTotalAfterDiscount;

  final num? discountTotal;
  final List<CartModel>? discountProductData;
  DiscountProductFromCoponModel({
    this.discountProductData,
    this.status,
    this.discountTotal,
    this.orderTotalBeforeDiscount,this.orderTotalAfterDiscount
});
  factory DiscountProductFromCoponModel.fromJson(Map<String, dynamic> json){
    return DiscountProductFromCoponModel(
      discountProductData:CartModel.fromJsonList(json['discounted_products']),
      discountTotal:json['discount_total']??0,
      orderTotalBeforeDiscount: json['order_total_before_discount']??0,
      status: json['status'],
      orderTotalAfterDiscount: json['order_total_after_discount']
    );
  }


  static DiscountProductFromCoponModel empty() {
    return DiscountProductFromCoponModel(
      discountProductData: [],
      orderTotalBeforeDiscount: 0,
      discountTotal: 0,

    );
  }
}