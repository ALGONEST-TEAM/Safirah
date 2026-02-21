import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:safirah/core/database/safirah_database.dart';

import '../../../../../injection.dart' as di;
import '../../../group/data/model/model.dart';
import '../../../match/data/model/match_model.dart';
import '../../../match/data/model/round_model.dart';
import '../../../team_and_player/data/model/team_model.dart';
import '../../presntation/state_mangement/riverpod.dart';
import '../data_source/local_data_source/local_knockout_data_source.dart';

class KnockoutGeneratorService {
  const KnockoutGeneratorService();

  List<MatchModel> buildKnockoutMatchesFromGroups({
    required String leagueSyncId,
    required List<GroupModel> groups,
    required Map<int, List<QualifiedTeamModel>> groupQualified,
    bool homeAway = false,
    int? seed,
  }) {
    final groupIds = groups.map((g) => g.id!).toList();
    final matches = <MatchModel>[];

    // يمكن استخدام seed مستقبلاً لعمل shuffle للمجموعات أو الفرق
    final rnd = seed == null ? Random() : Random(seed);
    rnd.hashCode; // فقط لكسر تحذير unused في حال لم نستخدمه الآن.

    for (int gi = 0; gi < groupIds.length; gi += 2) {
      final int groupAId = groupIds[gi];
      final int? groupBId = (gi + 1 < groupIds.length)
          ? groupIds[gi + 1]
          : null;

      final List<QualifiedTeamModel> groupA = groupQualified[groupAId] ?? [];
      final List<QualifiedTeamModel> groupB =
      groupBId != null ? (groupQualified[groupBId] ?? []) : [];

      if (groupBId == null) {
        // مجموعة بدون زوج: نُنشئ BYE لكل فريق
        for (final t in groupA) {
          matches.add(MatchModel(
            leagueSyncId: leagueSyncId,
            homeTeamSyncId: t.teamSyncId,
            awayTeamSyncId: null,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: DateTime.now(),
          ));
        }
        continue;
      }

      final int pairsCount = max(groupA.length, groupB.length);
      for (int pos = 0; pos < pairsCount; pos++) {
        final QualifiedTeamModel? a = pos < groupA.length ? groupA[pos] : null;
        final int bIndex = (groupB.length - 1) - pos;
        final QualifiedTeamModel? b =
        (bIndex >= 0 && bIndex < groupB.length) ? groupB[bIndex] : null;

        if (a != null && b != null) {
          final matchDate = DateTime.now();
          matches.add(MatchModel(
            leagueSyncId: leagueSyncId,
            homeTeamSyncId: a.teamSyncId,
            awayTeamSyncId: b.teamSyncId,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: matchDate,
          ));
          if (homeAway) {
            matches.add(MatchModel(
              leagueSyncId: leagueSyncId,
              homeTeamSyncId: b.teamSyncId,
              awayTeamSyncId: a.teamSyncId,
              homeScore: 0,
              awayScore: 0,
              status: 'unscheduled',
              matchDate: matchDate.add(const Duration(days: 7)),
            ));
          }
        } else if (a != null && b == null) {
          matches.add(MatchModel(
            leagueSyncId: leagueSyncId,
            homeTeamSyncId: a.teamSyncId,
            awayTeamSyncId: null,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: DateTime.now(),
          ));
        } else if (a == null && b != null) {
          matches.add(MatchModel(
            leagueSyncId: leagueSyncId,
            homeTeamSyncId: b.teamSyncId,
            awayTeamSyncId: null,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: DateTime.now(),
          ));
        }
      }
    }

    return matches;
  }

  /// يبني الجولة التالية من مباريات منتهية (مع فرقها) بدون تخزين.
//   List<MatchModel> buildNextKnockoutMatches({
//     required String leagueSyncId,
//     required List<MatchModel> finishedMatches,
//     required Map<String, TeamModel> teamsBySyncId,
//     String pairingStrategy = 'seeded',
//     bool homeAway = false,
//     int? seed,
//   }) {
//     final winners = <TeamModel>[];
//
//     for (final m in finishedMatches) {
//       final home = m.homeTeam;
//       final away = m.awayTeam;
//
//       if (away == null || (m.homeScore > m.awayScore)) {
//         if (home != null) winners.add(home);
//       } else if (m.awayScore > m.homeScore) {
//         winners.add(away);
//       } else {
//         if (home != null) winners.add(home);
//       }
//     }
//
//     if (winners.isEmpty) return const [];
//
//     final rnd = seed == null ? Random() : Random(seed);
//     final ordered = (pairingStrategy == 'random')
//         ? (List.of(winners)..shuffle(rnd))
//         : winners;
//
//     final total = ordered.length;
//     final matches = <MatchModel>[];
//
//     for (int i = 0; i < total; i += 2) {
//       final home = ordered[i];
//       final away = (i + 1 < total) ? ordered[i + 1] : null;
//
//       if (away == null) {
//         matches.add(MatchModel(
//           leagueSyncId: leagueSyncId,
//           homeTeamSyncId: home.syncId,
//           awayTeamSyncId: null,
//           homeScore: 0,
//           awayScore: 0,
//           status: 'unscheduled',
//         ));
//       } else {
//         matches.add(MatchModel(
//           leagueSyncId: leagueSyncId,
//           homeTeamSyncId: home.syncId,
//           awayTeamSyncId: away.syncId,
//           homeScore: 0,
//           awayScore: 0,
//           status: 'unscheduled',
//           matchDate: DateTime.now(),
//         ));
//         if (homeAway) {
//           matches.add(MatchModel(
//             leagueSyncId: leagueSyncId,
//             homeTeamSyncId: away.syncId,
//             awayTeamSyncId: home.syncId,
//             homeScore: 0,
//             awayScore: 0,
//             status: 'unscheduled',
//             matchDate: DateTime.now().add(const Duration(days: 7)),
//           ));
//         }
//       }
//     }
//
//     return matches;
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
//
// }

