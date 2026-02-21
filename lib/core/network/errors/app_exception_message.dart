import 'package:dio/dio.dart';

import 'local_exception.dart';
import 'remote_exception.dart';

/// واجهة موحّدة لاستخراج رسالة الخطأ من Remote أو Local.
///
/// - إذا كان الاستثناء DioException: نستخدم MessageOfErorrApi (نظامك الحالي).
/// - خلاف ذلك: نستخدم MessageOfLocalError (النظام المحلي).
class MessageOfError {
  static List<String> get(Object exception) {
    if (exception is DioException) {
      return MessageOfErorrApi.getExeptionMessage(exception);
    }

    return MessageOfLocalError.getExceptionMessage(exception);
  }
}
