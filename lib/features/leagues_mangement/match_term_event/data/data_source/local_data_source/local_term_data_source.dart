import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../core/database/safirah_database.dart';
import '../../../../group/data/model/model.dart';
import '../../../../match/data/model/match_model.dart';
import '../../model/assist_model.dart';
import '../../model/goal_model.dart';
import '../../model/match_term_model.dart';
import '../../model/player_stats.dart';
import '../../model/terms_model.dart';
import '../../model/warring_model.dart';
import '../../service/match_term_event_operations.dart';
typedef UpdatedQualifiedTeams = ({QualifiedTeamModel? home, QualifiedTeamModel? away});

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
          syncId: const Uuid().v7()),
      TermsCompanion.insert(
          name: 'الشوط الثاني',
          type: 'regular',
          order: 2,
          syncId: const Uuid().v7()),
      TermsCompanion.insert(
          name: 'الشوط الإضافي الأول',
          type: 'extra',
          order: 3,
          syncId: const Uuid().v7()),
      TermsCompanion.insert(
          name: 'الشوط الإضافي الثاني',
          type: 'extra',
          order: 4,
          syncId: const Uuid().v7()),
      TermsCompanion.insert(
          name: 'ركلات الترجيح',
          type: 'penalty',
          order: 5,
          syncId: const Uuid().v7()),
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

  Future<List<MatchTermModel>> createMatchTermsFromLeague({
    required String matchSyncId,
    required String leagueSyncId,
    String roundType = 'group',
  }) async {
    final leagueTerms = await (db.select(db.leagueTerms)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .get();

    if (leagueTerms.isEmpty) {
      // ignore: avoid_print
      print('⚠️ لا توجد إعدادات أشواط لهذا الدوري بعد ()');
      return [];
    }

    final allTerms = await db.select(db.terms).get();
    final Map<String, String> termTypeBySyncId = <String, String>{
      for (final t in allTerms) t.syncId: t.type,
    };

    List<String> selectedLeagueTermSyncIds = <String>[];

    if (roundType == 'group') {
      final regularTerms = leagueTerms
          .where((lt) => termTypeBySyncId[lt.termSyncId] == 'regular')
          .toList()
        ..sort((a, b) => a.id.compareTo(b.id));

      if (regularTerms.isEmpty) {
        // ignore: avoid_print
        print('⚠️ لا توجد أشواط عادية (regular) في إعدادات الدوري ');
        return [];
      }

      final int regularCount = regularTerms.length.clamp(1, 2);

      selectedLeagueTermSyncIds =
          regularTerms.take(regularCount).map((e) => e.syncId).toList();

      // ignore: avoid_print
      print('⚙️ تم اختيار $regularCount شوط (regular) لدور المجموعات');
    } else {
      selectedLeagueTermSyncIds = leagueTerms.map((lt) => lt.syncId).toList();
      // ignore: avoid_print
      print('⚙️ تم اختيار كل الأشواط للدور $roundType');
    }

    if (selectedLeagueTermSyncIds.isEmpty) {
      // ignore: avoid_print
      print('⚠️ لا توجد أشواط مطابقة للدور $roundType للدوري ');
      return [];
    }
    //
    // await db.batch((batch) {
    //   batch.insertAll(
    //     db.matchTerms,
    //     selectedLeagueTermSyncIds.map((leagueTermSyncId) {
    //       return MatchTermsCompanion.insert(
    //         syncId: const Uuid().v7(),
    //         matchSyncId: matchSyncId,
    //         leagueTermSyncId: leagueTermSyncId,
    //       );
    //     }).toList(),
    //   );
    // });

    List<MatchTermModel> insertedMatchTerms = [];

    await db.transaction(() async {
      for (final leagueTermSyncId in selectedLeagueTermSyncIds) {
        final row = await db.into(db.matchTerms).insertReturning(
              MatchTermsCompanion.insert(
                syncId: const Uuid().v7(),
                matchSyncId: matchSyncId,
                leagueTermSyncId: leagueTermSyncId,
              ),
            );
        insertedMatchTerms.add(MatchTermModel(
          syncId: row.syncId,
          id: row.id,
          matchSyncId: row.matchSyncId,
          leagueTermSyncId: row.leagueTermSyncId,
        ));
      }
    });
    print(
      '✅ تم إنشاء ${selectedLeagueTermSyncIds.length} أشواط للمباراة '
      '$matchSyncId (${roundType.toUpperCase()})',
    );
    return insertedMatchTerms;
  }

  // ✅ now matchTerms is sync-based but we still keep old signature (id) for UI.
  Future<int?> getTermDurationByMatchTermId(int matchTermId) async {
    final query = await (db.select(db.matchTerms).join(<Join>[
      innerJoin(
        db.leagueTerms,
        db.leagueTerms.syncId.equalsExp(db.matchTerms.leagueTermSyncId),
      )
    ])
          ..where(db.matchTerms.id.equals(matchTermId)))
        .getSingleOrNull();

    if (query == null) return null;

    final leagueTerm = query.readTable(db.leagueTerms);
    return leagueTerm.durationMinutes;
  }

  Future<void> updateAdditionalMinutes(
    int termId,
    int additionalMinutes,
  ) async {
    await (db.update(db.matchTerms)..where((tbl) => tbl.id.equals(termId)))
        .write(
      MatchTermsCompanion(
        additionalMinutes: Value(additionalMinutes),
      ),
    );
  }

  Future<void> startTermSafe(String matchSyncId, int matchTermId) async {
    await db.transaction(() async {
      final match = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();

      if (match == null) {
        throw Exception('⚠️ لم يتم العثور على المباراة');
      }

      final now = DateTime.now();
      final scheduledStart = match.scheduledStartTime ?? match.startTime;

      if (scheduledStart == null || now.isBefore(scheduledStart)) {
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

      await (db.update(db.matchTerms)..where((t) => t.id.equals(matchTermId)))
          .write(
        MatchTermsCompanion(
          startTime: Value(now),
          isFinished: const Value(false),
        ),
      );

      // ignore: avoid_print
      print('✅ بدأ الشوط لمدة دقيقة للمباراة $matchSyncId');
    });
  }

  //   Future<FinishResult?> finishTermSmart({
  //   required String matchSyncId,
  //   required int termId,
  // }) async {
  //   await db.transaction(() async {
  //     await (db.update(db.matchTerms)..where((t) => t.id.equals(termId))).write(
  //       const MatchTermsCompanion(isFinished: Value(true)),
  //     );
  //
  //     final matchEntity = await (db.select(db.matches)
  //           ..where((m) => m.syncId.equals(matchSyncId)))
  //         .getSingleOrNull();
  //
  //     if (matchEntity == null) {
  //       throw Exception('❌ لم يتم العثور على المباراة $matchSyncId');
  //     }
  //
  //     final match = MatchModel.fromEntityWithRelations(matchEntity);
  //
  //     final roundEntity = await (db.select(db.rounds)
  //           ..where((r) => r.syncId.equals(match.roundSyncId!)))
  //         .getSingleOrNull();
  //
  //     if (roundEntity == null) {
  //       throw Exception(
  //           '❌ لم يتم العثور على الجولة الخاصة بالمباراة $matchSyncId');
  //     }
  //
  //     final bool isKnockout = roundEntity.roundType == 'knockout';
  //
  //     final matchTerms = db.matchTerms;
  //     final leagueTerms = db.leagueTerms;
  //     final terms = db.terms;
  //
  //     // ✅ sync-based joins
  //     final joinedTerms = await (db.select(matchTerms).join(<Join>[
  //       innerJoin(
  //         leagueTerms,
  //         leagueTerms.syncId.equalsExp(matchTerms.leagueTermSyncId),
  //       ),
  //       innerJoin(
  //         terms,
  //         terms.syncId.equalsExp(leagueTerms.termSyncId),
  //       ),
  //     ])
  //           ..where(matchTerms.matchSyncId.equals(matchSyncId)))
  //         .get();
  //
  //     final allTerms = joinedTerms
  //         .map(
  //           (row) => (
  //             matchTerm: row.readTable(matchTerms),
  //             leagueTerm: row.readTable(leagueTerms),
  //             term: row.readTable(terms),
  //           ),
  //         )
  //         .toList();
  //
  //     if (allTerms.isEmpty) {
  //       throw Exception(
  //         '❌ لم يتم العثور على الأشواط الخاصة بالمباراة $matchSyncId',
  //       );
  //     }
  //     final termRow = await (db.select(db.matchTerms)..where((t) => t.id.equals(termId)))
  //         .getSingle();
  //
  //     final matchTermSyncId = termRow.syncId;
  //     final hasExtraTime = allTerms.any((t) => t.term.type == 'extra');
  //     final hasPenaltyShootout = allTerms.any((t) => t.term.type == 'penalty');
  //
  //     final normalTerms =
  //         allTerms.where((t) => t.term.type == 'regular').toList();
  //     final extraTerms = allTerms.where((t) => t.term.type == 'extra').toList();
  //     final penaltyTerms =
  //         allTerms.where((t) => t.term.type == 'penalty').toList();
  //
  //     final int finishedNormal =
  //         normalTerms.where((t) => t.matchTerm.isFinished).length;
  //     final int finishedExtra =
  //         extraTerms.where((t) => t.matchTerm.isFinished).length;
  //     final int finishedPenalty =
  //         penaltyTerms.where((t) => t.matchTerm.isFinished).length;
  //
  //     final int totalHomeScore = match.homeScore;
  //     final int totalAwayScore = match.awayScore;
  //
  //     final bool allFinished = allTerms.every((t) => t.matchTerm.isFinished);
  //     bool matchFinished = false;
  //     final now = DateTime.now();
  //     if (isKnockout) {
  //       if (finishedNormal == normalTerms.length && finishedExtra == 0) {
  //         if (totalHomeScore != totalAwayScore) {
  //           final unfinishedExtras =
  //               extraTerms.where((t) => !t.matchTerm.isFinished).toList();
  //           final unfinishedPenalties =
  //               penaltyTerms.where((t) => !t.matchTerm.isFinished).toList();
  //           final toFinish =
  //               <({dynamic matchTerm, dynamic leagueTerm, dynamic term})>[
  //             ...unfinishedExtras,
  //             ...unfinishedPenalties,
  //           ];
  //
  //           if (toFinish.isNotEmpty) {
  //             for (final term in toFinish) {
  //               await (db.update(db.matchTerms)
  //                     ..where((t) => t.syncId.equals(term.matchTerm.syncId)))
  //                   .write(
  //                 const MatchTermsCompanion(isFinished: Value(true)),
  //               );
  //             }
  //           }
  //
  //           matchFinished = true;
  //           await finishMatch(match);
  //           // return;
  //         } else {
  //           if (hasExtraTime) {
  //             // return;
  //           } else if (hasPenaltyShootout) {
  //             // return;
  //           } else {
  //             matchFinished = true;
  //             await finishMatch(match);
  //             // return;
  //           }
  //         }
  //       }
  //
  //       if (finishedExtra == extraTerms.length && finishedExtra > 0) {
  //         if (totalHomeScore != totalAwayScore) {
  //           matchFinished = true;
  //
  //           await finishMatch(match);
  //           // return;
  //         } else {
  //           if (hasPenaltyShootout) {
  //             // return;
  //           } else {
  //             matchFinished = true;
  //
  //             await finishMatch(match);
  //             // return;
  //           }
  //         }
  //       }
  //
  //       if (finishedPenalty == penaltyTerms.length && penaltyTerms.isNotEmpty) {
  //         matchFinished = true;
  //
  //         await finishMatch(match);
  //         // return;
  //       }
  //     } else {
  //       if (allFinished) {
  //         final syncId = match.syncId;
  //         if (syncId != null) {
  //           matchFinished = true;
  //
  //           await finishMatchAndUpdatePoints(syncId, DateTime.now());
  //         }
  //         // return;
  //       }
  //     }
  //     return FinishResult(
  //       termFinished: true,
  //       matchFinished: matchFinished,
  //       matchTermSyncId: matchTermSyncId,
  //       now: now,
  //     );
  //     // ignore: avoid_print
  //     print('✅ تم إنهاء الشوط $termId للمباراة $matchSyncId');
  //   });
  //   return null;
  // }
  Future<FinishTermResult> finishTermSmart({
    required String matchSyncId,
    required int termId,
  }) async {
    return await db.transaction(() async {
      await (db.update(db.matchTerms)..where((t) => t.id.equals(termId))).write(
        const MatchTermsCompanion(isFinished: Value(true)),
      );

      final matchEntity = await (db.select(db.matches)
        ..where((m) => m.syncId.equals(matchSyncId)))
          .getSingleOrNull();

      if (matchEntity == null) {
        throw Exception('❌ لم يتم العثور على المباراة $matchSyncId');
      }

      final match = MatchModel.fromEntityWithRelations(matchEntity);

      final roundEntity = await (db.select(db.rounds)
        ..where((r) => r.syncId.equals(match.roundSyncId!)))
          .getSingleOrNull();

      if (roundEntity == null) {
        throw Exception('❌ لم يتم العثور على الجولة الخاصة بالمباراة $matchSyncId');
      }

      final bool isKnockout = roundEntity.roundType == 'knockout';

      final matchTerms = db.matchTerms;
      final leagueTerms = db.leagueTerms;
      final terms = db.terms;

      final joinedTerms = await (db.select(matchTerms).join(<Join>[
        innerJoin(
          leagueTerms,
          leagueTerms.syncId.equalsExp(matchTerms.leagueTermSyncId),
        ),
        innerJoin(
          terms,
          terms.syncId.equalsExp(leagueTerms.termSyncId),
        ),
      ])
        ..where(matchTerms.matchSyncId.equals(matchSyncId)))
          .get();

      final allTerms = joinedTerms
          .map(
            (row) => (
        matchTerm: row.readTable(matchTerms),
        leagueTerm: row.readTable(leagueTerms),
        term: row.readTable(terms),
        ),
      )
          .toList();

      if (allTerms.isEmpty) {
        throw Exception('❌ لم يتم العثور على الأشواط الخاصة بالمباراة $matchSyncId');
      }

      final hasExtraTime = allTerms.any((t) => t.term.type == 'extra');
      final hasPenaltyShootout = allTerms.any((t) => t.term.type == 'penalty');

      final normalTerms = allTerms.where((t) => t.term.type == 'regular').toList();
      final extraTerms = allTerms.where((t) => t.term.type == 'extra').toList();
      final penaltyTerms = allTerms.where((t) => t.term.type == 'penalty').toList();

      final int finishedNormal = normalTerms.where((t) => t.matchTerm.isFinished).length;
      final int finishedExtra = extraTerms.where((t) => t.matchTerm.isFinished).length;
      final int finishedPenalty = penaltyTerms.where((t) => t.matchTerm.isFinished).length;

      final int totalHomeScore = match.homeScore;
      final int totalAwayScore = match.awayScore;

      final bool allFinished = allTerms.every((t) => t.matchTerm.isFinished);
      final now = DateTime.now();
      final termRow = await (db.select(db.matchTerms)
        ..where((t) => t.id.equals(termId)))
          .getSingleOrNull();

      if (termRow == null) {
        throw Exception('❌ لم يتم العثور على الشوط termId=$termId');
      }
      if (isKnockout) {
        if (finishedNormal == normalTerms.length && finishedExtra == 0) {
          if (totalHomeScore != totalAwayScore) {
            final unfinishedExtras = extraTerms.where((t) => !t.matchTerm.isFinished).toList();
            final unfinishedPenalties = penaltyTerms.where((t) => !t.matchTerm.isFinished).toList();
            final toFinish = <({dynamic matchTerm, dynamic leagueTerm, dynamic term})>[
              ...unfinishedExtras,
              ...unfinishedPenalties,
            ];

            if (toFinish.isNotEmpty) {
              for (final term in toFinish) {
                await (db.update(db.matchTerms)..where((t) => t.id.equals(term.matchTerm.id)))
                    .write(const MatchTermsCompanion(isFinished: Value(true)));
              }
            }

            await finishMatch(match);

            return FinishTermResult(
              termFinished: true,
              matchFinished: true,

              matchSyncId: matchSyncId,
              matchTermSyncId: termRow.syncId,            // ✅ المطلوب
              leagueTermSyncId: termRow.leagueTermSyncId, // ✅ المطلوب
              pointsUpdatedLocally: false,
              isKnockout: true,
              matchEndTime: now,
              homeScore: match.homeScore,
              awayScore: match.awayScore,
              leagueSyncId: match.leagueSyncId,
            );
          } else {
            if (hasExtraTime) {
              return FinishTermResult(
                termFinished: true,
                matchFinished: false,
                matchSyncId: matchSyncId,
                matchTermSyncId: termRow.syncId,            // ✅ المطلوب
                leagueTermSyncId: termRow.leagueTermSyncId, // ✅ المطلوب
                pointsUpdatedLocally: false,
                isKnockout: true,
              );
            } else if (hasPenaltyShootout) {
              return  FinishTermResult(
                matchSyncId: matchSyncId,
                matchTermSyncId: termRow.syncId,            // ✅ المطلوب
                leagueTermSyncId: termRow.leagueTermSyncId,
                termFinished: true,
                matchFinished: false,
                pointsUpdatedLocally: false,
                isKnockout: true,
              );
            } else {
              await finishMatch(match);
              return FinishTermResult(
                termFinished: true,
                matchSyncId: matchSyncId,
                matchTermSyncId: termRow.syncId,            // ✅ المطلوب
                leagueTermSyncId: termRow.leagueTermSyncId,
                matchFinished: true,
                pointsUpdatedLocally: false,
                isKnockout: true,
                matchEndTime: now,
                homeScore: match.homeScore,
                awayScore: match.awayScore,
                leagueSyncId: match.leagueSyncId,
              );
            }
          }
        }

        if (finishedExtra == extraTerms.length && finishedExtra > 0) {
          if (totalHomeScore != totalAwayScore) {
            await finishMatch(match);
            return FinishTermResult(
              termFinished: true,
              matchFinished: true,
              matchSyncId: matchSyncId,
              matchTermSyncId: termRow.syncId,            // ✅ المطلوب
              leagueTermSyncId: termRow.leagueTermSyncId,
              pointsUpdatedLocally: false,
              isKnockout: true,
              matchEndTime: now,
              homeScore: match.homeScore,
              awayScore: match.awayScore,
              leagueSyncId: match.leagueSyncId,
            );
          } else {
            if (hasPenaltyShootout) {
              return  FinishTermResult(
                termFinished: true,
                matchFinished: false,
                pointsUpdatedLocally: false,
                matchSyncId: matchSyncId,
                matchTermSyncId: termRow.syncId,            // ✅ المطلوب
                leagueTermSyncId: termRow.leagueTermSyncId,
                isKnockout: true,
              );
            } else {
              await finishMatch(match);
              return FinishTermResult(
                termFinished: true,
                matchFinished: true,
                pointsUpdatedLocally: false,
                isKnockout: true,
                matchSyncId: matchSyncId,
                matchTermSyncId: termRow.syncId,            // ✅ المطلوب
                leagueTermSyncId: termRow.leagueTermSyncId,
                matchEndTime: now,
                homeScore: match.homeScore,
                awayScore: match.awayScore,
                leagueSyncId: match.leagueSyncId,
              );
            }
          }
        }

        if (finishedPenalty == penaltyTerms.length && penaltyTerms.isNotEmpty) {
          await finishMatch(match);
          return FinishTermResult(
            termFinished: true,
            matchFinished: true,
            matchSyncId: matchSyncId,
            matchTermSyncId: termRow.syncId,            // ✅ المطلوب
            leagueTermSyncId: termRow.leagueTermSyncId,
            pointsUpdatedLocally: false,
            isKnockout: true,
            matchEndTime: now,
            homeScore: match.homeScore,
            awayScore: match.awayScore,
            leagueSyncId: match.leagueSyncId,
          );
        }
      } else {
        if (allFinished) {
          final syncId = match.syncId;
          if (syncId != null) {
           // await finishMatchAndUpdatePoints(syncId, now);
          }
          return FinishTermResult(
            termFinished: true,
            matchFinished: true,
            pointsUpdatedLocally: true,
            isKnockout: false,
            matchEndTime: now,
            matchSyncId: matchSyncId,
            matchTermSyncId: termRow.syncId,            // ✅ المطلوب
            leagueTermSyncId: termRow.leagueTermSyncId,
            homeScore: match.homeScore,
            awayScore: match.awayScore,
            leagueSyncId: match.leagueSyncId,
          );
        }
      }

      // لم تنتهِ المباراة
      return  FinishTermResult(
        termFinished: true,
        matchFinished: false,
        pointsUpdatedLocally: false,
        isKnockout: false,
        matchSyncId: matchSyncId,
        matchTermSyncId: termRow.syncId,            // ✅ المطلوب
        leagueTermSyncId: termRow.leagueTermSyncId,
      );
    });
  }

  Future<void> finishMatch(MatchModel match) async {
    if (match.status == 'finished') {
      // ignore: avoid_print
      print('⚠️ المباراة ${match.id} منتهية مسبقًا — تم تجاهل الإجراء.');
      return;
    }

    final now = DateTime.now();
    await (db.update(db.matches)..where((m) => m.id.equals(match.id!))).write(
      MatchesCompanion(
        status: const Value('finished'),
        updatedAt: Value(now),
        endTime: Value(now),
      ),
    );
    // ignore: avoid_print
    print('🏁 تم إنهاء المباراة ${match.id}');
  }

  Future<MatchTermModel> getCurrentMatchTerm(String matchSyncId) async {
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.syncId.equals(matchSyncId)))
        .getSingleOrNull();

    if (matchEntity == null) {
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
            OrderingTerm.asc(db.matchTerms.id),
          ]))
        .get();

    if (joinedTerms.isEmpty) {
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

  // Future<UpdatedQualifiedTeams> finishMatchAndUpdatePoints(
  //   String matchSyncId,
  //   DateTime now,
  // ) async {
  //   final matchEntity = await (db.select(db.matches)
  //         ..where((m) => m.syncId.equals(matchSyncId)))
  //       .getSingleOrNull();
  //
  //   if (matchEntity == null) {
  //     throw Exception('❌ لم يتم العثور على المباراة رقم $matchSyncId');
  //   }
  //
  //   final match = MatchModel.fromEntityWithRelations(matchEntity);
  //
  //   if (match.status == 'finished') {
  //     // ignore: avoid_print
  //     print('⚠️ المباراة $matchSyncId تم إنهاؤها مسبقًا');
  //     return;
  //   }
  //
  //   if (match.leagueSyncId == null) {
  //     // ignore: avoid_print
  //     print('⚠️ لا يمكن تحديث النقاط لأن match.leagueId غير موجود.');
  //     return;
  //   }
  //
  //   final homeId = match.homeTeamSyncId;
  //   final awayId = match.awayTeamSyncId;
  //
  //   if (homeId == null || awayId == null) {
  //     throw Exception('❌ أحد الفريقين غير معرف في المباراة $matchSyncId');
  //   }
  //
  //   int homePoints = 0;
  //   int awayPoints = 0;
  //
  //   if (match.homeScore > match.awayScore) {
  //     homePoints = 3;
  //   } else if (match.awayScore > match.homeScore) {
  //     awayPoints = 3;
  //   } else {
  //     homePoints = 1;
  //     awayPoints = 1;
  //   }
  //
  //   final q = db.qualifiedTeam;
  //
  //   final homeRow = await (db.select(q)
  //         ..where(
  //           (t) =>
  //               t.leagueSyncId.equals(match.leagueSyncId!) &
  //               t.teamSyncId.equals(homeId),
  //         ))
  //       .getSingleOrNull();
  //
  //   if (homeRow != null) {
  //     final homeModel = QualifiedTeamModel.fromEntity(homeRow).copyWith(
  //       points: homeRow.points + homePoints,
  //       played: homeRow.played + 1,
  //       wins: homePoints == 3 ? homeRow.wins + 1 : homeRow.wins,
  //       losses: homePoints == 0 ? homeRow.losses + 1 : homeRow.losses,
  //       draws: homePoints == 1 ? homeRow.draws + 1 : homeRow.draws,
  //     );
  //
  //     await (db.update(q)..where((t) => t.id.equals(homeRow.id)))
  //         .write(homeModel.toCompanionUpdate());
  //   }
  //
  //   final awayRow = await (db.select(q)
  //         ..where(
  //           (t) =>
  //               t.leagueSyncId.equals(match.leagueSyncId!) &
  //               t.teamSyncId.equals(awayId),
  //         ))
  //       .getSingleOrNull();
  //
  //   if (awayRow != null) {
  //     final awayModel = QualifiedTeamModel.fromEntity(awayRow).copyWith(
  //       points: awayRow.points + awayPoints,
  //       played: awayRow.played + 1,
  //       wins: awayPoints == 3 ? awayRow.wins + 1 : awayRow.wins,
  //       losses: awayPoints == 0 ? awayRow.losses + 1 : awayRow.losses,
  //       draws: awayPoints == 1 ? awayRow.draws + 1 : awayRow.draws,
  //     );
  //
  //     await (db.update(q)..where((t) => t.id.equals(awayRow.id)))
  //         .write(awayModel.toCompanionUpdate());
  //   }
  //
  //   await (db.update(db.matches)..where((m) => m.syncId.equals(matchSyncId))).write(
  //     MatchesCompanion(
  //       status: const Value('finished'),
  //       updatedAt: Value(now),
  //       endTime: Value(now),
  //     ),
  //   );
  //
  //   // ignore: avoid_print
  //   print('🏁 تم إنهاء المباراة $matchSyncId وتحديث النقاط بنجاح');
  // }
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
          t.leagueSyncId.equals(leagueId) & t.teamSyncId.equals(homeId)))
            .getSingleOrNull();

        final awayRow = await (db.select(q)
          ..where((t) =>
          t.leagueSyncId.equals(leagueId) & t.teamSyncId.equals(awayId)))
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

        await (db.update(q)
          ..where((t) => t.id.equals(homeRow.id)))
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

        await (db.update(q)
          ..where((t) => t.id.equals(awayRow.id)))
            .write(updatedAway.toCompanionUpdate());
      }

      await (db.update(db.matches)
        ..where((m) => m.syncId.equals(matchSyncId))).write(
        MatchesCompanion(
          status: const Value('finished'),
          updatedAt: Value(now),
          endTime: Value(now),
        ),
      );

      return (home: updatedHome, away: updatedAway);
    });
  }
  Future<GoalModel> insertGoalAndUpdateQualifiedTeams(
    GoalModel goal,
  ) async {
    late GoalModel insertedGoal;

    await db.transaction(() async {
      final insertedId =
          await db.into(db.goals).insert(goal.toCompanionInsert());

      final fetchedGoal = await (db.select(db.goals)
            ..where((g) => g.id.equals(insertedId)))
          .getSingleOrNull();

      print(fetchedGoal);
      if (fetchedGoal == null) {
        throw Exception('❌ فشل في جلب الهدف بعد الإدخال.');
      }

      insertedGoal = GoalModel.fromEntity(fetchedGoal);

      final match = await (db.select(db.matches)
            ..where((m) => m.syncId.equals(goal.matchSyncId)))
          .getSingleOrNull();

      if (match == null) {
        throw Exception('❌ لم يتم العثور على المباراة');
      }

      final player = await (db.select(db.players)
            ..where((p) => p.syncId.equals(goal.playerSyncId)))
          .getSingleOrNull();

      if (player == null) {
        throw Exception('❌ لم يتم العثور على اللاعب');
      }

      final bool isOwnGoal = goal.goalType == 'own_goal';
      final String scoringTeamSyncId =
          isOwnGoal ? match.awayTeamSyncId : player.teamSyncId;
      final String opponentTeamSyncId =
          isOwnGoal ? player.teamSyncId : match.homeTeamSyncId;

      final bool isHomeScorer = scoringTeamSyncId == match.homeTeamSyncId;
      final int updatedHomeScore = match.homeScore + (isHomeScorer ? 1 : 0);
      final int updatedAwayScore = match.awayScore + (isHomeScorer ? 0 : 1);

      await (db.update(db.matches)..where((m) => m.id.equals(match.id))).write(
        MatchesCompanion(
          homeScore: Value(updatedHomeScore),
          awayScore: Value(updatedAwayScore),
        ),
      );

      final q = db.qualifiedTeam;

      final scoringRow = await (db.select(q)
            ..where(
              (t) =>
                  t.leagueSyncId.equals(match.leagueSyncId) &
                  t.teamSyncId.equals(scoringTeamSyncId),
            ))
          .getSingleOrNull();

      if (scoringRow != null) {
        await (db.update(q)..where((t) => t.id.equals(scoringRow.id))).write(
          QualifiedTeamCompanion(
            goalsFor: Value(scoringRow.goalsFor + 1),
          ),
        );
      }

      final opponentRow = await (db.select(q)
            ..where(
              (t) =>
                  t.leagueSyncId.equals(match.leagueSyncId) &
                  t.teamSyncId.equals(opponentTeamSyncId),
            ))
          .getSingleOrNull();

      if (opponentRow != null) {
        await (db.update(q)..where((t) => t.id.equals(opponentRow.id))).write(
          QualifiedTeamCompanion(
            goalsAgainst: Value(opponentRow.goalsAgainst + 1),
          ),
        );
      }
    });

    return insertedGoal;
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
    final insertedId =
        await db.into(db.assists).insert(assist.toCompanionInsert());
    final entity = await (db.select(db.assists)
          ..where((a) => a.id.equals(insertedId)))
        .getSingle();
    return AssistModel.fromEntity(entity);
  }

  // ---------------------------------------------------------------------------
  // SyncId-based player participation
  // ---------------------------------------------------------------------------

  // Future<Unit> substitutePlayer({
  //   required String matchSyncId,
  //   required String matchTermSyncId,
  //   required String outgoingPlayerSyncId,
  //   required String incomingPlayerSyncId,
  //   required int substitutionMinute,
  // }) async {
  //   print(
  //       '🔁 [Local] substitutePlayer ENTER: matchSyncId=$matchSyncId, termSync=$matchTermSyncId, outgoing=$outgoingPlayerSyncId, incoming=$incomingPlayerSyncId, minute=$substitutionMinute');
  //
  //   return await db.transaction(() async {
  //     final p = db.playerMatchParticipation;
  //
  //     final outgoingRow = await (db.select(p)
  //           ..where((row) =>
  //               row.matchSyncId.equals(matchSyncId) &
  //               row.matchTermSyncId.equals(matchTermSyncId) &
  //               row.playerSyncId.equals(outgoingPlayerSyncId)))
  //         .getSingleOrNull();
  //
  //     final incomingRow = await (db.select(p)
  //           ..where((row) =>
  //               row.matchSyncId.equals(matchSyncId) &
  //               row.matchTermSyncId.equals(matchTermSyncId) &
  //               row.playerSyncId.equals(incomingPlayerSyncId)))
  //         .getSingleOrNull();
  //
  //     if (outgoingRow != null) {
  //       await (db.update(p)..where((row) => row.id.equals(outgoingRow.id)))
  //           .write(
  //         PlayerMatchParticipationCompanion(
  //           endTime: Value(substitutionMinute),
  //           participationType: const Value('SUB_OUT'),
  //         ),
  //       );
  //     }
  //
  //     if (incomingRow == null) {
  //       await db.into(p).insert(
  //             PlayerMatchParticipationCompanion.insert(
  //               matchSyncId: matchSyncId,
  //               playerSyncId: incomingPlayerSyncId,
  //               matchTermSyncId: matchTermSyncId,
  //               startTime: Value(substitutionMinute),
  //               endTime: const Value<int?>(null),
  //               substitutedPlayerSyncId: const Value<String?>(null),
  //               participationType: 'SUB_IN',
  //             ),
  //           );
  //     } else {
  //       await (db.update(p)..where((row) => row.id.equals(incomingRow.id)))
  //           .write(
  //         PlayerMatchParticipationCompanion(
  //           startTime: Value(substitutionMinute),
  //           endTime: const Value<int?>(null),
  //           substitutedPlayerSyncId: Value(outgoingPlayerSyncId),
  //           participationType: const Value('SUB_IN'),
  //         ),
  //       );
  //     }
  //
  //     return unit;
  //   });
  // }
  Future<Unit> substitutePlayer({
    required String matchSyncId,
    required String matchTermSyncId,
    required String outgoingPlayerSyncId,
    required String incomingPlayerSyncId,
    required int substitutionMinute,
  }) async {
    return db.transaction(() async {
      final p = db.playerMatchParticipation;

      // Helper: آخر سجل للاعب في هذا الشوط
      Future<PlayerMatchParticipationData?> _latestRow(String playerSyncId) {
        return (db.select(p)
              ..where((row) =>
                  row.matchSyncId.equals(matchSyncId) &
                  row.matchTermSyncId.equals(matchTermSyncId) &
                  row.playerSyncId.equals(playerSyncId))
              ..orderBy([(row) => OrderingTerm.desc(row.id)])
              ..limit(1))
            .getSingleOrNull();
      }

      bool _isOnPitch(PlayerMatchParticipationData row) {
        final t = row.participationType.toUpperCase();
        final onType = (t == 'STARTER' || t == 'SUB_IN');
        return onType && row.endTime == null;
      }

      final outgoingRow = await _latestRow(outgoingPlayerSyncId);
      if (outgoingRow == null || !_isOnPitch(outgoingRow)) {
        throw Exception('اللاعب الخارج ليس داخل الملعب حالياً');
      }

      final incomingRow = await _latestRow(incomingPlayerSyncId);
      if (incomingRow != null && _isOnPitch(incomingRow)) {
        throw Exception('اللاعب الداخل موجود في الملعب بالفعل');
      }

      // 1) اغلاق اللاعب الخارج
      await (db.update(p)..where((row) => row.id.equals(outgoingRow.id))).write(
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
    final query = db.select(db.playerMatchParticipation)
      ..where(
        (t) =>
            t.matchSyncId.equals(matchSyncId) &
            t.matchTermSyncId.equals(matchTermSyncId) &
            t.playerSyncId.equals(playerSyncId),
      )
      ..orderBy([
        (t) => OrderingTerm.desc(t.id),
      ])
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row?.participationType;
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

      // 1) اكتشف الشوط السابق تلقائياً (آخر term غير الحالي)
      final prevTerm = await (db.select(db.matchTerms)
            ..where((t) =>
                t.matchSyncId.equals(matchSyncId) &
                t.syncId.isNotIn([matchTermSyncId]))
            ..orderBy([(t) => OrderingTerm.desc(t.id)])
            ..limit(1))
          .getSingleOrNull();

      // ==========================
      // CASE A) لا يوجد شوط سابق => الشوط الأول
      // ==========================
      if (prevTerm == null) {
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
      final previousMatchTermSyncId = prevTerm.syncId;

      final prevRows = await (db.select(p)
            ..where((row) =>
                row.matchSyncId.equals(matchSyncId) &
                row.matchTermSyncId.equals(previousMatchTermSyncId))
            ..orderBy([
              (row) => OrderingTerm.asc(row.playerSyncId),
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
          final newType =
              isOnPitch(old.participationType) ? 'STARTER' : 'SUB_OUT';

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
class FinishTermResult {
  final bool termFinished;              // دائماً true هنا
  final bool matchFinished;             // هل انتهت المباراة؟
  final bool pointsUpdatedLocally;      // هل تم تحديث النقاط محلياً؟ (غير knockout)
  final bool isKnockout;                // لتحديد مسار المزامنة
  final DateTime? matchEndTime;         // وقت إنهاء المباراة إن انتهت
  final int? homeScore;
  final int? awayScore;
  final String? leagueSyncId;
  final String? matchTermSyncId;      // match_terms.sync_id
  final String leagueTermSyncId;      // match_terms.league_term_sync_id
  final String matchSyncId;

  const FinishTermResult({
    required this.termFinished,
    required this.matchSyncId,

    required this.matchTermSyncId,
    required this.leagueTermSyncId,
    required this.matchFinished,
    required this.pointsUpdatedLocally,
    required this.isKnockout,
    this.matchEndTime,
    this.homeScore,
    this.awayScore,
    this.leagueSyncId,
  });
}
