import 'package:drift/drift.dart';



class GroupTeam extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get groupSyncId => text()
      .named('group_sync_id')
      .customConstraint('REFERENCES "group"(sync_id) ON DELETE CASCADE')();
  TextColumn get teamSyncId => text()
      .named('team_sync_id')
      .customConstraint('NULL REFERENCES teams(sync_id) ON DELETE CASCADE')();


  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints =>
      ['UNIQUE(sync_id)'];
}
