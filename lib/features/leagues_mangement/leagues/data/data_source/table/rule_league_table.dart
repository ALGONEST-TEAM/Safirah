import 'package:drift/drift.dart';
import 'leagues_table.dart';

class LeagueRules extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get leagueId => integer().references(Leagues, #id)();

  TextColumn get description => text()();

  BoolColumn get isMandatory =>
      boolean().withDefault(const Constant(false))(); // اختيارية أو إلزامية

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
