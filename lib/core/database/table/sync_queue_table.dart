import 'package:drift/drift.dart';

/// حالات تنفيذ عملية المزامنة.
class SyncQueueStatus {
  static const String pending = 'pending';
  static const String inProgress = 'in_progress';
  static const String synced = 'synced';
  static const String failed = 'failed';

  static const List<String> values = [pending, inProgress, synced, failed];
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entityType => text()();     // league, team, player...
  IntColumn get entityId => integer()();     // الـ id المحلي

  TextColumn get operation => text()();      // create | update | delete
  TextColumn get payload => text()();        // JSON data

  /// للحفاظ على التوافق مع الاستعلامات الحالية.
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  /// الحالة الأدق للمزامنة.
  TextColumn get status => text().withDefault(const Constant(SyncQueueStatus.pending))();

  /// عدد المحاولات التي تمت لهذا السجل.
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();

  /// آخر رسالة خطأ (مختصرة) إن وُجدت.
  TextColumn get lastError => text().nullable()();

  /// وقت آخر محاولة مزامنة.
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
