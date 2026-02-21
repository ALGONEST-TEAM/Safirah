import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:safirah/features/authorization/data/reposaitory/authorization_repository.dart';

class AuthorizationService {
  final AuthorizationRepository _repo;

  const AuthorizationService(this._repo);

  /// مزامنة الوصول (roles) من السيرفر ثم تحويلها لصلاحيات محلياً وتخزينها.
  Future<Either<DioException, Unit>> syncUserAccessForAllLeagues() {
    return _repo.syncUserAccessForAllLeagues();
  }

  /// تحقق محلي سريع.
  Future<Either<DioException, bool>> can({
    required String leagueSyncId,
    required String permissionKey,
  }) {
    return _repo.can(
      leagueSyncId: leagueSyncId,
      permissionKey: permissionKey,
    );
  }

  /// مراقبة صلاحيات الدوري (مناسبة للـ UI).
  Stream<Set<String>> watchPermissions({
    required String leagueSyncId,
  }) {
    return _repo.watchLeaguePermissionKeys(
      leagueSyncId: leagueSyncId,
    );
  }
}
