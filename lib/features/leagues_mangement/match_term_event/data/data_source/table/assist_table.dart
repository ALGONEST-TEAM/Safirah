import 'package:drift/drift.dart';

class Assists extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();

  TextColumn get playerSyncId => text()
      .named('player_sync_id')
      .customConstraint('REFERENCES players(sync_id) ON DELETE CASCADE')();

  TextColumn get matchTermSyncId => text()
      .named('match_term_sync_id')
      .customConstraint('REFERENCES matchTerms(sync_id) ON DELETE CASCADE')();

  // ✅ sync-based FK to goals(sync_id)
  TextColumn get goalSyncId => text()
      .named('goal_sync_id')
      .customConstraint('REFERENCES goals(sync_id) ON DELETE CASCADE')();

  IntColumn get assistTime => integer()();

  TextColumn get status => text().withDefault(const Constant('active'))();
}