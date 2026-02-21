// import 'package:drift/drift.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../../../core/database/safirah_database.dart';
// import '../../../../group/data/model/model.dart';
// import '../../../../match/data/model/match_model.dart';
// import '../../../../match/data/model/round_model.dart';
// import '../../../../team_and_player/data/model/team_model.dart';
// import '../../model/match_term_model.dart';
// import '../../service/knockout_generator_service.dart';
// import 'local_term_data_source.dart';
// import 'package:rxdart/rxdart.dart';
//
// class KnockoutGeneratorLocalDataSource {
//   final Safirah db;
//   final KnockoutGeneratorService _service;
//
//   KnockoutGeneratorLocalDataSource(this.db)
//       : _service = const KnockoutGeneratorService();
//
//   Future<RoundModel> generateKnockoutFromGroups({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//     bool homeAway = false,
//     int? seed,
//     String roundNamePrefix = '',
//   }) async {
//     final matchTermLocal = MatchTermsEventLocalDataSource(db);
//
//     return db.transaction<RoundModel>(() async {
//       // 1) التحقق من عدم وجود مباريات جارية/مجدولة
//       final unfinished = await (db.select(db.matches)
//             ..where((m) => m.leagueSyncId.equals(leagueSyncId) &
//                 (m.status.equals('scheduled') | m.status.equals('live'))))
//           .get();
//       if (unfinished.isNotEmpty) {
//         throw Exception(
//             '⚠️ لا يمكن إنشاء التصفيات، بعض مباريات المجموعات لم تنته بعد.');
//       }
//
//       // 2) جلب المجموعات
//       final groupRows = await (db.select(db.group)
//             ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
//           .get();
//       if (groupRows.isEmpty) {
//         throw Exception('❌ لا توجد مجموعات لهذا الدوري ($leagueSyncId)');
//       }
//
//       final groups = groupRows.map((g) => GroupModel.fromEntity(g)).toList();
//
//       // 3) بناء قائمة المتأهلين لكل مجموعة
//       // NOTE: kept as int-keyed map to match existing KnockoutGeneratorService signature.
//       final Map<int, List<QualifiedTeamModel>> groupQualified = {};
//       for (final g in groupRows) {
//         final qualifiedRows = await (db.select(db.qualifiedTeam)
//               ..where((q) => q.groupSyncId.equals(g.syncId) &
//                   q.leagueSyncId.equals(leagueSyncId))
//               ..orderBy([
//                 (r) => OrderingTerm.desc(r.points),
//                 (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
//                 (r) => OrderingTerm.desc(r.goalsFor),
//               ]))
//             .get();
//
//         final selected = qualifiedRows.take(g.qualifiedTeamNumber).toList();
//         final models = <QualifiedTeamModel>[];
//         for (final r in selected) {
//           final teamEnt = await (db.select(db.teams)
//                 ..where((t) => t.syncId.equals(r.teamSyncId)))
//               .getSingleOrNull();
//           if (teamEnt != null) {
//             models.add(QualifiedTeamModel(
//               teamName: teamEnt.teamName,
//               groupSyncId: g.syncId,
//               teamSyncId: teamEnt.syncId,
//               leagueSyncId: leagueSyncId,
//               points: r.points,
//               goalsFor: r.goalsFor,
//               goalsAgainst: r.goalsAgainst,
//             ));
//           }
//         }
//         groupQualified[g.id] = models;
//       }
//
//       // 4) تكوين مباريات التصفيات منطقياً عبر الخدمة
//       final logicalMatches = _service.buildKnockoutMatchesFromGroups(
//         leagueSyncId: leagueSyncId,
//         groups: groups,
//         groupQualified: groupQualified,
//         homeAway: homeAway,
//         seed: seed,
//       );
//
//       if (logicalMatches.isEmpty) {
//         throw Exception('⚠️ لا توجد فرق متأهلة بعد من المجموعات.');
//       }
//
//       // 5) اسم الجولة
//       final roundName =
//           _service.roundNameForCount(logicalMatches.length, roundNamePrefix);
//
//       // 6) حفظ الجولة والمباريات في db وإنشاء match terms
//       final roundSyncId = const Uuid().v7();
//       final roundId = await db.into(db.rounds).insert(
//             RoundsCompanion.insert(
//               syncId: roundSyncId,
//               leagueSyncId: leagueSyncId,
//               name: roundName,
//               roundType: 'knockout',
//             ),
//           );
//
//       final insertedMatches = <MatchModel>[];
//       for (final m in logicalMatches) {
//         // Some services might still produce null/placeholder ids; keep safe.
//         final homeTid = m.homeTeamSyncId;
//         final awayTid = m.awayTeamSyncId;
//         if (homeTid == null || awayTid == null) continue;
//
//         final matchId = await db.into(db.matches).insert(
//               MatchesCompanion.insert(
//                 syncId: const Uuid().v7(),
//                 leagueSyncId: m.leagueSyncId ?? leagueSyncId,
//                 roundSyncId: roundSyncId,
//                 homeTeamSyncId: homeTid,
//                 awayTeamSyncId: awayTid,
//                 matchDate: m.matchDate ?? DateTime.now(),
//                 status: Value(m.status),
//                 homeScore: Value(m.homeScore),
//                 awayScore: Value(m.awayScore),
//               ),
//             );
//
//         final insertedMatchRow = await (db.select(db.matches)
//               ..where((mm) => mm.id.equals(matchId)))
//             .getSingle();
//
//         await matchTermLocal.createMatchTermsFromLeague(
//           matchSyncId: insertedMatchRow.syncId,
//           leagueSyncId: leagueSyncId,
//           roundType: 'knockout',
//         );
//
//         insertedMatches.add(m.copyWith(id: matchId, roundSyncId: roundSyncId));
//       }
//
//       return RoundModel(
//         id: roundId,
//         syncId: roundSyncId,
//         leagueSyncId: leagueSyncId,
//         roundName: roundName,
//         roundType: 'knockout',
//         groups: const [],
//         matches: insertedMatches,
//       );
//     });
//   }
//
//   Future<RoundModel?> createNextKnockoutRoundFromFinished({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//     String pairingStrategy = 'seeded',
//     bool homeAway = false,
//     int? seed,
//     String roundNamePrefix = '',
//   }) async {
//     final matchTermLocal = MatchTermsEventLocalDataSource(db);
//
//     return db.transaction<RoundModel?>(() async {
//       final finishedRoundEntity = await (db.select(db.rounds)
//             ..where((r) => r.syncId.equals(finishedRoundSyncId)))
//           .getSingleOrNull();
//       if (finishedRoundEntity == null) return null;
//
//       // 1) جلب مباريات الجولة المنتهية عبر roundSyncId
//       final matchEntities = await (db.select(db.matches)
//             ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
//           .get();
//
//       if (matchEntities.isEmpty) return null;
//       if (matchEntities.any((m) => m.status != 'finished')) {
//         throw Exception(
//             '⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
//       }
//
//       // 2) جلب الفرق المستخدمة (عن طريق sync ids)
//       final teamSyncIds = <String>{};
//       for (final m in matchEntities) {
//         teamSyncIds.add(m.homeTeamSyncId);
//         teamSyncIds.add(m.awayTeamSyncId);
//       }
//
//       final teamRows = await (db.select(db.teams)
//             ..where((t) => t.syncId.isIn(teamSyncIds.toList())))
//           .get();
//
//       // Keep map<int, TeamModel> because service expects that.
//       final teamsById = <int, TeamModel>{
//         for (final t in teamRows) t.id: TeamModel.fromEntity(t),
//       };
//
//       // 3) تحويل matchEntities إلى MatchModel
//       final finishedMatches = matchEntities
//           .map((m) => MatchModel.fromEntityWithRelations(
//                 m,
//                 home: null,
//                 away: null,
//                 matchTerms: const <MatchTermModel>[],
//               ))
//           .toList();
//
//       // 4) استخدام الخدمة لبناء مباريات الجولة التالية
//       final logicalMatches = _service.buildNextKnockoutMatches(
//         leagueSyncId: leagueSyncId,
//         finishedMatches: finishedMatches,
//         teamsById: teamsById,
//         pairingStrategy: pairingStrategy,
//         homeAway: homeAway,
//         seed: seed,
//       );
//
//       if (logicalMatches.isEmpty) return null;
//
//       // 5) اسم الجولة التالية
//       final nextRoundName =
//           _service.roundNameForCount(logicalMatches.length, roundNamePrefix);
//
//       final nextRoundSyncId = const Uuid().v7();
//       final nextRoundId = await db.into(db.rounds).insert(
//             RoundsCompanion.insert(
//               syncId: nextRoundSyncId,
//               leagueSyncId: leagueSyncId,
//               name: nextRoundName,
//               roundType: 'knockout',
//             ),
//           );
//
//       // helper: resolve team syncId from TeamModel (service may still build using id)
//       Future<String?> _teamSyncIdFromTeamModelId(int? id) async {
//         if (id == null) return null;
//         final row = await (db.select(db.teams)..where((t) => t.id.equals(id)))
//             .getSingleOrNull();
//         return row?.syncId;
//       }
//
//       // 6) حفظ المباريات وإنشاء match terms
//       for (final match in logicalMatches) {
//         final homeSync = match.homeTeamSyncId ??
//             await _teamSyncIdFromTeamModelId(match.homeTeam?.id);
//         final awaySync = match.awayTeamSyncId ??
//             await _teamSyncIdFromTeamModelId(match.awayTeam?.id);
//
//         if (homeSync == null || awaySync == null) continue;
//
//         final matches = await db.into(db.matches).insertReturning(
//               MatchesCompanion.insert(
//                 syncId: const Uuid().v7(),
//                 leagueSyncId: match.leagueSyncId ?? leagueSyncId,
//                 roundSyncId: nextRoundSyncId,
//                 homeTeamSyncId: homeSync,
//                 awayTeamSyncId: awaySync,
//                 matchDate: match.matchDate ?? DateTime.now(),
//                 status: Value(match.status),
//                 homeScore: Value(match.homeScore),
//                 awayScore: Value(match.awayScore),
//               ),
//             );
//
//         final insertedMatchRow = await (db.select(db.matches)
//               ..where((mm) => mm.syncId.equals(matches.syncId)))
//             .getSingle();
//
//         final termsMatch =   await matchTermLocal.createMatchTermsFromLeague(
//           matchSyncId: insertedMatchRow.syncId,
//           leagueSyncId: leagueSyncId,
//           roundType: 'knockout',
//         );
//         logicalMatches.add(MatchModel.fromEntityWithRelations(insertedMatchRow,matchTerms: termsMatch));
//
//       }
//
//       return RoundModel(
//         id: nextRoundId,
//         syncId: nextRoundSyncId,
//         leagueSyncId: leagueSyncId,
//         roundName: nextRoundName,
//         roundType: 'knockout',
//         matches: logicalMatches,
//         groups: const [],
//       );
//     });
//   }
//
//   Future<bool> areAllGroupMatchesFinished(String leagueSyncId) async {
//     // جلب كل مباريات "دور المجموعات" عبر ربطها بالجولات التي لها groupId
//     final groupMatches = await (db.select(db.matches).join([
//           innerJoin(db.rounds, db.rounds.syncId.equalsExp(db.matches.roundSyncId)),
//         ])
//           ..where(db.rounds.leagueSyncId.equals(leagueSyncId))
//           ..where(db.rounds.groupSyncId.isNotNull()))
//         .get()
//         .then((rows) => rows.map((row) => row.readTable(db.matches)).toList());
//
//     if (groupMatches.isEmpty) {
//       return false;
//     }
//
//     const unfinishedStatuses = {
//       'scheduled',
//       'unscheduled',
//       'live',
//       'pending',
//       'in_progress',
//     };
//
//     final unfinished = groupMatches.where((m) {
//       final status = m.status.toLowerCase().trim();
//       return unfinishedStatuses.contains(status);
//     }).toList();
//
//     return unfinished.isEmpty;
//   }
//
//   Future<RoundModel?> getCurrentLeagueRound(String leagueSyncId) async {
//     final rounds = await (db.select(db.rounds)
//           ..where((r) => r.leagueSyncId.equals(leagueSyncId))
//           ..orderBy([(r) => OrderingTerm.asc(r.id)]))
//         .get();
//
//     if (rounds.isEmpty) {
//       return null;
//     }
//
//     final latestRound = rounds.last;
//     return RoundModel.fromEntity(latestRound);
//   }
//   Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
//     required String leagueSyncId,
//     required String matchFilter,
//   }) {
//     final roundsTrigger = (db.select(db.rounds)
//       ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
//         .watch()
//         .map((_) => null);
//
//     final matchesTrigger = (db.select(db.matches)
//       ..where((m) => m.leagueSyncId.equals(leagueSyncId)))
//         .watch()
//         .map((_) => null);
//
//     // ✅ debounced rebuild لتجنب كثرة إعادة البناء أثناء التحديثات
//     return MergeStream([roundsTrigger, matchesTrigger])
//         .debounceTime(const Duration(milliseconds: 120))
//         .asyncMap((_) => getAllKnockoutRoundsWithMatches(
//        leagueSyncId,
//        matchFilter,
//     ));
//   }
//   Future<List<RoundModel>> getAllKnockoutRoundsWithMatches(
//     String leagueSyncId,
//     String matchFilter,
//   ) async {
//     final homeAlias = db.alias(db.teams, 'home');
//     final awayAlias = db.alias(db.teams, 'away');
//
//     final roundEntities = await (db.select(db.rounds)
//           ..where((r) => r.leagueSyncId.equals(leagueSyncId) &
//               r.roundType.equals('knockout')))
//         .get();
//
//     final List<RoundModel> rounds = [];
//     final filtersList = matchFilter
//         .toLowerCase()
//         .split(',')
//         .map((s) => s.trim())
//         .where((s) => s.isNotEmpty)
//         .toList();
//
//     final bool showAll = filtersList.contains('all') || filtersList.isEmpty;
//
//     for (final r in roundEntities) {
//       final query = db.select(db.matches).join([
//         innerJoin(homeAlias, homeAlias.syncId.equalsExp(db.matches.homeTeamSyncId)),
//         innerJoin(awayAlias, awayAlias.syncId.equalsExp(db.matches.awayTeamSyncId)),
//       ]);
//
//       final filters = <Expression<bool>>[
//         db.matches.roundSyncId.equals(r.syncId),
//         db.matches.leagueSyncId.equals(leagueSyncId),
//       ];
//
//       if (!showAll) {
//         final statusExpressions = <Expression<bool>>[];
//
//         for (final status in filtersList) {
//           switch (status) {
//             case 'scheduled':
//               statusExpressions.add(db.matches.status.equals('scheduled'));
//               break;
//             case 'unscheduled':
//               statusExpressions.add(db.matches.status.equals('unscheduled'));
//               break;
//             case 'live':
//               statusExpressions.add(db.matches.status.equals('live'));
//               break;
//             case 'finished':
//               statusExpressions.add(db.matches.status.equals('finished'));
//               break;
//           }
//         }
//
//         if (statusExpressions.isNotEmpty) {
//           final combined = statusExpressions.reduce((a, b) => a | b);
//           filters.add(combined);
//         }
//       }
//
//       query.where(filters.reduce((a, b) => a & b));
//
//       final joined = await query.get();
//
//       final matches = await Future.wait(joined.map((row) async {
//         final match = row.readTable(db.matches);
//         final home = row.readTable(homeAlias);
//         final away = row.readTable(awayAlias);
//
//         final matchTerms = await (db.select(db.matchTerms)
//               ..where((mt) => mt.matchSyncId.equals(match.syncId)))
//             .get();
//
//         final matchTermModels =
//             matchTerms.map((mt) => MatchTermModel.fromEntity(mt)).toList();
//         return MatchModel.fromEntityWithRelations(
//           match,
//           home: home,
//           away: away,
//           matchTerms: matchTermModels,
//         );
//       }));
//
//       rounds.add(RoundModel(
//         id: r.id,
//         syncId: r.syncId,
//         leagueSyncId: r.leagueSyncId,
//         roundName: r.name,
//         roundType: r.roundType,
//         createdAt: r.createdAt,
//         matches: matches,
//       ));
//     }
//
//     return rounds;
//   }
//
//   Future<void> checkAndCreateNextKnockoutRoundIfNeeded(
//     String leagueSyncId,
//     String finishedRoundSyncId,
//   ) async {
//     final finishedRoundEntity = await (db.select(db.rounds)
//           ..where((r) => r.syncId.equals(finishedRoundSyncId)))
//         .getSingleOrNull();
//
//     if (finishedRoundEntity == null) return;
//
//     final matches = await (db.select(db.matches)
//           ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
//         .get();
//
//     if (matches.isEmpty) return;
//     if (matches.any((m) => m.status != 'finished')) return;
//
//     await createNextKnockoutRoundFromFinished(
//       leagueSyncId: leagueSyncId,
//       finishedRoundSyncId: finishedRoundSyncId,
//     );
//   }
//
//   Future<void> upsertRoundsWithMatchesLocal(
//       List<RoundModel> apiRounds,
//       ) async {
//     if (apiRounds.isEmpty) return;
//
//     // =========================
//     // تجهيز بيانات (memory only)
//     // =========================
//
//     // (A) ربط rounds ب sync_id الصحيح
//     print('🔄 upsertRoundsWithMatchesLocal: Received ${apiRounds.length} rounds from API');
//     final rounds = apiRounds
//         .where((r) => (r.syncId ?? '').trim().isNotEmpty)
//         .toList();
//
//     if (rounds.isEmpty) return;
//     print('🔄 upsertRoundsWithMatchesLocal: Received ${apiRounds.length} rounds from API');
//
//     // (B) جولات التي أرسل لها API matches (حتى لو فاضية)
//     final roundsWithMatchesPayload = <String, List<MatchModel>>{};
//     for (final r in rounds) {
//       if (r.matches != null) {
//         roundsWithMatchesPayload[r.syncId!.trim()] = r.matches ?? const <MatchModel>[];
//       }
//     }
//     print('🔄 upsertRoundsWithMatchesLocal: Received ${apiRounds.length} rounds from API');
//
//     // (C) تجهيز كل matches للـ upsert في batch واحد
//     final allMatchesToUpsert = <MatchesCompanion>[];
//
//     // (D) تجهيز incoming ids لكل round (لاستخدامها في delete sync)
//     final incomingMatchIdsByRound = <String, Set<String>>{};
//
//     for (final r in rounds) {
//       final roundId = r.syncId!.trim();
//
//       final matchesProvided = roundsWithMatchesPayload.containsKey(roundId);
//       if (!matchesProvided) continue;
//
//       final matches = roundsWithMatchesPayload[roundId]!;
//       final incoming = <String>{};
//
//       for (final m in matches) {
//         final sid = (m.syncId ?? '').trim();
//         if (sid.isNotEmpty) incoming.add(sid);
//
//         // تجاهل أي match غير صالح (مثل نقص فريق)
//         final homeId = (m.homeTeamSyncId ?? '').trim();
//         final awayId = (m.awayTeamSyncId ?? '').trim();
//         if (homeId.isEmpty || awayId.isEmpty) continue;
//
//         // normalization + to companion
//         allMatchesToUpsert.add(
//           m.copyWith(
//             leagueSyncId: (m.leagueSyncId ?? '').trim().isNotEmpty
//                 ? m.leagueSyncId
//                 : r.leagueSyncId,
//             roundSyncId: (m.roundSyncId ?? '').trim().isNotEmpty
//                 ? m.roundSyncId
//                 : roundId,
//             updatedAt: DateTime.now(),
//           ).toUpsertCompanion(
//             fallbackLeagueSyncId: r.leagueSyncId,
//             fallbackRoundSyncId: roundId,
//           ),
//         );
//       }
//
//       incomingMatchIdsByRound[roundId] = incoming;
//     }
//
//     // =========================
//     // تنفيذ DB: Transaction
//     // =========================
//     await db.transaction(() async {
//       // 1) Upsert Rounds مرة واحدة
//       await db.batch((batch) {
//         for (final r in rounds) {
//           final syncId = (r.syncId ?? '').trim();
//           if (syncId.isEmpty) continue;
//
//           batch.customStatement(
//             '''
//         INSERT INTO rounds (sync_id, league_sync_id, round_name, round_type)
//         VALUES (?, ?, ?, ?)
//         ON CONFLICT(sync_id) DO UPDATE SET
//           league_sync_id = excluded.league_sync_id,
//           round_name     = excluded.round_name,
//           round_type     = excluded.round_type
//         ''',
//             [
//               syncId,
//               (r.leagueSyncId ?? '').trim(),
//               (r.roundName ?? '').trim(),
//               (r.roundType ?? '').trim(),
//             ],
//           );
//         }
//       });
//       print('🔄 upsertRoundsWithMatchesLocal: Received ${apiRounds.length} rounds from API');
//
//       // 2) Sync delete per round (فقط للجولات التي أرسل API matches لها)
//       for (final entry in incomingMatchIdsByRound.entries) {
//         final roundSyncId = entry.key;
//         final incomingIds = entry.value;
//
//         // لو API رجع [] أو كل syncIds فاضية => اعتبره "لا مباريات" واحذف الكل
//         if (incomingIds.isEmpty) {
//           await (db.delete(db.matches)
//             ..where((t) => t.roundSyncId.equals(roundSyncId)))
//               .go();
//           continue;
//         }
//
//         await (db.delete(db.matches)
//           ..where((t) => t.roundSyncId.equals(roundSyncId))
//           ..where((t) => t.syncId.isNotIn(incomingIds.toList())))
//             .go();
//       }
//
//       // 3) Upsert كل Matches في Batch واحد
//       if (allMatchesToUpsert.isNotEmpty) {
//         await db.batch((batch) {
//           batch.insertAllOnConflictUpdate(db.matches, allMatchesToUpsert);
//         });
//       }
//     });
//     print('🔄 upsertRoundsWithMatchesLocal: Received ${apiRounds[0].matches!.length} rounds from API');
//
//   }
//   Future<bool> hasAnyKnockoutRound(String leagueSyncId) async {
//     final row = await (db.select(db.rounds)
//       ..where((r) => r.leagueSyncId.equals(leagueSyncId) &
//       r.roundType.equals('knockout'))
//       ..limit(1))
//         .getSingleOrNull();
//
//     return row != null;
//   }
//
//   /// يمنع الإنشاء إذا:
//   /// - يوجد بالفعل knockout
//   /// - أو مباريات group لم تنته
//   Future<bool> shouldGenerateFirstKnockout(String leagueSyncId) async {
//     if (await hasAnyKnockoutRound(leagueSyncId)) return false;
//     return await areAllGroupMatchesFinished(leagueSyncId);
//   }
// // -------- Locks: First Knockout (مرة لكل League) --------
//   Future<bool> _isFirstKnockoutLocked(String leagueSyncId) async {
//     final row = await (db.select(db.leagueKnockoutFlags)
//       ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
//         .getSingleOrNull();
//     return row?.firstKnockoutCreated ?? false;
//   }
//
//   Future<void> _lockFirstKnockout(String leagueSyncId) async {
//     await db.into(db.leagueKnockoutFlags).insertOnConflictUpdate(
//       LeagueKnockoutFlagsCompanion(
//         leagueSyncId: Value(leagueSyncId),
//         firstKnockoutCreated: const Value(true),
//         updatedAt: Value(DateTime.now()),
//       ),
//     );
//   }
//
// // -------- Locks: Next Knockout (مرة لكل finishedRoundSyncId) --------
//   Future<bool> _hasNextLock({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//   }) async {
//     final row = await (db.select(db.knockoutProgressLocks)
//       ..where((t) => t.leagueSyncId.equals(leagueSyncId))
//       ..where((t) => t.finishedRoundSyncId.equals(finishedRoundSyncId)))
//         .getSingleOrNull();
//     return row != null;
//   }
//
//   Future<void> _addNextLock({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//   }) async {
//     await db.into(db.knockoutProgressLocks).insert(
//       KnockoutProgressLocksCompanion(
//         leagueSyncId: Value(leagueSyncId),
//         finishedRoundSyncId: Value(finishedRoundSyncId),
//       ),
//       mode: InsertMode.insertOrIgnore,
//     );
//   }
//   Future<void> ensureKnockoutProgress({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//   }) async {
//     await db.transaction(() async {
//       // 1) تحديد المرحلة الحالية (آخر round)
//       final current = await getCurrentLeagueRound(leagueSyncId);
//       if (current == null) return;
//
//       // =========================
//       // GROUP => Generate First KO
//       // =========================
//       if (current.roundType == 'group') {
//         // شرطك الحالي ممتاز
//         final should = await shouldGenerateFirstKnockout(leagueSyncId);
//         if (!should) return;
//
//         // lock لمنع التكرار (مرة لكل league)
//         final locked = await _isFirstKnockoutLocked(leagueSyncId);
//         if (locked) return;
//
//         // أنشئ أول KO
//         await generateKnockoutFromGroups(
//           leagueSyncId: leagueSyncId,
//           qualifiedPerGroup: qualifiedPerGroup,
//         );
//
//         // اقفل بعد النجاح
//         await _lockFirstKnockout(leagueSyncId);
//         return;
//       }
//
//       // =========================
//       // KNOCKOUT => Generate Next KO
//       // =========================
//
//       // 2) نحتاج نعرف آخر Round Knockout مكتمل
//       // (أفضل: تعتمد على finishedRoundSyncId من UI/repo وتمرره هنا)
//       final finishedRoundSyncId = await _getLastFinishedKnockoutRoundSyncId(leagueSyncId);
//       if (finishedRoundSyncId == null) return;
//
//       // 3) lock per finishedRoundSyncId
//       final hasLock = await _hasNextLock(
//         leagueSyncId: leagueSyncId,
//         finishedRoundSyncId: finishedRoundSyncId,
//       );
//       if (hasLock) return;
//
//       // 4) تحقق + إنشاء التالي (عندك الدالة جاهزة)
//       await checkAndCreateNextKnockoutRoundIfNeeded(
//         leagueSyncId,
//         finishedRoundSyncId,
//       );
//
//       // 5) اقفل بعد النجاح
//       // (مهم: لا تقفل إذا ما انشأ فعلياً—لكن دالتك تنشئ فقط إذا كل شيء finished)
//       await _addNextLock(
//         leagueSyncId: leagueSyncId,
//         finishedRoundSyncId: finishedRoundSyncId,
//       );
//     });
//   }
//   Future<String?> _getLastFinishedKnockoutRoundSyncId(String leagueSyncId) async {
//     // جلب كل جولات knockout
//     final rounds = await (db.select(db.rounds)
//       ..where((r) => r.leagueSyncId.equals(leagueSyncId) & r.roundType.equals('knockout'))
//       ..orderBy([(r) => OrderingTerm.desc(r.id)]))
//         .get();
//
//     for (final r in rounds) {
//       final matches = await (db.select(db.matches)
//         ..where((m) => m.roundSyncId.equals(r.syncId)))
//           .get();
//
//       if (matches.isEmpty) continue;
//       final allFinished = matches.every((m) => m.status == 'finished');
//       if (allFinished) return r.syncId;
//     }
//
//     return null;
//   }
//
// }
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/database/safirah_database.dart';
import '../../../../group/data/model/model.dart';
import '../../../../match/data/model/match_model.dart';
import '../../../../match/data/model/round_model.dart';
import '../../../../team_and_player/data/model/team_model.dart';
import '../../model/match_term_model.dart';
import '../../service/knockout_generator_service.dart';
import 'local_term_data_source.dart';

