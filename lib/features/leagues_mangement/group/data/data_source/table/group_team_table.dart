import 'package:drift/drift.dart';
import '../../../../team_and_player/data/data_source/table/teams_table.dart';
import 'group_table.dart';


class GroupTeam extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get groupId =>
      integer().references(Group, #id, onDelete: KeyAction.cascade)();
  IntColumn get teamId =>
      integer().references(Teams, #id, onDelete: KeyAction.cascade)();


  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
