import 'user_model.dart';

class AuthModel {
  final String token;
  final bool status;
  final UserModel user;

  AuthModel({
    required this.token,
    required this.status,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] ?? "",
      status: json['status'] ?? false,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user,
      'status': status,
    };
  }

  AuthModel copyWith({
    UserModel? user,
  }) {
    return AuthModel(
      token: token,
      status: status,
      user: user ?? this.user,
    );
  }

  factory AuthModel.empty() => AuthModel(
        token: '',
        status: false,
        user: UserModel.empty(),
      );
}
