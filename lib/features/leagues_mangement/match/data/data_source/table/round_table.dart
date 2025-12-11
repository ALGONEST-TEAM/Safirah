// ROUND
import 'package:drift/drift.dart';

import '../../../../group/data/data_source/table/group_table.dart';
import '../../../../leagues/data/data_source/table/leagues_table.dart';

class Rounds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get leagueId => integer().references(Leagues, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().named('round_name')();
  IntColumn get groupId =>
      integer().nullable().references(Group, #id, onDelete: KeyAction.cascade)();
  // league|group|knockout|final
  TextColumn get roundType => text().named('round_type')
      .check(roundType.isIn(['group','knockout','final','placement','qualifier']))() ;
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['UNIQUE(league_id, group_id, round_name)'];
}

