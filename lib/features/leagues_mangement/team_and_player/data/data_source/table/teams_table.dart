import 'package:drift/drift.dart';
import '../../../../leagues/data/data_source/table/leagues_table.dart';

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get leagueId => integer().references(Leagues, #id, onDelete: KeyAction.cascade)();
  TextColumn get teamName => text().named('team_name')();
  TextColumn get logoUrl => text().named('logo_url').nullable()();
  TextColumn get status => text().withDefault(const Constant('placeholder'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
