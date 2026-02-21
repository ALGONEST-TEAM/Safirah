import 'authorization_keys.dart';

/// مفاتيح الصلاحيات + تحويل الأدوار (Roles) القادمة من الـ API إلى صلاحيات.
///
/// بما أن الـ API يرجع Roles فقط، فنحتاج Mapping محلي.
///
/// مهم: عدّل هذا الملف حسب نظام الصلاحيات الحقيقي عندك.
class AuthorizationPermissions {
  static const Map<String, Set<String>> roleToPermissions = {
    'organizer': {
      AuthorizationKeys.leagueView,
      AuthorizationKeys.leagueEdit,
      AuthorizationKeys.teamManage,
    //  AuthorizationKeys.matchManage,
    },
    'referee': {
      AuthorizationKeys.leagueView,
      AuthorizationKeys.matchManage,
    },
  };

  static Set<String> permissionsForRoles(Iterable<String> roleKeys) {
    final out = <String>{};
    for (final role in roleKeys) {
      final perms = roleToPermissions[role];
      if (perms != null) out.addAll(perms);
    }
    return out;
  }
}
