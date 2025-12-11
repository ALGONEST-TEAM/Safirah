import 'package:drift/drift.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/table/round_table.dart';

import '../../../../leagues/data/data_source/table/leagues_table.dart';
import '../../../../team_and_player/data/data_source/table/teams_table.dart';

class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get leagueId => integer().references(Leagues, #id, onDelete: KeyAction.cascade)();
  IntColumn get roundId => integer().references(Rounds, #id, onDelete: KeyAction.cascade)();
  IntColumn get homeTeamId => integer().references(Teams, #id, onDelete: KeyAction.restrict)();
  IntColumn get awayTeamId => integer().references(Teams, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get matchDate => dateTime()(); // تاريخ اليوم
  DateTimeColumn get scheduledStartTime => dateTime().nullable()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();

  IntColumn get homeScore => integer().withDefault(const Constant(0))();
  IntColumn get awayScore => integer().withDefault(const Constant(0))();

  TextColumn get status => text().withDefault(const Constant('unscheduled'))
      .check(status.isIn(['scheduled','live','unscheduled','finished','canceled','walkover','postponed']))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'CHECK(home_team_id <> away_team_id)'
  ];
}
