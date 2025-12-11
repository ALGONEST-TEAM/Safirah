
import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class AssistModel {
  final int? id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int goalId;
  final int assistTime;
  final String status;

  AssistModel({
    this.id,
    required this.matchId,
    required this.playerId,
    required this.matchTermId,
    required this.goalId,
    required this.assistTime,
    this.status = 'active',
  });

  factory AssistModel.fromEntity(Assist entity) {
    return AssistModel(
      id: entity.id,
      matchId: entity.matchId,
      playerId: entity.playerId,
      matchTermId: entity.matchTermId,
      goalId: entity.goalId,
      assistTime: entity.assistTime,
      status: entity.status,
    );
  }

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'] as int?,
      matchId: json['match_id'] as int,
      playerId: json['player_id'] as int,
      matchTermId: json['match_term_id'] as int,
      goalId: json['goal_id'] as int,
      assistTime: json['assist_time'] as int,
      status: json['status'] as String? ?? 'active',
    );
  }

  AssistsCompanion toCompanionInsert() {
    return AssistsCompanion.insert(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      goalId: goalId,
      assistTime: assistTime,
      status: Value(status),
    );
  }

  AssistsCompanion toCompanionUpdate() {
    return AssistsCompanion(
      id: Value(id!),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      goalId: Value(goalId),
      assistTime: Value(assistTime),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'match_id': matchId,
        'player_id': playerId,
        'match_term_id': matchTermId,
        'goal_id': goalId,
        'assist_time': assistTime,
        'status': status,
      };

  AssistModel copyWith({
    int? id,
    int? matchId,
    int? playerId,
    int? matchTermId,
    int? goalId,
    int? assistTime,
    String? status,
  }) {
    return AssistModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      goalId: goalId ?? this.goalId,
      assistTime: assistTime ?? this.assistTime,
      status: status ?? this.status,
    );
  }
}
