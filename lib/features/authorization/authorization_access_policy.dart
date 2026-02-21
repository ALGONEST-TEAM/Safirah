import 'data/data_source/authorization_local_data_source.dart';

/// سياسة بسيطة لتحديد هل المستخدم لديه أي صلاحيات داخل دوري.
///
/// الفكرة:
/// - إذا كان لدى الدوري أي permission keys مخزنة محلياً => نعتبره "له وصول".
/// - إذا لا يوجد => نعتبره API-only.
class AuthorizationAccessPolicy {
  final AuthorizationLocalDataSource _local;

  const AuthorizationAccessPolicy(this._local);

  Future<bool> hasAnyLeaguePermission(String leagueSyncId) async {
    final perms = await _local.getLeaguePermissionKeys(leagueSyncId: leagueSyncId);
    return perms.isNotEmpty;
  }
}
