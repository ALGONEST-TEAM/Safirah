import 'package:drift/drift.dart';


class UserLeaguePermissions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// معرف عالمي للمزامنة (UUID)
  TextColumn get syncId => text()();

  /// ربط بالدوري عبر sync_id (بدل id)
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  /// مفتاح الصلاحية (league.view, match.manage, ...)
  TextColumn get permissionKey => text().named('permission_key')();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
        'UNIQUE(league_sync_id, permission_key)',
      ];
}
