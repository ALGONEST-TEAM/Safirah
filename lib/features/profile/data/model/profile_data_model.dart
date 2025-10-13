class ProfileDataModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String? gender;
  final String? dateOfBirth;
  final int? cityId;
  final String? cityName;

  const ProfileDataModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.cityId,
    this.cityName,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      id: json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      cityId: json['city_id'] ?? 0,
      cityName: json['city_name'] ?? '',
    );
  }

  factory ProfileDataModel.empty() => const ProfileDataModel(
        id: 0,
        name: '',
        phoneNumber: '',
        gender: '',
        dateOfBirth: '',
        cityId: 0,
        cityName: '',
      );
}

class ChangeResult {
  final bool nameChanged;
  final bool genderChanged;
  final bool birthDateChanged;
  final bool cityChanged;

  const ChangeResult({
    this.nameChanged = false,
    this.genderChanged = false,
    this.birthDateChanged = false,
    this.cityChanged = false,
  });

  bool get hasAny =>
      nameChanged || genderChanged || birthDateChanged || cityChanged;

  static const empty = ChangeResult();
}
