
import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../model/order_details_model.dart';
import '../model/order_model.dart';

class OrderRemoteDataSource {
  Future<OrdersModel> getAllOrders({
    required int page,
    int limit = 6,
  }) async {
    final response = await RemoteRequest.getData(
      url: AppURL.orders,
      query: {
        'page': page,
        'perPage': limit,
      },
    );
    return OrdersModel.fromJson(response.data);
  }

  Future<OrderDetailsModel> orderDetails({
    required int id,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.orderDetails}/$id",
    );
    return OrderDetailsModel.fromJson(response.data);
  }
}
