import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class WarningModel {
  final int? id;
  final int matchId;
  final int playerId;
  final int? playerName;

  final int matchTermId;
  final int warningTime;
  final String warningType;
  final String? reason;
  final String status;
  final int? teamId; // ✅ جديد

  WarningModel({
     this.id,
    required this.matchId,
    required this.playerId,
    required this.matchTermId,
    required this.warningTime,
    required this.warningType,
    this.reason,
    this.status = 'active',
    this.teamId,this.playerName
  });

  factory WarningModel.fromEntity(Warning entity) {
    return WarningModel(
      id: entity.id,
      matchId: entity.matchId,
      playerId: entity.playerId,
      matchTermId: entity.matchTermId,
      warningTime: entity.warningTime,
      warningType: entity.warningType,
      reason: entity.reason,
      status: entity.status,
    );
  }

  factory WarningModel.fromJson(Map<String, dynamic> json) {
    return WarningModel(
      id: json['id'] as int,
      matchId: json['match_id'] as int,
      playerId: json['player_id'] as int,
      matchTermId: json['match_term_id'] as int,
      warningTime: json['warning_time'] as int,
      warningType: json['warning_type'] as String,
      reason: json['reason'] as String?,
      status: json['status'] as String? ?? 'active',
    );
  }

  WarningsCompanion toCompanionInsert() {
    return WarningsCompanion.insert(
      matchId: matchId,
      playerId: playerId,
      matchTermId: matchTermId,
      warningTime: warningTime,
      warningType: warningType,
      reason: Value(reason),
      status: Value(status),
    );
  }

  WarningsCompanion toCompanionUpdate() {
    return WarningsCompanion(
      id: Value(id!),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      warningTime: Value(warningTime),
      warningType: Value(warningType),
      reason: Value(reason),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'match_id': matchId,
    'player_id': playerId,
    'match_term_id': matchTermId,
    'warning_time': warningTime,
    'warning_type': warningType,
    if (reason != null) 'reason': reason,
    'status': status,
  };

  WarningModel copyWith({
    int? id,
    int? matchId,
    int? playerId,
    int? matchTermId,
    int? warningTime,
    String? warningType,
    String? reason,
    String? status,
  }) {
    return WarningModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      warningTime: warningTime ?? this.warningTime,
      warningType: warningType ?? this.warningType,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }
}
