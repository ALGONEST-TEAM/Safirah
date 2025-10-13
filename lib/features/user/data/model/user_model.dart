class UserModel {
  final int id;
  final String name;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory UserModel.empty() => UserModel(
        id: 0,
        name: '',
        phoneNumber: '',
      );
}
