import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class WarningModel {
  final int? id;
  final String syncId;
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final int warningTime;
  final String warningType;
  final String? reason;
  final String status;
  final String? teamSyncId;
  final String? playerName;

  WarningModel({
    this.id,
    required this.syncId,
    required this.matchSyncId,
    required this.playerSyncId,
    required this.matchTermSyncId,
    required this.warningTime,
    required this.warningType,
    this.reason,
    this.status = 'active',
    this.teamSyncId,
    this.playerName,
  });

  factory WarningModel.fromEntity(Warning entity) {
    return WarningModel(
      id: entity.id,
      syncId: entity.syncId,
      matchSyncId: entity.matchSyncId,
      playerSyncId: entity.playerSyncId,
      matchTermSyncId: entity.matchTermSyncId,
      warningTime: entity.warningTime,
      warningType: entity.warningType,
      reason: entity.reason,
      status: entity.status,
    );
  }

  factory WarningModel.fromJson(Map<String, dynamic> json) {
    return WarningModel(
      id: json['id'] as int?,
      syncId: (json['sync_id'] ?? json['syncId']) as String,
      matchSyncId: (json['match_sync_id'] ?? json['matchSyncId']) as String,
      playerSyncId: (json['player_sync_id'] ?? json['playerSyncId']) as String,
      matchTermSyncId:
          (json['match_term_sync_id'] ?? json['matchTermSyncId']) as String,
      warningTime: json['warning_time'] as int,
      warningType: json['warning_type'] as String,
      reason: json['reason'] as String?,
      status: json['status'] as String? ?? 'active',
    );
  }

  WarningsCompanion toCompanionInsert() {
    return WarningsCompanion.insert(
      syncId: syncId,
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
      matchTermSyncId: matchTermSyncId,
      warningTime: warningTime,
      warningType: warningType,
      reason: Value(reason),
      status: Value(status),
    );
  }

  WarningsCompanion toCompanionUpdate() {
    return WarningsCompanion(
      id: Value(id!),
      syncId: Value(syncId),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
      warningTime: Value(warningTime),
      warningType: Value(warningType),
      reason: Value(reason),
      status: Value(status),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sync_id': syncId,
        'match_sync_id': matchSyncId,
        'player_sync_id': playerSyncId,
        'match_term_sync_id': matchTermSyncId,
        'warning_time': warningTime.toString(),
        'warning_type': warningType,
        if (reason != null) 'reason': reason,
        'status': status,
      };

  WarningModel copyWith({
    int? id,
    String? syncId,
    String? matchSyncId,
    String? playerSyncId,
    String? matchTermSyncId,
    int? warningTime,
    String? warningType,
    String? reason,
    String? status,
    String? teamSyncId,
    String? playerName,
  }) {
    return WarningModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      warningTime: warningTime ?? this.warningTime,
      warningType: warningType ?? this.warningType,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      teamSyncId: teamSyncId ?? this.teamSyncId,
      playerName: playerName ?? this.playerName,
    );
  }
}
