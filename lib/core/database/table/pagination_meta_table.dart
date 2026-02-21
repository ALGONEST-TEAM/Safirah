import 'package:drift/drift.dart';

/// Stores server-driven pagination metadata for any paginated list.
///
/// This is a generic replacement for feature-specific pagination meta tables.
///
/// Uniqueness is enforced on (resource, scope, key, parentKey).
///
/// Example usages:
/// - Leagues list: resource='leagues', scope='public'/'private'
/// - Matches list per league: resource='matches', parentKey='<leagueSyncId>'
class PaginationMeta extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Resource name: e.g. 'leagues', 'teams', 'players', 'matches'.
  TextColumn get resource => text()();

  /// Scope for variants of the same resource.
  /// Examples: 'public', 'private', 'all', 'mine', ...
  TextColumn get scope => text().withDefault(const Constant('default'))();

  /// Optional key for additional filtering/dimensions.
  /// Examples: searchTerm, sortKey, status, etc.
  TextColumn get key => text().nullable()();

  /// Optional parent identifier when pagination depends on a parent.
  /// Examples: leagueSyncId for matches list.
  TextColumn get parentKey => text().nullable()();

  IntColumn get lastPage => integer().withDefault(const Constant(1))();
  IntColumn get perPage => integer().withDefault(const Constant(20))();
  IntColumn get total => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(resource, scope, key, parent_key)',
      ];
}

