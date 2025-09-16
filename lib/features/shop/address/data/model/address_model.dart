import 'city_model.dart';
import 'district_model.dart';

class AddressModel {
  final int id;
  final String address;
  final int? cityId;
  final String? cityName;
  final CityModel? city;
  final int? districtId;
  final String? districtName;
  final DistrictModel? district;
  final String? nearestLandmark;
  final String lat;
  final String lon;
  final bool? isDefault;

  AddressModel({
    required this.id,
    required this.address,
    this.cityId,
    this.cityName,
    this.city,
    this.districtId,
    this.districtName,
    this.district,
    required this.lat,
    required this.lon,
    this.nearestLandmark,
    this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: (json['id'] as num).toInt(),
      address: json['address'] ?? "",
      cityId: (json['city_id'] as num?)?.toInt(),
      cityName: json['city_name'] ?? "",
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      districtId: (json['district_id'] as num?)?.toInt(),
      districtName: json['district_name'] ?? "",
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      lat: json['lat'] ?? "",
      lon: json['lng'] ?? "",
      nearestLandmark: json['nearest_landmark'] ?? "",
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  static List<AddressModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => AddressModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city_id': cityId,
      'district_id': districtId,
      'nearest_landmark': nearestLandmark,
      'lat': lat,
      'lng': lon,
      'is_default': 0,
    };
  }

  static AddressModel empty() {
    return AddressModel(
      id: 0,
      address: '',
      cityId: 0,
      cityName: '',
      city: CityModel.empty(),
      districtId: 0,
      districtName: '',
      district: DistrictModel.empty(),
      nearestLandmark: "",
      lat: '',
      lon: '',
      isDefault: false,
    );
  }
}
