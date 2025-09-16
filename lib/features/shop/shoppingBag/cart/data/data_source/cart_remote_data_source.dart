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
    // String? fcmToken = await PushNotificationService().getToken();

    final response = await RemoteRequest.getData(
      url: AppURL.getAllCart,
      fcmToken: fcmToken,
    );
    return CartModel.fromJsonList(response.data);
  }

  Future<Unit> addToCart(
    int productId,
    dynamic colorId,
    int sizeId,
    dynamic price,
    int quantity,
  ) async {
    // String? fcmToken = await PushNotificationService().getToken();

    await RemoteRequest.postData(
      path: AppURL.addToCart,
      fcmToken: fcmToken,
      data: {
        'product_id': productId,
        'color_id': colorId,
        'parent_measuring_id': sizeId,
        'price': price,
        'quantity': quantity,
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
  ) async {
    // String? fcmToken = await PushNotificationService().getToken();

    final response = await RemoteRequest.postData(
      path: "${AppURL.updateCart}/$id",
      fcmToken: fcmToken,
      data: {
        'product_id': productId,
        'color_id': colorId,
        'parent_measuring_id': sizeId,
        'price': price,
        'quantity': quantity,
      },
    );
    return CartProductModel.fromJson(response.data);
  }

  Future<Unit> deleteAProductFromTheCart(
    int id,
  ) async {
    // String? fcmToken = await PushNotificationService().getToken();

    await RemoteRequest.postData(
        path: "${AppURL.deleteCart}/$id", fcmToken: fcmToken);
    return Future.value(unit);
  }
}
