import 'package:drift/drift.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().named('sync_id')();
  TextColumn get playerLeagueSyncId => text()
      .named('player_league_sync_id')
      .customConstraint('NULL REFERENCES leaguePlayers(sync_id) ON DELETE CASCADE')();
  TextColumn get teamSyncId => text()
      .named('team_sync_id')
      .customConstraint('NULL REFERENCES teams(sync_id) ON DELETE CASCADE')();
  TextColumn get fullName => text().named('full_name')();
  TextColumn get position => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('main'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'UNIQUE(sync_id)',
    'UNIQUE(player_league_sync_id)',
  ];
}

