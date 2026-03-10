import 'package:drift/drift.dart';

class LeagueStatus extends Table {
  /// الأساس الجديد: الربط عبر sync id
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('REFERENCES leagues(sync_id) ON DELETE CASCADE')();


  BoolColumn get hasGroups => boolean().withDefault(const Constant(false))();
  BoolColumn get hasKnockout => boolean().withDefault(const Constant(false))();

  BoolColumn get hasTeamsInGroups => boolean().withDefault(const Constant(false))();
  BoolColumn get hasMatches => boolean().withDefault(const Constant(false))();
  BoolColumn get hasPlayersAssigned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {leagueSyncId};
}
