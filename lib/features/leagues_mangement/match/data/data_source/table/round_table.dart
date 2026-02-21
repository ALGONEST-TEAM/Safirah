import 'package:drift/drift.dart';


class Rounds extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get syncId => text().named('sync_id')();

  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();
  TextColumn get name => text().named('round_name')();

  TextColumn get groupSyncId => text()
      .named('group_sync_id').nullable()
      .customConstraint('REFERENCES "group"(sync_id) ON DELETE CASCADE')();
  TextColumn get roundType => text().named('round_type')
      .check(roundType.isIn(['group','knockout','final','placement','qualifier']))() ;
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
        'UNIQUE(league_sync_id, group_sync_id, round_name)'
      ];
}
