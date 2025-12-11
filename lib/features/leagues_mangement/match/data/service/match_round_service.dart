import '../../../group/data/model/model.dart';
import '../model/match_model.dart';

class MatchService {
  const MatchService();

  /// يحسب عدد جولات دور المجموعات بناءً على عدد الفرق في المجموعة.
  /// - إذا كان عدد الفرق أقل من 2 => 0
  /// - إذا كان العدد زوجياً => teamCount - 1
  /// - إذا كان فردياً => teamCount
  int calculateRoundsCount(int teamCount) {
    if (teamCount < 2) return 0;
    if (teamCount % 2 == 0) {
      return teamCount - 1;
    } else {
      return teamCount;
    }
  }

  /// يبني جولات دور المجموعات ومبارياتها منطقياً لمجموعة واحدة.
  /// يعيد قائمة MatchModel مع ضبط leagueId و roundId لاحقاً من طبقة الـ DB.
  List<MatchModel> buildGroupMatches({
    required int leagueId,
    required GroupModel group,
    required List<int> teamIds,
    bool homeAway = false,
  }) {
    if (teamIds.length < 2) {
      return const [];
    }

    final n = teamIds.length;
    final odd = n.isOdd;
    final rounds = odd ? n : n - 1;
    final matchesPerRound = n ~/ 2;

    // نعمل نسخة قابلة للتعديل من الفرق
    var teams = List<int>.from(teamIds);
    final List<MatchModel> result = [];

    for (var round = 0; round < rounds; round++) {
      // في حالة العدد الفردي، الفريق الأول في القائمة هو الذي يرتاح
      final playingTeams = odd
          ? teams.sublist(1) // نستثني الفريق الأول (الراحة)
          : List<int>.from(teams);

      for (var i = 0; i < matchesPerRound; i++) {
        final homeTeamId = playingTeams[i];
        final awayTeamId = playingTeams[playingTeams.length - 1 - i];

        result.add(
          MatchModel(
            leagueId: leagueId,
            roundId: null, // يتم تعيينها في طبقة DB بعد إنشاء الجولة
            homeTeamId: homeTeamId,
            awayTeamId: awayTeamId,
            matchDate: DateTime.now(),
            status: 'unscheduled',
          ),
        );

        if (homeAway) {
          result.add(
            MatchModel(
              leagueId: leagueId,
              roundId: null,
              homeTeamId: awayTeamId,
              awayTeamId: homeTeamId,
              matchDate: DateTime.now().add(const Duration(days: 7)),
              status: 'unscheduled',
            ),
          );
        }
      }

      // تدوير الفرق - الفريق الذي يرتاح ينتقل لنهاية القائمة
      teams = rotateTeams(teams);
    }

    return result;
  }

  /// تدوير قائمة الفرق كما في المنطق الأصلي: نقل أول عنصر إلى النهاية.
  List<int> rotateTeams(List<int> teams) {
    if (teams.isEmpty) return teams;
    final first = teams.first;
    final rest = teams.sublist(1);
    return [...rest, first];
  }
}
