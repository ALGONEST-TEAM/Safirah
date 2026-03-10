import 'package:drift/drift.dart';

class Terms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();
  TextColumn get name => text().withLength(min: 2, max: 50)();
  TextColumn get type => text().withLength(min: 3, max: 20)();
  IntColumn get order => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {syncId},
  ];
}