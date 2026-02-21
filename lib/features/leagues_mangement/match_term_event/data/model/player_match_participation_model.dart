class PlayerMatchParticipationModel {
  final int id;
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final int startTime; // دقيقة البداية داخل المباراة
  final int? endTime; // دقيقة النهاية (null إذا ما زال مشاركاً)
  final String? substitutedPlayerSyncId; // اللاعب الذي خرج بدلاً منه (اختياري)
  final String participationType; // مثال: STARTER, SUB_IN, SUB_OUT

  const PlayerMatchParticipationModel({
    required this.id,
    required this.matchSyncId,
    required this.playerSyncId,
    required this.matchTermSyncId,
    required this.startTime,
    this.endTime,
    this.substitutedPlayerSyncId,
    required this.participationType,
  });

  PlayerMatchParticipationModel copyWith({
    int? id,
    String? matchSyncId,
    String? playerSyncId,
    String? matchTermSyncId,
    int? startTime,
    int? endTime,
    String? substitutedPlayerSyncId,
    String? participationType,
  }) {
    return PlayerMatchParticipationModel(
      id: id ?? this.id,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      substitutedPlayerSyncId:
          substitutedPlayerSyncId ?? this.substitutedPlayerSyncId,
      participationType: participationType ?? this.participationType,
    );
  }

  // JSON (API)
  factory PlayerMatchParticipationModel.fromJson(Map<String, dynamic> json) {
    return PlayerMatchParticipationModel(
      id: (json['player_match_participation_id'] ?? json['id']) as int,
      matchSyncId: (json['match_sync_id'] ?? json['matchSyncId']) as String,
      playerSyncId: (json['player_sync_id'] ?? json['playerSyncId']) as String,
      matchTermSyncId:
          (json['match_term_sync_id'] ?? json['matchTermSyncId']) as String,
      startTime: json['start_time'] as int,
      endTime: json['end_time'] as int?,
      substitutedPlayerSyncId:
          json['substituted_player_sync_id'] as String?,
      participationType: json['participation_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_match_participation_id': id,
      'match_sync_id': matchSyncId,
      'player_sync_id': playerSyncId,
      'match_term_sync_id': matchTermSyncId,
      'start_time': startTime,
      'end_time': endTime,
      'substituted_player_sync_id': substitutedPlayerSyncId,
      'participation_type': participationType,
    };
  }

  // DB mapping (مثلاً لاستخدامها مع sqflite أو أي ORM)
  factory PlayerMatchParticipationModel.fromDb(Map<String, Object?> row) {
    return PlayerMatchParticipationModel(
      id: row['id'] as int,
      matchSyncId: row['match_sync_id'] as String,
      playerSyncId: row['player_sync_id'] as String,
      matchTermSyncId: row['match_term_sync_id'] as String,
      startTime: row['start_time'] as int,
      endTime: row['end_time'] as int?,
      substitutedPlayerSyncId: row['substituted_player_sync_id'] as String?,
      participationType: row['participation_type'] as String,
    );
  }

  Map<String, Object?> toDb() {
    return {
      'id': id,
      'match_sync_id': matchSyncId,
      'player_sync_id': playerSyncId,
      'match_term_sync_id': matchTermSyncId,
      'start_time': startTime,
      'end_time': endTime,
      'substituted_player_sync_id': substitutedPlayerSyncId,
      'participation_type': participationType,
    };
  }
}