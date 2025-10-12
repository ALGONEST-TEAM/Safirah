import 'package:dartz/dartz.dart';
import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../../../cart/data/model/cart_model.dart';
import '../model/confirm_order_data_model.dart';
import '../model/confirm_order_model.dart';

class ConfirmOrderRemoteDataSource {
  // fetch order confirmation data with coupon check
  Future<ConfirmOrderDataModel> fetchOrderConfirmationData({
    required List<CartModel> products,
    String? couponCode,
  }) async {
    final payload = {
      'products': products.map((e) => e.toJson()).toList(),
      if (couponCode != null) 'coupon_code': couponCode,
    };
    final response = await RemoteRequest.postData(
      path: AppURL.getOrderDate,
      data: payload,
    );

    return ConfirmOrderDataModel.fromJson(response.data['data']);
  }

  Future<Unit> confirmOrder(ConfirmOrderModel confirmOrderModel) async {
    await RemoteRequest.postData(
      path: AppURL.confirmOrder,
      data: confirmOrderModel.toJson(),
    );
    return Future.value(unit);
  }
}
