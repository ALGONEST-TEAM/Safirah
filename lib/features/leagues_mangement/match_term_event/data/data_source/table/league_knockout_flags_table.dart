import 'package:drift/drift.dart';

class LeagueKnockoutFlags extends Table {
  TextColumn get leagueSyncId => text()();

  BoolColumn get firstKnockoutCreated =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {leagueSyncId};
}
