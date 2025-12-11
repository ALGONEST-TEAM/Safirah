import 'package:drift/drift.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/data_source/table/teams_table.dart';

import 'league_players_table.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerLeagueId => integer().references(LeaguePlayers, #id, onDelete: KeyAction.cascade)();
  IntColumn get teamId => integer().nullable().references(Teams, #id, onDelete: KeyAction.setNull)();
  TextColumn get fullName => text().named('full_name')();
  TextColumn get position => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('main'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

