import 'package:sqlite3/sqlite3.dart' show SqliteException;

import '../../../generated/l10n.dart';
import 'local_app_exception.dart';

/// Mapper لأخطاء الـ Local (SQLite/Drift/Business) إلى رسائل قابلة للعرض في الـ UI.
class MessageOfLocalError {
  static List<String> _fallback() =>
      [S.current.somethingWentWrong, S.current.pleaseTryAgain];

  static List<String> getExceptionMessage(Object exception) {
    // 1) أخطاء الـ business المحلية (رسالة جاهزة للعرض)
    if (exception is LocalAppException) {
      final title = exception.title.trim().isEmpty
          ? S.current.somethingWentWrong
          : exception.title;
      final message = exception.message.trim().isEmpty
          ? S.current.pleaseTryAgain
          : exception.message;
      return [title, message];
    }

    // 2) أخطاء SQLite/Drift
    if (exception is SqliteException) {
      // حالياً: كل هذه الحالات تعرض نفس رسالة الـ fallback.
      // وضعنا ifs فقط كـ نقاط توسعة مستقبلية لو أردت رسالة أدق لاحقاً.
      final msg = exception.message;
      if (msg.contains('UNIQUE constraint failed')) return _fallback();
      if (msg.contains('FOREIGN KEY constraint failed')) return _fallback();
      if (msg.contains('no such column')) return _fallback();
      if (msg.contains('database is locked') || msg.contains('database is busy')) {
        return _fallback();
      }
      return _fallback();
    }

    // 3) صيغة بيانات غير صحيحة (مثل parsing تاريخ)
    if (exception is FormatException) {
      return _fallback();
    }

    // 4) fallback
    return _fallback();
  }
}
