import '../../../group/data/model/model.dart';
import '../../../match/data/model/match_model.dart';
import '../model/player_stats.dart';
import '../model/player_match_participation_model.dart';

class MatchTermEventOperations {
  const MatchTermEventOperations();

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

  ({int homeScore, int awayScore}) applyGoalToScore({
    required MatchModel match,
    required bool isHomeScorer,
  }) {
    final updatedHomeScore = match.homeScore + (isHomeScorer ? 1 : 0);
    final updatedAwayScore = match.awayScore + (isHomeScorer ? 0 : 1);
    return (homeScore: updatedHomeScore, awayScore: updatedAwayScore);
  }

  ({int homeScore, int awayScore}) revertGoalFromScore({
    required MatchModel match,
    required bool isHomeScorer,
  }) {
    final updatedHomeScore = match.homeScore - (isHomeScorer ? 1 : 0);
    final updatedAwayScore = match.awayScore - (isHomeScorer ? 0 : 1);
    return (homeScore: updatedHomeScore, awayScore: updatedAwayScore);
  }

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

  PlayerMatchParticipationModel buildStarterParticipation({
    required String matchSyncId,
    required String matchTermSyncId,
    required String playerSyncId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      startTime: 0,
      endTime: null,
      substitutedPlayerSyncId: null,
      participationType: 'STARTER',
    );
  }

  PlayerMatchParticipationModel buildSubOutParticipation({
    required String matchSyncId,
    required String matchTermSyncId,
    required String playerSyncId,
    required int substitutionMinute,
    required String substitutedByPlayerSyncId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      startTime: 0,
      endTime: substitutionMinute,
      substitutedPlayerSyncId: substitutedByPlayerSyncId,
      participationType: 'SUB_OUT',
    );
  }

  PlayerMatchParticipationModel buildSubInParticipation({
    required String matchSyncId,
    required String matchTermSyncId,
    required String playerSyncId,
    required int substitutionMinute,
    required String substitutedPlayerSyncId,
  }) {
    return PlayerMatchParticipationModel(
      id: 0,
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      startTime: substitutionMinute,
      endTime: null,
      substitutedPlayerSyncId: substitutedPlayerSyncId,
      participationType: 'SUB_IN',
    );
  }
}
