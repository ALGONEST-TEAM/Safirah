import 'package:drift/drift.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/table/terms_table.dart';

import '../../../../leagues/data/data_source/table/leagues_table.dart';

class LeagueTerms extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get leagueId => integer().references(Leagues, #id)();

  IntColumn get termId => integer().references(Terms, #id)();

  IntColumn get durationMinutes =>
      integer().withDefault(const Constant(45))(); // مدة الشوط الافتراضية

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
