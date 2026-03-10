import 'dart:convert';
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../group/data/model/model.dart';
import '../../../match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import '../../../match_term_event/data/model/match_term_model.dart';
import '../model/match_model.dart';
import '../model/round_model.dart';
import '../service/match_round_service.dart' show MatchService;

class MatchesLocalDataSource {
  final Safirah db;
  final MatchService _matchService;

  MatchesLocalDataSource(this.db) : _matchService = const MatchService();

  Future<List<RoundModel>> ensureGroupRounds({required String leagueSyncId}) async {
    final createdRounds = <RoundModel>[];

    await db.transaction(() async {
      final groups = await (db.select(db.group)
            ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
          .get();

      for (final g in groups) {
        final countRow = await (db.selectOnly(db.groupTeam)
              ..addColumns([db.groupTeam.id.count()])
              ..where(db.groupTeam.groupSyncId.equals(g.syncId)))
            .getSingleOrNull();

        final teamCount = countRow?.read<int>(db.groupTeam.id.count()) ?? 0;
        final roundsNeeded = _matchService.calculateRoundsCount(teamCount);
        if (roundsNeeded == 0) continue;

        for (var r = 1; r <= roundsNeeded; r++) {
          final roundName = 'Group ${g.groupName} - Round $r';

          final exists = await (db.select(db.rounds)
                ..where((x) =>
                    x.leagueSyncId.equals(leagueSyncId) &
                    x.groupSyncId.equals(g.syncId) &
                    x.name.equals(roundName)))
              .getSingleOrNull();

          if (exists != null) continue;
          final inserted = await db.into(db.rounds).insertReturning(
                RoundsCompanion.insert(
                  syncId: const Uuid().v7(),
                  leagueSyncId: leagueSyncId,
                  groupSyncId: Value(g.syncId),
                  name: roundName,
                  roundType: 'group',
                ),
              );
          createdRounds.add(RoundModel.fromEntity(inserted));
          // ignore: avoid_print
          print("✅ Created $RoundModel (group=${g.groupName})");
        }
      }
    });

    return createdRounds;
  }

  Future<List<MatchModel>> scheduleGroupStageMatchesRR({
    required String leagueSyncId,
    bool homeAway = false,
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);
    final List<MatchModel> insertedMatches = [];

    await db.transaction(() async {
      final groups = await (db.select(db.group)
        ..where((g) => g.leagueSyncId.equals(leagueSyncId)))
          .get();

      for (final g in groups) {
        final groupModel = GroupModel.fromEntity(g);

        // جلب فرق المجموعة (نحتاج teamSyncId)
        final teamJoin = await (db.select(db.groupTeam).join([
          innerJoin(
              db.teams, db.teams.syncId.equalsExp(db.groupTeam.teamSyncId)),
        ])
          ..where(db.groupTeam.groupSyncId.equals(g.syncId))
          ..orderBy([OrderingTerm.asc(db.teams.id)]))
            .get();

        final teamSyncIds =
        teamJoin.map((r) =>
        r
            .readTable(db.teams)
            .syncId).toList();
        if (teamSyncIds.length < 2) continue;

        // بناء مباريات منطقياً باستخدام sync ids
        final logicalMatches = _matchService.buildGroupMatches(
          leagueSyncId: leagueSyncId,
          group: groupModel,
          teamIds: teamSyncIds,
          homeAway: homeAway,
        );

        if (logicalMatches.isEmpty) continue;

        // جلب الجولات لهذا group (ما زلنا نستخدم groupId هنا للربط الداخلي بالأمان)
        final rounds = await (db.select(db.rounds)
          ..where((r) =>
          r.leagueSyncId.equals(leagueSyncId) & r.groupSyncId.equals(g.syncId))
          ..orderBy([(r) => OrderingTerm.asc(r.createdAt)]))
            .get();

        if (rounds.isEmpty) continue;

        final roundsCount = rounds.length;
        var matchIndex = 0;

        for (var roundPos = 0; roundPos < roundsCount; roundPos++) {
          final round = rounds[roundPos];

          final remainingMatches = logicalMatches.length - matchIndex;
          if (remainingMatches <= 0) break;

          final remainingRounds = roundsCount - roundPos;
          final takeCount = (remainingMatches / remainingRounds).ceil();

          final slice =
          logicalMatches.skip(matchIndex).take(takeCount).toList();
          matchIndex += slice.length;

          for (final m in slice) {
            final exists = await (db.select(db.matches)
              ..where((match) =>
              match.leagueSyncId.equals(leagueSyncId) &
              match.roundSyncId.equals(round.syncId) &
              ((match.homeTeamSyncId.equals(m.homeTeamSyncId!) &
              match.awayTeamSyncId.equals(m.awayTeamSyncId!)) |
              (match.homeTeamSyncId.equals(m.awayTeamSyncId!) &
              match.awayTeamSyncId.equals(m.homeTeamSyncId!)))))
                .getSingleOrNull();

            if (exists != null) continue;

            final matchEntity = await db.into(db.matches).insertReturning(
              MatchesCompanion.insert(
                syncId: const Uuid().v7(),
                leagueSyncId: leagueSyncId,
                roundSyncId: round.syncId,
                homeTeamSyncId: m.homeTeamSyncId!,
                awayTeamSyncId: m.awayTeamSyncId!,
                matchDate: m.matchDate ?? DateTime.now(),
                homeScore: Value(m.homeScore),
                awayScore: Value(m.awayScore),
                status: Value(m.status),
              ),
            );

            // ignore: avoid_print
            print(
                "✅ Inserted match: ${m.homeTeamSyncId} vs ${m
                    .awayTeamSyncId} in ${round.name}");

            // ✅ نستخدم createMatchTermsNoTx لأننا داخل transaction خارجية
            // استخدام createMatchTermsFromLeague هنا كان يسبب nested transaction
            // مما أدى إلى تكرار league_term_sync_id في الـ API
            final termsMatch = await matchTermLocal.
            createMatchTermsNoTx(
              matchSyncId: matchEntity.syncId,
              leagueSyncId: leagueSyncId,
            );
            print('000000000000000');

            print(termsMatch[0].leagueTermSyncId);
            print(termsMatch[1].leagueTermSyncId);

            insertedMatches.add(MatchModel.fromEntityWithRelations(
                matchEntity, matchTerms: termsMatch));
          }
        }
      }  });
        return insertedMatches;
      }



  Stream<List<RoundModel>> watchLeagueRoundsWithGroupsAndMatches({
    required String leagueSyncId,
    required String matchFilter,
  }) {
    // Drift tables don't expose `.watch()` directly, so we watch a lightweight select.
    final Stream<void> triggers = MergeStream<void>([
      (db.select(db.rounds)..where((r) => r.leagueSyncId.equals(leagueSyncId)))
          .watch()
          .map((_) => null),
      (db.select(db.group)..where((g) => g.leagueSyncId.equals(leagueSyncId)))
          .watch()
          .map((_) => null),
      (db.select(db.matches)
            ..where((m) => m.leagueSyncId.equals(leagueSyncId)))
          .watch()
          .map((_) => null),
      db.select(db.matchTerms).watch().map((_) => null),
      db.select(db.teams).watch().map((_) => null),
    ]);

    String signatureOf(List<RoundModel> rounds) {
      final b = StringBuffer();
      for (final r in rounds) {
        b.write('|R:${r.syncId ?? ''}:${r.roundName}|');
        for (final g in r.groups) {
          b.write('G:${g.syncId ?? ''}:${g.groupName}|');
          for (final m in g.matches) {
            b.write(
                'M:${m.syncId ?? ''}:${m.status}:${m.homeScore}:${m.awayScore}|');
          }
        }
      }
      return b.toString();
    }

    // The key: emit initial snapshot immediately, then recompute on every trigger.
    // Also, don't spam UI with identical payloads.
    return Rx.defer(() {
      DateTime lastNonEmptyAt = DateTime.fromMillisecondsSinceEpoch(0);

      return Stream<void>.value(null)
          .concatWith([triggers])
          .asyncMap((_) => getLeagueRoundsWithGroupsAndMatches(
                leagueSyncId: leagueSyncId,
                matchFilter: matchFilter,
              ))
          .distinct((a, b) => signatureOf(a) == signatureOf(b))
          // Suppress transient empty only for a brief grace window after having data.
          .scan<List<RoundModel>>((acc, curr, _) {
            if (curr.isNotEmpty) {
              lastNonEmptyAt = DateTime.now();
              return curr;
            }

            if (acc.isEmpty) return curr;

            const grace = Duration(milliseconds: 800);
            final tooSoon = DateTime.now().difference(lastNonEmptyAt) < grace;
            if (tooSoon) return acc;

            return curr;
          }, const <RoundModel>[]);
    });
  }

  /// ✅ قراءة مرة واحدة (تستعمل نفس منطق البناء)
  // Future<List<RoundModel>> getLeagueRoundsWithGroupsAndMatches({
  //   required String leagueSyncId,
  //   required String matchFilter,
  // }) async {
  //   final homeAlias = db.alias(db.teams, 'home');
  //   final awayAlias = db.alias(db.teams, 'away');
  //
  //   final rounds = await (db.select(db.rounds)
  //         ..where((r) => r.leagueSyncId.equals(leagueSyncId))
  //         ..orderBy([
  //           (r) => OrderingTerm.asc(r.createdAt),]))
  //       .get();
  //
  //   if (rounds.isEmpty) return [];
  //
  //   final filtersList = matchFilter
  //       .toLowerCase()
  //       .split(',')
  //       .map((s) => s.trim())
  //       .where((s) => s.isNotEmpty)
  //       .toList();
  //
  //   final bool showAll = filtersList.contains('all') || filtersList.isEmpty;
  //
  //   Expression<bool> statusFilterExpr() {
  //     final list = <Expression<bool>>[];
  //     for (final status in filtersList) {
  //       switch (status) {
  //         case 'scheduled':
  //         case 'unscheduled':
  //         case 'live':
  //         case 'finished':
  //           list.add(db.matches.status.equals(status));
  //           break;
  //       }
  //     }
  //     if (list.isEmpty) return const Constant(true);
  //     return list.reduce((a, b) => a | b);
  //   }
  //
  //   // Load all groups referenced by rounds (1 query)
  //   final groupIds = rounds.map((r) => r.groupSyncId).whereType<String>().toSet().toList();
  //   final groupsById = <String, GroupData>{};
  //   if (groupIds.isNotEmpty) {
  //     final groupRows = await (db.select(db.group)..where((g) => g.syncId.isIn(groupIds))).get();
  //     for (final g in groupRows) {
  //       groupsById[g.syncId] = g;
  //     }
  //   }
  //
  //   final List<RoundModel> result = [];
  //
  //   for (final round in rounds) {
  //     final groupSyncId = round.groupSyncId;
  //     if (groupSyncId == null) continue;
  //
  //     final group = groupsById[groupSyncId];
  //     if (group == null) continue;
  //
  //     // Load matches for this round with teams
  //     final query = db.select(db.matches).join([
  //       innerJoin(homeAlias, homeAlias.syncId.equalsExp(db.matches.homeTeamSyncId)),
  //       innerJoin(awayAlias, awayAlias.syncId.equalsExp(db.matches.awayTeamSyncId)),
  //     ]);
  //
  //     final filters = <Expression<bool>>[
  //       db.matches.roundSyncId.equals(round.syncId),
  //       db.matches.leagueSyncId.equals(leagueSyncId),
  //       if (!showAll) statusFilterExpr(),
  //     ];
  //     query.where(filters.reduce((a, b) => a & b));
  //
  //     final joined = await query.get();
  //
  //     if (joined.isEmpty) {
  //       // If you want to show empty rounds, remove this continue.
  //       continue;
  //     }
  //
  //     final matchIds = joined.map((row) => row.readTable(db.matches).syncId).toSet().toList();
  //
  //     final termsByMatch = <String, List<MatchTermModel>>{};
  //     if (matchIds.isNotEmpty) {
  //       final terms = await (db.select(db.matchTerms)..where((mt) => mt.matchSyncId.isIn(matchIds))).get();
  //       for (final t in terms) {
  //         termsByMatch.putIfAbsent(t.matchSyncId, () => []).add(MatchTermModel.fromEntity(t));
  //       }
  //     }
  //
  //     final matches = joined.map((row) {
  //       final match = row.readTable(db.matches);
  //       final home = row.readTable(homeAlias);
  //       final away = row.readTable(awayAlias);
  //
  //       return MatchModel.fromEntityWithRelations(
  //         match,
  //         home: home,
  //         away: away,
  //         matchTerms: termsByMatch[match.syncId] ?? const [],
  //       );
  //     }).toList();
  //
  //     if (matches.isEmpty) continue;
  //
  //     final groupModel = GroupModel.fromEntity(group).copyWith(matches: matches);
  //
  //     result.add(
  //       RoundModel.fromEntity(round).copyWith(
  //         // Keep original round name; UI can format it.
  //         roundName: round.name,
  //         groups: [groupModel],
  //       ),
  //     );
  //   }
  //
  //   return result;
  // }
  Future<List<RoundModel>> getLeagueRoundsWithGroupsAndMatches({
    required String leagueSyncId,
    required String matchFilter,
  }) async {
    // ملاحظة: سأحافظ على منطقك (roundNumbers + roundNo) لكن سأقلل N+1.
    final homeAlias = db.alias(db.teams, 'home');
    final awayAlias = db.alias(db.teams, 'away');

    final rounds = await (db.select(db.rounds)
      ..where((r) => r.leagueSyncId.equals(leagueSyncId))
      ..orderBy([(r) => OrderingTerm.asc(r.createdAt)]))
        .get();

    if (rounds.isEmpty) return [];

    // استخراج roundNo من الاسم (كما فعلت)
    final roundNumbers = rounds
        .map((r) {
      final m = RegExp(r'(\d+)$').firstMatch(r.name);
      return m != null ? int.tryParse(m.group(1)!) : null;
    })
        .whereType<int>()
        .toSet()
        .toList()
      ..sort();

    final filtersList = matchFilter
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final bool showAll = filtersList.contains('all') || filtersList.isEmpty;

    // ✅ خريطة status filters
    Expression<bool> statusFilterExpr() {
      final list = <Expression<bool>>[];
      for (final status in filtersList) {
        switch (status) {
          case 'scheduled':
          case 'unscheduled':
          case 'live':
          case 'finished':
            list.add(db.matches.status.equals(status));
            break;
        }
      }
      if (list.isEmpty) return const Constant(true);
      return list.reduce((a, b) => a | b);
    }

    // ✅ بدلاً من جلب group داخل loop (N+1) نجلب كل المجموعات المطلوبة مرة واحدة
    final groupIds = rounds.map((r) => r.groupSyncId).whereType<String>().toSet().toList();

    final groups = groupIds.isEmpty
        ? <String, GroupData>{}
        : {
      for (final g in await (db.select(db.group)
        ..where((t) => t.syncId.isIn(groupIds)))
          .get())
        g.syncId: g,
    };

    final List<RoundModel> result = [];

    for (final roundNo in roundNumbers) {
      final relatedRounds = rounds.where((r) => r.name.endsWith('Round $roundNo')).toList();
      if (relatedRounds.isEmpty) continue;

      final List<GroupModel> groupsForThisRound = [];

      for (final round in relatedRounds) {
        final groupSyncId = round.groupSyncId;
        if (groupSyncId == null) continue;

        final group = groups[groupSyncId];
        if (group == null) continue;

        final query = db.select(db.matches).join([
          innerJoin(homeAlias, homeAlias.syncId.equalsExp(db.matches.homeTeamSyncId)),
          innerJoin(awayAlias, awayAlias.syncId.equalsExp(db.matches.awayTeamSyncId)),
        ]);

        final filters = <Expression<bool>>[
          db.matches.roundSyncId.equals(round.syncId),
          db.matches.leagueSyncId.equals(leagueSyncId),
          if (!showAll) statusFilterExpr(),
        ];

        query.where(filters.reduce((a, b) => a & b));
        final joined = await query.get();

        // ✅ تحسين كبير: جلب matchTerms دفعة واحدة بدل لكل مباراة
        final matchIds = joined.map((row) => row.readTable(db.matches).syncId).toSet().toList();

        final termsByMatch = <String, List<MatchTermModel>>{};
        if (matchIds.isNotEmpty) {
          final terms = await (db.select(db.matchTerms)
            ..where((mt) => mt.matchSyncId.isIn(matchIds)))
              .get();

          for (final t in terms) {
            termsByMatch.putIfAbsent(t.matchSyncId, () => []).add(MatchTermModel.fromEntity(t));
          }
        }

        final matches = joined.map((row) {
          final match = row.readTable(db.matches);
          final home = row.readTable(homeAlias);
          final away = row.readTable(awayAlias);

          return MatchModel.fromEntityWithRelations(
            match,
            home: home,
            away: away,
            matchTerms: termsByMatch[match.syncId] ?? const [],
          );
        }).toList();

        if (matches.isEmpty) continue;

        groupsForThisRound.add(
          GroupModel.fromEntity(group).copyWith(matches: matches),
        );
      }

      if (groupsForThisRound.any((g) => g.matches.isNotEmpty)) {
        final roundEntity = relatedRounds.first;
        result.add(
          RoundModel.fromEntity(roundEntity).copyWith(
            roundName: 'Round $roundNo',
            groups: groupsForThisRound,
          ),
        );
      }
    }

    return result;
  }
  Future<void> upsertLeagueRoundsFromApiOneResponse({
    required String leagueSyncId,
    required List<RoundModel> apiRounds, // كل عنصر فيه group + matches
    bool deleteMissingRounds = true,
    bool deleteMissingMatches = true,
    bool deleteMissingMatchTerms = true, // ✅ NEW
  }) async {
    if (apiRounds.isEmpty) return;

    final seenGroup = <String>{}; // groupSyncId
    final seenRound = <String>{}; // roundSyncId
    final seenMatch = <String>{}; // matchSyncId
    final seenTerm = <String>{};  // matchTermSyncId ✅ NEW

    final keepRoundIds = <String>{};
    final keepMatchIds = <String>{};
    final keepTermIds = <String>{}; // ✅ NEW

    await db.transaction(() async {
      for (final r in apiRounds) {
        final roundSid = (r.syncId ?? '').trim();
        if (roundSid.isEmpty) continue;

        final groupSid = (r.groupSyncId ?? '').trim();
        if (groupSid.isEmpty) continue;

        final roundName = r.roundName.trim();
        if (roundName.isEmpty) continue;

        final GroupModel? payloadGroup = r.groups.isNotEmpty ? r.groups.first : null;

        // ----------------------------
        // 1) UPSERT GROUP
        // ----------------------------
        if (payloadGroup != null && seenGroup.add(groupSid)) {
          await db.into(db.group).insert(
            GroupCompanion(
              syncId: Value(groupSid),
              leagueSyncId: Value(leagueSyncId),
              groupName: Value(payloadGroup.groupName),
              qualifiedTeamNumber: Value(payloadGroup.qualifiedTeamNumber),
              createdAt: payloadGroup.createdAt != null ? Value(payloadGroup.createdAt!) : const Value.absent(),
            ),
            onConflict: DoUpdate(
                  (old) => GroupCompanion(
                leagueSyncId: Value(leagueSyncId),
                groupName: Value(payloadGroup.groupName),
                qualifiedTeamNumber: Value(payloadGroup.qualifiedTeamNumber),
              ),
              target: [db.group.syncId, db.group.leagueSyncId],
            ),
          );
        }

        // ----------------------------
        // 2) UPSERT ROUND
        // ----------------------------
        if (seenRound.add(roundSid)) {
          try {
            await db.into(db.rounds).insert(
              RoundsCompanion(
                syncId: Value(roundSid),
                leagueSyncId: Value(leagueSyncId),
                groupSyncId: Value(groupSid),
                name: Value(roundName),
                roundType: Value(r.roundType),
                createdAt: r.createdAt != null ? Value(r.createdAt!) : const Value.absent(),
              ),
              onConflict: DoUpdate(
                    (old) => RoundsCompanion(
                  leagueSyncId: Value(leagueSyncId),
                  groupSyncId: Value(groupSid),
                  name: Value(roundName),
                  roundType: Value(r.roundType),
                ),
                target: [db.rounds.syncId],
              ),
            );
          } on SqliteException catch (e) {
            final isCompositeUnique =
                e.message.contains('UNIQUE constraint failed: rounds.league_sync_id') ||
                    e.message.contains('rounds.league_sync_id, rounds.group_sync_id, rounds.round_name');

            if (!isCompositeUnique) rethrow;

            final existing = await (db.select(db.rounds)
              ..where((t) =>
              t.leagueSyncId.equals(leagueSyncId) &
              t.groupSyncId.equals(groupSid) &
              t.name.equals(roundName)))
                .getSingleOrNull();

            if (existing == null) rethrow;

            await (db.update(db.rounds)..where((t) => t.syncId.equals(existing.syncId))).write(
              RoundsCompanion(
                syncId: Value(roundSid),
                roundType: Value(r.roundType),
              ),
            );
          }
        }

        keepRoundIds.add(roundSid);

        // ----------------------------
        // 3) UPSERT MATCHES + MATCH_TERMS ✅
        // ----------------------------
        final matches = payloadGroup?.matches ?? const <MatchModel>[];

        for (final m in matches) {
          final msid = (m.syncId ?? '').trim();
          if (msid.isEmpty) continue;
          if (!seenMatch.add(msid)) continue;

          final homeId = (m.homeTeamSyncId ?? '').trim();
          final awayId = (m.awayTeamSyncId ?? '').trim();
          final date = m.matchDate;

          if (homeId.isEmpty || awayId.isEmpty || date == null) continue;

          // 3.1 upsert match
          await db.into(db.matches).insert(
            MatchesCompanion(
              syncId: Value(msid),
              leagueSyncId: Value(leagueSyncId),
              roundSyncId: Value(roundSid),
              homeTeamSyncId: Value(homeId),
              awayTeamSyncId: Value(awayId),
              matchDate: Value(date),
              scheduledStartTime: m.scheduledStartTime != null ? Value(m.scheduledStartTime!) : const Value.absent(),
              startTime: m.startTime != null ? Value(m.startTime!) : const Value.absent(),
              endTime: m.endTime != null ? Value(m.endTime!) : const Value.absent(),
              homeScore: Value(m.homeScore),
              awayScore: Value(m.awayScore),
              status: Value(m.status),
              createdAt: m.createdAt != null ? Value(m.createdAt!) : const Value.absent(),
              updatedAt: Value(DateTime.now()),
            ),
            onConflict: DoUpdate(
                  (old) => MatchesCompanion(
                leagueSyncId: Value(leagueSyncId),
                roundSyncId: Value(roundSid),
                homeTeamSyncId: Value(homeId),
                awayTeamSyncId: Value(awayId),
                matchDate: Value(date),
                scheduledStartTime: m.scheduledStartTime != null ? Value(m.scheduledStartTime!) : const Value.absent(),
                startTime: m.startTime != null ? Value(m.startTime!) : const Value.absent(),
                endTime: m.endTime != null ? Value(m.endTime!) : const Value.absent(),
                homeScore: Value(m.homeScore),
                awayScore: Value(m.awayScore),
                status: Value(m.status),
                updatedAt: Value(DateTime.now()),
              ),
              target: [db.matches.syncId],
            ),
          );

          keepMatchIds.add(msid);

          // 3.2 upsert match terms ✅
          // غيّر اسم القائمة حسب موديلك
          final terms = m.matchTerms ?? const <MatchTermModel>[]; // ✅ <-- عدّل هنا لو الاسم مختلف

          for (final t in terms) {
            final tsid = (t.syncId ?? '').trim();
            if (tsid.isEmpty) continue;
            if (!seenTerm.add(tsid)) continue;

            final leagueTermSid = (t.leagueTermSyncId ?? '').trim();
            if (leagueTermSid.isEmpty) continue;

          final x=  await db.into(db.matchTerms).insertReturning(
              MatchTermsCompanion(
                syncId: Value(tsid),
                matchSyncId: Value(msid),
                leagueTermSyncId: Value(leagueTermSid),
                startTime: t.startTime != null ? Value(t.startTime!) : const Value.absent(),
                endTime: t.endTime != null ? Value(t.endTime!) : const Value.absent(),
                additionalMinutes: Value(t.additionalMinutes ?? 0),
                isFinished: Value(t.isFinished ?? false),
              //  createdAt: t.createdAt != null ? Value(t.createdAt!) : const Value.absent(),
              ),
              onConflict: DoUpdate(
                    (old) => MatchTermsCompanion(
                  matchSyncId: Value(msid),
                  leagueTermSyncId: Value(leagueTermSid),
                  startTime: t.startTime != null ? Value(t.startTime!) : const Value.absent(),
                  endTime: t.endTime != null ? Value(t.endTime!) : const Value.absent(),
                  additionalMinutes: Value(t.additionalMinutes ?? 0),
                  isFinished: Value(t.isFinished ?? false),
                ),
                target: [db.matchTerms.syncId],
              ),
            );

            keepTermIds.add(tsid);
            print(x.syncId);
          }
        }
      }

      // ----------------------------
      // CLEANUP
      // ----------------------------
      if (deleteMissingRounds) {
        await (db.delete(db.rounds)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId) & t.syncId.isNotIn(keepRoundIds)))
            .go();
      }

      if (deleteMissingMatches) {
        await (db.delete(db.matches)
          ..where((t) => t.leagueSyncId.equals(leagueSyncId) & t.syncId.isNotIn(keepMatchIds)))
            .go();
      }

      if (deleteMissingMatchTerms) {
        // تنظيف كل terms التي لا تخص matches الموجودة بعد التحديث.
        // 1) احذف حسب keepTermIds (إن كانت القائمة ضخمة، اجعلها batch لاحقًا)
        await (db.delete(db.matchTerms)
          ..where((t) => t.syncId.isNotIn(keepTermIds)))
            .go();
      }
    });
  }

  Future<MatchModel> scheduleMatch({
    required String matchSyncId,
    required DateTime scheduledDateTime,
    required String refereeSyncId,
    required String mediaSyncId,
  }) async {
    return db.transaction(() async {
      final existing = await (db.select(db.matches)
        ..where((m) => m.syncId.equals(matchSyncId))
        ..limit(1))
          .getSingleOrNull();

      if (existing == null) {
        throw StateError('Match not found for syncId=$matchSyncId');
      }

      await (db.update(db.matches)..where((m) => m.syncId.equals(matchSyncId)))
          .write(
        MatchesCompanion(
          status: const Value('scheduled'),
          matchDate: Value(scheduledDateTime),
          scheduledStartTime: Value(scheduledDateTime),
          updatedAt: Value(DateTime.now()),
          refereeSyncId: Value(refereeSyncId),
          mediaSyncId: Value(mediaSyncId),
        ),
      );

      final updated = await (db.select(db.matches)
        ..where((m) => m.syncId.equals(matchSyncId))
        ..limit(1))
          .getSingle();

      print(updated.refereeSyncId);
      return MatchModel.fromEntityWithRelations(updated);
    });
  }

//
  // Future<void> updateRoundsWithGroupsAndMatches(List<RoundModel> rounds) async {
  //   await db.transaction(() async {
  //     for (final round in rounds) {
  //       // Update round
  //       await (db.update(db.rounds)..where((r) => r.syncId.equals(round.syncId!)))
  //           .write(round.toCompanionUpdate());
  //
  //       for (final group in round.groups) {
  //         // Update group
  //         await (db.update(db.group)..where((g) => g.syncId.equals(group.syncId!)))
  //             .write(group.toCompanionUpdate());
  //
  //         for (final match in group.matches) {
  //           // Update match
  //           await (db.update(db.matches)..where((m) => m.syncId.equals(match.syncId!)))
  //               .write(MatchesCompanion(
  //             homeScore: Value(match.homeScore),
  //             awayScore: Value(match.awayScore),
  //             status: Value(match.status),
  //             matchDate: Value(match.matchDate!),
  //             // Add other fields as needed
  //           ));
  //         }
  //       }
  //     }
  //   });
  // }
}
