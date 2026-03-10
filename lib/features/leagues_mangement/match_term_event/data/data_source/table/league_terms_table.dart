import 'package:drift/drift.dart';


class LeagueTerms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  TextColumn get termSyncId => text()
      .named('term_sync_id')
      .customConstraint('REFERENCES terms(sync_id) ON DELETE CASCADE')();

  IntColumn get durationMinutes =>
      integer().withDefault(const Constant(45))(); // مدة الشوط الافتراضية

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {leagueSyncId, termSyncId}, // ✅ المفتاح المنطقي
  ];
}
