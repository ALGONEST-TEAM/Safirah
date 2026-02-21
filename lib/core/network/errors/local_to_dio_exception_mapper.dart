import 'package:dio/dio.dart';

import 'local_app_exception.dart';

/// تحويل أخطاء الـ Local (المقصودة للعرض) إلى DioException
/// حتى تتعامل معها الواجهة الحالية بنفس نظام أخطاء الـ API بدون تضخيم كود الـ Repository.
class LocalToDioExceptionMapper {
  static DioException fromLocalAppException(
    LocalAppException e, {
     RequestOptions? requestOptions,
    int statusCode = 400,
  }) {
    return DioException(
      requestOptions: requestOptions ?? RequestOptions(path: ''),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions:  requestOptions ?? RequestOptions(path: ''),
        statusCode: statusCode,
        data: {
          'message': {
            'title': e.title,
            'sub_title': e.message,
          }
        },
      ),
      error: e,
      stackTrace: e.stackTrace,
    );
  }
}

