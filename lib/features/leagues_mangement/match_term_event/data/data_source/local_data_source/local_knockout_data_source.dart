import 'package:drift/drift.dart';

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

  Future<RoundModel> generateKnockoutFromGroups({
    required int leagueId,
    required int qualifiedPerGroup,
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    return db.transaction<RoundModel>(() async {
      // 1) التحقق من عدم وجود مباريات جارية/مجدولة
      final unfinished = await (db.select(db.matches)
            ..where((m) => m.leagueId.equals(leagueId) &
                (m.status.equals('scheduled') | m.status.equals('live'))))
          .get();
      if (unfinished.isNotEmpty) {
        throw Exception(
            '⚠️ لا يمكن إنشاء التصفيات، بعض مباريات المجموعات لم تنته بعد.');
      }

      // 2) جلب المجموعات
      final groupRows = await (db.select(db.group)
            ..where((g) => g.leagueId.equals(leagueId)))
          .get();
      if (groupRows.isEmpty) {
        throw Exception('❌ لا توجد مجموعات لهذا الدوري ($leagueId)');
      }

      // تحويل إلى GroupModel إذا كان عندك fromEntity، وإلا نستخدم GroupModel الموجود في model.dart
      final groups = groupRows
          .map((g) => GroupModel.fromEntity(g))
          .toList();

      // 3) بناء قائمة المتأهلين لكل مجموعة
      final Map<int, List<QualifiedTeamModel>> groupQualified = {};
      for (final g in groupRows) {
        final qualifiedRows = await (db.select(db.qualifiedTeam)
              ..where((q) =>
                  q.groupId.equals(g.id) & q.leagueId.equals(leagueId))
              ..orderBy([
                (r) => OrderingTerm.desc(r.points),
                (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
                (r) => OrderingTerm.desc(r.goalsFor),
              ]))
            .get();

        // نأخذ عدد المتأهلين من حقل qualifiedTeamNumber في الجروب (كما في منطقك السابق)
        final selected = qualifiedRows.take(g.qualifiedTeamNumber).toList();
        final models = <QualifiedTeamModel>[];
        for (final r in selected) {
          final teamEnt = await (db.select(db.teams)
                ..where((t) => t.id.equals(r.teamId)))
              .getSingleOrNull();
          if (teamEnt != null) {
            models.add(QualifiedTeamModel(
              teamName: teamEnt.teamName,
              groupId: g.id,
              teamId: teamEnt.id,
              leagueId: leagueId,
              points: r.points,
              goalsFor: r.goalsFor,
              goalsAgainst: r.goalsAgainst,
            ));
          }
        }
        groupQualified[g.id] = models;
      }

      // 4) تكوين مباريات التصفيات منطقياً عبر الخدمة
      final logicalMatches = _service.buildKnockoutMatchesFromGroups(
        leagueId: leagueId,
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

      // 6) حفظ الجولة والمباريات في db وإنشاء match terms
      final roundId = await db.into(db.rounds).insert(RoundsCompanion.insert(
            leagueId: leagueId,
            name: roundName,
            roundType: 'knockout',
          ));

      final insertedMatches = <MatchModel>[];
      for (final m in logicalMatches) {
        final matchId = await db.into(db.matches).insert(
              MatchesCompanion.insert(
                leagueId: m.leagueId!,
                roundId: roundId,
                homeTeamId: m.homeTeamId ?? 0,
                awayTeamId: m.awayTeamId ?? 0,
                matchDate: m.matchDate ?? DateTime.now(),
                status: Value(m.status),
                homeScore: Value(m.homeScore),
                awayScore: Value(m.awayScore),
              ),
            );

        await matchTermLocal.createMatchTermsFromLeague(
          matchId: matchId,
          leagueId: leagueId,
          roundType: 'knockout',
        );

        insertedMatches.add(m.copyWith(id: matchId));
      }

      return RoundModel(
        id: roundId,
        leagueId: leagueId,
        roundName: roundName,
        roundType: 'knockout',
        groups: const [],
        matches: insertedMatches,
      );
    });
  }

  Future<RoundModel?> createNextKnockoutRoundFromFinished({
    required int leagueId,
    required int finishedRoundId,
    String pairingStrategy = 'seeded',
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    final matchTermLocal = MatchTermsEventLocalDataSource(db);

    return db.transaction<RoundModel?>(() async {
      // 1) جلب مباريات الجولة المنتهية
      final matchEntities = await (db.select(db.matches)
            ..where((m) => m.roundId.equals(finishedRoundId)))
          .get();

      if (matchEntities.isEmpty) return null;
      if (matchEntities.any((m) => m.status != 'finished')) {
        throw Exception(
            '⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
      }

      final teamIds = <int>{};
      for (final m in matchEntities) {
        if (m.homeTeamId != null) teamIds.add(m.homeTeamId);
        if (m.awayTeamId != null) teamIds.add(m.awayTeamId);
      }

      final teamRows = await (db.select(db.teams)
            ..where((t) => t.id.isIn(teamIds.toList())))
          .get();
      final teamsById = <int, TeamModel>{
        for (final t in teamRows) t.id: TeamModel.fromEntity(t),
      };

      // 3) تحويل matchEntities إلى MatchModel بسيط
      final finishedMatches = matchEntities
          .map((m) => MatchModel.fromEntityWithRelations(
                m,
                home: null,
                away: null,
                matchTerms: const <MatchTermModel>[],
              ))
          .toList();

      // 4) استخدام الخدمة لبناء مباريات الجولة التالية
      final logicalMatches = _service.buildNextKnockoutMatches(
        leagueId: leagueId,
        finishedMatches: finishedMatches,
        teamsById: teamsById,
        pairingStrategy: pairingStrategy,
        homeAway: homeAway,
        seed: seed,
      );

      if (logicalMatches.isEmpty) return null;

      // 5) اسم الجولة التالية
      final nextRoundName =
          _service.roundNameForCount(logicalMatches.length, roundNamePrefix);

      final nextRoundId = await db.into(db.rounds).insert(
            RoundsCompanion.insert(
              leagueId: leagueId,
              name: nextRoundName,
              roundType: 'knockout',
            ),
          );

      // 6) حفظ المباريات وإنشاء match terms
      for (final match in logicalMatches) {
        final matchId = await db.into(db.matches).insert(
              MatchesCompanion.insert(
                leagueId: match.leagueId!,
                roundId: nextRoundId,
                homeTeamId: match.homeTeamId ?? 0,
                awayTeamId: match.awayTeamId ?? 0,
                matchDate: match.matchDate ?? DateTime.now(),
                status: Value(match.status),
                homeScore: Value(match.homeScore),
                awayScore: Value(match.awayScore),
              ),
            );

        await matchTermLocal.createMatchTermsFromLeague(
          matchId: matchId,
          leagueId: leagueId,
          roundType: 'knockout',
        );
      }

      return RoundModel(
        id: nextRoundId,
        leagueId: leagueId,
        roundName: nextRoundName,
        roundType: 'knockout',
        matches: logicalMatches,
        groups: const [],
      );
    });
  }

  Future<bool> areAllGroupMatchesFinished(int leagueId) async {
    // 🧾 جلب كل مباريات "دور المجموعات" عبر ربطها بالجولات التي لها groupId
    final groupMatches = await (db.select(db.matches).join([
          innerJoin(db.rounds, db.rounds.id.equalsExp(db.matches.roundId)),
        ])
          ..where(db.rounds.leagueId.equals(leagueId))
          ..where(db.rounds.groupId.isNotNull()))
        .get()
        .then((rows) => rows.map((row) => row.readTable(db.matches)).toList());

    if (groupMatches.isEmpty) {
      return false;
    }

    const unfinishedStatuses = {
      'scheduled',
      'unscheduled',
      'live',
      'pending',
      'in_progress',
    };

    final unfinished = groupMatches.where((m) {
      final status = m.status.toLowerCase().trim();
      return unfinishedStatuses.contains(status);
    }).toList();

    if (unfinished.isNotEmpty) {
      return false;
    }

    return true;
  }

  Future<RoundModel?> getCurrentLeagueRound(int leagueId) async {
    final rounds = await (db.select(db.rounds)
          ..where((r) => r.leagueId.equals(leagueId))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();

    if (rounds.isEmpty) {
      return null;
    }

    final latestRound = rounds.last;
    return RoundModel.fromEntity(latestRound);
  }

  Future<List<RoundModel>> getAllKnockoutRoundsWithMatches(
    int leagueId,
    String matchFilter,
  ) async {
    final homeAlias = db.alias(db.teams, 'home');
    final awayAlias = db.alias(db.teams, 'away');

    final roundEntities = await (db.select(db.rounds)
          ..where((r) =>
              r.leagueId.equals(leagueId) & r.roundType.equals('knockout')))
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
        innerJoin(homeAlias, homeAlias.id.equalsExp(db.matches.homeTeamId)),
        innerJoin(awayAlias, awayAlias.id.equalsExp(db.matches.awayTeamId)),
      ]);

      final filters = <Expression<bool>>[
        db.matches.roundId.equals(r.id),
        db.matches.leagueId.equals(leagueId),
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
          final combined = statusExpressions.reduce((a, b) => a | b);
          filters.add(combined);
        }
      }

      query.where(filters.reduce((a, b) => a & b));

      final joined = await query.get();

      final matches = await Future.wait(joined.map((row) async {
        final match = row.readTable(db.matches);
        final home = row.readTable(homeAlias);
        final away = row.readTable(awayAlias);

        final matchTerms = await (db.select(db.matchTerms)
              ..where((mt) => mt.matchId.equals(match.id)))
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
        leagueId: r.leagueId,
        roundName: r.name,
        roundType: r.roundType,
        createdAt: r.createdAt,
        matches: matches,
      ));
    }

    return rounds;
  }

  Future<void> checkAndCreateNextKnockoutRoundIfNeeded(
    int leagueId,
    int finishedRoundId,
  ) async {
    final matches = await (db.select(db.matches)
          ..where((m) => m.roundId.equals(finishedRoundId)))
        .get();

    if (matches.isEmpty) return;
    if (matches.any((m) => m.status != 'finished')) return;

    await createNextKnockoutRoundFromFinished(
      leagueId: leagueId,
      finishedRoundId: finishedRoundId,
    );
  }
}
// import 'dart:math';
//
// import 'package:drift/drift.dart';
//
// import '../../../../core/database/safirah_database.dart';
// import '../../../leagues_mangement/group/data/model/model.dart';
// import '../../../leagues_mangement/match/data/model/match_model.dart';
// import '../../../leagues_mangement/match/data/model/round_model.dart';
// import '../../../leagues_mangement/team_&_player/data/model/team_model.dart';
// import '../model/match_term_model.dart';
// import 'local_term_data_source.dart';
//
// /// كلاس مسؤول عن منطق إنشاء وإدارة جولات خروج المغلوب (knockout)
// /// يمكن استدعاؤه من LocalDataSource أو مباشرة من طبقة الـ API لاحقًا.
// class KnockoutGeneratorService {
//   final Safirah db;
//
//   KnockoutGeneratorService(this.db);
//
//   Future<RoundModel> generateKnockoutFromGroups({
//     required int leagueId,
//     required int qualifiedPerGroup,
//     bool homeAway = false,
//     int? seed,
//     String roundNamePrefix = '',
//   }) async {
//     final matchTermLocal = MatchTermsEventLocalDataSource(db);
//
//     return await db.transaction<RoundModel>(() async {
//       //  1. التحقق من عدم وجود مباريات جارية/مجدولة (إن شئت يمكنك تغيير الشرط).
//       final unfinished = await (db.select(db.matches)
//         ..where((m) =>
//         m.leagueId.equals(leagueId) &
//         (m.status.equals('scheduled') | m.status.equals('live'))))
//           .get();
//       if (unfinished.isNotEmpty) {
//         throw Exception(
//             '⚠️ لا يمكن إنشاء التصفيات، بعض مباريات المجموعات لم تنته بعد.');
//       }
//
//       // 2. جلب المجموعات
//       final groupEntities = await (db.select(db.group)
//         ..where((g) => g.leagueId.equals(leagueId)))
//           .get();
//       if (groupEntities.isEmpty) {
//         throw Exception('❌ لا توجد مجموعات لهذا الدوري ($leagueId)');
//       }
//
//       final Map<int, List<QualifiedTeamModel>> groupQualified = {};
//       for (final g in groupEntities) {
//         final qualifiedRows = await (db.select(db.qualifiedTeam)
//           ..where(
//                   (q) => q.groupId.equals(g.id) & q.leagueId.equals(leagueId))
//           ..orderBy([
//                 (r) => OrderingTerm.desc(r.points),
//                 (r) => OrderingTerm.desc(r.goalsFor - r.goalsAgainst),
//                 (r) => OrderingTerm.desc(r.goalsFor),
//           ]))
//             .get();
//
//         final selected = qualifiedRows
//             .take(groupEntities[0].qualifiedTeamNumber)
//             .toList();
//         final models = <QualifiedTeamModel>[];
//         for (final r in selected) {
//           final teamEnt = await (db.select(db.teams)
//             ..where((t) => t.id.equals(r.teamId)))
//               .getSingleOrNull();
//           if (teamEnt != null) {
//             models.add(QualifiedTeamModel(
//               teamName: teamEnt.teamName,
//               groupId: g.id,
//               teamId: teamEnt.id,
//               leagueId: leagueId,
//               points: r.points,
//               goalsFor: r.goalsFor,
//               goalsAgainst: r.goalsAgainst,
//             ));
//           }
//         }
//         groupQualified[g.id] = models;
//       }
//
//       // إذا لم يتأهل أحد -> خطأ
//       final totalQualified =
//       groupQualified.values.fold<int>(0, (s, l) => s + l.length);
//       if (totalQualified == 0) {
//         throw Exception('⚠️ لا توجد فرق متأهلة بعد من المجموعات.');
//       }
//
//       final groupIds = groupEntities.map((g) => g.id).toList();
//
//       // (اختياري) إتاحة قرعة للمجموعات قبل التزاوج — لو أردت shuffle
//       // NOTE: نُبقي المتغير للتوسعة المستقبلية (API أو قواعد أخرى)،
//       // لذلك لن نُعرّفه إن لم نستخدمه فعلاً حتى لا يظهر تحذير.
//
//       final List<MatchModel> matches = [];
//
//       for (int gi = 0; gi < groupIds.length; gi += 2) {
//         final int groupAId = groupIds[gi];
//         final int? groupBId =
//         (gi + 1 < groupIds.length) ? groupIds[gi + 1] : null;
//
//         final List<QualifiedTeamModel> groupA = groupQualified[groupAId] ?? [];
//         final List<QualifiedTeamModel> groupB =
//         groupBId != null ? (groupQualified[groupBId] ?? []) : [];
//
//         if (groupBId == null) {
//           // مجموعة بدون زوج: كل فرق هذه المجموعة تتأهل تلقائياً أو نخفضها إلى BYE
//           // سلوك افتراضي: نُنشئ مباريات BYE (away null) لكل فريق في هذه المجموعة
//           for (int pos = 0; pos < groupA.length; pos++) {
//             final home = groupA[pos];
//             // إدخال مباراة bye: away null => يعني تأهل تلقائي
//             matches.add(MatchModel(
//               leagueId: leagueId,
//               homeTeamId: home.teamId,
//               awayTeamId: null,
//               homeScore: 0,
//               awayScore: 0,
//               status: 'unscheduled',
//               matchDate: DateTime.now(),
//             ));
//           }
//           continue;
//         }
//
//         // الآن لدينا زوج مجموعتين (A,B). نريد: A[0] vs B[last], A[1] vs B[last-1], ...
//         final int pairsCount = max(groupA.length, groupB.length);
//         for (int pos = 0; pos < pairsCount; pos++) {
//           final QualifiedTeamModel? a =
//           pos < groupA.length ? groupA[pos] : null;
//           final int bIndex = (groupB.length - 1) - pos;
//           final QualifiedTeamModel? b =
//           (bIndex >= 0 && bIndex < groupB.length) ? groupB[bIndex] : null;
//
//           if (a != null && b != null) {
//             // مباراة فعلية بين a و b
//             final matchDate = DateTime.now();
//             matches.add(MatchModel(
//               leagueId: leagueId,
//               homeTeamId: a.teamId,
//               awayTeamId: b.teamId,
//               homeScore: 0,
//               awayScore: 0,
//               status: 'unscheduled',
//               matchDate: matchDate,
//             ));
//             if (homeAway) {
//               // عكس المنازل للمباراة الثانية (إياب)
//               matches.add(MatchModel(
//                 leagueId: leagueId,
//                 homeTeamId: b.teamId,
//                 awayTeamId: a.teamId,
//                 homeScore: 0,
//                 awayScore: 0,
//                 status: 'unscheduled',
//                 matchDate: matchDate.add(const Duration(days: 7)),
//               ));
//             }
//           } else if (a != null && b == null) {
//             // a يتأهل تلقائياً (BYE)
//             matches.add(MatchModel(
//               leagueId: leagueId,
//               homeTeamId: a.teamId,
//               awayTeamId: null,
//               homeScore: 0,
//               awayScore: 0,
//               status: 'unscheduled',
//               matchDate: DateTime.now(),
//             ));
//           } else if (a == null && b != null) {
//             // b يتأهل تلقائياً (BYE) — نضعه كـ home لتوحيد المنطق
//             matches.add(MatchModel(
//               leagueId: leagueId,
//               homeTeamId: b.teamId,
//               awayTeamId: null,
//               homeScore: 0,
//               awayScore: 0,
//               status: 'unscheduled',
//               matchDate: DateTime.now(),
//             ));
//           }
//         }
//       }
//
//       final roundName = roundNameForCount(matches.length, roundNamePrefix);
//       final roundId = await db.into(db.rounds).insert(RoundsCompanion.insert(
//         leagueId: leagueId,
//         name: roundName,
//         roundType: 'knockout',
//       ));
//
//       final insertedMatches = <MatchModel>[];
//       for (final m in matches) {
//         final matchId =
//         await db.into(db.matches).insert(MatchesCompanion.insert(
//           leagueId: m.leagueId!,
//           roundId: roundId,
//           homeTeamId: m.homeTeamId ?? 0,
//           awayTeamId: m.awayTeamId ?? 0,
//           matchDate: m.matchDate ?? DateTime.now(),
//           status: Value(m.status),
//           homeScore: Value(m.homeScore),
//           awayScore: Value(m.awayScore),
//         ));
//         await matchTermLocal.createMatchTermsFromLeague(
//           matchId: matchId,
//           leagueId: leagueId,
//           roundType: 'knockout',
//         );
//
//         insertedMatches.add(m.copyWith());
//       }
//
//       return RoundModel(
//         id: roundId,
//         leagueId: leagueId,
//         roundName: roundName,
//         roundType: 'knockout',
//         groups: [],
//         matches: insertedMatches,
//       );
//     });
//   }
//
//   Future<RoundModel?> createNextKnockoutRoundFromFinished({
//     required int leagueId,
//     required int finishedRoundId,
//     String pairingStrategy = 'seeded',
//     bool homeAway = false,
//     int? seed,
//     String roundNamePrefix = '',
//   }) async {
//     final matchTermLocal = MatchTermsEventLocalDataSource(db);
//
//     return await db.transaction<RoundModel?>(() async {
//       final matchEntities = await (db.select(db.matches)
//         ..where((m) => m.roundId.equals(finishedRoundId)))
//           .get();
//
//       if (matchEntities.isEmpty) return null;
//       if (matchEntities.any((m) => m.status != 'finished')) {
//         print('سابرة ياشيخ حسين');
//         throw Exception(
//             '⚠️ لا يمكن إنشاء الجولة التالية، بعض المباريات لم تنته بعد.');
//       }
//
//       // استخراج الفائزين
//       final winners = <TeamModel>[];
//       for (final m in matchEntities) {
//         final home = await (db.select(db.teams)
//           ..where((t) => t.id.equals(m.homeTeamId)))
//             .getSingleOrNull();
//         final away = await (db.select(db.teams)
//           ..where((t) => t.id.equals(m.awayTeamId)))
//             .getSingleOrNull();
//
//         if (away == null || (m.homeScore > m.awayScore)) {
//           if (home != null) winners.add(TeamModel.fromEntity(home));
//         } else if (m.awayScore > m.homeScore) {
//           if (away != null) winners.add(TeamModel.fromEntity(away));
//         } else {
//           // في حال التعادل (سياسة مؤقتة)
//           if (home != null) winners.add(TeamModel.fromEntity(home));
//         }
//       }
//
//       if (winners.isEmpty) return null;
//
//       // بناء الجولة التالية
//       final rnd = seed == null ? Random() : Random(seed);
//       final ordered = (pairingStrategy == 'random')
//           ? (List.of(winners)..shuffle(rnd))
//           : winners;
//
//       final total = ordered.length;
//       final matches = <MatchModel>[];
//
//       for (int i = 0; i < total; i += 2) {
//         final home = ordered[i];
//         final away = (i + 1 < total) ? ordered[i + 1] : null;
//
//         if (away == null) {
//           matches.add(MatchModel(
//             leagueId: leagueId,
//             homeTeamId: home.id,
//             awayTeamId: away!.id ?? 0,
//             homeScore: 0,
//             awayScore: 0,
//             status: 'unscheduled',
//           ));
//         } else {
//           matches.add(MatchModel(
//             leagueId: leagueId,
//             homeTeamId: home.id,
//             awayTeamId: away.id,
//             homeScore: 0,
//             awayScore: 0,
//             status: 'unscheduled',
//             matchDate: DateTime.now(),
//           ));
//         }
//       }
//
//       final nextRoundName = roundNameForCount(matches.length, roundNamePrefix);
//       final nextRoundId =
//       await db.into(db.rounds).insert(RoundsCompanion.insert(
//         leagueId: leagueId,
//         name: nextRoundName,
//         roundType: 'knockout',
//       ));
//
//       for (final match in matches) {
//         final matchId =
//         await db.into(db.matches).insert(MatchesCompanion.insert(
//           leagueId: match.leagueId!,
//           roundId: nextRoundId,
//           homeTeamId: match.homeTeamId ?? 0,
//           awayTeamId: match.awayTeamId ?? 0,
//           matchDate: match.matchDate ?? DateTime.now(),
//           status: Value(match.status),
//           homeScore: Value(match.homeScore),
//           awayScore: Value(match.awayScore),
//         ));
//         await matchTermLocal.createMatchTermsFromLeague(
//           matchId: matchId,
//           leagueId: leagueId,
//           roundType: 'knockout',
//         );
//       }
//
//       print('🎯 تم إنشاء الجولة الإقصائية التالية: $nextRoundName'
//           "هانا ياشيخ حسين");
//       return RoundModel(
//         id: nextRoundId,
//         leagueId: leagueId,
//         roundName: nextRoundName,
//         roundType: 'knockout',
//         matches: matches,
//         groups: [],
//       );
//     });
//   }
//
//   Future<bool> areAllGroupMatchesFinished(int leagueId) async {
//     // 🧾 جلب كل مباريات "دور المجموعات فقط" عبر ربطها بالجولات التي لها groupId
//     final groupMatches = await (db.select(db.matches).join([
//       innerJoin(db.rounds, db.rounds.id.equalsExp(db.matches.roundId))
//     ])
//       ..where(db.rounds.leagueId.equals(leagueId))
//       ..where(db.rounds.groupId.isNotNull()))
//         .get()
//         .then((rows) => rows.map((row) => row.readTable(db.matches)).toList());
//
//     if (groupMatches.isEmpty) {
//       print('⚠️ لا توجد مباريات دور مجموعات في الدوري ييييييييييييي$leagueId');
//       return false;
//     }
//
//     // 🔎 الحالات التي تعتبر المباراة فيها "غير منتهية"
//     const unfinishedStatuses = {
//       'scheduled',
//       'unscheduled',
//       'live',
//       'pending',
//       'in_progress',
//     };
//
//     // 🧠 فحص المباريات غير المنتهية فقط
//     final unfinished = groupMatches.where((m) {
//       final status = m.status.toLowerCase().trim();
//       return unfinishedStatuses.contains(status);
//     }).toList();
//
//     if (unfinished.isNotEmpty) {
//       print(
//           '⏳ يوجد ${unfinished.length} مباراة مجموعات لم تنته بعد في الدوري $leagueId');
//       for (final m in unfinished.take(5)) {
//         print('   • Match ID: ${m.id} | Status: ${m.status}');
//       }
//       return false;
//     }
//
//     print('🏁 جميع مباريات دور المجموعات انتهت ✅ (الدوري $leagueId)');
//     return true;
//   }
//
//   Future<RoundModel?> getCurrentLeagueRound(int leagueId) async {
//     final rounds = await (db.select(db.rounds)
//       ..where((r) => r.leagueId.equals(leagueId))
//       ..orderBy([(r) => OrderingTerm.asc(r.id)]))
//         .get();
//
//     if (rounds.isEmpty) {
//       print('⚠️ لا توجد جولات في الدوري $leagueId');
//       return null;
//     }
//
//     final latestRound = rounds.last;
//     print(
//         '📘 الجولة الحالية في الدوري $leagueId هي: ${latestRound.name} (${latestRound.roundType})');
//     return RoundModel.fromEntity(latestRound);
//   }
//
//   Future<List<RoundModel>> getAllKnockoutRoundsWithMatches(
//       int leagueId,
//       String matchFilter,
//       ) async {
//     final homeAlias = db.alias(db.teams, 'home');
//     final awayAlias = db.alias(db.teams, 'away');
//     // 🔹 1. جلب الجولات من نوع knockout
//     final roundEntities = await (db.select(db.rounds)
//       ..where((r) =>
//       r.leagueId.equals(leagueId) & r.roundType.equals('knockout')))
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
//     for (final r in roundEntities) {
//       // 🔹 2. جلب المباريات التابعة للجولة
//       final query = db.select(db.matches).join([
//         innerJoin(homeAlias, homeAlias.id.equalsExp(db.matches.homeTeamId)),
//         innerJoin(awayAlias, awayAlias.id.equalsExp(db.matches.awayTeamId)),
//       ]);
//
//       final filters = <Expression<bool>>[
//         db.matches.roundId.equals(r.id),
//         db.matches.leagueId.equals(leagueId),
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
//           // 🧠 نربطها بـ OR حتى نحصل على أكثر من حالة
//           final combined = statusExpressions.reduce((a, b) => a | b);
//           filters.add(combined);
//         }
//       }
//
//       query.where(filters.reduce((a, b) => a & b));
//
//       final joined = await query.get();
//
//       // 🔹 تحويل النتائج إلى MatchModel
//       final matches = await Future.wait(joined.map((row) async {
//         final match = row.readTable(db.matches);
//         final home = row.readTable(homeAlias);
//         final away = row.readTable(awayAlias);
//
//         var matchTermsQuery = db.select(db.matchTerms)
//           ..where((mt) => mt.matchId.equals(match.id));
//         final matchTerms = await matchTermsQuery.get();
//
//         final matchTermModels =
//         matchTerms.map((mt) => MatchTermModel.fromEntity(mt)).toList();
//         return MatchModel.fromEntityWithRelations(
//           match,
//           home: home,
//           away: away,
//           matchTerms: matchTermModels,
//         );
//       }));
//
//       // 🔹 4. إضافة الجولة مع مبارياتها
//       rounds.add(RoundModel(
//         id: r.id,
//         leagueId: r.leagueId,
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
//       int leagueId,
//       int finishedRoundId,
//       ) async {
//     final matches = await (db.select(db.matches)
//       ..where((m) => m.roundId.equals(finishedRoundId)))
//         .get();
//
//     if (matches.isEmpty) return;
//
//     if (matches.any((m) => m.status != 'finished')) {
//       return;
//     }
//
//     final nextRound = await createNextKnockoutRoundFromFinished(
//       leagueId: leagueId,
//       finishedRoundId: finishedRoundId,
//     );
//
//     if (nextRound != null) {
//       // استخدم print بدلاً من debugPrint لأن هذا الكلاس لا يعتمد على Flutter
//       print(
//           "✅ تم إنشاء ${nextRound.roundName} تلقائيًا بعد انتهاء الجولة $finishedRoundId");
//     } else {
//       print("🏁 لا مزيد من الجولات — النهائي تم بالفعل.");
//     }
//   }
//
//   String roundNameForCount(int count, String prefix) {
//     final namePrefix = prefix.isNotEmpty ? '$prefix - ' : '';
//     if (count >= 16) return '${namePrefix}دور 32';
//     if (count >= 8) return '${namePrefix}دور 16';
//     if (count >= 4) return '${namePrefix}ربع النهائي';
//     if (count >= 2) return '${namePrefix}نصف النهائي';
//     if (count >= 1) return '${namePrefix}النهائي';
//     return '${namePrefix}Unknown Round';
//   }
// }
