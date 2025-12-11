import 'dart:math';

import '../../../group/data/model/model.dart';
import '../../../match/data/model/match_model.dart';
import '../../../team_and_player/data/model/team_model.dart';

class KnockoutGeneratorService {
  const KnockoutGeneratorService();

  List<MatchModel> buildKnockoutMatchesFromGroups({
    required int leagueId,
    required List<GroupModel> groups,
    required Map<int, List<QualifiedTeamModel>> groupQualified,
    bool homeAway = false,
    int? seed,
  }) {
    final groupIds = groups.map((g) => g.id).toList();
    final matches = <MatchModel>[];

    // يمكن استخدام seed مستقبلاً لعمل shuffle للمجموعات أو الفرق
    final rnd = seed == null ? Random() : Random(seed);
    rnd.hashCode; // فقط لكسر تحذير unused في حال لم نستخدمه الآن.

    for (int gi = 0; gi < groupIds.length; gi += 2) {
      final int? groupAId = groupIds[gi];
      final int? groupBId = (gi + 1 < groupIds.length) ? groupIds[gi + 1] : null;

      final List<QualifiedTeamModel> groupA = groupQualified[groupAId] ?? [];
      final List<QualifiedTeamModel> groupB =
          groupBId != null ? (groupQualified[groupBId] ?? []) : [];

      if (groupBId == null) {
        // مجموعة بدون زوج: نُنشئ BYE لكل فريق
        for (final home in groupA) {
          matches.add(MatchModel(
            leagueId: leagueId,
            homeTeamId: home.teamId,
            awayTeamId: null,
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
            leagueId: leagueId,
            homeTeamId: a.teamId,
            awayTeamId: b.teamId,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: matchDate,
          ));
          if (homeAway) {
            matches.add(MatchModel(
              leagueId: leagueId,
              homeTeamId: b.teamId,
              awayTeamId: a.teamId,
              homeScore: 0,
              awayScore: 0,
              status: 'unscheduled',
              matchDate: matchDate.add(const Duration(days: 7)),
            ));
          }
        } else if (a != null && b == null) {
          matches.add(MatchModel(
            leagueId: leagueId,
            homeTeamId: a.teamId,
            awayTeamId: null,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: DateTime.now(),
          ));
        } else if (a == null && b != null) {
          matches.add(MatchModel(
            leagueId: leagueId,
            homeTeamId: b.teamId,
            awayTeamId: null,
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
  List<MatchModel> buildNextKnockoutMatches({
    required int leagueId,
    required List<MatchModel> finishedMatches,
    required Map<int, TeamModel> teamsById,
    String pairingStrategy = 'seeded',
    bool homeAway = false,
    int? seed,
  }) {
    final winners = <TeamModel>[];

    for (final m in finishedMatches) {
      final home = m.homeTeamId != null ? teamsById[m.homeTeamId] : null;
      final away = m.awayTeamId != null ? teamsById[m.awayTeamId] : null;

      if (away == null || (m.homeScore > m.awayScore)) {
        if (home != null) winners.add(home);
      } else if (m.awayScore > m.homeScore) {
        if (away != null) winners.add(away);
      } else {
        if (home != null) winners.add(home);
      }
    }

    if (winners.isEmpty) return const [];

    final rnd = seed == null ? Random() : Random(seed);
    final ordered = (pairingStrategy == 'random')
        ? (List.of(winners)..shuffle(rnd))
        : winners;

    final total = ordered.length;
    final matches = <MatchModel>[];

    for (int i = 0; i < total; i += 2) {
      final home = ordered[i];
      final away = (i + 1 < total) ? ordered[i + 1] : null;

      if (away == null) {
        matches.add(MatchModel(
          leagueId: leagueId,
          homeTeamId: home.id,
          awayTeamId: null,
          homeScore: 0,
          awayScore: 0,
          status: 'unscheduled',
        ));
      } else {
        matches.add(MatchModel(
          leagueId: leagueId,
          homeTeamId: home.id,
          awayTeamId: away.id,
          homeScore: 0,
          awayScore: 0,
          status: 'unscheduled',
          matchDate: DateTime.now(),
        ));
        if (homeAway) {
          matches.add(MatchModel(
            leagueId: leagueId,
            homeTeamId: away.id,
            awayTeamId: home.id,
            homeScore: 0,
            awayScore: 0,
            status: 'unscheduled',
            matchDate: DateTime.now().add(const Duration(days: 7)),
          ));
        }
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
