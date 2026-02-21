import 'package:drift/drift.dart';

class MatchTermPause extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// ✅ sync-based FK to match_terms(sync_id)
  TextColumn get matchTermSyncId => text()
      .named('match_term_sync_id')
      .customConstraint('REFERENCES matchTerms(sync_id) ON DELETE CASCADE')();

  DateTimeColumn get startPause => dateTime()();

  DateTimeColumn get endPause => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(match_term_sync_id, start_pause)',
      ];
}
