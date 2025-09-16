import 'package:flutter/foundation.dart';

import '../../../../../../core/network/remote_request.dart';
import '../model/product_data.dart';


class ProductDetailsRemoteDataSource {

  ProductDetailsRemoteDataSource();


  Future<ProductData> getDetailsOfProduct(int idProduct) async {

    final response = await RemoteRequest.getData(
      url: "/products/$idProduct",
    );
    debugPrint(response.data['product'].toString(),wrapWidth: 1024);
    return ProductData.fromJson(response.data['product']);
  }
}