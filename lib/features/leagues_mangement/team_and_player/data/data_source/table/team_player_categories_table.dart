import 'package:drift/drift.dart';

class TeamPlayerCategories extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// أساس الربط للمزامنة
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('NULL REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  TextColumn get name => text()(); // A, B, C, ...
  TextColumn get syncId => text()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(league_sync_id, name)',
        'UNIQUE(sync_id)',
      ];
}
