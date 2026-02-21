import 'package:drift/drift.dart';

class Warnings extends Table {
  IntColumn get id => integer().autoIncrement()();

  // ✅ stable identifier for sync-based relations
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();

  TextColumn get playerSyncId => text()
      .named('player_sync_id')
      .customConstraint('REFERENCES players(sync_id) ON DELETE CASCADE')();

  TextColumn get matchTermSyncId => text()
      .named('match_term_sync_id')
      .customConstraint('REFERENCES matchTerms(sync_id) ON DELETE CASCADE')();

  IntColumn get warningTime => integer()(); // بالثواني أو بالدقائق

  TextColumn get warningType => text()(); // مثال: "Yellow", "Red"

  TextColumn get reason => text().nullable()(); // سبب الإنذار

  TextColumn get status => text().withDefault(const Constant('active'))();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}
