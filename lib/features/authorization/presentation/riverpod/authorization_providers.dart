import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safirah/features/authorization/authorization_keys.dart';
import 'package:safirah/features/authorization/authorization_service.dart';
import 'package:safirah/injection.dart' as di;

/// بيرجع true إذا المستخدم يقدر يعدّل الدوري (league.edit) لهذا leagueSyncId.
final canEditLeagueProvider = StreamProvider.family<bool, String>((ref, leagueSyncId) {
  final AuthorizationService service = di.sl<AuthorizationService>();

  return service
      .watchPermissions(leagueSyncId: leagueSyncId)
      .map((keys) => keys.contains(AuthorizationKeys.leagueEdit));
});
