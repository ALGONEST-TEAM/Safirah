import 'dart:convert';
import 'dart:developer';
import '../../core/local/secure_storage.dart';
import '../../features/user/data/model/auth_model.dart';
import '../../injection.dart';

class Auth {
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

  String get name => user.user.name;

  String get phoneNumber => user.user.phoneNumber;

  Future<void> login(AuthModel data) async {
    user = data;
    _writeToCache();
  }

  _writeToCache() {
    log(jsonEncode(user), name: 'user');
    secureStorage.write(key: _key, value: jsonEncode(user));
  }

  Future logout() async {
    // await secureStorage.delete(key: 'fcmToken');
    user = AuthModel.empty();
    await secureStorage.delete(key: _key);
  }

  Future<void> setFcmToken(String fcmToken) async {
    await secureStorage.write(key: "fcm_token", value: fcmToken);
  }

  Future<String> getFcmToken() async {
    final fcmToken = await secureStorage.read(key: "fcm_token");
    return fcmToken ?? "";
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

  Future<void> cachePrintingIntroSeen(bool value) async {
    await secureStorage.write(
        key: "PRINTING_INTRO_SEEN_V1", value: jsonEncode(value));
  }

  Future<bool> getPrintingIntroSeen() async {
    final v = await secureStorage.read(key: "PRINTING_INTRO_SEEN_V1");
    if (v != null) {
      return jsonDecode(v) as bool;
    }
    return false;
  }
}
