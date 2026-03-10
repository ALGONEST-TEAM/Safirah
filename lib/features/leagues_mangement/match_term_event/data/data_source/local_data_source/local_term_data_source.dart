import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../core/database/safirah_database.dart';
import '../../../../../../core/network/errors/local_app_exception.dart';
import '../../../../group/data/model/model.dart';
import '../../../../match/data/model/match_model.dart';
import '../../model/assist_model.dart';
import '../../model/goal_model.dart';
import '../../model/match_term_model.dart';
import '../../model/player_stats.dart';
import '../../model/terms_model.dart';
import '../../model/warring_model.dart';
import '../../service/match_term_event_operations.dart';
import '../../model/finish_term_result.dart';
import '../../model/start_term_result.dart';

typedef UpdatedQualifiedTeams = ({
  QualifiedTeamModel? home,
  QualifiedTeamModel? away
});
typedef UpdatedGoalWithQualifiedTeams = ({
  QualifiedTeamModel? scoring,
  QualifiedTeamModel? opttend,
  GoalModel goal
});

class MatchTermsEventLocalDataSource {
  final Safirah db;
  final MatchTermEventOperations operations;

  MatchTermsEventLocalDataSource(this.db)
      : operations = const MatchTermEventOperations();

  Future<int> insertTerm(TermsCompanion term) => db.into(db.terms).insert(term);

  Future<List<TermModel>> getAllTerms() async {
    final data = await db.select(db.terms).get();
    return data.map(TermModel.fromEntity).toList();
  }

  Future<void> seedDefaultTerms() async {
    final existing = await db.select(db.terms).get();
    if (existing.isNotEmpty) return;

    final defaultTerms = <TermsCompanion>[
      TermsCompanion.insert(
          name: 'الشوط الأول',
          type: 'regular',
          order: 1,
          syncId: '967d9f64-cb79-464d-8a79-ff8379b0694c'),
      TermsCompanion.insert(
          name: 'الشوط الثاني',
          type: 'regular',
          order: 2,
          syncId: 'a24c1724-86ec-49ef-8319-4c76724cba8a'),
      TermsCompanion.insert(
          name: 'الشوط الإضافي الأول',
          type: 'extra',
          order: 3,
          syncId: '8ce4d336-7468-4258-b311-e3c1e9e1056b'),
      TermsCompanion.insert(
          name: 'الشوط الإضافي الثاني',
          type: 'extra',
          order: 4,
          syncId: '32c34219-3dc4-463a-bc4e-a4ce6b1b378d'),
      TermsCompanion.insert(
          name: 'ركلات الترجيح',
          type: 'penalty',
          order: 5,
          syncId: 'b0334a2c-741f-48b4-aefb-d5596e4babeb'),
    ];

    await db.batch((batch) => batch.insertAll(db.terms, defaultTerms));
    // ignore: avoid_print
    print('✅ تم إدخال بيانات الأشواط الأساسية (${defaultTerms.length})');
  }

