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
  }) async {
    String currency = await Auth().getCurrency();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'Accept-Language': await Auth().getLanguage(),
      // if (fcmToken.isNotEmpty) 'user-fcm-token': fcmToken,
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODVmYTQxYjJlNjY0ZDk2NjVlYzFkZDIyNjE0OGRhZWEyOGI0ZDU4N2EzZGJmZGU1YzI5MTE2NmEzM2M4NjkwYzhmNjE2NTY1N2M4ZDdiMGYiLCJpYXQiOjE3NzEzNzA5MDMuMTgyMjgxLCJuYmYiOjE3NzEzNzA5MDMuMTgyMjgzLCJleHAiOjE4MDI5MDY5MDMuMTc4NzM5LCJzdWIiOiIxNjMiLCJzY29wZXMiOltdfQ.hWOlweUL7qzuZS7aKdYA3mNdf7LlB2NR2sSf5nUVe_0erbPeEvKgJhxKrH2ejsDZg05esX2UMUyuzyoprS87moDCWGZSlTjYkDpraBuRGtNst3RJ3Pe7qzZaMZTfQtLlgwzbzR94YdTb87AdlSHA1eDtTXaTuM12YtR0t_Xh_NtjuLcP4vMActqrZtjUz7YReczMNkLjr-6uEKuLDlxXTYZFfre4IxcSYLGEAN-CYtPzOWlzVOsYqK0G-mP5Xmz8SY-YtQ7-AzzkjOKudPD9DfYFb8cvemHveiHF521oPV7GoubYIHKpMWxck-EI1lPeSqJQmTlNb4NmJlAMZe11PaNShkvyBzdd6lL9e3dUNCqgVRLqr_Qmf_Y4ISJgsk6gEDZl3ZzG9CSnSZ7air-0CGJRDe1LXncz1l0g_q1kury01okeHSy9kfkkB5So7gCwfAlYBeq9byyuQQt8uXF8TGZScyRst1i057XP-O8ufV8s3822jYim5paVYSLPQf2_lhB75DYai81G9K6MXW0sgeWBQaTLAK6knYBaAndh1-4Isy4MBqzw7SnDlRUXkJ92g8ihZddwTYC-mTDKF3vJH4HC9OZgu6V-PoNGnaXEX58_b83Uh1ERdHen9RtGnKIki7A3TNI6PQ7OoqOrO5VDk243YH66c_0bWjihIbUWupw'
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
  }) async {
    String currency = await Auth().getCurrency();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'Accept-Language': await Auth().getLanguage(),
      // if (fcmToken.isNotEmpty) 'user-fcm-token': fcmToken,
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODVmYTQxYjJlNjY0ZDk2NjVlYzFkZDIyNjE0OGRhZWEyOGI0ZDU4N2EzZGJmZGU1YzI5MTE2NmEzM2M4NjkwYzhmNjE2NTY1N2M4ZDdiMGYiLCJpYXQiOjE3NzEzNzA5MDMuMTgyMjgxLCJuYmYiOjE3NzEzNzA5MDMuMTgyMjgzLCJleHAiOjE4MDI5MDY5MDMuMTc4NzM5LCJzdWIiOiIxNjMiLCJzY29wZXMiOltdfQ.hWOlweUL7qzuZS7aKdYA3mNdf7LlB2NR2sSf5nUVe_0erbPeEvKgJhxKrH2ejsDZg05esX2UMUyuzyoprS87moDCWGZSlTjYkDpraBuRGtNst3RJ3Pe7qzZaMZTfQtLlgwzbzR94YdTb87AdlSHA1eDtTXaTuM12YtR0t_Xh_NtjuLcP4vMActqrZtjUz7YReczMNkLjr-6uEKuLDlxXTYZFfre4IxcSYLGEAN-CYtPzOWlzVOsYqK0G-mP5Xmz8SY-YtQ7-AzzkjOKudPD9DfYFb8cvemHveiHF521oPV7GoubYIHKpMWxck-EI1lPeSqJQmTlNb4NmJlAMZe11PaNShkvyBzdd6lL9e3dUNCqgVRLqr_Qmf_Y4ISJgsk6gEDZl3ZzG9CSnSZ7air-0CGJRDe1LXncz1l0g_q1kury01okeHSy9kfkkB5So7gCwfAlYBeq9byyuQQt8uXF8TGZScyRst1i057XP-O8ufV8s3822jYim5paVYSLPQf2_lhB75DYai81G9K6MXW0sgeWBQaTLAK6knYBaAndh1-4Isy4MBqzw7SnDlRUXkJ92g8ihZddwTYC-mTDKF3vJH4HC9OZgu6V-PoNGnaXEX58_b83Uh1ERdHen9RtGnKIki7A3TNI6PQ7OoqOrO5VDk243YH66c_0bWjihIbUWupw'
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
  }) async {
    String currency = await Auth().getCurrency();

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'Accept-Language': await Auth().getLanguage(),
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
  }) async {
    String currency = await Auth().getCurrency();

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Currency-Code': currency,
      'Accept-Language': await Auth().getLanguage(),
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
