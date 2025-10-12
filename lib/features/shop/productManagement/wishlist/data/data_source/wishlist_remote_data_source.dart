import 'package:dartz/dartz.dart';
import '../../../../../../core/network/remote_request.dart';
import '../../../../../../core/network/urls.dart';
import '../../../detailsProducts/data/model/product_data.dart';
import '../model/list_model.dart';

class WishlistRemoteDataSource {
  Future<List<ProductData>> getAllWishesProducts() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllWishesProducts,
    );
    return ProductData.fromJsonProductList(response.data['data']);
  }

  Future<Unit> addWishlist(int productId) async {
    await RemoteRequest.postData(
      path: AppURL.addWishlist,
      data: {
        'product_id': productId,
      },
    );

    return Future.value(unit);
  }

  Future<Unit> deleteWishlist(List<int> productsIds) async {
    await RemoteRequest.deleteData(
      path: AppURL.deleteWishlist,
      data: {
        'product_ids': productsIds,
      },
    );

    return Future.value(unit);
  }

  Future<List<ListModel>> getAllList() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getAllList,
    );
    return ListModel.fromJsonList(response.data['data']);
  }

  Future<Unit> createAnewListAndAddProducts(
    int listId,
    String listName,
    List<int> productsIds,
  ) async {
    await RemoteRequest.postData(
      path: AppURL.createAnewListAndAddProducts,
      data: {
        if (listId != 0) 'list_id': listId,
        if (listName.isNotEmpty) 'list_name': listName,
        if (productsIds.isNotEmpty) 'product_ids': productsIds,
      },
    );

    return Future.value(unit);
  }

  Future<Unit> renameTheList(
    int listId,
    String listName,
  ) async {
    await RemoteRequest.putData(
      path: AppURL.renameTheList,
      data: {
        'list_id': listId,
        'list_name': listName,
      },
    );

    return Future.value(unit);
  }

  Future<Unit> deleteList(int listId) async {
    await RemoteRequest.deleteData(
      path: AppURL.deleteList,
      data: {
        'list_id': listId,
      },
    );

    return Future.value(unit);
  }

  Future<List<ProductData>> getProductsByList(int listId) async {
    final response = await RemoteRequest.getData(
      url: AppURL.getProductsByList,
      query: {"list_id": listId},
    );
    return ProductData.fromJsonProductList(response.data['data']);
  }

  Future<Unit> deleteListProducts(int listId, List<int> productsIds) async {
    await RemoteRequest.deleteData(
      path: AppURL.deleteListProducts,
      data: {
        "list_id": listId,
        "product_ids": productsIds,
      },
    );

    return Future.value(unit);
  }
}
