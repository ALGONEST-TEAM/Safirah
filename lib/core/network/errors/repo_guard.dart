import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'local_app_exception.dart';
import 'local_to_dio_exception_mapper.dart';
import 'sync_dio_exception.dart';

/// Guard احترافي لتوحيد try/catch داخل الـ Repository.
///
/// الفكرة:
/// - أي عملية Repository ترجع Either<DioException, T>
/// - نلتقط:
///   - DioException كما هو.
///   - LocalAppException ونحوّله إلى DioException بصيغة متوافقة مع MessageOfErorrApi.
///   - أي خطأ آخر نحوله إلى DioException عام.
class RepoGuard {
  const RepoGuard._();

  static final RequestOptions requestOptionsForUnknown =
      RequestOptions(path: 'local');

  static Future<Either<DioException, T>> run<T>({
    RequestOptions? requestOptions,
    required Future<T> Function() action,

    /// إذا false: أخطاء SyncDioException (المزامنة) سيتم إخفاؤها وتحويلها إلى خطأ عام.
    /// إذا true: سيتم تمرير SyncDioException كما هو ليظهر للمستخدم (في عمليات المزامنة الفورية فقط).
    bool allowSyncErrorsToBubble = false,
  }) async {
    final ro = requestOptions ?? requestOptionsForUnknown;
    try {
      final value = await action();
      return Right(value);
    } on DioException catch (e) {
      print(e);
      // افتراضياً: نمرر DioException كما هو.
      // لكن إذا كان من نوع SyncDioException ولا نريد إظهاره للمستخدم (عملية ليست مزامنة فورية)
      // نحوله إلى DioException عام.
      if (!allowSyncErrorsToBubble && e is SyncDioException) {
        return Left(DioException(requestOptions: ro));
      }
      return Left(e);
    } on LocalAppException catch (e) {
      print(e);
      return Left(
        LocalToDioExceptionMapper.fromLocalAppException(
          e,
          requestOptions: ro,
        ),
      );
    } catch (e, st) {
      print(e);
      return Left(
        DioException(
          requestOptions: ro,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }
}
