import 'package:dartz/dartz.dart';

import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';

String fcmToken =
    "eqSHD0jlRqO6ja7V_2g7AK:APA91bE2Z1UTPQPFtQoNwqxGSxztrCXogiwhTWlTJ_5D20IKWK6cKjwdghuq1nkTDmlNq30Z9N8eXKP_qt4Oz8CYGY1cuw_unwAslv6pOz1mlL-XDdLKGQ8";

class CartRemoteDataSource {
  CartRemoteDataSource();

  Future<List<CartModel>> getAllCart() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllCart,
    );
    final List<dynamic> items =
        (response.data is Map && response.data['data'] is List)
            ? response.data['data'] as List
            : const [];
    return CartModel.fromJsonList(items);
  }

  Future<Unit> addToCart(
    int productId,
    dynamic colorId,
    int sizeId,
    dynamic price,
    int quantity,
    int? numberId,
    int isPrintable,
  ) async {
    await RemoteRequest.postData(
      path: AppURL.addToCart,
      data: {
        'product_id': productId,
        'color_id': colorId,
        'parent_measuring_id': sizeId,
        'price': price,
        'quantity': quantity,
        if (numberId != 0) 'number_id': numberId,
        'is_printable': isPrintable,
      },
    );
    return Future.value(unit);
  }

  Future<CartProductModel> updateCart(
    int id,
    int productId,
    dynamic colorId,
    int sizeId,
    dynamic price,
    int quantity,
    int? numberId,
    int isPrintable,
  ) async {
    final response = await RemoteRequest.postData(
      path: "${AppURL.updateCart}/$id",
      data: {
        'product_id': productId,
        'color_id': colorId,
        'parent_measuring_id': sizeId,
        'price': price,
        'quantity': quantity,
        if (numberId != 0) 'number_id': numberId,
        'is_printable': isPrintable,
      },
    );
    return CartProductModel.fromJson(response.data['data']);
  }

  Future<Unit> deleteAProductFromTheCart(
    int id,
  ) async {
    await RemoteRequest.postData(path: "${AppURL.deleteCart}/$id");
    return Future.value(unit);
  }
}
