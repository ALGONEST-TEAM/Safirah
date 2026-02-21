import 'package:drift/drift.dart';

class KnockoutProgressLocks extends Table {
  TextColumn get leagueSyncId => text()();
  TextColumn get finishedRoundSyncId => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {leagueSyncId, finishedRoundSyncId};
}
