import '../../../cart/data/model/cart_model.dart';

class CheckCoponModel{
  final List<CartModel>? cartProducts;
  final String? codeCopon;

  CheckCoponModel({this.cartProducts, this.codeCopon});

  factory CheckCoponModel.fromJson(Map<String, dynamic> json){
    return CheckCoponModel(
      cartProducts: CartModel.fromJsonList(json['products']??[]),
      codeCopon: json['coupon_code']??''
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'coupon_code':codeCopon,
      'products': List<Map<String, dynamic>>.from(
    cartProducts!.map((cartProducts) => cartProducts.toJson())),
    };
  }
}