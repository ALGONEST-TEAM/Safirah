import 'package:drift/drift.dart';
import '../../../../leagues/data/data_source/table/leagues_table.dart';
import '../../../../team_and_player/data/data_source/table/teams_table.dart';
import 'group_table.dart';

class QualifiedTeam extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get leagueId =>
      integer().references(Leagues, #id, onDelete: KeyAction.cascade)();

  IntColumn get groupId =>
      integer().references(Group, #id, onDelete: KeyAction.cascade)();

  IntColumn get teamId =>
      integer().references(Teams, #id, onDelete: KeyAction.cascade)();

  IntColumn get played => integer().withDefault(const Constant(0))();

  IntColumn get wins => integer().withDefault(const Constant(0))();

  IntColumn get draws => integer().withDefault(const Constant(0))();

  IntColumn get losses => integer().withDefault(const Constant(0))();

  IntColumn get goalsFor => integer().withDefault(const Constant(0))();

  IntColumn get goalsAgainst => integer().withDefault(const Constant(0))();

  IntColumn get points => integer().withDefault(const Constant(0))();

  TextColumn get qualificationType => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints =>
      ['UNIQUE(league_id, group_id, team_id)'];
}
