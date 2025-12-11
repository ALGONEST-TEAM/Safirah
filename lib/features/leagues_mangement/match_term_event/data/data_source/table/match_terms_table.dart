import 'package:drift/drift.dart';
import '../../../../match/data/data_source/table/matches_table.dart';
import 'league_terms_table.dart';

class MatchTerms extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get matchId => integer().references(Matches, #id)();

  IntColumn get leagueTermId => integer().references(LeagueTerms, #id)();

  // وقت بداية الشوط
  DateTimeColumn get startTime => dateTime().nullable()();

  // وقت نهاية الشوط
  DateTimeColumn get endTime => dateTime().nullable()();

  // وقت إضافي (مثلاً 5 دقائق إضافية)
  IntColumn get additionalMinutes => integer().withDefault(const Constant(0))();

  // هل انتهى هذا الشوط؟
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
