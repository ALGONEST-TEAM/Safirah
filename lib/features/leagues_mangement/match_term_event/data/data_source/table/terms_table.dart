import 'package:drift/drift.dart';

class Terms extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 2, max: 50)();

  /// نوع الشوط: عادي regular، إضافي extra، ركلات ترجيح penalty
  TextColumn get type => text().withLength(min: 3, max: 20)();

  /// الترتيب (الشوط الأول = 1، الثاني = 2 ...)
  IntColumn get order => integer()();

  /// التاريخ في حال احتجنا تحديث الأشواط مستقبلًا
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
