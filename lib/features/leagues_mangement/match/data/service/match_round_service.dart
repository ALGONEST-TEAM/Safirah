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
  ///
  /// NOTE: we now work with teamSyncIds (String) instead of numeric ids.
  /// roundSyncId will be assigned at DB layer.
//   List<MatchModel> buildGroupMatches({
//     required String leagueSyncId,
//     required GroupModel group,
//     required List<String> teamIds,
//     bool homeAway = false,
//   }) {
//     if (teamIds.length < 2) {
//       return const [];
//     }
//
//     final n = teamIds.length;
//     final odd = n.isOdd;
//     final rounds = odd ? n : n - 1;
//     final matchesPerRound = n ~/ 2;
//
//     // نعمل نسخة قابلة للتعديل من الفرق
//     var teams = List<String>.from(teamIds);
//     final List<MatchModel> result = [];
//
//     for (var round = 0; round < rounds; round++) {
//       // في حالة العدد الفردي، الفريق الأول في القائمة هو الذي يرتاح
//       final playingTeams = odd
//           ? teams.sublist(1) // نستثني الفريق الأول (الراحة)
//           : List<String>.from(teams);
//
//       for (var i = 0; i < matchesPerRound; i++) {
//         final homeTeamId = playingTeams[i];
//         final awayTeamId = playingTeams[playingTeams.length - 1 - i];
//
//         result.add(
//           MatchModel(
//             leagueSyncId: leagueSyncId,
//             homeTeamSyncId: homeTeamId,
//             awayTeamSyncId: awayTeamId,
//             matchDate: DateTime.now(),
//             status: 'unscheduled',
//           ),
//         );
//
//         // if (homeAway) {
//         //   result.add(
//         //     MatchModel(
//         //       leagueSyncId: leagueSyncId,
//         //      // roundSyncId: null,
//         //       homeTeamSyncId: homeTeamId,
//         //       awayTeamSyncId: awayTeamId,
//         //       matchDate: DateTime.now().add(const Duration(days: 7)),
//         //       status: 'unscheduled',
//         //     ),
//         //   );
//         // }
//       }
//
//       // تدوير الفرق - الفريق الذي يرتاح ينتقل لنهاية القائمة
//       teams = rotateTeams(teams);
//     }
//
//     return result;
//   }
//
//   /// تدوير قائمة الفرق كما في المنطق الأصلي: نقل أول عنصر إلى النهاية.
//   List<String> rotateTeams(List<String> teams) {
//     if (teams.isEmpty) return teams;
//     final first = teams.first;
//     final rest = teams.sublist(1);
//     return [...rest, first];
//   }
// }
  List<MatchModel> buildGroupMatches({
    required String leagueSyncId,
    required GroupModel group,
    required List<String> teamIds,
    bool homeAway = false,
  }) {
    if (teamIds.length < 2) return const [];

    final teams = List<String>.from(teamIds);

    // ✅ إذا فردي: أضف BYE ليصبح العدد زوجي
    const bye = '__BYE__';
    final odd = teams.length.isOdd;
    if (odd) teams.add(bye);

    final n = teams.length;        // الآن زوجي دائمًا
    final rounds = n - 1;          // ✅ دائمًا n-1
    final matchesPerRound = n ~/ 2;

    // ✅ pivot ثابت + تدوير للباقي فقط
    final pivot = teams.first;
    var rot = teams.sublist(1);

    final List<MatchModel> result = [];

    for (var round = 0; round < rounds; round++) {
      final current = <String>[pivot, ...rot];

      for (var i = 0; i < matchesPerRound; i++) {
        final a = current[i];
        final b = current[n - 1 - i];

        if (a == bye || b == bye) continue;

        // توزيع home/away بشكل أفضل (اختياري)
        final swap = (round.isOdd && i == 0);
        final home = swap ? b : a;
        final away = swap ? a : b;

        result.add(
          MatchModel(
            leagueSyncId: leagueSyncId,
            homeTeamSyncId: home,
            awayTeamSyncId: away,
            matchDate: DateTime.now(),
            status: 'unscheduled',
          ),
        );

        if (homeAway) {
          result.add(
            MatchModel(
              leagueSyncId: leagueSyncId,
              homeTeamSyncId: away,
              awayTeamSyncId: home,
              matchDate: DateTime.now().add(const Duration(days: 7)),
              status: 'unscheduled',
            ),
          );
        }
      }

      // ✅ rotate rot (يمين 1): آخر عنصر ينتقل للبداية
      rot = <String>[rot.last, ...rot.sublist(0, rot.length - 1)];
    }

    return result;
  }}