import 'package:drift/drift.dart';

class MatchTerms extends Table {
  IntColumn get id => integer().autoIncrement()();

  // ✅ New: stable identifier for sync-based relations
  TextColumn get syncId => text().named('sync_id')();

  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();

  TextColumn get leagueTermSyncId => text()
      .named('league_term_sync_id')
      .customConstraint('REFERENCES leagueTerms(sync_id) ON DELETE CASCADE')();

  // وقت بداية الشوط
  DateTimeColumn get startTime => dateTime().nullable()();

  // وقت نهاية الشوط
  DateTimeColumn get endTime => dateTime().nullable()();

  // وقت إضافي (مثلاً 5 دقائق إضافية)
  IntColumn get additionalMinutes => integer().withDefault(const Constant(0))();

  // هل انتهى هذا الشوط؟
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}
