import 'package:drift/drift.dart';

class PlayerMatchParticipation extends Table {
  // PK
  IntColumn get id => integer().autoIncrement()();

  // FKs (تربط مع جداول matches, players, match_terms)
  TextColumn get matchSyncId => text()
      .named('match_sync_id')
      .customConstraint('REFERENCES matches(sync_id) ON DELETE CASCADE')();
  TextColumn get playerSyncId => text()
      .named('player_sync_id')
      .customConstraint('REFERENCES players(sync_id) ON DELETE CASCADE')();
  TextColumn get matchTermSyncId => text()
      .named('match_term_sync_id')
      .customConstraint('REFERENCES matchTerms(sync_id) ON DELETE CASCADE')();

  // أوقات البداية والنهاية (يمكن تغيير النوع حسب تصميمك الحقيقي)
  IntColumn get startTime => integer().nullable()();
  IntColumn get endTime => integer().nullable()();

  // اللاعب الذي تم استبداله (اختياري)
  TextColumn get substitutedPlayerSyncId => text()
      .named('substituted_player_sync_id')
      .nullable()
      .customConstraint('REFERENCES players(sync_id) ON DELETE CASCADE')();

  // نوع المشاركة (أساسي / بديل / الخ...)
  TextColumn get participationType => text()();
}