import 'package:dio/dio.dart';

class SyncDioException extends DioException {
  SyncDioException.from(DioException e)
      : super(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type,
          error: e.error,
          message: e.message,
          stackTrace: e.stackTrace,
        );
}

