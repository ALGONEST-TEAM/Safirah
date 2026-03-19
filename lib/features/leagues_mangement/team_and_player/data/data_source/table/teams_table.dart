import 'package:drift/drift.dart';

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// أساس الربط للمزامنة
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('NULL REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  TextColumn get teamName => text().named('team_name')();
  TextColumn get logoUrl => text().named('logo_url').nullable()();
  TextColumn get status => text().withDefault(const Constant('placeholder'))();
  TextColumn get syncId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}
