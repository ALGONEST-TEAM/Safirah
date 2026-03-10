import 'package:drift/drift.dart';

class Matches extends Table {
  // ✅ sync_id is the primary key
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  /// ✅ sync-based FK to rounds(sync_id)
  TextColumn get roundSyncId => text()
      .named('round_sync_id')
      .customConstraint('REFERENCES rounds(sync_id) ON DELETE CASCADE')();

  /// ✅ sync-based FK to teams(sync_id)
  TextColumn get homeTeamSyncId => text()
      .named('home_team_sync_id')
      .customConstraint('REFERENCES teams(sync_id) ON DELETE RESTRICT')();

  /// ✅ sync-based FK to teams(sync_id)
  TextColumn get awayTeamSyncId => text()
      .named('away_team_sync_id')
      .customConstraint('REFERENCES teams(sync_id) ON DELETE RESTRICT')();

  TextColumn get refereeSyncId => text()
      .named('referee_sync_id')
      .nullable()
      .customConstraint('REFERENCES users_has_role(sync_id) ON DELETE SET NULL')();

  TextColumn get mediaSyncId => text()
      .named('media_sync_id')
      .nullable()
      .customConstraint('REFERENCES users_has_role(sync_id) ON DELETE SET NULL')();

  DateTimeColumn get matchDate => dateTime()();
  DateTimeColumn get scheduledStartTime => dateTime().nullable()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();

  IntColumn get homeScore => integer().withDefault(const Constant(0))();
  IntColumn get awayScore => integer().withDefault(const Constant(0))();

  TextColumn get status => text()
      .withDefault(const Constant('unscheduled'))
      .check(status.isIn([
        'scheduled',
        'live',
        'unscheduled',
        'finished',
        'canceled',
        'walkover',
        'postponed'
      ]))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {syncId};

  @override
  List<String> get customConstraints => [
        'CHECK(home_team_sync_id <> away_team_sync_id)',
      ];
}
