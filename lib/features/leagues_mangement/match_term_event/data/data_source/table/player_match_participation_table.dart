
import 'package:drift/drift.dart';

import '../../../../match/data/data_source/table/matches_table.dart';
import '../../../../team_and_player/data/data_source/table/players_table.dart';
import 'match_terms_table.dart';

class PlayerMatchParticipation extends Table {
  // PK
  IntColumn get id => integer().autoIncrement()();

  // FKs (تربط مع جداول matches, players, match_terms)
  IntColumn get matchId => integer().references(Matches, #id, onDelete: KeyAction.cascade)();
  IntColumn get playerId => integer().references(Players, #id, onDelete: KeyAction.cascade)();
  IntColumn get matchTermId => integer().references(MatchTerms, #id, onDelete: KeyAction.cascade)();

  // أوقات البداية والنهاية (يمكن تغيير النوع حسب تصميمك الحقيقي)
  IntColumn get startTime => integer().nullable()();
  IntColumn get endTime => integer().nullable()();

  // اللاعب الذي تم استبداله (اختياري)
  IntColumn get substitutedPlayerId => integer().references(Players, #id, onDelete: KeyAction.cascade)();

  // نوع المشاركة (أساسي / بديل / الخ...)
  TextColumn get participationType => text()();
}