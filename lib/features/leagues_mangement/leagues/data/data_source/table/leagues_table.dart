import 'package:drift/drift.dart';

class Leagues extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// معرف مزامنة عالمي (UUID) يُستخدم مع الـ backend بدل id المحلي.
  /// يجب أن يكون فريدًا على مستوى قاعدة البيانات.
  TextColumn get syncId => text()();

  TextColumn get name => text()();
  TextColumn get nameOrganizer => text().nullable()();
  BoolColumn get canWatch => boolean().nullable().withDefault(const Constant(false))();

  TextColumn get subscriptionPrice => text()();

  TextColumn get type => text().nullable()();

  IntColumn get organizerId => integer().nullable()();

  TextColumn get scope => text().nullable()();

  TextColumn get logoPath => text().nullable()();

  DateTimeColumn get startDate => dateTime().nullable()();

  DateTimeColumn get endDate => dateTime().nullable()();

  IntColumn get maxTeams => integer().nullable()();

  IntColumn get maxMainPlayers => integer().nullable()();

  IntColumn get maxSubPlayers => integer().nullable()();

  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();

  TextColumn get status => text().withDefault(const Constant('active'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get logoLocalPath => text().named('logo_local_path').nullable()();
  @override
  List<String> get customConstraints => [
        'UNIQUE(sync_id)',
      ];
}