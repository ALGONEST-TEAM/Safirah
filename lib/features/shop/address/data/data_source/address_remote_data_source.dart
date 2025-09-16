

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
    return AddressModel.fromJsonList(response.data);
  }

  Future<List<CityModel>> getCities() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getCities,
    );
    return CityModel.fromJsonList(response.data);
  }

  Future<List<DistrictModel>> getDistricts() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getDistricts,
    );
    return DistrictModel.fromJsonList(response.data);
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
