import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';

import '../../../match/data/model/match_model.dart';

class GroupModel {
  final int? id;
  final String? syncId;

  final String leagueSyncId;
  final String groupName;
  final DateTime? createdAt;
  final int qualifiedTeamNumber;
  final List<MatchModel> matches;

  final List<QualifiedTeamModel> qualifiedTeams;

  const GroupModel({
    this.id,
    this.syncId,
    required this.leagueSyncId,
    required this.groupName,
    this.createdAt,
    required this.qualifiedTeamNumber,
    this.matches = const [], // افتراضيًا فارغة
    this.qualifiedTeams = const [], // افتراضيًا فارغة
  });

  GroupModel copyWith({
    int? id,
    String? leagueSyncId,
    String? syncId,
    String? groupName,
    DateTime? createdAt,
    List<MatchModel>? matches,
    int? qualifiedTeamNumber,
    List<QualifiedTeamModel>? qualifiedTeams,
  }) =>
      GroupModel(
        id: id ?? this.id,
        syncId: syncId??this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        groupName: groupName ?? this.groupName,
        createdAt: createdAt ?? this.createdAt,
        matches: matches ?? this.matches,
        qualifiedTeamNumber: qualifiedTeamNumber ?? this.qualifiedTeamNumber,
        qualifiedTeams: qualifiedTeams ?? this.qualifiedTeams,
      );

  factory GroupModel.fromJson(Map<String, dynamic> j) {
    int parseInt(dynamic v, {int fallback = 0}) {
      if (v == null) return fallback;
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? fallback;
      if (v is double) return v.toInt();
      return fallback;
    }

    final qualifiedTeamsJson =
    (j['qualified_teams'] ?? j['qualifiedTeams']) as List<dynamic>?;

    return GroupModel(
      id: j['id'] as int?,
      syncId: j['sync_id'] as String?,
      leagueSyncId: (j['league_sync_id'] ) as String,
      groupName: (j['group_name'] ?? j['groupName'] ?? j['name']) as String,
      matches: (j['matches'] as List<dynamic>?)
          ?.map((x) => MatchModel.fromJson(x as Map<String, dynamic>))
          .toList() ??
          const [],
      qualifiedTeamNumber: parseInt(j['qualified_team_number'] ?? j['qualifiedTeamNumber'] ?? 0),
      qualifiedTeams: qualifiedTeamsJson
          ?.map((x) => QualifiedTeamModel.fromJson(x as Map<String, dynamic>))
          .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'leagueSyncId': leagueSyncId,
        'group_name': groupName,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (matches.isNotEmpty) 'matches': matches.map((m) => m.toJson()).toList(),
        if (qualifiedTeams.isNotEmpty)
          'qualified_teams': qualifiedTeams.map((t) => t.toJson()).toList(),
      };

  GroupCompanion toCompanionInsert() => GroupCompanion.insert(
        leagueSyncId: leagueSyncId,
        groupName: groupName,
        syncId: const Uuid().v7(),
      );

  GroupCompanion toCompanionUpdate() => GroupCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        leagueSyncId: Value(leagueSyncId),
        qualifiedTeamNumber: Value(qualifiedTeamNumber),
        groupName: Value(groupName),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      );

  static GroupModel fromEntity(GroupData e) => GroupModel(
        id: e.id,
        leagueSyncId: e.leagueSyncId,
        groupName: e.groupName,
        createdAt: e.createdAt,
        qualifiedTeamNumber: e.qualifiedTeamNumber,
      );

  /// 🔥 دالة مخصصة لربط المجموعة مع مبارياتها (بعد الجلب من DB)
  GroupModel withMatches(List<MatchModel> matches) => copyWith(matches: matches);

  /// 🔥 دالة مخصصة لربط المجموعة مع ترتيب/فرق المجموعة (بعد الجلب من DB)
  GroupModel withQualifiedTeams(List<QualifiedTeamModel> teams) =>
      copyWith(qualifiedTeams: teams);

  static List<GroupModel> fromJsonGroupList(List json) {
    return json.map((e) => GroupModel.fromJson(e)).toList();
  }
}

// ============ GROUP_TEAM ============
class GroupTeamModel {
  final int? id;
  final String groupSyncId;
  final String teamSyncId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GroupTeamModel({
    this.id,
    required this.groupSyncId,
    required this.teamSyncId,
    this.createdAt,
    this.updatedAt,
  });