class KnockoutGeneratorLocalDataSource {
  final Safirah db;
  final KnockoutGeneratorService _service;

  KnockoutGeneratorLocalDataSource(this.db)
      : _service = const KnockoutGeneratorService();

  // ---------------------------------------------------------------------------
  // GROUP => Generate first KO
  // ---------------------------------------------------------------------------
  Future<RoundModel> generateKnockoutFromGroups({
    required String leagueSyncId,
    required int qualifiedPerGroup,
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    return db.transaction<RoundModel>(() async {
      // 1) التحقق من عدم وجود مباريات جارية/مجدولة
      final unfinished = await (db.select(db.matches)
        ..where((m) =>
        m.leagueSyncId.equals(leagueSyncId) &
        (m.status.equals('scheduled') | m.status.equals('live'))))
          .get();

      if (unfinished.isNotEmpty) {
        throw Exception('⚠️ لا يمكن إنشاء التصفيات، بعض المباريات لم تنته بعد.');
      }

      // 2) جلب المجموعات
      final groupRows = await (db.select(db.group)
        ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
          .get();
      if (groupRows.isEmpty) {
        throw Exception('❌ لا توجد مجموعات لهذا الدوري ($leagueSyncId)');
      }

      final groups = groupRows.map((g) => GroupModel.fromEntity(g)).toList();

      // 3) المتأهلين لكل مجموعة
      final Map<int, List<QualifiedTeamModel>> groupQualified = {};
      for (final g in groupRows) {
        final qualifiedRows = await (db.select(db.qualifiedTeam)
          ..where((q) =>
          q.groupSyncId.equals(g.syncId) &
          q.leagueSyncId.equals(leagueSyncId))
          ..orderBy([
                (r) => OrderingTerm.desc(r.points),
                (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
                (r) => OrderingTerm.desc(r.goalsFor),
          ]))
            .get();

        final selected = qualifiedRows.take(g.qualifiedTeamNumber).toList();
        final models = <QualifiedTeamModel>[];

        for (final r in selected) {
          final teamEnt = await (db.select(db.teams)
            ..where((t) => t.syncId.equals(r.teamSyncId)))
              .getSingleOrNull();

          if (teamEnt != null) {
            models.add(QualifiedTeamModel(
              teamName: teamEnt.teamName,
              groupSyncId: g.syncId,
              teamSyncId: teamEnt.syncId,
              leagueSyncId: leagueSyncId,
              points: r.points,
              goalsFor: r.goalsFor,
              goalsAgainst: r.goalsAgainst,
            ));
          }
        }

        groupQualified[g.id] = models;
      }

      // 4) بناء مباريات التصفيات
      final logicalMatches = _service.buildKnockoutMatchesFromGroups(
        leagueSyncId: leagueSyncId,
        groups: groups,
        groupQualified: groupQualified,
        homeAway: homeAway,
        seed: seed,
      );

      if (logicalMatches.isEmpty) {
        throw Exception('⚠️ لا توجد فرق متأهلة بعد من المجموعات.');
      }

      // 5) اسم الجولة
      final roundName =
      _service.roundNameForCount(logicalMatches.length, roundNamePrefix);

      // 6) حفظ الجولة والمباريات + terms
      final roundSyncId = const Uuid().v7();

      final roundId = await db.into(db.rounds).insert(
        RoundsCompanion.insert(
          syncId: roundSyncId,
          leagueSyncId: leagueSyncId,
          name: roundName, // drift maps to round_name
          roundType: 'knockout',
          groupSyncId: const Value.absent(),
        ),
      );

      final insertedMatches = <MatchModel>[];

      for (final m in logicalMatches) {
        final homeTid = m.homeTeamSyncId;
        final awayTid = m.awayTeamSyncId;
        if (homeTid == null || awayTid == null) continue;

        final matchRow = await db.into(db.matches).insertReturning(
          MatchesCompanion.insert(
            syncId: const Uuid().v7(),
            leagueSyncId: m.leagueSyncId ?? leagueSyncId,
            roundSyncId: roundSyncId,
            homeTeamSyncId: homeTid,
            awayTeamSyncId: awayTid,
            matchDate: m.matchDate ?? DateTime.now(),
            status: Value(m.status),
            homeScore: Value(m.homeScore),
            awayScore: Value(m.awayScore),
          ),
        );

     final term =    await matchTermLocal.createMatchTermsFromLeague(
          matchSyncId: matchRow.syncId,
          leagueSyncId: leagueSyncId,
          roundType: 'knockout',
        );

        insertedMatches.add(
          m.copyWith(id: matchRow.id, roundSyncId: roundSyncId,syncId: matchRow.syncId, matchTerms: term,),
        );
      }

      return RoundModel(
        id: roundId,
        syncId: roundSyncId,
        leagueSyncId: leagueSyncId,
        roundName: roundName,
        roundType: 'knockout',
        groups: const [],
        matches: insertedMatches,
      );
    });
  }

  // ---------------------------------------------------------------------------
  // KNOCKOUT => Create next KO from finished round
  // ---------------------------------------------------------------------------
  // Future<RoundModel?> createNextKnockoutRoundFromFinished({
  //   required String leagueSyncId,
  //   required String finishedRoundSyncId,
  //   String pairingStrategy = 'seeded',
  //   bool homeAway = false,
  //   int? seed,
  //   String roundNamePrefix = '',
  // }) async {
  //   final matchTermLocal = MatchTermsEventLocalDataSource(db);
  //
  //   return db.transaction<RoundModel?>(() async {
  //     final finishedRoundEntity = await (db.select(db.rounds)
  //       ..where((r) => r.syncId.equals(finishedRoundSyncId)))
  //         .getSingleOrNull();
  //     print(finishedRoundEntity);
  //     if (finishedRoundEntity == null) return null;
  //
  //     // 1) جلب مباريات الجولة المنتهية
  //     final matchEntities = await (db.select(db.matches)
  //       ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
  //         .get();
  //
  //     if (matchEntities.isEmpty) return null;
  //     if (matchEntities.any((m) => m.status != 'finished')) {
  //       throw Exception('⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
  //     }
  //
  //     // 2) جلب الفرق
  //     final teamSyncIds = <String>{};
  //     for (final m in matchEntities) {
  //       teamSyncIds.add(m.homeTeamSyncId);
  //       teamSyncIds.add(m.awayTeamSyncId);
  //     }
  //
  //     final teamRows = await (db.select(db.teams)
  //       ..where((t) => t.syncId.isIn(teamSyncIds.toList())))
  //         .get();
  //
  //     final teamsBySyncId = <String, TeamModel>{
  //       for (final t in teamRows) t.syncId: TeamModel.fromEntity(t),
  //     };
  //
  //     // 3) تحويل matches
  //     final finishedMatches = matchEntities
  //         .map((m) => MatchModel.fromEntityWithRelations(
  //       m,
  //       home: null,
  //       away: null,
  //       matchTerms: const <MatchTermModel>[],
  //     ))
  //         .toList();
  //
  //     // 4) بناء مباريات الجولة التالية من الخدمة
  //     final logicalMatches = _service.buildNextKnockoutMatches(
  //       leagueSyncId: leagueSyncId,
  //       finishedMatches: finishedMatches,
  //       teamsBySyncId: teamsBySyncId,
  //       pairingStrategy: pairingStrategy,
  //       homeAway: homeAway,
  //       seed: seed,
  //     );
  //     print('nextKO: matches=${matchEntities.length}');
  //     print('nextKO: draws=${matchEntities.where((m)=>m.homeScore==m.awayScore).length}');
  //     print('nextKO: statuses=${matchEntities.map((m)=>m.status).toList()}');
  //     print('nextKO: teamRows=${teamRows.length} needed=${teamSyncIds.length}');
  //     if (logicalMatches.isEmpty) return null;
  //
  //     // 5) اسم الجولة
  //     final nextRoundName =
  //     _service.roundNameForCount(logicalMatches.length, roundNamePrefix);
  //
  //     final nextRoundSyncId = const Uuid().v7();
  //
  //     final nextRoundId = await db.into(db.rounds).insert(
  //       RoundsCompanion.insert(
  //         syncId: nextRoundSyncId,
  //         leagueSyncId: leagueSyncId,
  //         name: nextRoundName,
  //         roundType: 'knockout',
  //         groupSyncId: const Value.absent(),
  //       ),
  //     );
  //
  //     // ✅ helper: resolve team syncId if needed
  //     Future<String?> _teamSyncIdFromTeamModelId(int? id) async {
  //       if (id == null) return null;
  //       final row =
  //       await (db.select(db.teams)..where((t) => t.id.equals(id)))
  //           .getSingleOrNull();
  //       return row?.syncId;
  //     }
  //
  //     // ✅ IMPORTANT: لا تعدّل logicalMatches أثناء loop
  //     final insertedMatches = <MatchModel>[];
  //
  //     for (final match in logicalMatches) {
  //       final homeSync = match.homeTeamSyncId ??
  //           await _teamSyncIdFromTeamModelId(match.homeTeam?.id);
  //       final awaySync = match.awayTeamSyncId ??
  //           await _teamSyncIdFromTeamModelId(match.awayTeam?.id);
  //
  //       if (homeSync == null || awaySync == null) continue;
  //
  //       final inserted = await db.into(db.matches).insertReturning(
  //         MatchesCompanion.insert(
  //           syncId: const Uuid().v7(),
  //           leagueSyncId: match.leagueSyncId ?? leagueSyncId,
  //           roundSyncId: nextRoundSyncId,
  //           homeTeamSyncId: homeSync,
  //           awayTeamSyncId: awaySync,
  //           matchDate: match.matchDate ?? DateTime.now(),
  //           status: Value(match.status),
  //           homeScore: Value(match.homeScore),
  //           awayScore: Value(match.awayScore),
  //         ),
  //       );
  //
  //       final termsMatch = await matchTermLocal.createMatchTermsFromLeague(
  //         matchSyncId: inserted.syncId,
  //         leagueSyncId: leagueSyncId,
  //         roundType: 'knockout',
  //       );
  //
  //       insertedMatches.add(
  //         MatchModel.fromEntityWithRelations(
  //           inserted,
  //           home: null,
  //           away: null,
  //           matchTerms: termsMatch,
  //         ),
  //       );
  //     }
  //
  //     return RoundModel(
  //       id: nextRoundId,
  //       syncId: nextRoundSyncId,
  //       leagueSyncId: leagueSyncId,
  //       roundName: nextRoundName,
  //       roundType: 'knockout',
  //       matches: insertedMatches,
  //       groups: const [],
  //     );
  //   });
  // }
  Future<RoundModel?> createNextKnockoutRoundFromFinished({
    required String leagueSyncId,
    required String finishedRoundSyncId,
    String pairingStrategy = 'seeded',
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    bool isFinished(String s) => s.toLowerCase().trim() == 'finished';

    return db.transaction<RoundModel?>(() async {
      final finishedRoundEntity = await (db.select(db.rounds)
        ..where((r) => r.syncId.equals(finishedRoundSyncId)))
          .getSingleOrNull();

      if (finishedRoundEntity == null) return null;

      // 1) matches of finished round
      final matchEntities = await (db.select(db.matches)
        ..where((m) => m.roundSyncId.equals(finishedRoundEntity.syncId)))
          .get();

      if (matchEntities.isEmpty) return null;

      if (matchEntities.any((m) => !isFinished(m.status))) {
        throw Exception('⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
      }

      // 2) teams by syncId (for validation)
      final teamSyncIds = <String>{
        for (final m in matchEntities) m.homeTeamSyncId,
        for (final m in matchEntities) m.awayTeamSyncId,
      };

      final teamRows = await (db.select(db.teams)
        ..where((t) => t.syncId.isIn(teamSyncIds.toList())))
          .get();

      final teamsBySyncId = <String, TeamModel>{
        for (final t in teamRows) t.syncId: TeamModel.fromEntity(t),
      };

      // safety: ensure all teams exist
      if (teamsBySyncId.length != teamSyncIds.length) {
        throw Exception('⚠️ بعض الفرق غير موجود محليًا (teams rows mismatch).');
      }

      // 3) convert matches to models (sync-based)
      final finishedMatches = matchEntities
          .map((m) => MatchModel.fromEntityWithRelations(
        m,
        home: null,
        away: null,
        matchTerms: const <MatchTermModel>[],
      ))
          .toList();

      // 4) build next logical matches (THIS was returning empty before)
      final logicalMatches = _service.buildNextKnockoutMatches(
        leagueSyncId: leagueSyncId,
        finishedMatches: finishedMatches,
        teamsBySyncId: teamsBySyncId,
        pairingStrategy: pairingStrategy,
        homeAway: homeAway,
        seed: seed,
      );

      if (logicalMatches.isEmpty) return null;

      // 5) next round name + create round
      final nextRoundName =
      _service.roundNameForCount(logicalMatches.length, roundNamePrefix);

      final nextRoundSyncId = const Uuid().v7();

      final nextRoundId = await db.into(db.rounds).insert(
        RoundsCompanion.insert(
          syncId: nextRoundSyncId,
          leagueSyncId: leagueSyncId,
          name: nextRoundName,
          roundType: 'knockout',
          groupSyncId: const Value.absent(),
        ),
      );

      // 6) insert matches + terms
      final insertedMatches = <MatchModel>[];

      for (final match in logicalMatches) {
        final homeSync = (match.homeTeamSyncId ?? '').trim();
        final awaySync = (match.awayTeamSyncId ?? '').trim();

        // جدولك يمنع null و يمنع home==away
        if (homeSync.isEmpty || awaySync.isEmpty) continue;
        if (homeSync == awaySync) continue;

        final inserted = await db.into(db.matches).insertReturning(
          MatchesCompanion.insert(
            syncId: const Uuid().v7(),
            leagueSyncId: (match.leagueSyncId ?? leagueSyncId).trim(),
            roundSyncId: nextRoundSyncId,
            homeTeamSyncId: homeSync,
            awayTeamSyncId: awaySync,
            matchDate: match.matchDate ?? DateTime.now(),
            status: Value(match.status),
            homeScore: Value(match.homeScore),
            awayScore: Value(match.awayScore),
          ),
        );

        final termsMatch = await matchTermLocal.createMatchTermsFromLeague(
          matchSyncId: inserted.syncId,
          leagueSyncId: leagueSyncId,
          roundType: 'knockout',
        );

        insertedMatches.add(
          MatchModel.fromEntityWithRelations(
            inserted,
            home: null,
            away: null,
            matchTerms: termsMatch,
          ),
        );
      }

      return RoundModel(
        id: nextRoundId,
        syncId: nextRoundSyncId,
        leagueSyncId: leagueSyncId,
        roundName: nextRoundName,
        roundType: 'knockout',
        matches: insertedMatches,
        groups: const [],
      );
    });
  }
  // ---------------------------------------------------------------------------
  // Queries & watchers
  // ---------------------------------------------------------------------------
  Future<bool> areAllGroupMatchesFinished(String leagueSyncId) async {
    final groupMatches = await (db.select(db.matches).join([
      innerJoin(db.rounds, db.rounds.syncId.equalsExp(db.matches.roundSyncId)),
    ])
      ..where(db.rounds.leagueSyncId.equals(leagueSyncId))
      ..where(db.rounds.groupSyncId.isNotNull()))
        .get()
        .then((rows) => rows.map((row) => row.readTable(db.matches)).toList());

    if (groupMatches.isEmpty) return false;

    const unfinishedStatuses = {
      'scheduled',
      'unscheduled',
      'live',
      'pending',
      'in_progress',
    };

    return groupMatches.every((m) {
      final s = m.status.toLowerCase().trim();
      return !unfinishedStatuses.contains(s);
    });
  }

  Future<RoundModel?> getCurrentLeagueRound(String leagueSyncId) async {
    final rounds = await (db.select(db.rounds)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId))
      ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();

    if (rounds.isEmpty) return null;
    return RoundModel.fromEntity(rounds.last);
  }

  Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
    required String leagueSyncId,
    required String matchFilter,
  }) {
    final roundsTrigger = (db.select(db.rounds)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);

    final matchesTrigger = (db.select(db.matches)
      ..where((m) => m.leagueSyncId.equals(leagueSyncId)))
        .watch()
        .map((_) => null);

    return MergeStream([roundsTrigger, matchesTrigger])
        .debounceTime(const Duration(milliseconds: 120))
        .asyncMap((_) => getAllKnockoutRoundsWithMatches(leagueSyncId, matchFilter));
  }

  Future<List<RoundModel>> getAllKnockoutRoundsWithMatches(
      String leagueSyncId,
      String matchFilter,
      ) async {
    final homeAlias = db.alias(db.teams, 'home');
    final awayAlias = db.alias(db.teams, 'away');

    final roundEntities = await (db.select(db.rounds)
      ..where((r) =>
      r.leagueSyncId.equals(leagueSyncId) &
      r.roundType.equals('knockout')))
        .get();

    final List<RoundModel> rounds = [];
    final filtersList = matchFilter
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final bool showAll = filtersList.contains('all') || filtersList.isEmpty;

    for (final r in roundEntities) {
      final query = db.select(db.matches).join([
        innerJoin(homeAlias, homeAlias.syncId.equalsExp(db.matches.homeTeamSyncId)),
        innerJoin(awayAlias, awayAlias.syncId.equalsExp(db.matches.awayTeamSyncId)),
      ]);

      final filters = <Expression<bool>>[
        db.matches.roundSyncId.equals(r.syncId),
        db.matches.leagueSyncId.equals(leagueSyncId),
      ];

      if (!showAll) {
        final statusExpressions = <Expression<bool>>[];
        for (final status in filtersList) {
          switch (status) {
            case 'scheduled':
              statusExpressions.add(db.matches.status.equals('scheduled'));
              break;
            case 'unscheduled':
              statusExpressions.add(db.matches.status.equals('unscheduled'));
              break;
            case 'live':
              statusExpressions.add(db.matches.status.equals('live'));
              break;
            case 'finished':
              statusExpressions.add(db.matches.status.equals('finished'));
              break;
          }
        }
        if (statusExpressions.isNotEmpty) {
          filters.add(statusExpressions.reduce((a, b) => a | b));
        }
      }

      query.where(filters.reduce((a, b) => a & b));
      final joined = await query.get();

      final matches = await Future.wait(joined.map((row) async {
        final match = row.readTable(db.matches);
        final home = row.readTable(homeAlias);
        final away = row.readTable(awayAlias);

        final matchTerms = await (db.select(db.matchTerms)
          ..where((mt) => mt.matchSyncId.equals(match.syncId)))
            .get();

        final matchTermModels =
        matchTerms.map((mt) => MatchTermModel.fromEntity(mt)).toList();

        return MatchModel.fromEntityWithRelations(
          match,
          home: home,
          away: away,
          matchTerms: matchTermModels,
        );
      }));

      rounds.add(RoundModel(
        id: r.id,
        syncId: r.syncId,
        groupSyncId: r.groupSyncId,
        leagueSyncId: r.leagueSyncId,
        roundName: r.name,
        roundType: r.roundType,
        createdAt: r.createdAt,
        matches: matches,
      ));
    }

    return rounds;
  }
  final _upsertMutex = _AsyncMutex();
  // ---------------------------------------------------------------------------
  // Upsert from API (Rounds + Matches)
  // ---------------------------------------------------------------------------
  Future<void> upsertRoundsWithMatchesLocal(List<RoundModel> apiRounds) async {
    return _upsertMutex.run(() async {
      if (apiRounds.isEmpty) return;

      // ✅ rounds لازم sync_id
      final rounds = apiRounds.where((r) =>
      (r.syncId ?? '')
          .trim()
          .isNotEmpty).toList();
      if (rounds.isEmpty) return;

      // ✅ فقط الجولات التي "أرسل لها API مفتاح matches فعليًا"
      // بعد تعديل fromJson: هذا يعني r.matches != null
      final roundsWithMatchesKey = <String, List<MatchModel>>{};
      for (final r in rounds) {
        final rid = r.syncId!.trim();
        if (r.matches != null) {
          roundsWithMatchesKey[rid] = r.matches!; // قد تكون []
        }
      }

      // تجهيز matches للـ upsert + incoming ids للحذف المتزامن
      final allMatches = <MatchesCompanion>[];
      final incomingIdsByRound = <String, Set<String>>{};

      for (final r in rounds) {
        final roundSyncId = r.syncId!.trim();

        // ✅ لا تعمل delete ولا upsert للمباريات إذا API لم يرسل matches key
        final matchesProvided = roundsWithMatchesKey.containsKey(roundSyncId);
        if (!matchesProvided) continue;

        final matches = roundsWithMatchesKey[roundSyncId]!;
        final incoming = <String>{};

        for (final m in matches) {
          final sid = (m.syncId ?? '').trim();
          if (sid.isNotEmpty) incoming.add(sid);

          final homeId = (m.homeTeamSyncId ?? '').trim();
          final awayId = (m.awayTeamSyncId ?? '').trim();
          if (homeId.isEmpty || awayId.isEmpty) continue;

          // ✅ تجاهل match بدون sync_id أثناء sync-delete حتى لا نحذف كل شيء بالغلط
          if (sid.isEmpty) continue;

          allMatches.add(
            m.copyWith(
              leagueSyncId: (m.leagueSyncId ?? '')
                  .trim()
                  .isNotEmpty ? m.leagueSyncId : r.leagueSyncId,
              roundSyncId: (m.roundSyncId ?? '')
                  .trim()
                  .isNotEmpty ? m.roundSyncId : roundSyncId,
              updatedAt: DateTime.now(),
            ).toUpsertCompanion(
              fallbackLeagueSyncId: r.leagueSyncId,
              fallbackRoundSyncId: roundSyncId,
            ),
          );
        }

        incomingIdsByRound[roundSyncId] = incoming;
      }

      await db.transaction(() async {
        // 1) upsert rounds
        await db.batch((batch) {
          for (final r in rounds) {
            final syncId = (r.syncId ?? '').trim();
            if (syncId.isEmpty) continue;

            batch.customStatement(
              '''
          INSERT INTO rounds (
            sync_id, league_sync_id, round_name, round_type, group_sync_id
          )
          VALUES (?, ?, ?, ?, ?)
          ON CONFLICT(sync_id) DO UPDATE SET
            league_sync_id = excluded.league_sync_id,
            round_name     = excluded.round_name,
            round_type     = excluded.round_type,
            group_sync_id  = excluded.group_sync_id
          ''',
              [
                syncId,
                r.leagueSyncId.trim(),
                r.roundName.trim(),
                r.roundType.trim(),
                (r.groupSyncId ?? '')
                    .trim()
                    .isNotEmpty ? r.groupSyncId!.trim() : null,
              ],
            );
          }
        });

        // 2) sync-delete matches only when matches key exists
        for (final entry in incomingIdsByRound.entries) {
          final roundSyncId = entry.key;
          final incomingIds = entry.value;

          // ✅ API أرسل matches: []
          // هذا يعني "لا مباريات" = احذف الكل
          if (incomingIds.isEmpty) {
            await (db.delete(db.matches)
              ..where((t) => t.roundSyncId.equals(roundSyncId))).go();
            continue;
          }

          await (db.delete(db.matches)
            ..where((t) => t.roundSyncId.equals(roundSyncId))..where((t) =>
                t.syncId.isNotIn(incomingIds.toList())))
              .go();
        }

        // 3) upsert matches (dedupe by sync_id)
        if (allMatches.isNotEmpty) {
          final bySyncId = <String, MatchesCompanion>{};
          for (final c in allMatches) {
            final sid = c.syncId.value.trim();
            if (sid.isEmpty) continue;
            bySyncId[sid] = c;
          }

          await db.batch((batch) {
            for (final c in bySyncId.values) {
              batch.insert(
                db.matches,
                c,
                mode: InsertMode
                    .insertOrReplace, // ✅ drift way (يشتغل مع UNIQUE(sync_id))
              );
            }
          });
        }
      });

    });

  }
  // Future<void> upsertRoundsWithMatchesLocal(List<RoundModel> apiRounds) async {
  //   if (apiRounds.isEmpty) return;
  //
  //   int _sec(DateTime? dt) =>
  //       dt == null ? DateTime.now().millisecondsSinceEpoch ~/ 1000 : dt.millisecondsSinceEpoch ~/ 1000;
  //
  //   // =========================
  //   // تجهيز بيانات (memory only)
  //   // =========================
  //
  //   // (A) round لازم يكون معه sync_id
  //   final rounds = apiRounds
  //       .where((r) => (r.syncId ?? '').trim().isNotEmpty)
  //       .toList();
  //   if (rounds.isEmpty) return;
  //
  //   // (B) جولات التي API أرسل لها matches (حتى لو فاضية)
  //   final roundsWithMatchesPayload = <String, List<MatchModel>>{};
  //   for (final r in rounds) {
  //     final rid = r.syncId!.trim();
  //     if (r.matches != null) {
  //       roundsWithMatchesPayload[rid] = r.matches ?? const <MatchModel>[];
  //     }
  //   }
  //
  //   // (C) كل matches للـ upsert
  //   final allMatchesToUpsert = <MatchesCompanion>[];
  //
  //   // (D) incoming ids لكل round (delete sync)
  //   final incomingMatchIdsByRound = <String, Set<String>>{};
  //
  //   for (final r in rounds) {
  //     final roundSyncId = r.syncId!.trim();
  //
  //     final matchesProvided = roundsWithMatchesPayload.containsKey(roundSyncId);
  //     if (!matchesProvided) continue;
  //
  //     final matches = roundsWithMatchesPayload[roundSyncId]!;
  //     final incoming = <String>{};
  //
  //     for (final m in matches) {
  //       final sid = (m.syncId ?? '').trim();
  //       if (sid.isNotEmpty) incoming.add(sid);
  //
  //       // تجاهل أي match غير صالح (مثل نقص فريق)
  //       final homeId = (m.homeTeamSyncId ?? '').trim();
  //       final awayId = (m.awayTeamSyncId ?? '').trim();
  //       if (homeId.isEmpty || awayId.isEmpty) continue;
  //
  //       // normalization + to companion
  //       allMatchesToUpsert.add(
  //         m.copyWith(
  //           leagueSyncId: (m.leagueSyncId ?? '').trim().isNotEmpty
  //               ? m.leagueSyncId
  //               : r.leagueSyncId,
  //           roundSyncId: (m.roundSyncId ?? '').trim().isNotEmpty
  //               ? m.roundSyncId
  //               : roundSyncId,
  //           updatedAt: DateTime.now(),
  //         ).toUpsertCompanion(
  //           fallbackLeagueSyncId: r.leagueSyncId,
  //           fallbackRoundSyncId: roundSyncId,
  //         ),
  //       );
  //     }
  //
  //     incomingMatchIdsByRound[roundSyncId] = incoming;
  //   }
  //
  //   // =========================
  //   // تنفيذ DB: Transaction
  //   // =========================
  //   await db.transaction(() async {
  //     // ------------------------------------------------------------
  //     // 1) Upsert Rounds على sync_id (حل UNIQUE(sync_id))
  //     // ------------------------------------------------------------
  //     await db.batch((batch) {
  //       for (final r in rounds) {
  //         final syncId = (r.syncId ?? '').trim();
  //         if (syncId.isEmpty) continue;
  //
  //         batch.customStatement(
  //           '''
  //         INSERT INTO rounds (
  //           sync_id,
  //           league_sync_id,
  //           round_name,
  //           round_type,
  //           group_sync_id
  //         )
  //         VALUES (?, ?, ?, ?, ?)
  //         ON CONFLICT(sync_id) DO UPDATE SET
  //           league_sync_id = excluded.league_sync_id,
  //           round_name     = excluded.round_name,
  //           round_type     = excluded.round_type,
  //           group_sync_id  = excluded.group_sync_id
  //         ''',
  //           [
  //             syncId,
  //             (r.leagueSyncId).trim(),
  //             (r.roundName).trim(),
  //             (r.roundType).trim(),
  //             (r.groupSyncId ?? '').trim().isNotEmpty ? r.groupSyncId!.trim() : null,
  //           ],
  //         );
  //       }
  //     });
  //
  //     // ------------------------------------------------------------
  //     // 2) Sync delete per round (فقط للجولات التي API أرسل لها matches)
  //     // ------------------------------------------------------------
  //     for (final entry in incomingMatchIdsByRound.entries) {
  //       final roundSyncId = entry.key;
  //       final incomingIds = entry.value;
  //
  //       // لو API رجع [] أو كل syncIds فاضية => اعتبره "لا مباريات" واحذف الكل
  //       if (incomingIds.isEmpty) {
  //         await (db.delete(db.matches)..where((t) => t.roundSyncId.equals(roundSyncId))).go();
  //         continue;
  //       }
  //
  //       await (db.delete(db.matches)
  //         ..where((t) => t.roundSyncId.equals(roundSyncId))
  //         ..where((t) => t.syncId.isNotIn(incomingIds.toList())))
  //           .go();
  //     }
  //
  //     // ------------------------------------------------------------
  //     // 3) Upsert Matches على sync_id (حل UNIQUE(sync_id) نهائيًا)
  //     // ------------------------------------------------------------
  //     if (allMatchesToUpsert.isNotEmpty) {
  //       // Deduplicate داخل نفس الباتش حسب sync_id (مهم جدًا)
  //       final bySyncId = <String, MatchesCompanion>{};
  //       for (final c in allMatchesToUpsert) {
  //         final sid = c.syncId.value.trim();
  //         if (sid.isEmpty) continue;
  //         bySyncId[sid] = c; // آخر نسخة تفوز
  //       }
  //
  //       await db.batch((batch) {
  //         for (final c in bySyncId.values) {
  //           final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //
  //           batch.customStatement(
  //             '''
  //           INSERT INTO matches (
  //             sync_id,
  //             league_sync_id,
  //             round_sync_id,
  //             home_team_sync_id,
  //             away_team_sync_id,
  //             referee_sync_id,
  //             media_sync_id,
  //             match_date,
  //             scheduled_start_time,
  //             start_time,
  //             end_time,
  //             home_score,
  //             away_score,
  //             status,
  //             updated_at
  //           )
  //           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  //           ON CONFLICT(sync_id) DO UPDATE SET
  //             league_sync_id       = excluded.league_sync_id,
  //             round_sync_id        = excluded.round_sync_id,
  //             home_team_sync_id    = excluded.home_team_sync_id,
  //             away_team_sync_id    = excluded.away_team_sync_id,
  //             referee_sync_id      = excluded.referee_sync_id,
  //             media_sync_id        = excluded.media_sync_id,
  //             match_date           = excluded.match_date,
  //             scheduled_start_time = excluded.scheduled_start_time,
  //             start_time           = excluded.start_time,
  //             end_time             = excluded.end_time,
  //             home_score           = excluded.home_score,
  //             away_score           = excluded.away_score,
  //             status               = excluded.status,
  //             updated_at           = excluded.updated_at
  //           ''',
  //             [
  //               c.syncId.value.trim(),
  //               c.leagueSyncId.value.trim(),
  //               c.roundSyncId.value.trim(),
  //               c.homeTeamSyncId.value.trim(),
  //               c.awayTeamSyncId.value.trim(),
  //
  //               // nullable
  //               c.refereeSyncId.present ? c.refereeSyncId.value?.trim() : null,
  //               c.mediaSyncId.present ? c.mediaSyncId.value?.trim() : null,
  //
  //               // dates stored as INTEGER (seconds)
  //               _sec(c.matchDate.value),
  //               c.scheduledStartTime.present ? _sec(c.scheduledStartTime.value) : null,
  //               c.startTime.present ? _sec(c.startTime.value) : null,
  //               c.endTime.present ? _sec(c.endTime.value) : null,
  //
  //               // scores/status
  //               c.homeScore.present ? c.homeScore.value : 0,
  //               c.awayScore.present ? c.awayScore.value : 0,
  //               c.status.present ? c.status.value : 'unscheduled',
  //
  //               // updated_at
  //               c.updatedAt.present ? _sec(c.updatedAt.value) : nowSec,
  //             ],
  //           );
  //         }
  //       });
  //     }
  //   });
  // }


  // ---------------------------------------------------------------------------
  // Guards + locks
  // ---------------------------------------------------------------------------
  Future<bool> hasAnyKnockoutRound(String leagueSyncId) async {
    final row = await (db.select(db.rounds)
      ..where((r) =>
      r.leagueSyncId.equals(leagueSyncId) &
      r.roundType.equals('knockout'))
      ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  Future<bool> shouldGenerateFirstKnockout(String leagueSyncId) async {
    if (await hasAnyKnockoutRound(leagueSyncId)) return false;
    return await areAllGroupMatchesFinished(leagueSyncId);
  }

  // -------- Locks: First Knockout (مرة لكل League) --------
  Future<bool> _isFirstKnockoutLocked(String leagueSyncId) async {
    final row = await (db.select(db.leagueKnockoutFlags)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId)))
        .getSingleOrNull();
    return row?.firstKnockoutCreated ?? false;
  }

  Future<void> _lockFirstKnockout(String leagueSyncId) async {
    await db.into(db.leagueKnockoutFlags).insertOnConflictUpdate(
      LeagueKnockoutFlagsCompanion(
        leagueSyncId: Value(leagueSyncId),
        firstKnockoutCreated: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // -------- Locks: Next Knockout (مرة لكل finishedRoundSyncId) --------
  Future<bool> _hasNextLock({
    required String leagueSyncId,
    required String finishedRoundSyncId,
  }) async {
    final row = await (db.select(db.knockoutProgressLocks)
      ..where((t) => t.leagueSyncId.equals(leagueSyncId))
      ..where((t) => t.finishedRoundSyncId.equals(finishedRoundSyncId)))
        .getSingleOrNull();
    return row != null;
  }

  Future<void> _addNextLock({
    required String leagueSyncId,
    required String finishedRoundSyncId,
  }) async {
    await db.into(db.knockoutProgressLocks).insert(
      KnockoutProgressLocksCompanion(
        leagueSyncId: Value(leagueSyncId),
        finishedRoundSyncId: Value(finishedRoundSyncId),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// ✅ orchestrator: يعمل مرة واحدة لكل مرحلة
  /// - إذا أنشأ Round يرجعها
  /// - إذا لا يوجد شيء جديد يرجع null
  // Future<RoundModel?> ensureKnockoutProgress({
  //   required String leagueSyncId,
  //   required int qualifiedPerGroup,
  // }) async {
  //   return db.transaction<RoundModel?>(() async {
  //     final current = await getCurrentLeagueRound(leagueSyncId);
  //     if (current == null) return null;
  //
  //     // -------------------------
  //     // GROUP => generate first KO
  //     // -------------------------
  //     if (current.roundType == 'group') {
  //       final should = await shouldGenerateFirstKnockout(leagueSyncId);
  //       if (!should) return null;
  //
  //       final locked = await _isFirstKnockoutLocked(leagueSyncId);
  //       if (locked) return null;
  //
  //       final created = await generateKnockoutFromGroups(
  //         leagueSyncId: leagueSyncId,
  //         qualifiedPerGroup: qualifiedPerGroup,
  //       );
  //
  //       await _lockFirstKnockout(leagueSyncId);
  //       return created;
  //     }
  //
  //     // -------------------------
  //     // KNOCKOUT => generate next
  //     // -------------------------
  //     final finishedRoundSyncId =
  //     await getLastFinishedKnockoutRoundSyncId(leagueSyncId);
  //     print(finishedRoundSyncId);
  //     if (finishedRoundSyncId == null) return null;
  //
  //     final hasLock = await _hasNextLock(
  //       leagueSyncId: leagueSyncId,
  //       finishedRoundSyncId: finishedRoundSyncId,
  //     );
  //     print(hasLock);
  //     if (hasLock) return null;
  //
  //     // ✅ إنشاء فعلي للجولة التالية (يرجع null إذا لا يوجد)
  //     final created = await createNextKnockoutRoundFromFinished(
  //       leagueSyncId: leagueSyncId,
  //       finishedRoundSyncId: finishedRoundSyncId,
  //     );
  //
  //     // ✅ lock فقط إذا تم إنشاء الجولة فعلاً
  //     if (created != null) {
  //       await _addNextLock(
  //         leagueSyncId: leagueSyncId,
  //         finishedRoundSyncId: finishedRoundSyncId,
  //       );
  //     }
  //
  //     return created;
  //   });
  // }
  Future<RoundModel?> ensureKnockoutProgress({
    required String leagueSyncId,
    required int qualifiedPerGroup,
  }) async {
    return db.transaction<RoundModel?>(() async {
      final current = await getCurrentLeagueRound(leagueSyncId);
      print('ensureKO: current=${current?.roundType} sync=${current?.syncId}');
      if (current == null) return null;

      if (current.roundType == 'group') {
        final should = await shouldGenerateFirstKnockout(leagueSyncId);
        print('ensureKO: shouldFirst=$should');
        if (!should) return null;

        final locked = await _isFirstKnockoutLocked(leagueSyncId);
        print('ensureKO: firstLocked=$locked');
        if (locked) return null;

        final created = await generateKnockoutFromGroups(
          leagueSyncId: leagueSyncId,
          qualifiedPerGroup: qualifiedPerGroup,
        );

        await _lockFirstKnockout(leagueSyncId);
        print('ensureKO: createdFirst=${created.syncId}');
        return created;
      }

      final finishedRoundSyncId =
      await getLastFinishedKnockoutRoundSyncId(leagueSyncId);
      print('ensureKO: lastFinishedRound=$finishedRoundSyncId');
      if (finishedRoundSyncId == null) return null;

      final hasLock = await _hasNextLock(
        leagueSyncId: leagueSyncId,
        finishedRoundSyncId: finishedRoundSyncId,
      );
      print('ensureKO: hasNextLock=$hasLock');
      if (hasLock) return null;

      final created = await createNextKnockoutRoundFromFinished(
        leagueSyncId: leagueSyncId,
        finishedRoundSyncId: finishedRoundSyncId,
      );
      print('ensureKO: createdNext=${created?.syncId}');

      if (created != null) {
        await _addNextLock(
          leagueSyncId: leagueSyncId,
          finishedRoundSyncId: finishedRoundSyncId,
        );
      }

      return created;
    });
  }
  /// ✅ آخر جولة Knockout مكتملة (كل مبارياتها finished)
  Future<String?> getLastFinishedKnockoutRoundSyncId(String leagueSyncId) async {
    final rounds = await (db.select(db.rounds)
      ..where((r) =>
      r.leagueSyncId.equals(leagueSyncId) &
      r.roundType.equals('knockout'))
      ..orderBy([(r) => OrderingTerm.desc(r.id)]))
        .get();

    for (final r in rounds) {
      final matches = await (db.select(db.matches)
        ..where((m) => m.roundSyncId.equals(r.syncId)))
          .get();

      if (matches.isEmpty) continue;
      final allFinished = matches.every((m) => m.status == 'finished');
      if (allFinished) return r.syncId;
    }
    return null;
  }
}
// lib/.../knockout_generator_local_data_source.dart

class _AsyncMutex {
  Future<void> _tail = Future.value();

  Future<T> run<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _tail = _tail.then((_) async {
      try {
        completer.complete(await action());
      } catch (e, st) {
        completer.completeError(e, st);
      }
    });
    return completer.future;
  }
}