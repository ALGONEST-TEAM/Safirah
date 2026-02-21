import 'package:drift/drift.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();
  TextColumn get groupName => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get qualifiedTeamNumber => integer().withDefault(const Constant(0))();



  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id, league_sync_id)'
      ];
}
