import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class AssistModel {
  final int? id;
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final String goalSyncId;
  final int assistTime;
  final String status;

  AssistModel({
    this.id,
    required this.matchSyncId,
    required this.playerSyncId,
    required this.matchTermSyncId,
    required this.goalSyncId,
    required this.assistTime,
    this.status = 'active',
  });

  factory AssistModel.fromEntity(Assist entity) {
    return AssistModel(
      id: entity.id,
      matchSyncId: entity.matchSyncId,
      playerSyncId: entity.playerSyncId,
      matchTermSyncId: entity.matchTermSyncId,
      goalSyncId: entity.goalSyncId,
      assistTime: entity.assistTime,
      status: entity.status,
    );
  }

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'] as int?,
      matchSyncId: (json['match_sync_id'] ?? json['matchSyncId']) as String,
      playerSyncId: (json['player_sync_id'] ?? json['playerSyncId']) as String,
      matchTermSyncId:
          (json['match_term_sync_id'] ?? json['matchTermSyncId']) as String,
      goalSyncId: (json['goal_sync_id'] ?? json['goalSyncId']) as String,
      assistTime: json['assist_time'] as int,
      status: json['status'] as String? ?? 'active',
    );
  }

  AssistsCompanion toCompanionInsert() {
    return AssistsCompanion.insert(
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      goalSyncId: goalSyncId,
      assistTime: assistTime,
      status: Value(status),
    );
  }

  AssistsCompanion toCompanionUpdate() {
    return AssistsCompanion(
      id: Value(id!),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
      goalSyncId: Value(goalSyncId),
      assistTime: Value(assistTime),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'match_sync_id': matchSyncId,
        'player_sync_id': playerSyncId,
        'match_term_sync_id': matchTermSyncId,
        'goal_sync_id': goalSyncId,
        'assist_time': assistTime.toString(),
        'status': status,
      };

  AssistModel copyWith({
    int? id,
    String? matchSyncId,
    String? playerSyncId,
    String? matchTermSyncId,
    String? goalSyncId,
    int? assistTime,
    String? status,
  }) {
    return AssistModel(
      id: id ?? this.id,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      goalSyncId: goalSyncId ?? this.goalSyncId,
      assistTime: assistTime ?? this.assistTime,
      status: status ?? this.status,
    );
  }
}
