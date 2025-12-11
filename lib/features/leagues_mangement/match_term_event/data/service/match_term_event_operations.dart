import '../../../group/data/model/model.dart';
import '../../../match/data/model/match_model.dart';
import '../model/player_stats.dart';
import '../model/player_match_participation_model.dart';

/// كلاس عمليات (Business Logic) لأحداث المباراة والأشواط
/// لا يتعامل مع قاعدة البيانات مباشرة، بل يعمل على الموديلات فقط.
class MatchTermEventOperations {
  const MatchTermEventOperations();

  /// حساب نقاط الفريقين بناءً على نتيجة المباراة (دور المجموعات)
  ({int homePoints, int awayPoints}) computePointsForMatch(MatchModel match) {
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

    return (homePoints: homePoints, awayPoints: awayPoints);
  }

  /// تحديث نموذج QualifiedTeamModel عند انتهاء مباراة (فقط منطق، بدون DB)
  QualifiedTeamModel buildUpdatedQualifiedTeam(
    QualifiedTeamModel current,
    int addedPoints,
  ) {
    return current.copyWith(
      points: current.points + addedPoints,
      played: current.played + 1,
      wins: addedPoints == 3 ? current.wins + 1 : current.wins,
      losses: addedPoints == 0 ? current.losses + 1 : current.losses,
    );
  }

  /// حساب تأثير هدف جديد على نتيجة المباراة (لكل من home / away)
  ({int homeScore, int awayScore}) applyGoalToScore({
    required MatchModel match,
    required bool isHomeScorer,
  }) {
    final updatedHomeScore = match.homeScore + (isHomeScorer ? 1 : 0);
    final updatedAwayScore = match.awayScore + (isHomeScorer ? 0 : 1);
    return (homeScore: updatedHomeScore, awayScore: updatedAwayScore);
  }

  /// حساب تأثير حذف هدف على نتيجة المباراة
  ({int homeScore, int awayScore}) revertGoalFromScore({
    required MatchModel match,
    required bool isHomeScorer,
  }) {
    final updatedHomeScore = match.homeScore - (isHomeScorer ? 1 : 0);
    final updatedAwayScore = match.awayScore - (isHomeScorer ? 0 : 1);
    return (homeScore: updatedHomeScore, awayScore: updatedAwayScore);
  }

  /// دمج إحصائيات اللاعب من قيم خام (goals, assists, yellow, red)
  PlayerStats buildPlayerStats({
    required int goals,
    required int assists,
    required int yellowCards,
    required int redCards,
  }) {
    return PlayerStats(
      goals: goals,
      assists: assists,
      yellowCards: yellowCards,
      redCards: redCards,
    );
  }

  /// بناء مشاركة لاعب كأساسي في مباراة/شوط
  PlayerMatchParticipationModel buildStarterParticipation({
    required int matchId,
    required int matchTermId,
    required int playerId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      startTime: 0,
      endTime: null,
      substitutedPlayerId: null,
      participationType: 'STARTER',
    );
  }

  /// بناء مشاركة لاعب كخارج (SUB_OUT)
  PlayerMatchParticipationModel buildSubOutParticipation({
    required int matchId,
    required int matchTermId,
    required int playerId,
    required int substitutionMinute,
    required int substitutedByPlayerId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      startTime: 0,
      endTime: substitutionMinute,
      substitutedPlayerId: substitutedByPlayerId,
      participationType: 'SUB_OUT',
    );
  }

  /// بناء مشاركة لاعب كداخل (SUB_IN)
  PlayerMatchParticipationModel buildSubInParticipation({
    required int matchId,
    required int matchTermId,
    required int playerId,
    required int substitutionMinute,
    required int substitutedPlayerId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      startTime: substitutionMinute,
      endTime: null,
      substitutedPlayerId: substitutedPlayerId,
      participationType: 'SUB_IN',
    );
  }
}
