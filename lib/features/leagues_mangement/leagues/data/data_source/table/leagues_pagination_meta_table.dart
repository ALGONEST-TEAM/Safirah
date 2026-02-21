import 'package:drift/drift.dart';

/// Stores pagination metadata for leagues list (per privacy mode).
///
/// This fixes the mismatch between remote pagination (server-side) and local
/// pagination computed purely from local row count.
class LeaguesPaginationMeta extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// false = public, true = private
  BoolColumn get isPrivate => boolean()();

  IntColumn get lastPage => integer().withDefault(const Constant(1))();
  IntColumn get perPage => integer().withDefault(const Constant(20))();
  IntColumn get total => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(is_private)',
      ];
}

