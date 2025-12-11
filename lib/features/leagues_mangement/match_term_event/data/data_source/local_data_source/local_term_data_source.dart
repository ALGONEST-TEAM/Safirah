import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../../../core/database/safirah_database.dart';
import '../../../../group/data/model/model.dart';
import '../../../../match/data/model/match_model.dart';
import '../../../../match/data/model/round_model.dart';
import '../../../../team_and_player/data/model/team_model.dart';
import '../../model/assist_model.dart';
import '../../model/goal_model.dart';
import '../../model/match_term_model.dart';
import '../../model/player_match_participation_model.dart';
import '../../model/player_stats.dart';
import '../../model/terms_model.dart';
import '../../model/warring_model.dart';
import '../../service/match_term_event_operations.dart';

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
      TermsCompanion.insert(name: 'الشوط الأول', type: 'regular', order: 1),
      TermsCompanion.insert(name: 'الشوط الثاني', type: 'regular', order: 2),
      TermsCompanion.insert(
        name: 'الشوط الإضافي الأول',
        type: 'extra',
        order: 3,
      ),
      TermsCompanion.insert(
        name: 'الشوط الإضافي الثاني',
        type: 'extra',
        order: 4,
      ),
      TermsCompanion.insert(name: 'ركلات الترجيح', type: 'penalty', order: 5),
    ];

    await db.batch((batch) => batch.insertAll(db.terms, defaultTerms));
    // ignore: avoid_print
    print('✅ تم إدخال بيانات الأشواط الأساسية (${defaultTerms.length})');
  }

  Future<void> initLeagueTerms({
    required int leagueId,
    required List<int> selectedTermIds,
    required int durationMinutes,
  }) async {
    await db.transaction(() async {
      await (db.delete(db.leagueTerms)
            ..where((t) => t.leagueId.equals(leagueId)))
          .go();

      await db.batch((batch) {
        batch.insertAll(
          db.leagueTerms,
          selectedTermIds.map((termId) {
            return LeagueTermsCompanion.insert(
              leagueId: leagueId,
              termId: termId,
              durationMinutes: Value(durationMinutes),
            );
          }).toList(),
        );
      });
    });

    // ignore: avoid_print
    print('✅ League terms initialized for league $leagueId');
  }

  Future<void> createMatchTermsFromLeague({
    required int matchId,
    required int leagueId,
    String roundType = 'group',
  }) async {
    final leagueTerms = await (db.select(db.leagueTerms)
          ..where((t) => t.leagueId.equals(leagueId)))
        .get();

    if (leagueTerms.isEmpty) {
      // ignore: avoid_print
      print('⚠️ لا توجد إعدادات أشواط لهذا الدوري بعد ($leagueId)');
      return;
    }

    final allTerms = await db.select(db.terms).get();
    final Map<int, String> termTypeById = <int, String>{
      for (final t in allTerms) t.id: t.type,
    };

    List<int> selectedLeagueTermIds = <int>[];

    if (roundType == 'group') {
      final regularTerms = leagueTerms
          .where((lt) => termTypeById[lt.termId] == 'regular')
          .toList()
        ..sort((a, b) => a.id.compareTo(b.id));

      if (regularTerms.isEmpty) {
        // ignore: avoid_print
        print(
          '⚠️ لا توجد أشواط عادية (regular) في إعدادات الدوري $leagueId',
        );
        return;
      }

      final int regularCount = regularTerms.length.clamp(1, 2);

      selectedLeagueTermIds =
          regularTerms.take(regularCount).map((e) => e.id).toList();

      // ignore: avoid_print
      print('⚙️ تم اختيار $regularCount شوط (regular) لدور المجموعات');
    } else {
      selectedLeagueTermIds = leagueTerms.map((lt) => lt.id).toList();
      // ignore: avoid_print
      print('⚙️ تم اختيار كل الأشواط للدور $roundType');
    }

    if (selectedLeagueTermIds.isEmpty) {
      // ignore: avoid_print
      print(
        '⚠️ لا توجد أشواط مطابقة للدور $roundType للدوري $leagueId',
      );
      return;
    }

    await db.batch((batch) {
      batch.insertAll(
        db.matchTerms,
        selectedLeagueTermIds.map((leagueTermId) {
          return MatchTermsCompanion.insert(
            matchId: matchId,
            leagueTermId: leagueTermId,
          );
        }).toList(),
      );
    });

    // ignore: avoid_print
    print(
      '✅ تم إنشاء ${selectedLeagueTermIds.length} أشواط للمباراة '
      '$matchId (${roundType.toUpperCase()})',
    );
  }

  Future<int?> getTermDurationByMatchTermId(int matchTermId) async {
    final query = await (db.select(db.matchTerms).join(<Join>[
      innerJoin(
        db.leagueTerms,
        db.leagueTerms.id.equalsExp(db.matchTerms.leagueTermId),
      )
    ])
          ..where(db.matchTerms.id.equals(matchTermId)))
        .getSingleOrNull();

    if (query == null) return null;

    final leagueTerm = query.readTable(db.leagueTerms);
    // ignore: avoid_print
    print(leagueTerm.durationMinutes);
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

  Future<void> startTermSafe(int matchId, int matchTermId) async {
    await db.transaction(() async {
      final match = await (db.select(db.matches)
            ..where((m) => m.id.equals(matchId)))
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
        await (db.update(db.matches)..where((m) => m.id.equals(matchId))).write(
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
      print('✅ بدأ الشوط } لمدة  دقيقة للمباراة $matchId');
    });
  }

  Future<void> finishTermSmart({
    required int matchId,
    required int termId,
  }) async {
    await db.transaction(() async {
      await (db.update(db.matchTerms)..where((t) => t.id.equals(termId))).write(
        const MatchTermsCompanion(isFinished: Value(true)),
      );

      final matchEntity = await (db.select(db.matches)
            ..where((m) => m.id.equals(matchId)))
          .getSingleOrNull();

      if (matchEntity == null) {
        throw Exception('❌ لم يتم العثور على المباراة رقم $matchId');
      }
      final match = MatchModel.fromEntityWithRelations(matchEntity);

      final roundEntity = await (db.select(db.rounds)
            ..where((r) => r.id.equals(match.roundId!)))
          .getSingleOrNull();

      if (roundEntity == null) {
        throw Exception('❌ لم يتم العثور على الجولة الخاصة بالمباراة $matchId');
      }

      final round = RoundModel.fromEntity(roundEntity);
      final bool isKnockout = round.roundType == 'knockout';

      final matchTerms = db.matchTerms;
      final leagueTerms = db.leagueTerms;
      final terms = db.terms;

      final joinedTerms = await (db.select(matchTerms).join(<Join>[
        innerJoin(
          leagueTerms,
          leagueTerms.id.equalsExp(matchTerms.leagueTermId),
        ),
        innerJoin(
          terms,
          terms.id.equalsExp(leagueTerms.termId),
        ),
      ])
            ..where(matchTerms.matchId.equals(matchId)))
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
        throw Exception(
          '❌ لم يتم العثور على الأشواط الخاصة بالمباراة $matchId',
        );
      }

      final hasExtraTime = allTerms.any((t) => t.term.type == 'extra');
      final hasPenaltyShootout = allTerms.any((t) => t.term.type == 'penalty');

      final normalTerms =
          allTerms.where((t) => t.term.type == 'regular').toList();
      final extraTerms = allTerms.where((t) => t.term.type == 'extra').toList();
      final penaltyTerms =
          allTerms.where((t) => t.term.type == 'penalty').toList();

      final int finishedNormal =
          normalTerms.where((t) => t.matchTerm.isFinished).length;
      final int finishedExtra =
          extraTerms.where((t) => t.matchTerm.isFinished).length;
      final int finishedPenalty =
          penaltyTerms.where((t) => t.matchTerm.isFinished).length;

      final int totalHomeScore = match.homeScore;
      final int totalAwayScore = match.awayScore;

      final bool allFinished = allTerms.every((t) => t.matchTerm.isFinished);

      if (isKnockout) {
        if (finishedNormal == normalTerms.length && finishedExtra == 0) {
          if (totalHomeScore != totalAwayScore) {
            final unfinishedExtras =
                extraTerms.where((t) => !t.matchTerm.isFinished).toList();
            final unfinishedPenalties =
                penaltyTerms.where((t) => !t.matchTerm.isFinished).toList();
            final toFinish =
                <({dynamic matchTerm, dynamic leagueTerm, dynamic term})>[
              ...unfinishedExtras,
              ...unfinishedPenalties,
            ];

            if (toFinish.isNotEmpty) {
              for (final term in toFinish) {
                await (db.update(db.matchTerms)
                      ..where((t) => t.id.equals(term.matchTerm.id)))
                    .write(
                  const MatchTermsCompanion(isFinished: Value(true)),
                );
              }
            }

            await finishMatch(match);
            return;
          } else {
            if (hasExtraTime) {
              return;
            } else if (hasPenaltyShootout) {
              return;
            } else {
              await finishMatch(match);
              return;
            }
          }
        }

        if (finishedExtra == extraTerms.length && finishedExtra > 0) {
          if (totalHomeScore != totalAwayScore) {
            await finishMatch(match);
            return;
          } else {
            if (hasPenaltyShootout) {
              // ignore: avoid_print
              print('🎯 المباراة متعادلة بعد الإضافي — الانتقال إلى البلنتيات');
              return;
            } else {
              // ignore: avoid_print
              print('⚠️ لا يوجد بلنتيات — سيتم إنهاء المباراة بالتعادل');
              await finishMatch(match);
              return;
            }
          }
        }

        if (finishedPenalty == penaltyTerms.length && penaltyTerms.isNotEmpty) {
          await finishMatch(match);
          return;
        }
      } else {
        if (allFinished) {
          await finishMatchAndUpdatePoints(matchId, DateTime.now());
          return;
        }
      }

      // ignore: avoid_print
      print('✅ تم إنهاء الشوط $termId للمباراة $matchId');
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

  Future<MatchTermModel> getCurrentMatchTerm(int matchId) async {
    final joinedTerms = await (db.select(db.matchTerms).join(<Join>[
      innerJoin(
        db.leagueTerms,
        db.leagueTerms.id.equalsExp(db.matchTerms.leagueTermId),
      ),
      innerJoin(
        db.terms,
        db.terms.id.equalsExp(db.leagueTerms.termId),
      ),
    ])
          ..where(db.matchTerms.matchId.equals(matchId)))
        .get();

    if (joinedTerms.isEmpty) {
      return MatchTermModel(
        id: 0,
        matchId: matchId,
        leagueTermId: 0,
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
        id: mt.id,
        matchId: mt.matchId,
        leagueTermId: mt.leagueTermId,
        startTime: mt.startTime,
        endTime: mt.endTime,
        additionalMinutes: mt.additionalMinutes,
        isFinished: mt.isFinished,
        leagueTermName: lt.id.toString(),
        termName: term.name,
        termType: term.type,
      );
    }).toList();

    for (final term in matchTerms) {
      if (!term.isFinished) return term;
    }

    return MatchTermModel(
      id: 0,
      matchId: matchId,
      leagueTermId: 0,
      isFinished: true,
      termName: 'انتهت المباراة',
      termType: 'finished',
      leagueTermName: '',
    );
  }

  Future<void> finishMatchAndUpdatePoints(
    int matchId,
    DateTime now,
  ) async {
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.id.equals(matchId)))
        .getSingleOrNull();

    if (matchEntity == null) {
      throw Exception('❌ لم يتم العثور على المباراة رقم $matchId');
    }

    final match = MatchModel.fromEntityWithRelations(matchEntity);

    if (match.status == 'finished') {
      // ignore: avoid_print
      print('⚠️ المباراة $matchId تم إنهاؤها مسبقًا');
      return;
    }

    if (match.leagueId == null) {
      // ignore: avoid_print
      print('⚠️ لا يمكن تحديث النقاط لأن match.leagueId غير موجود.');
      return;
    }

    final homeId = match.homeTeamId;
    final awayId = match.awayTeamId;

    if (homeId == null || awayId == null) {
      throw Exception('❌ أحد الفريقين غير معرف في المباراة $matchId');
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

    final homeRow = await (db.select(q)
          ..where(
            (t) => t.leagueId.equals(match.leagueId!) & t.teamId.equals(homeId),
          ))
        .getSingleOrNull();

    if (homeRow != null) {
      final homeModel = QualifiedTeamModel.fromEntity(homeRow).copyWith(
        points: homeRow.points + homePoints,
        played: homeRow.played + 1,
        wins: homePoints == 3 ? homeRow.wins + 1 : homeRow.wins,
        losses: homePoints == 0 ? homeRow.losses + 1 : homeRow.losses,
        draws: homePoints == 1 ? homeRow.draws + 1 : homeRow.draws,
      );

      await (db.update(q)..where((t) => t.id.equals(homeRow.id)))
          .write(homeModel.toCompanionUpdate());
    }

    final awayRow = await (db.select(q)
          ..where(
            (t) => t.leagueId.equals(match.leagueId!) & t.teamId.equals(awayId),
          ))
        .getSingleOrNull();

    if (awayRow != null) {
      final awayModel = QualifiedTeamModel.fromEntity(awayRow).copyWith(
        points: awayRow.points + awayPoints,
        played: awayRow.played + 1,
        wins: awayPoints == 3 ? awayRow.wins + 1 : awayRow.wins,
        losses: awayPoints == 0 ? awayRow.losses + 1 : awayRow.losses,
        draws: awayPoints == 1 ? awayRow.draws + 1 : awayRow.draws,
      );

      await (db.update(q)..where((t) => t.id.equals(awayRow.id)))
          .write(awayModel.toCompanionUpdate());
    }

    await (db.update(db.matches)..where((m) => m.id.equals(matchId))).write(
      MatchesCompanion(
        status: const Value('finished'),
        updatedAt: Value(now),
        endTime: Value(now),
      ),
    );

    // ignore: avoid_print
    print('🏁 تم إنهاء المباراة $matchId وتحديث النقاط بنجاح');
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

      if (fetchedGoal == null) {
        throw Exception('❌ فشل في جلب الهدف بعد الإدخال.');
      }

      insertedGoal = GoalModel.fromEntity(fetchedGoal);

      final match = await (db.select(db.matches)
            ..where((m) => m.id.equals(goal.matchId)))
          .getSingleOrNull();

      if (match == null) {
        throw Exception('❌ لم يتم العثور على المباراة رقم ${goal.matchId}');
      }

      final player = await (db.select(db.players)
            ..where((p) => p.id.equals(goal.playerId)))
          .getSingleOrNull();

      if (player == null) {
        throw Exception('❌ لم يتم العثور على اللاعب رقم ${goal.playerId}');
      }

      final bool isOwnGoal = goal.goalType == 'own_goal';
      final int? scoringTeamId = isOwnGoal ? match.awayTeamId : player.teamId;

      final int? opponentTeamId = isOwnGoal
          ? player.teamId
          : (match.awayTeamId == scoringTeamId
              ? match.homeTeamId
              : match.awayTeamId);

      final bool isHomeScorer = scoringTeamId == match.homeTeamId;
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
                  t.leagueId.equals(match.leagueId) &
                  t.teamId.equals(scoringTeamId!),
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
                  t.leagueId.equals(match.leagueId) &
                  t.teamId.equals(opponentTeamId!),
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

  Future<int> deleteGoal(int goalId) async {
    late int? assistPlayerId;
    await db.transaction(() async {
      final goal = await (db.select(db.goals)
            ..where((g) => g.id.equals(goalId)))
          .getSingleOrNull();

      if (goal == null) {
        throw Exception('❌ الهدف غير موجود');
      }
      final assist = await (db.select(db.assists)
            ..where((a) => a.goalId.equals(goalId)))
          .getSingleOrNull();

      assistPlayerId = assist?.playerId;
      print(assistPlayerId.toString() + 'from deleteGoal');
      if (assist != null) {
        await (db.delete(db.assists)..where((a) => a.goalId.equals(goalId)))
            .go();
      }

      await (db.delete(db.goals)..where((g) => g.id.equals(goalId))).go();

      final match = await (db.select(db.matches)
            ..where((m) => m.id.equals(goal.matchId)))
          .getSingleOrNull();

      if (match == null) return 0;

      final player = await (db.select(db.players)
            ..where((p) => p.id.equals(goal.playerId)))
          .getSingleOrNull();

      if (player == null) return 0;

      final bool isOwnGoal = goal.goalType == 'own_goal';
      final int? scoringTeamId = isOwnGoal ? match.awayTeamId : player.teamId;

      final int? opponentTeamId = isOwnGoal
          ? player.teamId
          : (match.awayTeamId == scoringTeamId
              ? match.homeTeamId
              : match.awayTeamId);

      final bool isHomeScorer = scoringTeamId == match.homeTeamId;
      final int updatedHomeScore = match.homeScore - (isHomeScorer ? 1 : 0);
      final int updatedAwayScore = match.awayScore - (isHomeScorer ? 0 : 1);

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
                  t.leagueId.equals(match.leagueId) &
                  t.teamId.equals(scoringTeamId!),
            ))
          .getSingleOrNull();

      if (scoringRow != null && scoringRow.goalsFor > 0) {
        await (db.update(q)..where((t) => t.id.equals(scoringRow.id))).write(
          QualifiedTeamCompanion(
            goalsFor: Value(scoringRow.goalsFor - 1),
          ),
        );
      }

      final opponentRow = await (db.select(q)
            ..where(
              (t) =>
                  t.leagueId.equals(match.leagueId) &
                  t.teamId.equals(opponentTeamId!),
            ))
          .getSingleOrNull();

      if (opponentRow != null && opponentRow.goalsAgainst > 0) {
        await (db.update(q)..where((t) => t.id.equals(opponentRow.id))).write(
          QualifiedTeamCompanion(
            goalsAgainst: Value(opponentRow.goalsAgainst - 1),
          ),
        );
      }
      print(assistPlayerId.toString() + 'from deleteGoal');
    });
    return assistPlayerId!;
  }

  Future<WarningModel> insertWarning(WarningModel warning) async {
    late WarningModel insertedWarning;

    await db.transaction(() async {
      final int idWarring =
          await db.into(db.warnings).insert(warning.toCompanionInsert());

      final fetchedWarring = await (db.select(db.warnings)
            ..where((g) => g.id.equals(idWarring)))
          .getSingleOrNull();

      if (fetchedWarring == null) {
        throw Exception('❌ فشل في جلب الهدف بعد الإدخال.');
      }

      insertedWarning = WarningModel.fromEntity(fetchedWarring);
    });

    return insertedWarning;
  }

  Future<void> deleteWarning(int warningId) async {
    await (db.delete(db.warnings)..where((w) => w.id.equals(warningId))).go();
  }

  Future<MatchModel?> getFullMatchData(int matchId) async {
    return db.transaction<MatchModel?>(() async {
      final match = await (db.select(db.matches)
            ..where((m) => m.id.equals(matchId)))
          .getSingleOrNull();

      if (match == null) return null;

      final homeTeam = await (db.select(db.teams)
            ..where((t) => t.id.equals(match.homeTeamId)))
          .getSingleOrNull();

      final awayTeam = await (db.select(db.teams)
            ..where((t) => t.id.equals(match.awayTeamId)))
          .getSingleOrNull();
      final matchTerms = await (db.select(db.matchTerms)
            ..where((t) => t.matchId.equals(matchId))
            ..orderBy([
              (t) => OrderingTerm.asc(t.id),
            ]))
          .get();

      final goalsQuery = await (db.select(db.goals)
            ..where((g) => g.matchId.equals(matchId)))
          .join(<Join>[
        leftOuterJoin(
          db.players,
          db.players.id.equalsExp(db.goals.playerId),
        ),
      ]).get();

      final goalModels = goalsQuery.map((row) {
        final goal = row.readTable(db.goals);
        final player = row.readTableOrNull(db.players);
        return GoalModel(
          id: goal.id,
          matchId: goal.matchId,
          playerId: goal.playerId,
          matchTermId: goal.matchTermId,
          goalTime: goal.goalTime,
          goalType: goal.goalType,
          teamId: player?.teamId,
        );
      }).toList();

      final warningsQuery = await (db.select(db.warnings)
            ..where((w) => w.matchId.equals(matchId)))
          .join(<Join>[
        leftOuterJoin(
          db.players,
          db.players.id.equalsExp(db.warnings.playerId),
        ),
      ]).get();

      final warningModels = warningsQuery.map((row) {
        final warning = row.readTable(db.warnings);
        final player = row.readTableOrNull(db.players);
        return WarningModel(
          id: warning.id,
          matchId: warning.matchId,
          playerId: warning.playerId,
          matchTermId: warning.matchTermId,
          warningTime: warning.warningTime,
          warningType: warning.warningType,
          reason: warning.reason,
          teamId: player?.teamId,
        );
      }).toList();

      final matchTermModels =
          matchTerms.map(MatchTermModel.fromEntity).toList();

      final fullMatch = MatchModel.fromEntityWithRelations(
        match,
        home: homeTeam,
        away: awayTeam,
        matchTerms: matchTermModels,
        goals: goalModels,
        warnings: warningModels,
      );

      return fullMatch;
    });
  }

  Future<AssistModel> addAssist(AssistModel assist) async {
    late AssistModel insertedAssist;

    await db.transaction(() async {
      // 1️⃣ تأكيد أن الهدف موجود
      final goal = await (db.select(db.goals)
            ..where((g) => g.id.equals(assist.goalId)))
          .getSingleOrNull();
      print('1');
      if (goal == null) {
        throw Exception('❌ لم يتم العثور على الهدف رقم ${assist.goalId}');
      }
      final existing = await (db.select(db.assists)
            ..where((a) => a.goalId.equals(assist.goalId)))
          .getSingleOrNull();

      if (existing != null) {
        throw Exception('هذا الهدف لديه أسيست بالفعل، لا يمكن إضافة أسيست آخر');
      }

      // 2️⃣ إدخال الأسيست
      final insertedId =
          await db.into(db.assists).insert(assist.toCompanionInsert());
      print('2');

      final fetchedAssist = await (db.select(db.assists)
            ..where((a) => a.id.equals(insertedId)))
          .getSingleOrNull();

      if (fetchedAssist == null) {
        throw Exception('❌ فشل في جلب الأسيست بعد الإدخال.');
      }

      insertedAssist = AssistModel.fromEntity(fetchedAssist);
    });

    return insertedAssist;
  }

  Future<PlayerStats> getPlayerStats({
    required int matchId,
    required int playerId,
  }) async {
    // goals
    final goalsCount = await (db.select(db.goals)
          ..where((g) =>
              g.matchId.equals(matchId) &
              g.playerId.equals(playerId) &
              g.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    // assists
    final assistsCount = await (db.select(db.assists)
          ..where((a) =>
              a.matchId.equals(matchId) &
              a.playerId.equals(playerId) &
              a.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    // yellow cards
    final yellowCount = await (db.select(db.warnings)
          ..where((w) =>
              w.matchId.equals(matchId) &
              w.playerId.equals(playerId) &
              w.warningType.equals('yellow') &
              w.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    // red cards
    final redCount = await (db.select(db.warnings)
          ..where((w) =>
              w.matchId.equals(matchId) &
              w.playerId.equals(playerId) &
              w.warningType.equals('red') &
              w.status.equals('active')))
        .get()
        .then((rows) => rows.length);

    // ✅ بناء PlayerStats عبر العمليات بدلاً من الإنشاء اليدوي
    return operations.buildPlayerStats(
      goals: goalsCount,
      assists: assistsCount,
      yellowCards: yellowCount,
      redCards: redCount,
    );
  }
  //
  //
  // Future<Unit> substitutePlayer({
  //   required int matchId,
  //   required int matchTermId,
  //   required int outgoingPlayerId,
  //   required int incomingPlayerId,
  //   required int substitutionMinute,
  // }) async {
  //   await db.transaction(() async {
  //     // 1) إدخال مشاركة اللاعب الخارج (SUB_OUT)
  //     print('🔁 [Local] substitutePlayer ENTER: '
  //         'matchId=$matchId, termId=$matchTermId, '
  //         'outgoing=$outgoingPlayerId, incoming=$incomingPlayerId, '
  //         'minute=$substitutionMinute');
  //     await db.into(db.playerMatchParticipation).insertReturning(
  //           PlayerMatchParticipationCompanion.insert(
  //             matchId: matchId,
  //             playerId: outgoingPlayerId,
  //             matchTermId: matchTermId,
  //             startTime: Value(0),
  //             // أو null أو دقيقة بداية الشوط إذا أردت
  //             endTime: Value(substitutionMinute),
  //             substitutedPlayerId: incomingPlayerId,
  //             participationType: 'SUB_OUT',
  //           ),
  //         );
  //
  //     // 2) إدخال مشاركة اللاعب الداخل (SUB_IN)
  //     await db.into(db.playerMatchParticipation).insertReturning(
  //           PlayerMatchParticipationCompanion.insert(
  //             matchId: matchId,
  //             playerId: incomingPlayerId,
  //             matchTermId: matchTermId,
  //             startTime: Value(substitutionMinute),
  //             endTime: const Value(null),
  //             substitutedPlayerId: outgoingPlayerId,
  //             participationType: 'SUB_IN',
  //           ),
  //         );
  //   });
  //   return Future.value(unit);
  // }

Future<Unit> substitutePlayer({
  required int matchId,
  required int matchTermId,
  required int outgoingPlayerId,
  required int incomingPlayerId,
  required int substitutionMinute,
}) async {
  print('🔁 [Local] substitutePlayer ENTER: matchId=$matchId, termId=$matchTermId, outgoing=$outgoingPlayerId, incoming=$incomingPlayerId, minute=$substitutionMinute');

  return await db.transaction(() async {
    final p = db.playerMatchParticipation;

    // 1️⃣ اللاعب الخارج
    final outgoingRow = await (db.select(p)
          ..where((row) =>
              row.matchId.equals(matchId) &
              row.matchTermId.equals(matchTermId) &
              row.playerId.equals(outgoingPlayerId)))
        .getSingleOrNull();

    // 2️⃣ اللاعب الداخل
    final incomingRow = await (db.select(p)
          ..where((row) =>
              row.matchId.equals(matchId) &
              row.matchTermId.equals(matchTermId) &
              row.playerId.equals(incomingPlayerId)))
        .getSingleOrNull();

    print('🔁 [Local] قبل التبديل: outgoingRow=$outgoingRow, incomingRow=$incomingRow');

    // ✅ تحديث اللاعب الخارج إلى SUB_OUT
    if (outgoingRow != null) {
      await (db.update(p)..where((row) => row.id.equals(outgoingRow.id))).write(
        PlayerMatchParticipationCompanion(
          endTime: Value(substitutionMinute),
          participationType: const Value('SUB_OUT'),
        ),
      );
    } else {
      print('⚠️ [Local] لم يتم العثور على مشاركة للاعب الخارج $outgoingPlayerId');
    }

    // ✅ إدخال/تحديث اللاعب الداخل إلى SUB_IN
    if (incomingRow == null) {
      final id = await db.into(p).insert(
            PlayerMatchParticipationCompanion.insert(
              matchId: matchId,
              playerId: incomingPlayerId,
              matchTermId: matchTermId,
              startTime:Value( substitutionMinute),
              endTime: const Value<int?>(null),
              substitutedPlayerId: outgoingPlayerId,
              participationType: 'SUB_IN',
            ),
          );
      print('🔁 [Local] تم إدخال مشاركة جديدة للاعب الداخل $incomingPlayerId برقم id=$id');
    } else {
      await (db.update(p)..where((row) => row.id.equals(incomingRow.id))).write(
        PlayerMatchParticipationCompanion(
          startTime: Value(substitutionMinute),
          endTime: const Value<int?>(null),
          substitutedPlayerId: Value(outgoingPlayerId),
          participationType: const Value('SUB_IN'),
        ),
      );
      print('🔁 [Local] تم تحديث مشاركة اللاعب الداخل $incomingPlayerId');
    }

    // 🔍 إعادة جلب القيم بعد التحديث للتأكد
    final updatedOutgoing = await (db.select(p)
          ..where((row) => row.id.equals(outgoingRow?.id ?? -1)))
        .getSingleOrNull();

    final updatedIncoming = await (db.select(p)
          ..where((row) =>
              row.matchId.equals(matchId) &
              row.matchTermId.equals(matchTermId) &
              row.playerId.equals(incomingPlayerId)))
        .getSingleOrNull();

    print('🔁 [Local] بعد التبديل: updatedOutgoing=$updatedOutgoing, updatedIncoming=$updatedIncoming');

    return unit;
  });
}
    // Future<String?> getPlayerParticipationStatus({
    //   required int matchId,
    //   required int matchTermId,
    //   required int playerId,
    // }) async {
    //   final query = db.select(db.playerMatchParticipation)
    //     ..where(
    //       (t) =>
    //           t.matchId.equals(matchId) &
    //           t.matchTermId.equals(matchTermId) &
    //           t.playerId.equals(playerId),
    //     )
    //     ..orderBy([
    //       // نأخذ آخر سجل (أعلى id)
    //       (t) => OrderingTerm.desc(t.id),
    //     ])
    //     ..limit(1);
    //
    //   final row = await query.getSingleOrNull();
    //   if (row == null) {
    //     // لا يوجد أي سجل لهذا اللاعب في هذا الشوط
    //     return null;
    //   }
    //
    //   // هنا ممكن تكون القيمة SUB_IN أو SUB_OUT أو أنواع أخرى لو أضفتها لاحقاً
    //   return row.participationType;
    // }
Future<String?> getPlayerParticipationStatus({
  required int matchId,
  required int matchTermId,
  required int playerId,
}) async {
  print('🔎 [Local] getPlayerParticipationStatus: matchId=$matchId, termId=$matchTermId, player=$playerId');

  // استعلام الجدول
  final query = db.select(db.playerMatchParticipation)
    ..where(
      (t) =>
          t.matchId.equals(matchId) &
          t.matchTermId.equals(matchTermId) &
          t.playerId.equals(playerId),
    )
    ..orderBy([
      (t) => OrderingTerm.desc(t.id),
    ])
    ..limit(1);

  final row = await query.getSingleOrNull();
  if (row == null) {
    return null;
  }
  return row.participationType;
}
Future<void> initStartersForMatchTerm({
  required int matchId,
  required int matchTermId,
}) async {
  // تهيئة اللاعبين الأساسيين كـ STARTER في هذا الشوط (مرة واحدة فقط لكل لاعب)
  print(
    '⚽ [Local] initStartersForMatchTerm: matchId=$matchId, termId=$matchTermId',
  );

  await db.transaction(() async {
    // 1) جلب بيانات المباراة كـ MatchModel (باستخدام fromEntityWithRelations)
    final matchEntity = await (db.select(db.matches)
          ..where((m) => m.id.equals(matchId)))
        .getSingleOrNull();

    if (matchEntity == null) {
      throw Exception('لم يتم العثور على مباراة بالمعرّف $matchId');
    }

    // نستعمل MatchModel كمودل لو احتجنا مستقبلاً المزيد من البيانات
    final matchModel = MatchModel.fromEntityWithRelations(matchEntity);
    final homeTeamId = matchModel.homeTeamId;
    final awayTeamId = matchModel.awayTeamId;

    if (homeTeamId == null || awayTeamId == null) {
      throw Exception('أحد الفريقين غير معرّف في المباراة $matchId');
    }

    // 2) جلب اللاعبين الأساسيين (status == "main") للفريقين وتحويلهم إلى PlayerModel
    final playersRows = await (db.select(db.players)
          ..where(
            (p) =>
                (p.teamId.equals(homeTeamId) |
                    p.teamId.equals(awayTeamId)) &
                p.status.equals('main'),
          ))
        .get(); // List<Player>

    if (playersRows.isEmpty) {
      print(
        '⚠ [Local] initStartersForMatchTerm: لا يوجد لاعبين أساسيين للمباراة $matchId',
      );
      return;
    }

    // نحول rows إلى PlayerModel لاتباع نمط الموديلات في المشروع
    final starterPlayers = playersRows
        .map((row) => PlayerModel.fromEntity(row))
        .toList(); // List<PlayerModel>

    final participationTable = db.playerMatchParticipation;
    final startersWithoutParticipation = <PlayerModel>[];

    // 3) نضيف STARTER فقط للاعبين الذين لا يملكون أي مشاركة في هذا الشوط
    for (final player in starterPlayers) {
      if (player.id == null) {
        // لاعب بدون id من الـ DB، نتجاهله بحذر
        print(
          '⚠ [Local] initStartersForMatchTerm: playerModel بدون id، سيتم تجاهله',
        );
        continue;
      }

      final existing = await (db.select(participationTable)
            ..where(
              (row) =>
                  row.matchId.equals(matchId) &
                  row.matchTermId.equals(matchTermId) &
                  row.playerId.equals(player.id!),
            ))
          .getSingleOrNull();

      if (existing == null) {
        startersWithoutParticipation.add(player);
      } else {
        print(
          'ℹ [Local] initStartersForMatchTerm: اللاعب ${player.id} لديه مشاركة سابقة '
          '(${existing.participationType})، لن يُعاد تعيينه كـ STARTER.',
        );
      }
    }

    if (startersWithoutParticipation.isEmpty) {
      print(
        'ℹ [Local] initStartersForMatchTerm: جميع اللاعبين الأساسيين لديهم مشاركات '
        'في هذا الشوط، لن تتم إضافة STARTER جديدة.',
      );
      return;
    }

    // 4) إنشاء PlayerMatchParticipationModel لكل لاعب ثم تحويله إلى Companion وإدخاله
    await db.batch((batch) {
      batch.insertAll(
        participationTable,
        startersWithoutParticipation.map((player) {
          // ننشئ مودل المشاركة
          final participationModel = PlayerMatchParticipationModel(
            id: 0, // سيتم تجاهله في insert (Drift ينشئ id)
            matchId: matchId,
            playerId: player.id!,
            matchTermId: matchTermId,
            startTime: 0, // بداية الشوط من الدقيقة 0
            endTime: null,
            substitutedPlayerId: null,
            participationType: 'STARTER',
          );

          // ثم نحوله يدوياً إلى Companion مناسب لـ Drift
          return PlayerMatchParticipationCompanion.insert(
            matchId: participationModel.matchId,
            playerId: participationModel.playerId,
            matchTermId: participationModel.matchTermId,
            startTime: Value(participationModel.startTime),
            endTime: const Value<int?>(null),
            substitutedPlayerId: 0,
            participationType: participationModel.participationType,
          );
        }).toList(),
      );
    });

    print(
      '✅ [Local] initStartersForMatchTerm: تم تهيئة '
      '${startersWithoutParticipation.length} لاعباً كأساسيين لهذا الشوط.',
    );
  });
}
}
