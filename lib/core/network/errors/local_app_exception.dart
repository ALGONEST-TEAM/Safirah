import '../../../generated/l10n.dart';

/// Exception خاص بالـ Local يمكن عرض رسالته للمستخدم مباشرة.
///
/// الهدف منه:
/// - أخطاء الـ business rules المحلية (مثل: اكتمال عدد اللاعبين)
/// - أو أي خطأ محلي نريد تمريره للـ UI برسالة واضحة
class LocalAppException implements Exception {
  /// عنوان يظهر للمستخدم (مثال: حدث خطأ)
  final String title;

  /// وصف/تفصيل الخطأ
  final String message;

  /// السبب الأصلي (اختياري) للتسجيل فقط
  final Object? cause;

  /// StackTrace (اختياري) للتسجيل فقط
  final StackTrace? stackTrace;

  const LocalAppException({
    required this.title,
    required this.message,
    this.cause,
    this.stackTrace,
  });

  /// رسالة جاهزة للعرض للمستخدم مع عنوان افتراضي من الترجمة.
  factory LocalAppException.userMessage(String message, {Object? cause, StackTrace? stackTrace}) {
    return LocalAppException(
      title: S.current.somethingWentWrong,
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    );
  }

  @override
  String toString() => 'LocalAppException(title: $title, message: $message, cause: $cause)';
}

