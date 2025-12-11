import 'package:drift/drift.dart';
import '../../../../leagues/data/data_source/table/leagues_table.dart';
import 'team_player_categories_table.dart';

class LeaguePlayers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get leagueId =>
      integer().references(Leagues, #id, onDelete: KeyAction.cascade)();
  IntColumn get userId => integer().named('user_id')();
  IntColumn get teamPlayerCategoryId => integer().named('team_player_category_id').nullable()
      .references(TeamPlayerCategories, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}