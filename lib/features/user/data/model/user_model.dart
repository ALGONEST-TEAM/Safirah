class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name':name,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  UserModel copyWith() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
    );
  }

  factory UserModel.empty() => UserModel(
        id: 0,
        name: '',
        email: '',
        phoneNumber: '',
      );
}
