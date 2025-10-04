import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/address_model.dart';
import '../../data/model/city_model.dart';
import '../../data/model/district_model.dart';
import '../../data/repos/address_repo.dart';
import '../widgets/address_form.dart';
import 'map_state.dart';

final mapProvider = StateNotifierProvider.autoDispose<MapNotifier, MapState>(
    (ref) => MapNotifier());

class MapNotifier extends StateNotifier<MapState> {
  MapNotifier() : super(MapState.initial());

  final _streamController = StreamController<LatLng>();

  Stream<LatLng> get locationStream => _streamController.stream;

  bool locationIsEmpty = true;
  bool checkForLocationChanges = false;

  void changeLocation(LatLng latLng) {
    state = state.copyWith(
      temp: latLng,
    );
  }

  void confirmLocation() {
    _streamController.add(state.temp);
    state = state.copyWith(
      location: state.temp,
    );
  }
}

final getAllAddressesProvider = StateNotifierProvider.autoDispose<
    GetAllAddressesController, DataState<List<AddressModel>>>(
  (ref) {
    return GetAllAddressesController();
  },
);

class GetAllAddressesController
    extends StateNotifier<DataState<List<AddressModel>>> {
  GetAllAddressesController()
      : super(DataState<List<AddressModel>>.initial([])) {
    getData();
  }

  final _controller = AddressReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getAllAddresses();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final addressProvider = StateNotifierProvider.autoDispose
    .family<AddressController, DataState<Unit>, AddressModel>(
  (ref, address) {
    return AddressController(address);
  },
);

class AddressController extends StateNotifier<DataState<Unit>> {
  AddressController(this.address) : super(DataState<Unit>.initial(unit)) {
    fillForm(address);
  }

  final AddressModel address;

  final _controller = AddressReposaitory();
  final AddressFormController form =
      AddressFormController(AddressModel.empty());

  fillForm(AddressModel address) {
    form.fillForm(address);
  }

  Future<void> addOrUpdateAddress({
    required double lat,
    required double lng,
  }) async {
    form.group.markAllAsTouched();
    if (!form.group.valid) return;
    var formData = form.group.value;

    state = state.copyWith(state: States.loading);
    final data = await _controller.addOrUpdateAddress(
      id: address.id,
      addressModel: AddressModel(
        id: address.id,
        address: formData['address'].toString(),
        cityId: formData['city_id'] as int,
        districtId: formData['district_id'] as int,
        nearestLandmark: formData['nearest_landmark'].toString(),
        lat: lat.toString(),
        lon: lng.toString(),
        phoneNumber: formData['phone_number'].toString(),
      ),
    );
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }

  void deleteAddress() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.deleteAddress(address.id);

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

final citiesProvider = StateNotifierProvider.autoDispose<CitiesController,
    DataState<List<CityModel>>>(
  (ref) {
    return CitiesController();
  },
);

class CitiesController extends StateNotifier<DataState<List<CityModel>>> {
  CitiesController() : super(DataState<List<CityModel>>.initial([])) {
    getData();
  }

  final _controller = AddressReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getCities();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final districtsProvider = StateNotifierProvider.autoDispose<DistrictsController,
    DataState<List<DistrictModel>>>(
  (ref) {
    return DistrictsController();
  },
);

class DistrictsController
    extends StateNotifier<DataState<List<DistrictModel>>> {
  DistrictsController() : super(DataState<List<DistrictModel>>.initial([])) {
    getData();
  }

  final _controller = AddressReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getDistricts();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
