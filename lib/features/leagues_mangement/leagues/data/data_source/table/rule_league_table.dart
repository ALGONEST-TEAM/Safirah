import 'package:drift/drift.dart';
import 'leagues_table.dart';

class LeagueRules extends Table {
  IntColumn get id => integer().autoIncrement()();


  // الأساس الجديد: الربط عبر sync id
  TextColumn get leagueSyncId => text()
      .named('league_sync_id')
      .customConstraint('NULL REFERENCES leagues(sync_id) ON DELETE CASCADE')();

  TextColumn get syncId => text()();

  TextColumn get description => text()();

  BoolColumn get isMandatory =>
      boolean().withDefault(const Constant(false))(); // اختيارية أو إلزامية

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}
