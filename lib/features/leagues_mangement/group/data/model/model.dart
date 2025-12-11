import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

import '../../../match/data/model/match_model.dart'; // 👈 لاستدعاء MatchModel

class GroupModel {
  final int? id;
  final int leagueId;
  final String groupName;
  final DateTime? createdAt;
  final int qualifiedTeamNumber;

  /// ✅ قائمة المباريات التابعة للمجموعة
  final List<MatchModel> matches;

  const GroupModel({
    this.id,
    required this.leagueId,
    required this.groupName,
    this.createdAt,
    required  this.qualifiedTeamNumber,
    this.matches = const [], // افتراضيًا فارغة
  });

  GroupModel copyWith({
    int? id,
    int? leagueId,
    String? groupName,
    DateTime? createdAt,
    List<MatchModel>? matches,
    int? qualifiedTeamNumber,
  }) =>
      GroupModel(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        groupName: groupName ?? this.groupName,
        createdAt: createdAt ?? this.createdAt,
        matches: matches ?? this.matches,
        qualifiedTeamNumber: qualifiedTeamNumber ?? this.qualifiedTeamNumber,
      );

  factory GroupModel.fromJson(Map<String, dynamic> j) => GroupModel(
    id: j['id'] as int?,
    leagueId: (j['league_id'] ?? j['leagueId']) as int,
    groupName: (j['group_name'] ?? j['groupName'] ?? j['name']) as String,
    createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
    matches: (j['matches'] as List<dynamic>?)
        ?.map((x) => MatchModel.fromJson(x as Map<String, dynamic>))
        .toList() ??
        [],
    qualifiedTeamNumber: (j['qualified_team_number'] ?? j['qualifiedTeamNumber'] ?? 0) as int,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'league_id': leagueId,
    'group_name': groupName,
    if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    if (matches.isNotEmpty)
      'matches': matches.map((m) => m.toJson()).toList(),
  };

  GroupCompanion toCompanionInsert() => GroupCompanion.insert(
    leagueId: leagueId,
    groupName: groupName,
  );

  GroupCompanion toCompanionUpdate() => GroupCompanion(
    id: id != null ? Value(id!) : const Value.absent(),
    leagueId: Value(leagueId),
    qualifiedTeamNumber: Value(qualifiedTeamNumber),
    groupName: Value(groupName),

    createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
  );

  static GroupModel fromEntity(GroupData e) => GroupModel(
    id: e.id,
    leagueId: e.leagueId,
    groupName: e.groupName,
    createdAt: e.createdAt,
    qualifiedTeamNumber: e.qualifiedTeamNumber,
  );

  /// 🔥 دالة مخصصة لربط المجموعة مع مبارياتها (بعد الجلب من DB)
  GroupModel withMatches(List<MatchModel> matches) =>
      copyWith(matches: matches);
}

// ============ GROUP_TEAM ============
class GroupTeamModel {
  final int? id;
  final int groupId;
  final int teamId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GroupTeamModel({
    this.id,
    required this.groupId,
    required this.teamId,
    this.createdAt,
    this.updatedAt,
  });

