import 'package:drift/drift.dart';

class QualifiedTeam extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();


  TextColumn get groupSyncId => text()
      .named('group_sync_id')
      .customConstraint('REFERENCES "group"(sync_id) ON DELETE CASCADE')();
  TextColumn get teamSyncId => text()
      .named('team_sync_id')
      .customConstraint('NULL REFERENCES teams(sync_id) ON DELETE CASCADE')();

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
      ['UNIQUE(sync_id)'];
}
