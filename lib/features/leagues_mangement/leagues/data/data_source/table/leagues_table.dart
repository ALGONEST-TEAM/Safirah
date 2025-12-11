import 'package:drift/drift.dart';

class Leagues extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

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
}
