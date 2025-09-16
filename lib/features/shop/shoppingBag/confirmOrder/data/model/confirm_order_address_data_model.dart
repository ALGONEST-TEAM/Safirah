import '../../../../address/data/model/city_model.dart';
import '../../../../address/data/model/district_model.dart';

class ConfirmOrderAddressDataModel {
  final int id;
  final String address;
  final int? isDefault;
  final CityModel? city;
  final DistrictModel? district;

  ConfirmOrderAddressDataModel({
    required this.id,
    required this.address,
    this.isDefault,
    this.city,
    this.district,
  });

  factory ConfirmOrderAddressDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderAddressDataModel(
      id: (json['id'] as num).toInt(),
      address: json['address'] as String,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      isDefault: (json['is_default'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'is_default': isDefault,
    };
  }

  static ConfirmOrderAddressDataModel empty() {
    return ConfirmOrderAddressDataModel(
      id: 0,
      address: "",
      isDefault: 0,
      city: CityModel.empty(),
      district: DistrictModel.empty(),
    );
  }
}
