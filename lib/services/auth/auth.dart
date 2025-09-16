import 'dart:convert';
import 'dart:developer';
import '../../core/local/secure_storage.dart';
import '../../features/user/data/model/auth_model.dart';
import '../../injection.dart';

class Auth  {
  factory Auth() {
    _instance ??= Auth._();

    return _instance!;
  }

  final String _key = 'user';
  final WingsSecureStorage secureStorage = sl<WingsSecureStorage>();

  Auth._() {
    onInit();
  }

  void onInit() async {
    try {
      var read = await secureStorage.read(
        key: _key,
      );

      if (read != null) {
        Map<String, dynamic> map = jsonDecode(read);
        AuthModel authModel = AuthModel.fromJson(map);
        user = authModel;
      }
       print("token: ${user.token}");


    } catch (ex) {
      throw '$ex';
    }
  }

  static Auth? _instance;

  AuthModel user = AuthModel.empty();

  bool get loggedIn => user.token.isNotEmpty;

  String get token => user.token;
  // String get token => "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTFmMTBkOTY3YjBkZTc2ZjJkZWU2MTc3YWVjN2Q0MGVhMTQ4MmYxMzkzZDIzODc4OWMxYTM2ODAzODc4NzBhNWYxYzQwZTZkMzA1MzFmZmEiLCJpYXQiOjE3NTUzMzIxMzIuOTU0NzkyOTc2Mzc5Mzk0NTMxMjUsIm5iZiI6MTc1NTMzMjEzMi45NTQ3OTM5MzAwNTM3MTA5Mzc1LCJleHAiOjE3ODY4NjgxMzIuOTUzNzUyOTk0NTM3MzUzNTE1NjI1LCJzdWIiOiIxMTkiLCJzY29wZXMiOltdfQ.IHR906CHdJpn0OWs-L_SSpdVVDOYeLBFfRGUUrykZ5UzMByirDkCpAwWlam3UhFC9xkij-ZIqoL96xu6XgdcmvnJcOSwE6zP8D5vfUpu57eGI3mK0wA6uDPUDpaXA1nQtJnQ4-CC2arNtpDGxmjq0u1oKfDcruUpwIfDHAq7RFqTil9WZfjkPFWpHym9QFfSFLT0wMfi55U4NCr3lk4qvXUf_abSjyPFu2AJlizS61qODP8JUuKyeCi3NvgHCcYkBiLw2cKNmJOcSiOaGl8O7udBRbxwsfot5eJgZG0h5pKfzQNYd3LSqaLY2SF56TUr8XOnrrdxaVV9aBbWoGH2BvUdXNnHAdv--R8UURxaAu8Nt7q1pT0Dq5qpp0PpIwAedhvTKf1VXUwUc74_VfP87XTRCQtEi0yZ2Zxs9WPGDU0dbXfvx2sIkQVIN3aRPhCYOQ8ZFCmq0BVv6QIj-2Ev9urjIuQdSWWyw2tWGP8obRWL9w5iFpScbAlsfzjC-dYVIiHZZKLKFrKwdz-0Ob-IzLzrfKL9Vu4vpmzEgr8P6b53q-TSgk0GYkgx3tQFKoPAkwkwMa9BgnINiwbxHpQIdtvHaaUB9uQ36tHXIWbNNGZeb69QqMT7zQsRxJ-wNFG_EEflijOjGxlKdRuNR3KPIKj9q6k";

// eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTFmMTBkOTY3YjBkZTc2ZjJkZWU2MTc3YWVjN2Q0MGVhMTQ4MmYxMzkzZDIzODc4OWMxYTM2ODAzODc4NzBhNWYxYzQwZTZkMzA1MzFmZmEiLCJpYXQiOjE3NTUzMzIxMzIuOTU0NzkyOTc2Mzc5Mzk0NTMxMjUsIm5iZiI6MTc1NTMzMjEzMi45NTQ3OTM5MzAwNTM3MTA5Mzc1LCJleHAiOjE3ODY4NjgxMzIuOTUzNzUyOTk0NTM3MzUzNTE1NjI1LCJzdWIiOiIxMTkiLCJzY29wZXMiOltdfQ.IHR906CHdJpn0OWs-L_SSpdVVDOYeLBFfRGUUrykZ5UzMByirDkCpAwWlam3UhFC9xkij-ZIqoL96xu6XgdcmvnJcOSwE6zP8D5vfUpu57eGI3mK0wA6uDPUDpaXA1nQtJnQ4-CC2arNtpDGxmjq0u1oKfDcruUpwIfDHAq7RFqTil9WZfjkPFWpHym9QFfSFLT0wMfi55U4NCr3lk4qvXUf_abSjyPFu2AJlizS61qODP8JUuKyeCi3NvgHCcYkBiLw2cKNmJOcSiOaGl8O7udBRbxwsfot5eJgZG0h5pKfzQNYd3LSqaLY2SF56TUr8XOnrrdxaVV9aBbWoGH2BvUdXNnHAdv--R8UURxaAu8Nt7q1pT0Dq5qpp0PpIwAedhvTKf1VXUwUc74_VfP87XTRCQtEi0yZ2Zxs9WPGDU0dbXfvx2sIkQVIN3aRPhCYOQ8ZFCmq0BVv6QIj-2Ev9urjIuQdSWWyw2tWGP8obRWL9w5iFpScbAlsfzjC-dYVIiHZZKLKFrKwdz-0Ob-IzLzrfKL9Vu4vpmzEgr8P6b53q-TSgk0GYkgx3tQFKoPAkwkwMa9BgnINiwbxHpQIdtvHaaUB9uQ36tHXIWbNNGZeb69QqMT7zQsRxJ-wNFG_EEflijOjGxlKdRuNR3KPIKj9q6k
  String get name => user.user.name;

  String get phoneNumber => user.user.phoneNumber;
  String get email => user.user.email;


  Future<void> login(AuthModel data) async {
    user = data;
    _writeToCache();
  }

  _writeToCache() {
    log(jsonEncode(user), name: 'user');
    secureStorage.write(key: _key, value: jsonEncode(user));
  }

  Future logout() async {
    await secureStorage.delete(key: 'fcmToken');
    user = AuthModel.empty();
    await secureStorage.delete(key: _key);
  }

  Future<void> setCurrency(String currencyCode) async {
    await secureStorage.write(key: "CURRENCY", value: currencyCode);
  }

  Future<String> getCurrency() async {
    final language = await secureStorage.read(key: "CURRENCY");
    return language ?? "YER";
  }

  Future<void> setLanguage(String languageCode) async {
    await secureStorage.write(key: "LANGUAGE", value: languageCode);
  }

  Future<String> getLanguage() async {
    final language = await secureStorage.read(key: "LANGUAGE");
    return language ?? "ar";
  }

  Future<void> cacheOnBoarding(bool value) async {
    await secureStorage.write(key: "SPLASH_SCREEN", value: jsonEncode(value));
  }

  Future<bool> getOnBoarding() async {
    final fingerprintValue = await secureStorage.read(key: "SPLASH_SCREEN");
    if (fingerprintValue != null) {
      return jsonDecode(fingerprintValue) as bool;
    }
    return false;
  }

}