  GroupTeamModel copyWith({
    int? id,
    int? groupId,
    int? teamId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GroupTeamModel(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        teamId: teamId ?? this.teamId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GroupTeamModel.fromJson(Map<String, dynamic> j) => GroupTeamModel(
        id: j['id'] as int?,
        groupId: (j['group_id'] ?? j['groupId']) as int,
        teamId: (j['team_id'] ?? j['teamId']) as int,
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'group_id': groupId,
        'team_id': teamId,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      };

  GroupTeamCompanion toCompanionInsert() => GroupTeamCompanion.insert(
        groupId: groupId,
        teamId: teamId,
      );

  GroupTeamCompanion toCompanionUpdate() => GroupTeamCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        groupId: Value(groupId),
        teamId: Value(teamId),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
        updatedAt: updatedAt != null ? Value(updatedAt!) : const Value.absent(),
      );

  static GroupTeamModel fromEntity(GroupTeamData e) => GroupTeamModel(
        id: e.id,
        groupId: e.groupId,
        teamId: e.teamId,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );
}

// ============ QUALIFIED_TEAM ============
class QualifiedTeamModel {
  final int? id;
  final int leagueId;
  final int groupId;
  final int teamId;

  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String? qualificationType;

  // اسم الفريق — غير مُخزَّن في DB
  final String? teamName;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QualifiedTeamModel({
    this.id,
    required this.leagueId,
    required this.groupId,
    required this.teamId,
    this.played = 0,
    this.wins = 0,
    this.draws = 0,
    this.losses = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
    this.points = 0,
    this.qualificationType,
    this.teamName, // جديد
    this.createdAt,
    this.updatedAt,
  });

  QualifiedTeamModel copyWith({
    int? id, int? leagueId, int? groupId, int? teamId,
    int? played, int? wins, int? draws, int? losses,
    int? goalsFor, int? goalsAgainst, int? points,
    String? qualificationType,
    String? teamName, // جديد
    DateTime? createdAt, DateTime? updatedAt,
  }) => QualifiedTeamModel(
    id: id ?? this.id,
    leagueId: leagueId ?? this.leagueId,
    groupId: groupId ?? this.groupId,
    teamId: teamId ?? this.teamId,
    played: played ?? this.played,
    wins: wins ?? this.wins,
    draws: draws ?? this.draws,
    losses: losses ?? this.losses,
    goalsFor: goalsFor ?? this.goalsFor,
    goalsAgainst: goalsAgainst ?? this.goalsAgainst,
    points: points ?? this.points,
    qualificationType: qualificationType ?? this.qualificationType,
    teamName: teamName ?? this.teamName, // جديد
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  // للاستخدام مع JSON إن رغبت عرض الاسم فقط (لن يُستخدم في DB)
  factory QualifiedTeamModel.fromJson(Map<String,dynamic> j) => QualifiedTeamModel(
    id: j['id'] as int?,
    leagueId: (j['league_id'] ?? j['leagueId']) as int,
    groupId: (j['group_id'] ?? j['groupId']) as int,
    teamId: (j['team_id'] ?? j['teamId']) as int,
    played: (j['played'] ?? 0) as int,
    wins: (j['wins'] ?? 0) as int,
    draws: (j['draws'] ?? 0) as int,
    losses: (j['losses'] ?? 0) as int,
    goalsFor: (j['goals_for'] ?? j['goalsFor'] ?? 0) as int,
    goalsAgainst: (j['goals_against'] ?? j['goalsAgainst'] ?? 0) as int,
    points: (j['points'] ?? 0) as int,
    qualificationType: j['qualification_type'] ?? j['qualificationType'],
    teamName: j['team_name'] ?? j['teamName'], // جديد
    createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
    updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
  );

  Map<String,dynamic> toJson() => {
    if (id!=null) 'id': id,
    'league_id': leagueId,
    'group_id': groupId,
    'team_id': teamId,
    'played': played,
    'wins': wins,
    'draws': draws,
    'losses': losses,
    'goals_for': goalsFor,
    'goals_against': goalsAgainst,
    'points': points,
    if (qualificationType!=null) 'qualification_type': qualificationType,
    if (teamName!=null) 'team_name': teamName, // للعرض فقط
    if (createdAt!=null) 'created_at': createdAt!.toIso8601String(),
    if (updatedAt!=null) 'updated_at': updatedAt!.toIso8601String(),
  };

  // لا تغييرات على الـ Companion: لا نمرر teamName لأنه غير موجود في الجدول
  QualifiedTeamCompanion toCompanionInsert() => QualifiedTeamCompanion.insert(
    leagueId: leagueId,
    groupId: groupId,
    teamId: teamId,
    played: Value(played),
    wins: Value(wins),
    draws: Value(draws),
    losses: Value(losses),
    goalsFor: Value(goalsFor),
    goalsAgainst: Value(goalsAgainst),
    points: Value(points),
    qualificationType: qualificationType!=null ? Value(qualificationType!) : const Value.absent(),
  );

  QualifiedTeamCompanion toCompanionUpdate() => QualifiedTeamCompanion(
    id: id!=null ? Value(id!) : const Value.absent(),
    leagueId: Value(leagueId),
    groupId: Value(groupId),
    teamId: Value(teamId),
    played: Value(played),
    wins: Value(wins),
    draws: Value(draws),
    losses: Value(losses),
    goalsFor: Value(goalsFor),
    goalsAgainst: Value(goalsAgainst),
    points: Value(points),
    qualificationType: qualificationType!=null ? Value(qualificationType!) : const Value.absent(),
    createdAt: createdAt!=null ? Value(createdAt!) : const Value.absent(),
    updatedAt: updatedAt!=null ? Value(updatedAt!) : const Value.absent(),
  );

  static QualifiedTeamModel fromEntity(QualifiedTeamData e)=> QualifiedTeamModel(
    id: e.id,
    leagueId: e.leagueId,
    groupId: e.groupId,
    teamId: e.teamId,
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

  // مُساعد سريع لإلحاق الاسم بعد الجلب من DB
  QualifiedTeamModel withTeamName(String? name) => copyWith(teamName: name);
}

// ======= helpers =======
DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}

