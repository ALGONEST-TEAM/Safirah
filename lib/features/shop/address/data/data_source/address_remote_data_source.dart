

import 'package:dartz/dartz.dart';

import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../model/address_model.dart';
import '../model/city_model.dart';
import '../model/district_model.dart';

class AddressRemoteDataSource {
  AddressRemoteDataSource();

  Future<List<AddressModel>> getAllAddresses() async {
    final response = await RemoteRequest.getData(
      url: AppURL.addresses,
    );
    return AddressModel.fromJsonList(response.data['data']);
  }

  Future<List<CityModel>> getCities() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getCities,
    );
    // final List<dynamic> items =
    // (response.data is Map && response.data['data'] is List)
    //     ? response.data['data'] as List
    //     : const [];
    return CityModel.fromJsonList(response.data['data'] );
  }

  Future<List<DistrictModel>> getDistricts() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getDistricts,
    );
    // final List<dynamic> items =
    // (response.data is Map && response.data['data'] is List)
    //     ? response.data['data'] as List
    //     : const [];
    return DistrictModel.fromJsonList(response.data['data'] );
  }

  Future<Unit> addOrUpdateAddress({
    int? id,
    required AddressModel addressModel,
  }) async {
    var url = AppURL.createAddress;
    if (id != null && id != 0) {
      url = "${AppURL.updateAddress}/$id";
    }
    await RemoteRequest.postData(
      path: url,
      data: addressModel.toJson(),
    );
    return Future.value(unit);
  }

  Future<Unit> deleteAddress(int id) async {
    await RemoteRequest.postData(
      path: "${AppURL.deleteAddress}/$id",
    );
    return Future.value(unit);
  }
}
