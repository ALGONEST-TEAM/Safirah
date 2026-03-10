import 'authorization_keys.dart';

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
    'media': {
      AuthorizationKeys.matchReport,
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