  List<MatchModel> buildNextKnockoutMatches({
    required String leagueSyncId,
    required List<MatchModel> finishedMatches,
    required Map<String, TeamModel> teamsBySyncId,
    String pairingStrategy = 'seeded', // 'seeded' | 'random' | 'bracket'
    bool homeAway = false,
    int? seed,
  }) {
    bool isFinished(String s) => s.toLowerCase().trim() == 'finished';

    // 1) Extract winners by syncId (no need homeTeam/awayTeam objects)
    final winners = <String>[];

    for (final m in finishedMatches) {
      if (!isFinished(m.status)) continue;

      final homeSync = (m.homeTeamSyncId ?? '').trim();
      final awaySync = (m.awayTeamSyncId ?? '').trim();
      if (homeSync.isEmpty || awaySync.isEmpty) continue;

      if (m.homeScore == m.awayScore) {
        // لو عندك ركلات ترجيح/معيار كسر تعادل، طبقه هنا بدل throw
        throw Exception(
            '⚠️ لا يمكن إنشاء الجولة التالية: توجد مباراة منتهية بالتعادل.');
      }

      final winnerSync = m.homeScore > m.awayScore ? homeSync : awaySync;

      // ensure exists locally
      if (!teamsBySyncId.containsKey(winnerSync)) {
        // لا نرجع empty بصمت، هذا يسهّل اكتشاف مشاكل sync
        throw Exception('⚠️ الفائز غير موجود محليًا: $winnerSync');
      }

      winners.add(winnerSync);
    }

    if (winners.isEmpty) return const <MatchModel>[];

    // 2) Order winners
    final ordered = List<String>.from(winners);
    final strategy = pairingStrategy.toLowerCase().trim();

    if (strategy == 'random') {
      final rnd = Random(seed ?? DateTime
          .now()
          .millisecondsSinceEpoch);
      ordered.shuffle(rnd);
    } else {
      // seeded/bracket: keep deterministic order (match order)
    }

    // 3) Need even number for pairs (no byes because DB forbids null away team)
    if (ordered.length.isOdd) {
      throw Exception(
          '⚠️ عدد الفائزين فردي، لا يمكن تكوين أزواج (لا يوجد دعم bye حاليًا).');
    }

    // 4) Build next round matches
    final now = DateTime.now();
    final matches = <MatchModel>[];

    for (int i = 0; i < ordered.length; i += 2) {
      final home = ordered[i];
      final away = ordered[i + 1];

      // (extra safety)
      if (home == away) {
        throw Exception('⚠️ خطأ pairing: home == away ($home)');
      }

      matches.add(MatchModel(
        leagueSyncId: leagueSyncId,
        homeTeamSyncId: home,
        awayTeamSyncId: away,
        homeScore: 0,
        awayScore: 0,
        status: 'unscheduled',
        matchDate: now,
      ));

      if (homeAway) {
        matches.add(MatchModel(
          leagueSyncId: leagueSyncId,
          homeTeamSyncId: away,
          awayTeamSyncId: home,
          homeScore: 0,
          awayScore: 0,
          status: 'unscheduled',
          matchDate: now.add(const Duration(days: 7)),
        ));
      }
    }

    return matches;
  }

  String roundNameForCount(int count, String prefix) {
    final namePrefix = prefix.isNotEmpty ? '$prefix - ' : '';
    if (count >= 16) return '${namePrefix}دور 32';
    if (count >= 8) return '${namePrefix}دور 16';
    if (count >= 4) return '${namePrefix}ربع النهائي';
    if (count >= 2) return '${namePrefix}نصف النهائي';
    if (count >= 1) return '${namePrefix}النهائي';
    return '${namePrefix}Unknown Round';
  }
}
final ensureFirstKnockoutProvider = Provider<EnsureFirstKnockoutService>((ref) {
  return EnsureFirstKnockoutService(ref);
});

class _AsyncMutex {
  bool _locked = false;

  Future<T?> runIfFree<T>(Future<T> Function() action) async {
    if (_locked) return null;
    _locked = true;
    try {
      return await action();
    } finally {
      _locked = false;
    }
  }
}

class EnsureFirstKnockoutService {
  final Ref ref;
   KnockoutGeneratorLocalDataSource local=KnockoutGeneratorLocalDataSource(di.sl());
  final _mutex = _AsyncMutex();

  EnsureFirstKnockoutService(this.ref);

  Future<RoundModel?> run({
    required String leagueSyncId,
    required int qualifiedPerGroup,
    bool homeAway = false,
    int? seed,
    String roundNamePrefix = '',
  }) async {
    return _mutex.runIfFree(() async {
      // ✅ Guard DB + Logic
      final should = await local.shouldGenerateFirstKnockout(leagueSyncId);
     // if (!should) return null;

      // ✅ Generate
      final round = await local.generateKnockoutFromGroups(
        leagueSyncId: leagueSyncId,
        qualifiedPerGroup: qualifiedPerGroup,
        homeAway: homeAway,
        seed: seed,
        roundNamePrefix: roundNamePrefix,
      );

      // ✅ بعد الإنشاء: invalidation مركزي (اقل calls)
      // ref.invalidate(knockoutRoundsWithMatchesProvider(Tuple2(leagueSyncId, 'unscheduled')));
      // ref.invalidate(knockoutRoundsWithMatchesProvider(Tuple2(leagueSyncId, 'scheduled,live')));
      // ref.invalidate(knockoutRoundsWithMatchesProvider(Tuple2(leagueSyncId, 'scheduled,live,finished')));

      return round;
    });
  }
}

