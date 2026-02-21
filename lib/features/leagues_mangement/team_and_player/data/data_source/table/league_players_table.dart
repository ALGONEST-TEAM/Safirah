import 'package:drift/drift.dart';
import 'team_player_categories_table.dart';

class LeaguePlayers extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// معرف مزامنة عالمي (UUID) يُستخدم مع الـ backend بدل id المحلي.
  TextColumn get syncId => text().named('sync_id')();
  TextColumn get name => text().nullable()();
  TextColumn get code => text().nullable()();

  /// الربط الاحترافي: نحتفظ بـ leagueId (للبيانات القديمة) + leagueSyncId (للمزامنة).
  /// الأساس في الاستعلامات الجديدة يكون leagueSyncId.
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('NULL REFERENCES leagues(sync_id) ON DELETE CASCADE')();



  IntColumn get teamPlayerCategoryId => integer()
      .named('team_player_category_id')
      .nullable()
      .references(TeamPlayerCategories, #id, onDelete: KeyAction.setNull)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(league_sync_id, sync_id)',
      ];
}