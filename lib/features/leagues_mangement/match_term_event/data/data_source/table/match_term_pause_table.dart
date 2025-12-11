import 'package:drift/drift.dart';

import 'match_terms_table.dart';

class MatchTermPause extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get matchTermId =>
      integer().references(MatchTerms, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get startPause => dateTime()();

  DateTimeColumn get endPause => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        // اجعل كل startPause داخل نفس match_term فريدًا (اختياري)
        // يمكنك تعديل القيود حسب احتياجك. هذا مثال لـ UNIQUE.
        'UNIQUE(match_term_id, start_pause)'
            'UNIQUE(match_term_id, end_pause)'
      ];
}
