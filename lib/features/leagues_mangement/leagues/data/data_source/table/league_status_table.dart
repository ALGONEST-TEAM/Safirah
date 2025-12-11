import 'package:drift/drift.dart';

import 'leagues_table.dart';

class LeagueStatus extends Table {
  IntColumn get leagueId =>
      integer().references(Leagues, #id)();

  BoolColumn get hasGroups => boolean().withDefault(const Constant(false))();
  BoolColumn get hasTeamsInGroups => boolean().withDefault(const Constant(false))();
  BoolColumn get hasMatches => boolean().withDefault(const Constant(false))();
  BoolColumn get hasPlayersAssigned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {leagueId}; //  مهم جداً للـ upser
}
