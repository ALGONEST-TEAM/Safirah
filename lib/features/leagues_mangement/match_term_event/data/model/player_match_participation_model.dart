class PlayerMatchParticipationModel {
  final int id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int startTime; // دقيقة البداية داخل المباراة
  final int? endTime; // دقيقة النهاية (null إذا ما زال مشاركاً)
  final int? substitutedPlayerId; // اللاعب الذي خرج بدلاً منه (اختياري)
  final String participationType; // مثال: STARTER, SUB_IN, SUB_OUT

  const PlayerMatchParticipationModel({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.matchTermId,
    required this.startTime,
    this.endTime,
    this.substitutedPlayerId,
    required this.participationType,
  });

  PlayerMatchParticipationModel copyWith({
    int? id,
    int? matchId,
    int? playerId,
    int? matchTermId,
    int? startTime,
    int? endTime,
    int? substitutedPlayerId,
    String? participationType,
  }) {
    return PlayerMatchParticipationModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      substitutedPlayerId: substitutedPlayerId ?? this.substitutedPlayerId,
      participationType: participationType ?? this.participationType,
    );
  }

  // JSON (API)
  factory PlayerMatchParticipationModel.fromJson(Map<String, dynamic> json) {
    return PlayerMatchParticipationModel(
      id: json['player_match_participation_id'] as int,
      matchId: json['match_id'] as int,
      playerId: json['player_id'] as int,
      matchTermId: json['match_term_id'] as int,
      startTime: json['start_time'] as int,
      endTime: json['end_time'] as int?,
      substitutedPlayerId: json['substituted_player_id'] as int?,
      participationType: json['participation_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_match_participation_id': id,
      'match_id': matchId,
      'player_id': playerId,
      'match_term_id': matchTermId,
      'start_time': startTime,
      'end_time': endTime,
      'substituted_player_id': substitutedPlayerId,
      'participation_type': participationType,
    };
  }

  // DB mapping (مثلاً لاستخدامها مع sqflite أو أي ORM)
  factory PlayerMatchParticipationModel.fromDb(Map<String, Object?> row) {
    return PlayerMatchParticipationModel(
      id: row['player_match_participation_id'] as int,
      matchId: row['match_id'] as int,
      playerId: row['player_id'] as int,
      matchTermId: row['match_term_id'] as int,
      startTime: row['start_time'] as int,
      endTime: row['end_time'] as int?,
      substitutedPlayerId: row['substituted_player_id'] as int?,
      participationType: row['participation_type'] as String,
    );
  }

  Map<String, Object?> toDb() {
    return {
      'player_match_participation_id': id,
      'match_id': matchId,
      'player_id': playerId,
      'match_term_id': matchTermId,
      'start_time': startTime,
      'end_time': endTime,
      'substituted_player_id': substitutedPlayerId,
      'participation_type': participationType,
    };
  }
}