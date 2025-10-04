import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../data/model/address_model.dart';

class AddressFormController {
  final AddressModel address;

  AddressFormController(this.address) {
    fillForm(address);
  }

  final key = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final group = FormGroup({
    'address': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'phone_number': FormControl<String>(
      validators: [
        Validators.required,
        Validators.pattern(
            r'^(((\+|00)9677|0?7)[01378]\d{7}|((\+|00)967|0)[1-7]\d{6})$')
      ],
      value: '',
    ),
    'city_id': FormControl<int>(),
    'city_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'district_id': FormControl<int>(),
    'district_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'nearest_landmark': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  void fillForm(AddressModel address) {
    group.patchValue({
      'address': address.address,
      'phone_number': address.phoneNumber,
      'city_name': address.cityName.toString(),
      'city_id': address.cityId,
      'district_name': address.districtName.toString(),
      'district_id': address.districtId,
      'nearest_landmark': address.nearestLandmark,
    });
  }
}
