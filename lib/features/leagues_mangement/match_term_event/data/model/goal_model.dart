import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class GoalModel {
  final int? id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int goalTime;
  final String goalType;
  final String status;
  final int? teamId; // ✅ جديد

  GoalModel({
     this.id,
    required this.matchId,
    required this.playerId,
    required this.matchTermId,
    required this.goalTime,
    required this.goalType,
    this.status = 'active',
    this.teamId
  });

  factory GoalModel.fromEntity(Goal entity) {
    return GoalModel(
      id: entity.id,
      matchId: entity.matchId,
      playerId: entity.playerId,
      matchTermId: entity.matchTermId,
      goalTime: entity.goalTime,
      goalType: entity.goalType,
      status: entity.status,
    );
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] as int,
      matchId: json['match_id'] as int,
      playerId: json['player_id'] as int,
      matchTermId: json['match_term_id'] as int,
      goalTime: json['goal_time'] as int,
      goalType: json['goal_type'] as String,
      status: json['status'] as String? ?? 'active',
    );
  }

  GoalsCompanion toCompanionInsert() {
    return GoalsCompanion.insert(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      goalTime: goalTime,
      goalType: goalType,
      status: Value(status),
    );
  }

  GoalsCompanion toCompanionUpdate() {
    return GoalsCompanion(
      id: Value(id!),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      goalTime: Value(goalTime),
      goalType: Value(goalType),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'match_id': matchId,
    'player_id': playerId,
    'match_term_id': matchTermId,
    'goal_time': goalTime,
    'goal_type': goalType,
    'status': status,
  };

  GoalModel copyWith({
    int? id,
    int? matchId,
    int? playerId,
    int? matchTermId,
    int? goalTime,
    String? goalType,
    String? status,
    int? idTeam,
  }) {
    return GoalModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      goalTime: goalTime ?? this.goalTime,
      goalType: goalType ?? this.goalType,
      status: status ?? this.status,
      teamId: idTeam ?? this.teamId,
    );
  }
}
