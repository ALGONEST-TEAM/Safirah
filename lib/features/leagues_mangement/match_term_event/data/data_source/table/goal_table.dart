import 'package:drift/drift.dart';

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();

  // ✅ stable identifier for sync-based relations
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();

  TextColumn get playerSyncId => text()
      .named('player_sync_id')
      .customConstraint('REFERENCES players(sync_id) ON DELETE CASCADE')();

  /// ✅ link to match_terms via matchTerms.sync_id
  TextColumn get matchTermSyncId => text()
      .named('match_term_sync_id')
      .customConstraint('REFERENCES matchTerms(sync_id) ON DELETE CASCADE')();

  IntColumn get goalTime => integer()(); // بالثواني أو بالدقائق حسب الاتفاق

  TextColumn get goalType => text()(); // مثال: "Regular", "PK"

  TextColumn get status => text().withDefault(const Constant('active'))();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}
