import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class GoalModel {
  final int? id;
  final String syncId;
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final int goalTime;
  final String goalType;
  final String status;
  final String? teamSyncId;

  GoalModel({
    this.id,
    required this.syncId,
    required this.matchSyncId,
    required this.playerSyncId,
    required this.matchTermSyncId,
    required this.goalTime,
    required this.goalType,
    this.status = 'active',
    this.teamSyncId,
  });

  factory GoalModel.fromEntity(Goal entity) {
    return GoalModel(
      id: entity.id,
      syncId: entity.syncId,
      matchSyncId: entity.matchSyncId,
      playerSyncId: entity.playerSyncId,
      matchTermSyncId: entity.matchTermSyncId,
      goalTime: entity.goalTime,
      goalType: entity.goalType,
      status: entity.status,
    );
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] as int?,
      syncId: (json['sync_id'] ?? json['syncId']) as String,
      matchSyncId: (json['match_sync_id'] ?? json['matchSyncId']) as String,
      playerSyncId: (json['player_sync_id'] ?? json['playerSyncId']) as String,
      matchTermSyncId:
          (json['match_term_sync_id'] ?? json['matchTermSyncId']) as String,
      goalTime: json['goal_time'] as int,
      goalType: json['goal_type'] as String,
      status: json['status'] as String? ?? 'active',
    );
  }

  GoalsCompanion toCompanionInsert() {
    return GoalsCompanion.insert(
      syncId: syncId,
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      goalTime: goalTime,
      goalType: goalType,
      status: Value(status),
    );
  }

  GoalsCompanion toCompanionUpdate() {
    return GoalsCompanion(
      id: Value(id!),
      syncId: Value(syncId),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
      goalTime: Value(goalTime),
      goalType: Value(goalType),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sync_id': syncId,
        'match_sync_id': matchSyncId,
        'player_sync_id': playerSyncId,
        'match_term_sync_id': matchTermSyncId,
        'goal_time': goalTime.toString(),
        'goal_type': goalType,
        'status': status,
      };

  GoalModel copyWith({
    int? id,
    String? syncId,
    String? matchSyncId,
    String? playerSyncId,
    String? matchTermSyncId,
    int? goalTime,
    String? goalType,
    String? status,
    String? teamSyncId,
  }) {
    return GoalModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      goalTime: goalTime ?? this.goalTime,
      goalType: goalType ?? this.goalType,
      status: status ?? this.status,
      teamSyncId: teamSyncId ?? this.teamSyncId,
    );
  }
}