  //
  // Future<List<LeagueTermModel>> initLeagueTerms({
  //   required String leagueSyncId,
  //   required List<String> selectedTermIds,
  //   required int durationMinutes,
  // }) async {
  //   print(selectedTermIds.length);
  //   await db.transaction(() async {
  //     await (db.delete(db.leagueTerms)
  //           ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
  //         .go();
  //
  //     await db.batch((batch) {
  //       batch.insertAll(
  //         db.leagueTerms,
  //         selectedTermIds.map((termSyncId) {
  //           return LeagueTermsCompanion.insert(
  //             syncId: const Uuid().v7(),
  //             leagueSyncId: leagueSyncId,
  //             termSyncId: termSyncId,
  //             durationMinutes: Value(durationMinutes),
  //           );
  //         }).toList(),
  //       );
  //     });
  //   });
  //   final leagueTermsRows = await (db.select(db.leagueTerms)
  //         ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
  //       .get();
  //
  //   return leagueTermsRows.map(LeagueTermModel.fromEntity).toList();
  //   // ignore: avoid_print
  // }
  Future<List<LeagueTermModel>> initLeagueTerms({
    required String leagueSyncId,
    required List<String> selectedTermIds,
    required int durationMinutes,
  }) async {
    print(selectedTermIds.length);
    await db.transaction(() async {
      await (db.delete(db.leagueTerms)
            ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
          .go();

      await db.batch((batch) {
        batch.insertAll(
          db.leagueTerms,
          selectedTermIds.map((termSyncId) {
            return LeagueTermsCompanion.insert(
              syncId: const Uuid().v7(),
              leagueSyncId: leagueSyncId,
              termSyncId: termSyncId,
              durationMinutes: Value(durationMinutes),
            );
          }).toList(),
        );
      });
    });

    // Join leagueTerms with terms to get the order
    final query = await (db.select(db.leagueTerms).join([
      innerJoin(
        db.terms,
        db.terms.syncId.equalsExp(db.leagueTerms.termSyncId),
      )
    ])
          ..where(db.leagueTerms.leagueSyncId.equals(leagueSyncId)))
        .get();

    return query.map((row) {
      final leagueTerm = row.readTable(db.leagueTerms);
      final term = row.readTable(db.terms);
      return LeagueTermModel.fromEntity(leagueTerm)
          .copyWith(orderTerm: term.order);
    }).toList();
  }

  /// ✅ الدالة الأساسية - تُستخدم عند الاستدعاء المستقل (تلف transaction خاصة)
  Future<List<MatchTermModel>> createMatchTermsFromLeague({
    required String matchSyncId,
    required String leagueSyncId,
    String roundType = 'group',
  }) async {
    // عند الاستدعاء المستقل نلف بـ transaction
    return db.transaction(() async {
      return _createMatchTermsNoTx(
        matchSyncId: matchSyncId,
        leagueSyncId: leagueSyncId,
        roundType: roundType,
      );
    });
  }

  /// ✅ نسخة بدون transaction - تُستخدم داخل transactions خارجية
  /// (مثل scheduleGroupStageMatchesRR التي لديها transaction خارجية)
  /// تجنب الـ nested transactions التي تسبب تكرار league_term_sync_id
  Future<List<MatchTermModel>> createMatchTermsNoTx({
    required String matchSyncId,
    required String leagueSyncId,
    String roundType = 'group',
  }) {
    return _createMatchTermsNoTx(
      matchSyncId: matchSyncId,
      leagueSyncId: leagueSyncId,
      roundType: roundType,
    );
  }

  Future<List<MatchTermModel>> _createMatchTermsNoTx({
    required String matchSyncId,
    required String leagueSyncId,
    String roundType = 'group',
  }) async {
    // Load leagueTerms with their Terms.order (and type) so all selection/sorting is order-based.
    final lt = db.leagueTerms;
    final tr = db.terms;

    final leagueJoined = await (db.select(lt).join([
      innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
    ])
          ..where(lt.leagueSyncId.equals(leagueSyncId)))
        .get();

    if (leagueJoined.isEmpty) {
      // ignore: avoid_print
      print('⚠️ لا توجد إعدادات أشواط لهذا الدوري بعد ()');
      return [];
    }

    // Normalized list with order/type.
    final leagueTermsWithOrder = leagueJoined
        .map((row) => (
              leagueTerm: row.readTable(lt),
              term: row.readTable(tr),
            ))
        .toList();

    // Collect which leagueTermSyncIds are already attached to this match.
    // This makes the operation safe to call after/alongside server sync.
    final existingMatchTerms = await (db.select(db.matchTerms)
          ..where((t) => t.matchSyncId.equals(matchSyncId)))
        .get();
    final existingLeagueTermSyncIds = existingMatchTerms
        .map((e) => e.leagueTermSyncId)
        .where((e) => e.trim().isNotEmpty)
        .toSet();

    List<String> selectedLeagueTermSyncIds = <String>[];
    print(
        '🔍 إعدادات الأشواط للدوري $leagueSyncId: ${leagueTermsWithOrder.length} شوط');

    // Always sort by Terms.order first.
    leagueTermsWithOrder.sort((a, b) => a.term.order.compareTo(b.term.order));

    if (roundType == 'group') {
      final regular = leagueTermsWithOrder
          .where((x) => x.term.type.trim().toLowerCase() == 'regular')
          .toList();

      if (regular.isEmpty) {
        // ignore: avoid_print
        print('⚠️ لا توجد أشواط عادية (regular) في إعدادات الدوري ');
        return [];
      }

      final regularCount = regular.length.clamp(1, 2);
      selectedLeagueTermSyncIds =
          regular.take(regularCount).map((e) => e.leagueTerm.syncId).toList();

      // ignore: avoid_print
      print('⚙️ تم اختيار $regularCount شوط (regular) لدور المجموعات');
    } else if (roundType == 'knockout') {
      List<({LeagueTerm leagueTerm, Term term})> termsOfType(String type) {
        final list = leagueTermsWithOrder
            .where((x) => x.term.type.trim().toLowerCase() == type)
            .toList();
        list.sort((a, b) => a.term.order.compareTo(b.term.order));
        return list;
      }

      final regular = termsOfType('regular');
      final extra = termsOfType('extra');
      final penalty = termsOfType('penalty');

      final picked = <({LeagueTerm leagueTerm, Term term})>[];
      picked.addAll(regular.take(2));
      picked.addAll(extra.take(2));
      if (penalty.isNotEmpty) picked.add(penalty.first);

      if (picked.isEmpty) {
        final takeCount = leagueTermsWithOrder.length.clamp(1, 5);
        selectedLeagueTermSyncIds = leagueTermsWithOrder
            .take(takeCount)
            .map((e) => e.leagueTerm.syncId)
            .toList();
        // ignore: avoid_print
        print(
            '⚙️ لا توجد أنواع أشواط معروفة (regular/extra/penalty)، تم اختيار $takeCount شوط للدور knockout');
      } else {
        selectedLeagueTermSyncIds =
            picked.map((e) => e.leagueTerm.syncId).toList();
        // ignore: avoid_print
        print(
            '⚙️ تم اختيار ${selectedLeagueTermSyncIds.length} أشواط للدور knockout (regular/extra/penalty)');
      }
    } else {
      selectedLeagueTermSyncIds =
          leagueTermsWithOrder.map((x) => x.leagueTerm.syncId).toList();
      // ignore: avoid_print
      print('⚙️ تم اختيار كل الأشواط للدور $roundType');
    }

    if (selectedLeagueTermSyncIds.isEmpty) {
      // ignore: avoid_print
      print('⚠️ لا توجد أشواط مطابقة للدور $roundType للدوري ');
      return [];
    }

    // Only insert missing terms (sync-aware).
    final toInsert = selectedLeagueTermSyncIds
        .where((leagueTermSid) =>
            !existingLeagueTermSyncIds.contains(leagueTermSid))
        .toList();

    if (toInsert.isEmpty) {
      // ignore: avoid_print
      print(
          'ℹ️ matchTerms موجودة بالفعل للمباراة $matchSyncId ولن يتم إنشاء أشواط جديدة.');

      final existingModels = existingMatchTerms.map(MatchTermModel.fromEntity).toList();

      // ignore: avoid_print
      print('🧾 _createMatchTermsNoTx return (existing only): match=$matchSyncId league=$leagueSyncId roundType=$roundType count=${existingModels.length}');
      for (var i = 0; i < existingModels.length; i++) {
        final t = existingModels[i];
        // ignore: avoid_print
        print(
            '  • term[$i] syncId=${t.syncId} id=${t.id} matchSyncId=${t.matchSyncId} leagueTermSyncId=${t.leagueTermSyncId} '
            'start=${t.startTime} end=${t.endTime} additionalMinutes=${t.additionalMinutes} isFinished=${t.isFinished}');
      }

      return existingModels;
    }

    final insertedMatchTerms = <MatchTermModel>[];

    for (final leagueTermSyncId in toInsert) {
      final already = await (db.select(db.matchTerms)
            ..where((t) =>
                t.matchSyncId.equals(matchSyncId) &
                t.leagueTermSyncId.equals(leagueTermSyncId))
            ..limit(1))
          .getSingleOrNull();
      if (already != null) continue;

      final row = await db.into(db.matchTerms).insertReturning(
            MatchTermsCompanion.insert(
              syncId: const Uuid().v7(),
              matchSyncId: matchSyncId,
              leagueTermSyncId: leagueTermSyncId,
            ),
          );
      insertedMatchTerms.add(MatchTermModel.fromEntity(row));
    }

    print(
      '✅ تم إنشاء ${insertedMatchTerms.length} أشواط/شوط للمباراة '
      '$matchSyncId (${roundType.toUpperCase()}) (sync-aware)',
    );

    final returned = [
      ...existingMatchTerms.map(MatchTermModel.fromEntity),
      ...insertedMatchTerms
    ];

    // ignore: avoid_print
    print('🧾 _createMatchTermsNoTx return: match=$matchSyncId league=$leagueSyncId roundType=$roundType count=${returned.length}');
    for (var i = 0; i < returned.length; i++) {
      final t = returned[i];
      // ignore: avoid_print
      print(
          '  • term[$i] syncId=${t.syncId} id=${t.id} matchSyncId=${t.matchSyncId} leagueTermSyncId=${t.leagueTermSyncId} '
          'start=${t.startTime} end=${t.endTime} additionalMinutes=${t.additionalMinutes} isFinished=${t.isFinished}');
    }

    return returned;
  }

  // Future<List<MatchTermModel>> createMatchTermsFromLeague({
  //   required String matchSyncId,
  //   required String leagueSyncId,
  //   String roundType = 'group',
  // }) async {
  //   final leagueTerms = await (db.select(db.leagueTerms)
  //     ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
  //       .get();
  //
  //   if (leagueTerms.isEmpty) {
  //     // ignore: avoid_print
  //     print('⚠️ لا توجد إعدادات أشواط لهذا الدوري بعد ()');
  //     return [];
  //   }
  //
  //   final allTerms = await db.select(db.terms).get();
  //   final Map<String, String> termTypeBySyncId = <String, String>{
  //     for (final t in allTerms) t.syncId: t.type,
  //   };
  //
  //   List<String> selectedLeagueTermSyncIds = <String>[];
  //
  //   if (roundType == 'group') {
  //     final regularTerms = leagueTerms
  //         .where((lt) => termTypeBySyncId[lt.termSyncId] == 'regular')
  //         .toList()
  //       ..sort((a, b) => a.id.compareTo(b.id));
  //
  //     if (regularTerms.isEmpty) {
  //       // ignore: avoid_print
  //       print('⚠️ لا توجد أشواط عادية (regular) في إعدادات الدوري ');
  //       return [];
  //     }
  //
  //     final int regularCount = regularTerms.length.clamp(1, 2);
  //
  //     selectedLeagueTermSyncIds =
  //         regularTerms.take(regularCount).map((e) => e.syncId).toList();
  //
  //     // ignore: avoid_print
  //     print('⚙️ تم اختيار $regularCount شوط (regular) لدور المجموعات');
  //   } else {
  //     selectedLeagueTermSyncIds = leagueTerms.map((lt) => lt.syncId).toList();
  //     // ignore: avoid_print
  //     print('⚙️ تم اختيار كل الأشواط للدور $roundType');
  //   }
  //
  //   if (selectedLeagueTermSyncIds.isEmpty) {
  //     // ignore: avoid_print
  //     print('⚠️ لا توجد أشواط مطابقة للدور $roundType للدوري ');
  //     return [];
  //   }
  //   //
  //   // await db.batch((batch) {
  //   //   batch.insertAll(
  //   //     db.matchTerms,
  //   //     selectedLeagueTermSyncIds.map((leagueTermSyncId) {
  //   //       return MatchTermsCompanion.insert(
  //   //         syncId: const Uuid().v7(),
  //   //         matchSyncId: matchSyncId,
  //   //         leagueTermSyncId: leagueTermSyncId,
  //   //       );
  //   //     }).toList(),
  //   //   );
  //   // });
  //
  //   List<MatchTermModel> insertedMatchTerms = [];
  //
  //   await db.transaction(() async {
  //     for (final leagueTermSyncId in selectedLeagueTermSyncIds) {
  //       final row = await db.into(db.matchTerms).insertReturning(
  //         MatchTermsCompanion.insert(
  //           syncId: const Uuid().v7(),
  //           matchSyncId: matchSyncId,
  //           leagueTermSyncId: leagueTermSyncId,
  //         ),
  //       );
  //       insertedMatchTerms.add(MatchTermModel(
  //         syncId: row.syncId,
  //         id: row.id,
  //         matchSyncId: row.matchSyncId,
  //         leagueTermSyncId: row.leagueTermSyncId,
  //       ));
  //     }
  //   });
  //   print(
  //     '✅ تم إنشاء ${selectedLeagueTermSyncIds.length} أشواط للمباراة '
  //         '$matchSyncId (${roundType.toUpperCase()})',
  //   );
  //   return insertedMatchTerms;
  // }
  // ✅ now matchTerms is sync-based but we still keep old signature (id) for UI.
  //   Future<int?> getTermDuration(String matchTermSyncId) async {
  //
  //     final query = await (db.select(db.matchTerms).join(<Join>[
  //       innerJoin(
  //         db.leagueTerms,
  //         db.leagueTerms.syncId.equalsExp(db.matchTerms.leagueTermSyncId),
  //       )
  //     ])
  //           ..where(db.matchTerms.syncId.equals(matchTermSyncId)))
  //         .getSingleOrNull();
  //
  //     if (query == null) {
  //       print('nullllllllllll');
  //       return null;
  //     }
  //
  //     final leagueTerm = query.readTable(db.leagueTerms);
  //     return leagueTerm.durationMinutes;
  //   }
  Future<int?> getTermDuration(String matchTermSyncId) async {
    final rows = await (db.select(db.matchTerms).join([
      innerJoin(
        db.leagueTerms,
        db.leagueTerms.syncId.equalsExp(db.matchTerms.leagueTermSyncId),
      )
    ])
          ..where(db.matchTerms.syncId.equals(matchTermSyncId))
          ..limit(1))
        .get();

    if (rows.isEmpty) return null;

    final leagueTerm = rows.first.readTable(db.leagueTerms);
    return leagueTerm.durationMinutes;
  }

  Future<void> updateAdditionalMinutes(
    String termSyncId,
    int additionalMinutes,
  ) async {
    await (db.update(db.matchTerms)
          ..where((tbl) => tbl.syncId.equals(termSyncId)))
        .write(
      MatchTermsCompanion(
        additionalMinutes: Value(additionalMinutes),
      ),
    );
  }

  Future<StartTermResult> startTermSafe(String matchSyncId, String matchTermSyncId) async {
    return db.transaction(() async {
      final match = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();

      if (match == null) {
        throw Exception('⚠️ لم يتم العثور على المباراه');
      }

      final now = DateTime.now();
      final scheduledStart = match.scheduledStartTime ?? match.matchDate;

      // Don't allow starting before scheduled start (with a small grace window).
      const grace = Duration(seconds: 30);
      if (now.isBefore(scheduledStart.subtract(grace))) {
        throw Exception('لايمكن بدء المباراه قبل موعدها المحدد');
      }

      if (match.status != 'live') {
        await (db.update(db.matches)
              ..where((m) => m.syncId.equals(matchSyncId)))
            .write(
          MatchesCompanion(
            status: const Value('live'),
            startTime: Value(now),
            updatedAt: Value(now),
          ),
        );
      }

      // Update the match-term itself.
      await (db.update(db.matchTerms)
            ..where((t) => t.syncId.equals(matchTermSyncId)))
          .write(
        MatchTermsCompanion(
          startTime: Value(now),
          isFinished: const Value(false),
        ),
      );

      // Load the updated match-term row so we can get its leagueTermSyncId.
      final matchTermRow = await (db.select(db.matchTerms)
            ..where((t) => t.syncId.equals(matchTermSyncId)))
          .getSingleOrNull();

      if (matchTermRow == null) {
        throw Exception('⚠️ لم يتم العثور على شوط المباراة بعد التحديث');
      }

      // Fetch the league-term row by its own syncId (from league_terms_table.dart).
      final termRow = await (db.select(db.leagueTerms)
            ..where((t) => t.syncId.equals(matchTermRow.leagueTermSyncId)))
          .getSingleOrNull();

      if (termRow == null) {
        throw Exception('⚠️ لم يتم العثور على الشوط (LeagueTerm) بعد التحديث');
      }

      // ignore: avoid_print
      print('✅ بدأ الشوط لمدة دقيقة للمباراة $matchSyncId');

      return StartTermResult(
        termStarted: true,
        matchSyncId: matchSyncId,
        matchTermSyncId: matchTermSyncId,
        leagueTermSyncId: termRow.syncId,
        termStartTime: now,
        matchStatus: 'live',
      );
    });
  }

  Future<FinishTermResult> finishTermSmart({
    required String matchSyncId,
    required String matchTermSyncId,
  }) async {
    bool _isPenaltyTerm(Term tr) {
      final name = tr.name.trim();
      final type = tr.type.trim().toLowerCase();
      // DB عندكم قد يجعل ركلات الترجيح type='اضافي'، لذلك نميّزها بالاسم/الترتيب.
      return type == 'penalty' ||
          type == 'ترجيح' ||
          name.contains('ترجيح') ||
          name.contains('ركلات') ||
          tr.order == 5;
    }

    int _typePriority(String raw, {required Term tr}) {
      if (_isPenaltyTerm(tr)) return 2;
      final v = raw.trim().toLowerCase();
      if (v == 'regular' || v == 'اساسي' || v == 'أساسي') return 0;
      if (v == 'extra' || v == 'اضافي' || v == 'إضافي') return 1;
      return 9;
    }

    FinishTermResult _result({
      required bool termFinished,
      required bool matchFinished,
      required bool isKnockout,
      required MatchModel match,
      required MatchTerm termRow,
      DateTime? matchEndTime,
      bool pointsUpdatedLocally = false,
    }) {
      return FinishTermResult(
        termFinished: termFinished,
        matchFinished: matchFinished,
        pointsUpdatedLocally: pointsUpdatedLocally,
        isKnockout: isKnockout,
        matchEndTime: matchEndTime,
        termEndTime: termRow.endTime,
        additionalMinutes: termRow.additionalMinutes,
        matchSyncId: matchSyncId,
        matchTermSyncId: termRow.syncId,
        leagueTermSyncId: termRow.leagueTermSyncId,
        homeScore: match.homeScore,
        awayScore: match.awayScore,
        leagueSyncId: match.leagueSyncId,
      );
    }

    Future<MatchModel> _loadMatchOrThrow() async {
      final e = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();
      if (e == null) {
        throw Exception('❌ لم يتم العثور على المباراة $matchSyncId');
      }
      return MatchModel.fromEntityWithRelations(e);
    }

    Future<bool> _isKnockoutOrThrow(MatchModel match) async {
      final roundSyncId = match.roundSyncId;
      if (roundSyncId == null) {
        throw Exception('❌ roundSyncId غير موجود للمباراة $matchSyncId');
      }

      final r = await (db.select(db.rounds)
            ..where((x) => x.syncId.equals(roundSyncId)))
          .getSingleOrNull();
      if (r == null) {
        throw Exception(
            '❌ لم يتم العثور على الجولة الخاصة بالمباراة $matchSyncId');
      }
      return r.roundType == 'knockout';
    }

    Future<List<({MatchTerm mt, LeagueTerm lt, Term tr})>>
        _loadOrderedTermsOrThrow() async {
      final mt = db.matchTerms;
      final lt = db.leagueTerms;
      final tr = db.terms;

      final rows = await (db.select(mt).join([
        innerJoin(lt, lt.syncId.equalsExp(mt.leagueTermSyncId)),
        innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
      ])
            ..where(mt.matchSyncId.equals(matchSyncId)))
          .get();

      if (rows.isEmpty) {
        throw Exception('❌ لا توجد أشواط لهذه المباراة $matchSyncId');
      }

      final all = rows
          .map((row) => (
                mt: row.readTable(mt),
                lt: row.readTable(lt),
                tr: row.readTable(tr),
              ))
          .toList();

      // ✅ الأهم: الاعتماد على order الفعلي لضمان تسلسل الأشواط:
      // 1 -> 2 -> 3 -> 4 -> 5
      // مع كسر التعادل بتحويل penalty لآخر شيء لو حصل تساوي غير متوقع.
      all.sort((a, b) {
        final byOrder = a.tr.order.compareTo(b.tr.order);
        if (byOrder != 0) return byOrder;

        final ap = _typePriority(a.tr.type, tr: a.tr);
        final bp = _typePriority(b.tr.type, tr: b.tr);
        final byType = ap.compareTo(bp);
        if (byType != 0) return byType;

        return a.mt.id.compareTo(b.mt.id);
      });

      return all;
    }

    bool _allFinished(Iterable<({MatchTerm mt, LeagueTerm lt, Term tr})> xs) =>
        xs.every((x) => x.mt.isFinished);

    return db.transaction(() async {
      // 1) Read/validate for safety (tables existence + coherent state)
      final match0 = await _loadMatchOrThrow();
      final isKnockout = await _isKnockoutOrThrow(match0);

      final all = await _loadOrderedTermsOrThrow();

      // Always use DB state to decide what is the current term
      final current = all.where((x) => !x.mt.isFinished).firstOrNull;

      // If no current term => match is effectively finished
      if (current == null) {
        final now = DateTime.now();
        await finishMatch(match0);
        final matchNow = await _loadMatchOrThrow();
        final last = all.last.mt;
        return _result(
          termFinished: true,
          matchFinished: true,
          isKnockout: isKnockout,
          match: matchNow,
          termRow: last,
          matchEndTime: now,
          pointsUpdatedLocally: !isKnockout,
        );
      }

      // Guard: only finish CURRENT term (idempotent & prevents re-showing term)
      if (current.mt.syncId != matchTermSyncId) {
        final matchNow = await _loadMatchOrThrow();
        return _result(
          termFinished: false,
          matchFinished: false,
          isKnockout: isKnockout,
          match: matchNow,
          termRow: current.mt,
        );
      }

      final now = DateTime.now();

      // 2) Finish term atomically: set isFinished + endTime
      // (endTime previously wasn't written which can confuse sync/UI)
      await (db.update(db.matchTerms)
            ..where((t) => t.syncId.equals(matchTermSyncId)))
          .write(
        MatchTermsCompanion(
          isFinished: const Value(true),
          endTime: Value(now),
        ),
      );

      // 3) Re-read tables after mutation (safety)
      final match = await _loadMatchOrThrow();
      final all2 = await _loadOrderedTermsOrThrow();

      final finishedTerm =
          all2.firstWhere((x) => x.mt.syncId == matchTermSyncId).mt;
      final next = all2.where((x) => !x.mt.isFinished).firstOrNull;

      final regular =
          all2.where((x) => _typePriority(x.tr.type, tr: x.tr) == 0).toList();
      final extra =
          all2.where((x) => _typePriority(x.tr.type, tr: x.tr) == 1).toList();
      final penalty =
          all2.where((x) => _typePriority(x.tr.type, tr: x.tr) == 2).toList();

      final regularFinished = regular.isEmpty ? true : _allFinished(regular);
      final extraFinished = extra.isEmpty ? true : _allFinished(extra);
      final penaltyFinished = penalty.isEmpty ? true : _allFinished(penalty);

      final tie = match.homeScore == match.awayScore;

      // 4) Knockout flow
      if (isKnockout) {
        // A) Regular ended, not tie => finish match and auto-finish remaining terms
        if (regularFinished && !tie) {
          for (final x in [...extra, ...penalty]) {
            if (!x.mt.isFinished) {
              await (db.update(db.matchTerms)
                    ..where((t) => t.id.equals(x.mt.id)))
                  .write(
                MatchTermsCompanion(
                  isFinished: const Value(true),
                  endTime: Value(now),
                ),
              );
            }
          }

          await finishMatch(match);
          final matchEnd = await _loadMatchOrThrow();
          return _result(
            termFinished: true,
            matchFinished: true,
            isKnockout: true,
            match: matchEnd,
            termRow: finishedTerm,
            matchEndTime: now,
          );
        }

        // B) Regular ended, tie => go next if exists, else finish
        if (regularFinished && tie) {
          if (next != null) {
            return _result(
              termFinished: true,
              matchFinished: false,
              isKnockout: true,
              match: match,
              termRow: next.mt,
            );
          }

          await finishMatch(match);
          final matchEnd = await _loadMatchOrThrow();
          return _result(
            termFinished: true,
            matchFinished: true,
            isKnockout: true,
            match: matchEnd,
            termRow: finishedTerm,
            matchEndTime: now,
          );
        }

        // C) Extra ended, not tie => finish (and close penalty if exists)
        if (extra.isNotEmpty && extraFinished && !tie) {
          for (final x in penalty) {
            if (!x.mt.isFinished) {
              await (db.update(db.matchTerms)
                    ..where((t) => t.id.equals(x.mt.id)))
                  .write(
                MatchTermsCompanion(
                  isFinished: const Value(true),
                  endTime: Value(now),
                ),
              );
            }
          }

          await finishMatch(match);
          final matchEnd = await _loadMatchOrThrow();
          return _result(
            termFinished: true,
            matchFinished: true,
            isKnockout: true,
            match: matchEnd,
            termRow: finishedTerm,
            matchEndTime: now,
          );
        }

        // D) Penalty ended => finish match
        if (penalty.isNotEmpty && penaltyFinished) {
          await finishMatch(match);
          final matchEnd = await _loadMatchOrThrow();
          return _result(
            termFinished: true,
            matchFinished: true,
            isKnockout: true,
            match: matchEnd,
            termRow: finishedTerm,
            matchEndTime: now,
          );
        }

        // Ongoing => go next
        if (next != null) {
          return _result(
            termFinished: true,
            matchFinished: false,
            isKnockout: true,
            match: match,
            termRow: next.mt,
          );
        }

        // Fallback
        await finishMatch(match);
        final matchEnd = await _loadMatchOrThrow();
        return _result(
          termFinished: true,
          matchFinished: true,
          isKnockout: true,
          match: matchEnd,
          termRow: finishedTerm,
          matchEndTime: now,
        );
      }

      // 5) Non-knockout: finish when all terms are finished
      final allFinished = all2.every((x) => x.mt.isFinished);
      if (allFinished) {
        return _result(
          termFinished: true,
          matchFinished: true,
          isKnockout: false,
          match: match,
          termRow: finishedTerm,
          matchEndTime: now,
          pointsUpdatedLocally: true,
        );
      }

      if (next != null) {
        return _result(
          termFinished: true,
          matchFinished: false,
          isKnockout: false,
          match: match,
          termRow: next.mt,
          pointsUpdatedLocally: false,
        );
      }

      return _result(
        termFinished: true,
        matchFinished: false,
        isKnockout: false,
        match: match,
        termRow: finishedTerm,
      );
    });
  }

  Future<void> finishMatch(MatchModel match) async {
    if (match.status == 'finished') {
      // ignore: avoid_print
      print('⚠️ المباراة ${match.syncId} منتهية مسبقًا — تم تجاهل الإجراء.');
      return;
    }

    final matchSyncId = (match.syncId ?? '').trim();
    if (matchSyncId.isEmpty) {
      throw Exception('finishMatch requires match.syncId');
    }

    final now = DateTime.now();
    await (db.update(db.matches)..where((m) => m.syncId.equals(matchSyncId)))
        .write(
      MatchesCompanion(
        status: const Value('finished'),
        updatedAt: Value(now),
        endTime: Value(now),
      ),
    );
    // ignore: avoid_print
    print('🏁 تم إنهاء المباراة $matchSyncId');
  }

  Future<MatchTermModel> getCurrentMatchTerm(String matchSyncId) async {
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.syncId.equals(matchSyncId)))
        .getSingleOrNull();

