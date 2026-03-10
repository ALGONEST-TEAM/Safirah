import 'package:dio/dio.dart';
import 'package:safirah/core/network/urls.dart';
import '../../services/auth/auth.dart';

class RemoteRequest {
  static late final Dio dio;

  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppURL.baseURL,
        receiveDataWhenStatusError: true,
        validateStatus: (c) => c != null && c >= 100 && c < 600,
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }

  static Future<Map<String, dynamic>> _headers({String fcmToken = ''}) async {
    return {
      'Accept': 'application/json',
      'Currency-Code': await Auth().getCurrency(),
      'Accept-Language': await Auth().getLanguage(),
      'Authorization': 'Bearer ${Auth().token}',
      if (fcmToken.isNotEmpty) 'user-fcm-token': fcmToken,
    };
  }

  static bool _ok(int? c) => c == 200 || c == 201 || c == 202;

  static Never _throw(Response r) {
    throw DioException(
      requestOptions: r.requestOptions,
      response: r,
      type: DioExceptionType.badResponse,
      error: r.data,
    );
  }

  static Future<Response<T>> postData<T>({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String fcmToken = '',
  }) async {
    dio.options.headers = await _headers(fcmToken: fcmToken);

    final isMultipart = data is FormData;

    final res = await dio.post<T>(
      path,
      queryParameters: query,
      data: data,
      options: Options(
        contentType: isMultipart ? null : Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (_ok(res.statusCode)) return res;
    _throw(res);
  }

  static Future<Response<T>> putData<T>({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String fcmToken = '',
  }) async {
    dio.options.headers = await _headers(fcmToken: fcmToken);

    final isMultipart = data is FormData;

    final res = await dio.put<T>(
      path,
      queryParameters: query,
      data: data,
      options: Options(
        contentType: isMultipart ? null : Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (_ok(res.statusCode)) return res;
    _throw(res);
  }

  static Future<Response<T>> deleteData<T>({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String fcmToken = '',
  }) async {
    dio.options.headers = await _headers(fcmToken: fcmToken);

    final isMultipart = data is FormData;

    final res = await dio.delete<T>(
      path,
      queryParameters: query,
      data: data,
      options: Options(
        contentType: isMultipart ? null : Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (_ok(res.statusCode)) return res;
    _throw(res);
  }

  static Future<Response<T>> getData<T>({
    required String url,
    dynamic query,
    String fcmToken = '',
  }) async {
    dio.options.headers = await _headers(fcmToken: fcmToken);

    final res = await dio.get<T>(
      url,
      queryParameters: query,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (_ok(res.statusCode)) return res;
    _throw(res);
  }
}
