import 'dart:math';

import '../model/team_model.dart';

/// خدمة مسؤولة عن منطق توزيع اللاعبين على الفرق (Draft)
/// بدون أي أوامر مباشرة على قاعدة البيانات.
class TeamPlayerDraftService {
  const TeamPlayerDraftService();

  /// يبني لاعبي الـ draft منطقياً بدون تخزين في قاعدة البيانات.
  List<PlayerModel> buildDraftPlayers({
    required int leagueId,
    required List<TeamModel> teams,
    required List<TeamPlayerCategoryModel> categories,
    required Map<int?, List<LeaguePlayerModel>> leaguePlayersByCategory,
    int? seed,
    int maxMainPlayers = 0,
    int maxSubPlayers = 0,
  }) {
    if (teams.isEmpty) return const [];

    // نضمن أن لكل فريق id غير فارغ قبل الاستخدام
    final teamIds = teams.map((t) => t.id!).toList();

    // عدّادات لكل فريق
    final Map<int, int> mainCount = {for (final t in teams) t.id!: 0};
    final Map<int, int> subCount = {for (final t in teams) t.id!: 0};

    final rng = seed == null ? null : Random(seed);
    final result = <PlayerModel>[];

    // تجهيز قائمة الفئات، إن لم توجد فئات نستخدم null كفئة وحيدة
    final List<int?> catIds =
        categories.isEmpty ? <int?>[null] : categories.map((c) => c.id!).toList();

    for (final catId in catIds) {
      final lpList = List<LeaguePlayerModel>.from(
        leaguePlayersByCategory[catId] ?? const [],
      );
      if (lpList.isEmpty) continue;

      if (rng != null) {
        teamIds.shuffle(rng);
        lpList.shuffle(rng);
      } else {
        teamIds.shuffle();
        lpList.shuffle();
      }

      var ti = 0; // Round-Robin
      for (final lp in lpList) {
        final teamId = teamIds[ti];
        ti = (ti + 1) % teamIds.length;

        // تحديد الحالة لحظة التوزيع
        String status = 'main';
        if (maxMainPlayers > 0 &&
            mainCount[teamId]! >= maxMainPlayers &&
            maxSubPlayers > 0 &&
            subCount[teamId]! < maxSubPlayers) {
          status = 'sub';
        }

        result.add(PlayerModel(
          id: null, // يتم تعيينه في طبقة الـ DB
          playerLeagueId: lp.id!,
          teamId: teamId,
          fullName: 'Player #${lp.userId}',
          status: status,
        ));

        if (status == 'main') {
          mainCount[teamId] = mainCount[teamId]! + 1;
        } else {
          subCount[teamId] = subCount[teamId]! + 1;
        }
      }
    }

    return result;
  }

  /// منطق تعيين لاعبين محددين لفريق معين، مع احترام الحد الأعلى.
  List<PlayerModel> buildAssignPlayersToTeam({
    required int teamId,
    required int leagueId,
    required List<LeaguePlayerModel> leaguePlayers,
    required Set<int> takenLeaguePlayerIds,
    required int currentMain,
    required int currentSub,
    int maxMainPlayers = 0,
    int maxSubPlayers = 0,
  }) {
    var main = currentMain;
    var sub = currentSub;
    final result = <PlayerModel>[];

    for (final lp in leaguePlayers) {
      if (takenLeaguePlayerIds.contains(lp.id)) {
        continue;
      }

      String status = 'main';
      if (maxMainPlayers > 0 &&
          main >= maxMainPlayers &&
          maxSubPlayers > 0 &&
          sub < maxSubPlayers) {
        status = 'sub';
      }

      result.add(PlayerModel(
        playerLeagueId: lp.id!,
        teamId: teamId,
        fullName: 'Player #${lp.userId}',
        status: status,
      ));

      if (status == 'main') {
        main++;
      } else {
        sub++;
      }
    }

    return result;
  }
}