    if (matchEntity == null) {
      print("1");
      return MatchTermModel(
        syncId: '',
        id: 0,
        matchSyncId: '',
        leagueTermSyncId: '',
        isFinished: true,
        termName: 'انتهت المباراة',
        termType: 'finished',
        leagueTermName: '',
      );
    }

    final joinedTerms = await (db.select(db.matchTerms).join(<Join>[
      innerJoin(
        db.leagueTerms,
        db.leagueTerms.syncId.equalsExp(db.matchTerms.leagueTermSyncId),
      ),
      innerJoin(
        db.terms,
        db.terms.syncId.equalsExp(db.leagueTerms.termSyncId),
      ),
    ])
          ..where(db.matchTerms.matchSyncId.equals(matchSyncId))
          ..orderBy([
            OrderingTerm.asc(db.terms.order),
            OrderingTerm.asc(db.matchTerms.id),
          ]))
        .get();

    if (joinedTerms.isEmpty) {
      print("2");

      return MatchTermModel(
        syncId: '',
        id: 0,
        matchSyncId: matchSyncId,
        leagueTermSyncId: '',
        isFinished: true,
        termName: 'انتهت المباراة',
        termType: 'finished',
        leagueTermName: '',
      );
    }

    final matchTerms = joinedTerms.map((row) {
      final mt = row.readTable(db.matchTerms);
      final lt = row.readTable(db.leagueTerms);
      final term = row.readTable(db.terms);

      return MatchTermModel(
        syncId: mt.syncId,
        id: mt.id,
        matchSyncId: mt.matchSyncId,
        leagueTermSyncId: mt.leagueTermSyncId,
        startTime: mt.startTime,
        endTime: mt.endTime,
        additionalMinutes: mt.additionalMinutes,
        isFinished: mt.isFinished,
        leagueTermName: lt.syncId,
        termName: term.name,
        termType: term.type,
      );
    }).toList();