  GroupTeamModel copyWith({
    int? id,
    String? groupSyncId,
    String? teamSyncId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GroupTeamModel(
        id: id ?? this.id,
        groupSyncId: groupSyncId ?? this.groupSyncId,
        teamSyncId: teamSyncId ?? this.teamSyncId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GroupTeamModel.fromJson(Map<String, dynamic> j) => GroupTeamModel(
        id: j['id'] as int?,
        groupSyncId: (j['group_sync_id'] ?? j['groupSyncId'] ?? j['group_id'])
            as String,
        teamSyncId:
            (j['team_sync_id'] ?? j['teamSyncId'] ?? j['team_id']) as String,
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'group_sync_id': groupSyncId,
        'team_sync_id': teamSyncId,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      };

  GroupTeamCompanion toCompanionInsert() => GroupTeamCompanion.insert(
        syncId: const Uuid().v7(),
        groupSyncId: groupSyncId,
        teamSyncId: teamSyncId,
      );

  GroupTeamCompanion toCompanionUpdate() => GroupTeamCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        groupSyncId: Value(groupSyncId),
        teamSyncId: Value(teamSyncId),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
        updatedAt: updatedAt != null ? Value(updatedAt!) : const Value.absent(),
      );

  static GroupTeamModel fromEntity(GroupTeamData e) => GroupTeamModel(
        id: e.id,
        groupSyncId: e.groupSyncId,
        teamSyncId: e.teamSyncId,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );
}

// ============ QUALIFIED_TEAM ============
class QualifiedTeamModel {
  final int? id;
  final String? syncId;
  final String leagueSyncId;
  final String groupSyncId;
  final String teamSyncId;

  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String? qualificationType;
  final String? teamName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QualifiedTeamModel({
    this.id,
    this.syncId,
    required this.leagueSyncId,
    required this.groupSyncId,
    required this.teamSyncId,
    this.played = 0,
    this.wins = 0,
    this.draws = 0,
    this.losses = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
    this.points = 0,
    this.qualificationType,
    this.teamName,
    this.createdAt,
    this.updatedAt,
  });

  QualifiedTeamModel copyWith({
    int? id,
    String? syncId,
    String? leagueSyncId,
    String? groupSyncId,
    String? teamSyncId,
    int? played,
    int? wins,
    int? draws,
    int? losses,
    int? goalsFor,
    int? goalsAgainst,
    int? points,
    String? qualificationType,
    String? teamName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => QualifiedTeamModel(
        id: id ?? this.id,
        syncId: syncId??this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        groupSyncId: groupSyncId ?? this.groupSyncId,
        teamSyncId: teamSyncId ?? this.teamSyncId,
        played: played ?? this.played,
        wins: wins ?? this.wins,
        draws: draws ?? this.draws,
        losses: losses ?? this.losses,
        goalsFor: goalsFor ?? this.goalsFor,
        goalsAgainst: goalsAgainst ?? this.goalsAgainst,
        points: points ?? this.points,
        qualificationType: qualificationType ?? this.qualificationType,
        teamName: teamName ?? this.teamName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory QualifiedTeamModel.fromJson(Map<String, dynamic> j) =>
      QualifiedTeamModel(
        id: j['id'] as int?,
        syncId: j['sync_id'],
        leagueSyncId: ( j['league_sync_id']) as String,
        groupSyncId: ( j['group_sync_id'] )
            as String,
        teamSyncId:
            ( j['team_sync_id']) as String,
        played: (j['played'] ?? 0) as int,
        wins: (j['wins'] ?? 0) as int,
        draws: (j['draws'] ?? 0) as int,
        losses: (j['losses'] ?? 0) as int,
        goalsFor: (j['goals_for'] ?? j['goalsFor'] ?? 0) as int,
        goalsAgainst: (j['goals_against'] ?? j['goalsAgainst'] ?? 0) as int,
        points: (j['points'] ?? 0) as int,
        qualificationType: (j['qualification_type'] ?? j['qualificationType'])
            as String?,
        teamName: (j['team_name'] ?? j['teamName']) as String?,
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
    'sync_id':syncId,
        'league_sync_id': leagueSyncId,
        'group_sync_id': groupSyncId,
        'team_sync_id': teamSyncId,
        'played': played,
        'wins': wins,
        'draws': draws,
        'losses': losses,
        'goals_for': goalsFor,
        'goals_against': goalsAgainst,
        'points': points,
        if (qualificationType != null) 'qualification_type': qualificationType,
        if (teamName != null) 'team_name': teamName,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      };

  QualifiedTeamCompanion toCompanionInsert() => QualifiedTeamCompanion.insert(
        syncId: const Uuid().v7(),
        leagueSyncId: leagueSyncId,
        groupSyncId: groupSyncId,
        teamSyncId: teamSyncId,
      );

  QualifiedTeamCompanion toCompanionUpdate() => QualifiedTeamCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        leagueSyncId: Value(leagueSyncId),
        groupSyncId: Value(groupSyncId),
        teamSyncId: Value(teamSyncId),
        played: Value(played),
        wins: Value(wins),
        draws: Value(draws),
        losses: Value(losses),
        goalsFor: Value(goalsFor),
        goalsAgainst: Value(goalsAgainst),
        points: Value(points),
        qualificationType: Value(qualificationType),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
        updatedAt: updatedAt != null ? Value(updatedAt!) : const Value.absent(),
      );

  static QualifiedTeamModel fromEntity(QualifiedTeamData e) => QualifiedTeamModel(
        id: e.id,
        syncId: e.syncId,
        leagueSyncId: e.leagueSyncId,
        groupSyncId: e.groupSyncId,
        teamSyncId: e.teamSyncId,
        played: e.played,
        wins: e.wins,
        draws: e.draws,
        losses: e.losses,
        goalsFor: e.goalsFor,
        goalsAgainst: e.goalsAgainst,
        points: e.points,
        qualificationType: e.qualificationType,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,

      );

  QualifiedTeamModel withTeamName(String? name) => copyWith(teamName: name);
}

// ======= helpers =======
DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}
