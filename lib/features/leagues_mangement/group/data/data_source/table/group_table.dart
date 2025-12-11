import 'package:drift/drift.dart';
import '../../../../leagues/data/data_source/table/leagues_table.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get leagueId => integer().references(Leagues, #id)();

  TextColumn get groupName => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get qualifiedTeamNumber => integer().withDefault(const Constant(0))();


}
