import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';

class UserHasRoleModel {
  final String? syncId;
  final String leagueSyncId;
  final String name;
  final String role;
  final int? roleOrder;

  const UserHasRoleModel({
    this.syncId,
    required this.leagueSyncId,
    required this.name,
    required this.role,
    this.roleOrder,
  });

  UserHasRoleModel copyWith({
    String? syncId,
    String? leagueSyncId,
    String? name,
    String? role,
    int? roleOrder,
  }) {
    return UserHasRoleModel(
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      name: name ?? this.name,
      role: role ?? this.role,
      roleOrder: roleOrder ?? this.roleOrder,
    );
  }

  /// ✅ من JSON (يدعم أكثر من naming + role_order)
  factory UserHasRoleModel.fromJson(Map<String, dynamic> j) {
    final leagueId =
    (j['league_sync_id'] ?? j['leagueSyncId'] ?? j['league_id']) as String?;

    int? parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is String) return int.tryParse(v);
      if (v is num) return v.toInt();
      return null;
    }

    return UserHasRoleModel(
      syncId: (j['sync_id'] ?? j['syncId']) as String?,
      leagueSyncId: (leagueId ?? '').trim(),
      name: (j['user_name'] ?? j['user_name'] ?? j['username']) as String? ?? '',
      role: (j['league_participant_role_name'] ?? j['user_role']) as String? ?? '',
      roleOrder: parseInt(j['league_participant_role_id'] ?? j['roleOrder']),
    );
  }

  /// ✅ إلى JSON
  Map<String, dynamic> toJson() => {
    if (syncId != null) 'sync_id': syncId,
    'league_sync_id': leagueSyncId,
    'name': name,
    'role': role,
    if (roleOrder != null) 'role_order': roleOrder,
  };

  /// ✅ Insert Companion
  UsersHasRoleCompanion toCompanionInsert() => UsersHasRoleCompanion.insert(
    syncId: syncId ?? const Uuid().v7(),
    leagueSyncId: leagueSyncId,
    name: name,
    role: role,
    roleOrder: roleOrder != null ? Value(roleOrder!) : const Value.absent(),
  );

  /// ✅ Update Companion
  UsersHasRoleCompanion toCompanionUpdate() => UsersHasRoleCompanion(
    syncId: syncId != null ? Value(syncId!) : const Value.absent(),
    leagueSyncId: Value(leagueSyncId),
    name: Value(name),
    role: Value(role),
    roleOrder:
    roleOrder != null ? Value(roleOrder!) : const Value.absent(),
  );

  /// ✅ من Entity (Drift Data Class)
  static UserHasRoleModel fromEntity(UsersHasRoleData e) => UserHasRoleModel(
    syncId: e.syncId,
    leagueSyncId: e.leagueSyncId,
    name: e.name,
    role: e.role,
    roleOrder: e.roleOrder,
  );

  static List<UserHasRoleModel> fromJsonList(List json) {
    return json
        .whereType<Map>()
        .map((e) => UserHasRoleModel.fromJson(e.cast<String, dynamic>()))
        .toList();
  }
}
