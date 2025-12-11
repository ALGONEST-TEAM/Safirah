// draft_progress_table.dart
import 'package:drift/drift.dart';

class DraftProgress extends Table {
  IntColumn get leagueId => integer()(); // PK
  TextColumn get catsJson => text().withDefault(const Constant('{}'))();      // Map<String, List<int>>
  TextColumn get unassignedJson => text().withDefault(const Constant('[]'))();// List<int>
  TextColumn get currentName => text().withDefault(const Constant(''))();
  TextColumn get currentPickJson => text().withDefault(const Constant('[]'))();// List<int>
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {leagueId};
}
