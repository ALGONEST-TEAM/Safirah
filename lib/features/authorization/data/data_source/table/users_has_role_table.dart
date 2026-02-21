import 'package:drift/drift.dart';

class UsersHasRole extends Table {

  TextColumn get syncId => text()();
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();
  TextColumn get name => text()();

  TextColumn get role => text()();
  IntColumn get roleOrder =>integer().nullable()();

  @override
  List<String> get customConstraints => [
    'UNIQUE(sync_id)',
  ];
}