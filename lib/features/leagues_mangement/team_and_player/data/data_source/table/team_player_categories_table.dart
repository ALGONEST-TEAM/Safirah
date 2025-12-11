import 'package:drift/drift.dart';

import '../../../../leagues/data/data_source/table/leagues_table.dart';

class TeamPlayerCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get leagueId =>
      integer().references(Leagues, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()(); // A, B, C, ...

  @override
  List<String> get customConstraints => ['UNIQUE(league_id, name)'];

}
