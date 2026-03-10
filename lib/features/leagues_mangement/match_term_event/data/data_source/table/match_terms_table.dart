import 'package:drift/drift.dart';

class MatchTerms extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get syncId => text().named('sync_id')();

  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();

  TextColumn get leagueTermSyncId => text()
      .named('league_term_sync_id')
      .customConstraint('REFERENCES leagueTerms(sync_id) ON DELETE CASCADE')();

  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get additionalMinutes => integer().withDefault(const Constant(0))();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {syncId},
  ];
}