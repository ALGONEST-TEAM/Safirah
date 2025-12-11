import 'package:drift/drift.dart';

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entityType => text()();     // league, team, player...
  IntColumn get entityId => integer()();     // الـ id المحلي
  TextColumn get operation => text()();      // create | update | delete
  TextColumn get payload => text()();        // JSON data

  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
