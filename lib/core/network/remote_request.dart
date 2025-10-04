import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safirah/core/network/urls.dart';
import '../../services/auth/auth.dart';

class RemoteRequest {
  static late Dio dio;

  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppURL.baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    dynamic query,
    // String fcmToken = '',
    String lang = 'ar',
  }) async {
    String currency = await Auth().getCurrency();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'lang': lang,
      // if (fcmToken.isNotEmpty) 'user-fcm-token': fcmToken,
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.get(url, queryParameters: query);
    debugPrint(response.statusCode.toString());
    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      return response;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    // String fcmToken = '',
    String lang = 'ar',
  }) async {
    String currency = await Auth().getCurrency();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'lang': lang,
      // if (fcmToken.isNotEmpty) 'user-fcm-token': fcmToken,
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.post(
      path,
      queryParameters: query,
      data: data is FormData ? data : jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      throw Exception();
    }
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'ar',
  }) async {
    String currency = await Auth().getCurrency();

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'lang': lang,
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.put(
      path,
      queryParameters: query,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      throw Exception();
    }
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'ar',
  }) async {
    String currency = await Auth().getCurrency();

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'lang': lang,
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response =
    await dio.delete(path, queryParameters: query, data: jsonEncode(data));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      throw Exception();
    }
  }
}
