import 'package:dartz/dartz.dart';
import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../model/check_copon_model.dart';
import '../model/confirm_order_data_model.dart';
import '../model/confirm_order_model.dart';
import '../model/discount_copon_data.dart';

class ConfirmOrderRemoteDataSource {
  Future<ConfirmOrderDataModel> getConfirmOrderData() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getOrderDate,
    );
    return ConfirmOrderDataModel.fromJson(response.data['data']);
  }

  Future<Unit> confirmOrder(ConfirmOrderModel confirmOrderModel) async {
    final response = await RemoteRequest.postData(
      path: AppURL.confirmOrder,
      data: confirmOrderModel.toJson(),
    );
    return Future.value(unit);
  }


  Future<DiscountProductFromCoponModel> checkCodeCopon(CheckCoponModel checkCode) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkCoupon,
      data: checkCode.toJson(),
    );
    return DiscountProductFromCoponModel.fromJson(response.data['data']);
  }
}
