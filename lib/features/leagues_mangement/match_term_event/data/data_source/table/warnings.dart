import 'package:drift/drift.dart';
import '../../../../match/data/data_source/table/matches_table.dart';
import '../../../../team_and_player/data/data_source/table/players_table.dart';
import 'match_terms_table.dart';

class Warnings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get matchId => integer().references(Matches, #id)();

  IntColumn get playerId => integer().references(Players, #id)();

  IntColumn get matchTermId => integer().references(MatchTerms, #id)();

  IntColumn get warningTime => integer()(); // بالثواني أو بالدقائق

  TextColumn get warningType => text()(); // مثال: "Yellow", "Red"

  TextColumn get reason => text().nullable()(); // سبب الإنذار

  TextColumn get status => text().withDefault(const Constant('active'))();
}