    for (final term in matchTerms) {
      if (!term.isFinished) return term;
    }

    print('3');
    return MatchTermModel(
      syncId: '',
      id: 0,
      matchSyncId: matchSyncId,
      leagueTermSyncId: '',
      isFinished: true,
      termName: 'انتهت المباراة',
      termType: 'finished',
      leagueTermName: '',
    );
  }

  Future<UpdatedQualifiedTeams> finishMatchAndUpdatePoints(
    String matchSyncId,
    DateTime now,
  ) async {
    return db.transaction<UpdatedQualifiedTeams>(() async {
      final matchEntity = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();

      if (matchEntity == null) {
        throw Exception('❌ لم يتم العثور على المباراة رقم $matchSyncId');
      }

      final match = MatchModel.fromEntityWithRelations(matchEntity);

      if (match.status.toLowerCase().trim() == 'finished') {
        // ترجع القيم الحالية بدون تعديل (إن وجدت)
        final q = db.qualifiedTeam;

        final leagueId = (match.leagueSyncId ?? '').trim();
        if (leagueId.isEmpty) return (home: null, away: null);

        final homeId = (match.homeTeamSyncId ?? '').trim();
        final awayId = (match.awayTeamSyncId ?? '').trim();
        if (homeId.isEmpty || awayId.isEmpty) return (home: null, away: null);

        final homeRow = await (db.select(q)
              ..where((t) =>
                  t.leagueSyncId.equals(leagueId) &
                  t.teamSyncId.equals(homeId)))
            .getSingleOrNull();

        final awayRow = await (db.select(q)
              ..where((t) =>
                  t.leagueSyncId.equals(leagueId) &
                  t.teamSyncId.equals(awayId)))
            .getSingleOrNull();

        return (
          home: homeRow != null ? QualifiedTeamModel.fromEntity(homeRow) : null,
          away: awayRow != null ? QualifiedTeamModel.fromEntity(awayRow) : null,
        );
      }

      final leagueId = (match.leagueSyncId ?? '').trim();
      if (leagueId.isEmpty) {
        throw Exception(
            '⚠️ لا يمكن تحديث النقاط لأن match.leagueSyncId غير موجود.');
      }

      final homeId = (match.homeTeamSyncId ?? '').trim();
      final awayId = (match.awayTeamSyncId ?? '').trim();
      if (homeId.isEmpty || awayId.isEmpty) {
        throw Exception('❌ أحد الفريقين غير معرف في المباراة $matchSyncId');
      }

      int homePoints = 0;
      int awayPoints = 0;

      if (match.homeScore > match.awayScore) {
        homePoints = 3;
      } else if (match.awayScore > match.homeScore) {
        awayPoints = 3;
      } else {
        homePoints = 1;
        awayPoints = 1;
      }

      final q = db.qualifiedTeam;

      QualifiedTeamModel? updatedHome;
      QualifiedTeamModel? updatedAway;

      final homeRow = await (db.select(q)
            ..where((t) =>
                t.leagueSyncId.equals(leagueId) & t.teamSyncId.equals(homeId)))
          .getSingleOrNull();

      if (homeRow != null) {
        updatedHome = QualifiedTeamModel.fromEntity(homeRow).copyWith(
          points: homeRow.points + homePoints,
          played: homeRow.played + 1,
          wins: homePoints == 3 ? homeRow.wins + 1 : homeRow.wins,
          losses: homePoints == 0 ? homeRow.losses + 1 : homeRow.losses,
          draws: homePoints == 1 ? homeRow.draws + 1 : homeRow.draws,
        );

        await (db.update(q)..where((t) => t.id.equals(homeRow.id)))
            .write(updatedHome.toCompanionUpdate());
      }

      final awayRow = await (db.select(q)
            ..where((t) =>
                t.leagueSyncId.equals(leagueId) & t.teamSyncId.equals(awayId)))
          .getSingleOrNull();

      if (awayRow != null) {
        updatedAway = QualifiedTeamModel.fromEntity(awayRow).copyWith(
          points: awayRow.points + awayPoints,
          played: awayRow.played + 1,
          wins: awayPoints == 3 ? awayRow.wins + 1 : awayRow.wins,
          losses: awayPoints == 0 ? awayRow.losses + 1 : awayRow.losses,
          draws: awayPoints == 1 ? awayRow.draws + 1 : awayRow.draws,
        );

        await (db.update(q)..where((t) => t.id.equals(awayRow.id)))
            .write(updatedAway.toCompanionUpdate());
      }

      await (db.update(db.matches)..where((m) => m.syncId.equals(matchSyncId)))
          .write(
        MatchesCompanion(
          status: const Value('finished'),
          updatedAt: Value(now),
          endTime: Value(now),
        ),
      );

      return (home: updatedHome, away: updatedAway);
    });
  }

  Future<UpdatedGoalWithQualifiedTeams> insertGoalAndUpdateQualifiedTeams(
    GoalModel goal,
  ) async {
    late GoalModel insertedGoal;
    QualifiedTeamModel? opponent;
    QualifiedTeamModel? scoring;

    await db.transaction(() async {
      final inserted =
          await db.into(db.goals).insertReturning(goal.toCompanionInsert());

      final match = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(goal.matchSyncId)))
          .getSingleOrNull();
      if (match == null) throw Exception('❌ لم يتم العثور على المباراة');

      final player = await (db.select(db.players)
            ..where((p) => p.syncId.equals(goal.playerSyncId)))
          .getSingleOrNull();
      if (player == null) throw Exception('❌ لم يتم العثور على اللاعب');

      insertedGoal = GoalModel.fromEntity(inserted);

      final isOwnGoal = goal.goalType == 'own_goal';

      final playerTeamSyncId = (player.teamSyncId).trim();
      if (playerTeamSyncId.isEmpty) {
        throw Exception(
            '❌ اللاعب بدون teamSyncId، لا يمكن تحديد الفريق المسجل');
      }

      final isPlayerHome = playerTeamSyncId == match.homeTeamSyncId;
      final isPlayerAway = playerTeamSyncId == match.awayTeamSyncId;
      if (!isPlayerHome && !isPlayerAway) {
        throw Exception('❌ فريق اللاعب لا يطابق طرفي المباراة');
      }

      // الفريق الذي يُحسب له الهدف
      final scoringTeamSyncId = isOwnGoal
          ? (isPlayerHome ? match.awayTeamSyncId : match.homeTeamSyncId)
          : playerTeamSyncId;

      final opponentTeamSyncId = scoringTeamSyncId == match.homeTeamSyncId
          ? match.awayTeamSyncId
          : match.homeTeamSyncId;

      final updatedHomeScore =
          match.homeScore + (scoringTeamSyncId == match.homeTeamSyncId ? 1 : 0);
      final updatedAwayScore =
          match.awayScore + (scoringTeamSyncId == match.awayTeamSyncId ? 1 : 0);

      await (db.update(db.matches)..where((m) => m.syncId.equals(match.syncId)))
          .write(
        MatchesCompanion(
          homeScore: Value(updatedHomeScore),
          awayScore: Value(updatedAwayScore),
        ),
      );

      final q = db.qualifiedTeam;

      final scoringRow = await (db.select(q)
            ..where((t) =>
                t.leagueSyncId.equals(match.leagueSyncId) &
                t.teamSyncId.equals(scoringTeamSyncId)))
          .getSingleOrNull();

      if (scoringRow != null) {
        scoring = QualifiedTeamModel.fromEntity(scoringRow)
            .copyWith(goalsFor: scoringRow.goalsFor + 1);
        await (db.update(q)..where((t) => t.syncId.equals(scoringRow.syncId)))
            .write(
          QualifiedTeamCompanion(goalsFor: Value(scoringRow.goalsFor + 1)),
        );
      }

      final opponentRow = await (db.select(q)
            ..where((t) =>
                t.leagueSyncId.equals(match.leagueSyncId) &
                t.teamSyncId.equals(opponentTeamSyncId)))
          .getSingleOrNull();

      if (opponentRow != null) {
        opponent = QualifiedTeamModel.fromEntity(opponentRow)
            .copyWith(goalsAgainst: opponentRow.goalsAgainst + 1);
        await (db.update(q)..where((t) => t.syncId.equals(opponentRow.syncId)))
            .write(
          QualifiedTeamCompanion(
              goalsAgainst: Value(opponentRow.goalsAgainst + 1)),
        );
      }
    });

    return (opttend: opponent!, scoring: scoring, goal: insertedGoal);
  }

  Future<PlayerStats> getPlayerStats({
    required String matchSyncId,
    required String playerSyncId,
  }) async {
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.syncId.equals(matchSyncId)))
        .getSingleOrNull();

    if (matchEntity == null) {
      return operations.buildPlayerStats(
        goals: 0,
        assists: 0,
        yellowCards: 0,
        redCards: 0,
      );
    }

    final goalsCount = await (db.select(db.goals)
          ..where((g) =>
              g.matchSyncId.equals(matchSyncId) &
              g.playerSyncId.equals(playerSyncId) &
              g.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    final assistsCount = await (db.select(db.assists)
          ..where((a) =>
              a.matchSyncId.equals(matchSyncId) &
              a.playerSyncId.equals(playerSyncId) &
              a.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    final yellowCount = await (db.select(db.warnings)
          ..where((w) =>
              w.matchSyncId.equals(matchSyncId) &
              w.playerSyncId.equals(playerSyncId) &
              w.warningType.equals('yellow') &
              w.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    final redCount = await (db.select(db.warnings)
          ..where((w) =>
              w.matchSyncId.equals(matchSyncId) &
              w.playerSyncId.equals(playerSyncId) &
              w.warningType.equals('red') &
              w.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    return operations.buildPlayerStats(
      goals: goalsCount,
      assists: assistsCount,
      yellowCards: yellowCount,
      redCards: redCount,
    );
  }

  // ---------------------------------------------------------------------------
  // Repository-required methods (were missing due to incomplete file edits)
  // ---------------------------------------------------------------------------

  Future<MatchModel?> getFullMatchData(String matchSyncId) async {
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.syncId.equals(matchSyncId)))
        .getSingleOrNull();

    if (matchEntity == null) return null;
    return MatchModel.fromEntityWithRelations(matchEntity);
  }

  Future<WarningModel> insertWarning(WarningModel warning) async {
    final insertedId =
        await db.into(db.warnings).insert(warning.toCompanionInsert());
    final entity = await (db.select(db.warnings)
          ..where((w) => w.id.equals(insertedId)))
        .getSingle();
    return WarningModel.fromEntity(entity);
  }

  Future<void> deleteWarningBySyncId(String warningSyncId) async {
    await (db.update(db.warnings)..where((w) => w.syncId.equals(warningSyncId)))
        .write(const WarningsCompanion(status: Value('deleted')));
  }

  /// Backward-compatible: legacy delete by numeric id.
  Future<void> deleteWarning(int warningId) async {
    final row = await (db.select(db.warnings)
          ..where((w) => w.id.equals(warningId)))
        .getSingleOrNull();
    if (row == null) return;
    await deleteWarningBySyncId(row.syncId);
  }

  /// Deletes a goal by syncId and returns the assister playerSyncId if any (so UI can update assist stats).
  Future<String?> deleteGoalBySyncId(String goalSyncId) async {
    return db.transaction(() async {
      final goalRow = await (db.select(db.goals)
            ..where((g) => g.syncId.equals(goalSyncId)))
          .getSingleOrNull();
      if (goalRow == null) return null;

      final assistRow = await (db.select(db.assists)
            ..where((a) =>
                a.goalSyncId.equals(goalRow.syncId) &
                a.status.equals('active')))
          .getSingleOrNull();

      if (assistRow != null) {
        await (db.update(db.assists)..where((a) => a.id.equals(assistRow.id)))
            .write(const AssistsCompanion(status: Value('deleted')));
      }

      await (db.update(db.goals)..where((g) => g.syncId.equals(goalSyncId)))
          .write(
        const GoalsCompanion(status: Value('deleted')),
      );

      return assistRow?.playerSyncId;
    });
  }

  /// Backward-compatible: delete by numeric id (UI might still pass it).
  /// Internally resolves syncId then deletes by syncId.
  Future<String?> deleteGoal(int goalId) async {
    final goalRow = await (db.select(db.goals)
          ..where((g) => g.id.equals(goalId)))
        .getSingleOrNull();
    if (goalRow == null) return null;
    return deleteGoalBySyncId(goalRow.syncId);
  }

  Future<AssistModel> addAssist(AssistModel assist) async {

    if (assist.goalSyncId.trim().isEmpty || assist.playerSyncId.trim().isEmpty) {
      throw LocalAppException.userMessage('بيانات الأسيست غير مكتملة');
    }

    // 1) prevent duplicate assist for the same goal
    final existingForGoal = await (db.select(db.assists)
          ..where((a) =>
              a.goalSyncId.equals(assist.goalSyncId)
              )
          ..limit(1))
        .getSingleOrNull();
    if (existingForGoal != null) {
      throw LocalAppException.userMessage('لا يمكن إضافة أسيستين لهدف واحد');
    }

    // 2) prevent same assister from being linked to multiple goals
    final existingForPlayer = await (db.select(db.assists)
          ..where((a) =>
              a.playerSyncId.equals(assist.playerSyncId) )

          ..limit(1))
        .getSingleOrNull();
    if (existingForPlayer != null) {
      throw LocalAppException.userMessage('لا يمكن للأسيست أن يرتبط بأكثر من هدف');
    }

     final insertedId =
         await db.into(db.assists).insert(assist.toCompanionInsert());
     final entity = await (db.select(db.assists)
           ..where((a) => a.id.equals(insertedId)))
         .getSingle();
     return AssistModel.fromEntity(entity);
   }

  Future<Unit> substitutePlayer({
    required String matchSyncId,
    required String matchTermSyncId,
    required String outgoingPlayerSyncId,
    required String incomingPlayerSyncId,
    required int substitutionMinute,
  }) async {
    return db.transaction(() async {
      final p = db.playerMatchParticipation;

      // Helper: آخر سجل للاعب في هذا الشوط (مرتب بـ id AUTOINCREMENT للترتيب الزمني)
      Future<PlayerMatchParticipationData?> latestRow(String playerSyncId) {
        return (db.select(p)
              ..where((row) =>
                  row.matchSyncId.equals(matchSyncId) &
                  row.matchTermSyncId.equals(matchTermSyncId) &
                  row.playerSyncId.equals(playerSyncId))
              ..orderBy([(row) => OrderingTerm.desc(row.id)])
              ..limit(1))
            .getSingleOrNull();
      }

      bool isOnPitch(PlayerMatchParticipationData row) {
        final t = row.participationType.toUpperCase();
        final onType = (t == 'STARTER' || t == 'SUB_IN');
        return onType && row.endTime == null;
      }

      var outgoingRow = await latestRow(outgoingPlayerSyncId);

      // ✅ إذا لم يكن للاعب سجل في هذا الشوط، تحقق من أنه لاعب أساسي في جدول players
      // وأنشئ له سجل STARTER تلقائياً (يحدث عند تأخر initStarters)
      if (outgoingRow == null || !isOnPitch(outgoingRow)) {
        final playerEntity = await (db.select(db.players)
              ..where((pl) =>
                  pl.syncId.equals(outgoingPlayerSyncId) &
                  pl.status.equals('main')))
            .getSingleOrNull();

        if (playerEntity == null) {
          // ليس لاعباً أساسياً ولا يملك سجل participation صالح
          throw Exception('اللاعب الخارج ليس داخل الملعب حالياً');
        }

        // اللاعب أساسي (main) لكن غاب سجله → أنشئ له سجل STARTER الآن
        if (outgoingRow == null) {
          await db.into(p).insert(
                PlayerMatchParticipationCompanion.insert(
                  matchSyncId: matchSyncId,
                  playerSyncId: outgoingPlayerSyncId,
                  matchTermSyncId: matchTermSyncId,
                  startTime: const Value(0),
                  endTime: const Value<int?>(null),
                  participationType: 'STARTER',
                ),
              );
        } else {
          // السجل موجود لكن endTime != null → أعد فتحه (حالة نادرة)
          final existingId = outgoingRow.id;
          await (db.update(p)..where((row) => row.id.equals(existingId))).write(
            const PlayerMatchParticipationCompanion(
              endTime: Value(null),
              participationType: Value('STARTER'),
            ),
          );
        }
        // أعد قراءة السجل بعد الإنشاء
        outgoingRow = await latestRow(outgoingPlayerSyncId);
      }

      if (outgoingRow == null || !isOnPitch(outgoingRow)) {
        throw Exception('اللاعب الخارج ليس داخل الملعب حالياً');
      }

      final incomingRow = await latestRow(incomingPlayerSyncId);
      if (incomingRow != null && isOnPitch(incomingRow)) {
        throw Exception('اللاعب الداخل موجود في الملعب بالفعل');
      }

      // 1) اغلاق اللاعب الخارج
      await (db.update(p)..where((row) => row.id.equals(outgoingRow!.id)))
          .write(
        PlayerMatchParticipationCompanion(
          endTime: Value(substitutionMinute),
          participationType: const Value('SUB_OUT'),
          substitutedPlayerSyncId: Value(incomingPlayerSyncId), // اختياري
        ),
      );

      // 2) فتح/تحديث اللاعب الداخل
      if (incomingRow == null) {
        await db.into(p).insert(
              PlayerMatchParticipationCompanion.insert(
                matchSyncId: matchSyncId,
                playerSyncId: incomingPlayerSyncId,
                matchTermSyncId: matchTermSyncId,
                startTime: Value(substitutionMinute),
                endTime: const Value<int?>(null),
                substitutedPlayerSyncId: Value(outgoingPlayerSyncId),
                // اختياري
                participationType: 'SUB_IN',
              ),
            );
      } else {
        // تحديث آخر سجل (حتى لو كان BENCH أو SUB_OUT سابقًا)
        await (db.update(p)..where((row) => row.id.equals(incomingRow.id)))
            .write(
          PlayerMatchParticipationCompanion(
            startTime: Value(substitutionMinute),
            endTime: const Value<int?>(null),
            substitutedPlayerSyncId: Value(outgoingPlayerSyncId),
            participationType: const Value('SUB_IN'),
          ),
        );
      }
      final rows = await (db.select(p)
            ..where((t) =>
                t.matchSyncId.equals(matchSyncId) &
                t.matchTermSyncId.equals(matchTermSyncId))
            ..orderBy([
              (t) => OrderingTerm.asc(t.playerSyncId),
              (t) => OrderingTerm.desc(t.id)
            ]))
          .get();

      for (final r in rows) {
        print(
            'P=${r.playerSyncId} type=${r.participationType} start=${r.startTime} end=${r.endTime}');
      }

      return unit;
    });
  }

  Future<String?> getPlayerParticipationStatus({
    required String matchSyncId,
    required String matchTermSyncId,
    required String playerSyncId,
  }) async {
    final p = db.playerMatchParticipation;

    // 1) ابحث أولاً في الشوط الحالي
    final currentRow = await (db.select(p)
          ..where(
            (t) =>
                t.matchSyncId.equals(matchSyncId) &
                t.matchTermSyncId.equals(matchTermSyncId) &
                t.playerSyncId.equals(playerSyncId),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();

    if (currentRow != null) {
      return currentRow.participationType;
    }

    // 2) لا يوجد سجل في الشوط الحالي.
    //    هذا يحدث غالبًا عند بداية/نهاية الشوط قبل تهيئة المشاركة للشوط الجديد.
    //    بدل إرجاع null (والذي يجعل UI يعتبر اللاعب احتياط)، نعمل fallback
    //    للشوط السابق الحقيقي حسب (terms.order).

    Future<String?> _statusFromPrevOrderedTerm() async {
      final mt = db.matchTerms;
      final lt = db.leagueTerms;
      final tr = db.terms;

      // Load current term order
      final curJoined = await (db.select(mt).join([
        innerJoin(lt, lt.syncId.equalsExp(mt.leagueTermSyncId)),
        innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
      ])
            ..where(mt.syncId.equals(matchTermSyncId))
            ..limit(1))
          .getSingleOrNull();

      if (curJoined == null) return null;
      final curTerm = curJoined.readTable(tr);

      // Find the immediate previous term in the same match by order
      final prevJoined = await (db.select(mt).join([
        innerJoin(lt, lt.syncId.equalsExp(mt.leagueTermSyncId)),
        innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
      ])
            ..where(
              mt.matchSyncId.equals(matchSyncId) &
                  tr.order.isSmallerThanValue(curTerm.order),
            )
            ..orderBy([
              OrderingTerm.desc(tr.order),
              OrderingTerm.desc(mt.id),
            ])
            ..limit(1))
          .getSingleOrNull();

      if (prevJoined == null) return null;
      final prevMt = prevJoined.readTable(mt);

      final prevRow = await (db.select(p)
            ..where(
              (t) =>
                  t.matchSyncId.equals(matchSyncId) &
                  t.matchTermSyncId.equals(prevMt.syncId) &
                  t.playerSyncId.equals(playerSyncId),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.id)])
            ..limit(1))
          .getSingleOrNull();

      return prevRow?.participationType;
    }

    final prevStatus = await _statusFromPrevOrderedTerm();
    if (prevStatus != null) {
      return prevStatus;
    }

    // 3) fallback اخير: إذا كان اللاعب مستبدلاً (SUB_OUT) في أي شوط سابق → يبقى خارج الملعب
    final anySubOut = await (db.select(p)
          ..where(
            (t) =>
                t.matchSyncId.equals(matchSyncId) &
                t.playerSyncId.equals(playerSyncId) &
                t.participationType.equals('SUB_OUT'),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();

    if (anySubOut != null) {
      return 'SUB_OUT';
    }

    // لا سجل في أي شوط → null (يُقرره الـ widget بناءً على status اللاعب)
    return null;
  }

  Future<void> initStartersForMatchTerm({
    required String matchSyncId,
    required String matchTermSyncId,
  }) async {
    await db.transaction(() async {
      final matchEntity = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();

      if (matchEntity == null) {
        throw Exception('لم يتم العثور على مباراة بالمعرّف $matchSyncId');
      }

      final matchModel = MatchModel.fromEntityWithRelations(matchEntity);
      final homeTeamSyncId = matchModel.homeTeamSyncId;
      final awayTeamSyncId = matchModel.awayTeamSyncId;

      if (homeTeamSyncId == null || awayTeamSyncId == null) {
        throw Exception('أحد الفريقين غير معرّف في المباراة $matchSyncId');
      }

      final playersRows = await (db.select(db.players)
            ..where(
              (p) =>
                  (p.teamSyncId.equals(homeTeamSyncId) |
                      p.teamSyncId.equals(awayTeamSyncId)) &
                  p.status.equals('main'),
            ))
          .get();

      if (playersRows.isEmpty) {
        return;
      }

      final participationTable = db.playerMatchParticipation;

      for (final player in playersRows) {
        final existing = await (db.select(participationTable)
              ..where(
                (row) =>
                    row.matchSyncId.equals(matchSyncId) &
                    row.matchTermSyncId.equals(matchTermSyncId) &
                    row.playerSyncId.equals(player.syncId),
              ))
            .getSingleOrNull();

        if (existing != null) continue;

        await db.into(participationTable).insert(
              PlayerMatchParticipationCompanion.insert(
                matchSyncId: matchSyncId,
                playerSyncId: player.syncId,
                matchTermSyncId: matchTermSyncId,
                startTime: const Value(0),
                endTime: const Value<int?>(null),
                substitutedPlayerSyncId: const Value<String?>(null),
                participationType: 'STARTER',
              ),
            );
      }
    });
  }

  Future<void> initMatchTermParticipation({
    required String matchSyncId,
    required String matchTermSyncId, // الشوط الحالي/الجديد
  }) async {
    await db.transaction(() async {
      final p = db.playerMatchParticipation;

      // 0) لو الشوط الحالي تم تهيئته بالفعل لا نكرر
      final currentCountRow = await (db.selectOnly(p)
            ..addColumns([p.id.count()])
            ..where(
              p.matchSyncId.equals(matchSyncId) &
                  p.matchTermSyncId.equals(matchTermSyncId),
            ))
          .getSingle();

      final currentCount = currentCountRow.read(p.id.count()) ?? 0;
      if (currentCount > 0) return;

      // 1) اكتشف الشوط السابق بشكل صحيح حسب (terms.order) وليس syncId.
      //    لأن syncId/UUID لا يضمن ترتيب الأشواط وقد يسبب اعتبار الشوط السابق = شوط آخر.
      final mt = db.matchTerms;
      final lt = db.leagueTerms;
      final tr = db.terms;

      final curJoined = await (db.select(mt).join([
        innerJoin(lt, lt.syncId.equalsExp(mt.leagueTermSyncId)),
        innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
      ])
            ..where(mt.syncId.equals(matchTermSyncId))
            ..limit(1))
          .getSingleOrNull();

      // لو الشوط الحالي غير موجود في DB (حالة نادرة)، نرجع بدون تهيئة.
      if (curJoined == null) return;

      final curTerm = curJoined.readTable(tr);

      final prevJoined = await (db.select(mt).join([
        innerJoin(lt, lt.syncId.equalsExp(mt.leagueTermSyncId)),
        innerJoin(tr, tr.syncId.equalsExp(lt.termSyncId)),
      ])
            ..where(
              mt.matchSyncId.equals(matchSyncId) &
                  tr.order.isSmallerThanValue(curTerm.order),
            )
            ..orderBy([
              OrderingTerm.desc(tr.order),
              OrderingTerm.desc(mt.id),
            ])
            ..limit(1))
          .getSingleOrNull();

      // ==========================
      // CASE A) لا يوجد شوط سابق => الشوط الأول
      // ==========================
      if (prevJoined == null) {
        final matchEntity = await (db.select(db.matches)
              ..where((m) => m.syncId.equals(matchSyncId)))
            .getSingleOrNull();

        if (matchEntity == null) {
          throw Exception('لم يتم العثور على مباراة بالمعرّف $matchSyncId');
        }

        final matchModel = MatchModel.fromEntityWithRelations(matchEntity);
        final homeTeamSyncId = matchModel.homeTeamSyncId;
        final awayTeamSyncId = matchModel.awayTeamSyncId;

        if (homeTeamSyncId == null || awayTeamSyncId == null) {
          throw Exception('أحد الفريقين غير معرّف في المباراة $matchSyncId');
        }

        final playersRows = await (db.select(db.players)
              ..where(
                (pl) =>
                    (pl.teamSyncId.equals(homeTeamSyncId) |
                        pl.teamSyncId.equals(awayTeamSyncId)) &
                    pl.status.equals('main'),
              ))
            .get();

        if (playersRows.isEmpty) return;

        await db.batch((b) {
          for (final player in playersRows) {
            b.insert(
              p,
              PlayerMatchParticipationCompanion.insert(
                matchSyncId: matchSyncId,
                playerSyncId: player.syncId,
                matchTermSyncId: matchTermSyncId,
                startTime: const Value(0),
                endTime: const Value<int?>(null),
                substitutedPlayerSyncId: const Value<String?>(null),
                participationType: 'STARTER',
              ),
              mode: InsertMode.insertOrIgnore,
            );
          }
        });

        return;
      }

      // ==========================
      // CASE B) يوجد شوط سابق => نسخ الحالة بمنطق كرة القدم
      // ==========================
      final previousMatchTermSyncId = prevJoined.readTable(mt).syncId;

      final prevRows = await (db.select(p)
            ..where((row) =>
                row.matchSyncId.equals(matchSyncId) &
                row.matchTermSyncId.equals(previousMatchTermSyncId))
            ..orderBy([
              (row) => OrderingTerm.asc(row.playerSyncId),
              // ✅ نرتب بـ id AUTOINCREMENT لأن PlayerMatchParticipation لا يملك syncId
              (row) => OrderingTerm.desc(row.id),
            ]))
          .get();

      if (prevRows.isEmpty) return;

      // آخر حالة لكل لاعب
      final latestByPlayer = <String, PlayerMatchParticipationData>{};
      for (final row in prevRows) {
        latestByPlayer.putIfAbsent(row.playerSyncId, () => row);
      }

      bool isOnPitch(String type) {
        final t = type.toUpperCase();
        return t == 'STARTER' || t == 'SUB_IN';
      }

      await db.batch((b) {
        for (final old in latestByPlayer.values) {
          final newType = isOnPitch(old.participationType) ? 'STARTER' : 'SUB_OUT';

          b.insert(
            p,
            PlayerMatchParticipationCompanion.insert(
              matchSyncId: matchSyncId,
              playerSyncId: old.playerSyncId,
              matchTermSyncId: matchTermSyncId,
              startTime: const Value(0),
              endTime: const Value<int?>(null),
              substitutedPlayerSyncId: const Value<String?>(null),
              participationType: newType,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });
    });
  }
}
