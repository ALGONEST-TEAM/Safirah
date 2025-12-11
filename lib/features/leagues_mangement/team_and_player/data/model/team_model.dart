import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';

class TeamModel {
  final int? id;
  final int leagueId;
  final String teamName;
  final String? logoUrl;
  final String status;

  TeamModel({
    this.id,
    required this.leagueId,
    required this.teamName,
    this.logoUrl,
    this.status = 'placeholder',
  });

  TeamModel copyWith({
    int? id,
    int? leagueId,
    String? teamName,
    String? logoUrl,
    String? status,
  }) => TeamModel(
    id: id ?? this.id,
    leagueId: leagueId ?? this.leagueId,
    teamName: teamName ?? this.teamName,
    logoUrl: logoUrl ?? this.logoUrl,
    status: status ?? this.status,
  );

  // API JSON
  factory TeamModel.fromJson(Map<String, dynamic> j) => TeamModel(
    id: j['id'],
    leagueId: j['league_id'] ?? j['leagueId'],
    teamName: j['team_name'] ?? j['name'] ?? '',
    logoUrl: j['logo_url'] ?? j['logoUrl'],
    status: j['status'] ?? 'placeholder',
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'league_id': leagueId,
    'team_name': teamName,
    if (logoUrl != null) 'logo_url': logoUrl,
    'status': status,
  };

  // Drift
  TeamsCompanion toCompanion() => TeamsCompanion.insert(
    leagueId: leagueId,
    teamName: teamName,
    logoUrl: logoUrl != null ? Value(logoUrl!) : const Value.absent(),
    status: Value(status),
  );

  static TeamModel fromEntity(Team e) => TeamModel(
    id: e.id,
    leagueId: e.leagueId,
    teamName: e.teamName,
    logoUrl: e.logoUrl,
    status: e.status,
  );
}

/// ================= PLAYER =================

class PlayerModel {
  final int? id;
  final int playerLeagueId;     // FK -> LeaguePlayers.id
  final int? teamId;            // FK -> Teams.id (nullable)
  final String fullName;
  final String? position;       // GK|DF|MF|FW (nullable)
  final String status;          // main | sub (إلخ)
  final DateTime? createdAt;    // اختياري للقراءة/العرض
  final DateTime? updatedAt;    // اختياري للقراءة/العرض

  const PlayerModel({
    this.id,
    required this.playerLeagueId,
    this.teamId,
    required this.fullName,
    this.position,
    this.status = 'main',
    this.createdAt,
    this.updatedAt,
  });

  PlayerModel copyWith({
    int? id,
    int? playerLeagueId,
    int? teamId,
    String? fullName,
    String? position,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      playerLeagueId: playerLeagueId ?? this.playerLeagueId,
      teamId: teamId ?? this.teamId,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // -------- JSON (API / local cache) ----------
  factory PlayerModel.fromJson(Map<String, dynamic> j) => PlayerModel(
        id: j['id'] as int?,
        playerLeagueId:
            (j['player_league_id'] ?? j['playerLeagueId']) as int,
        teamId: (j['team_id'] ?? j['teamId']) as int?,
        fullName:
            (j['full_name'] ?? j['fullName'] ?? j['name']) as String,
        position: j['position'] as String?,
        status: (j['status'] ?? 'main') as String,
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'player_league_id': playerLeagueId,
        'team_id': teamId,
        'full_name': fullName,
        if (position != null) 'position': position,
        'status': status,
        if (createdAt != null)
          'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null)
          'updated_at': updatedAt!.toIso8601String(),
      };

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
    return null;
  }

  // -------- Drift mapping ----------
  PlayersCompanion toCompanionInsert() => PlayersCompanion.insert(
        playerLeagueId: playerLeagueId,
        fullName: fullName,
        teamId: teamId != null ? Value(teamId!) : const Value.absent(),
        position:
            position != null ? Value(position!) : const Value.absent(),
        status: Value(status),
      );

  PlayersCompanion toCompanionUpdate() => PlayersCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        playerLeagueId: Value(playerLeagueId),
        teamId: teamId != null ? Value(teamId!) : const Value.absent(),
        fullName: Value(fullName),
        position:
            position != null ? Value(position!) : const Value.absent(),
        status: Value(status),
        createdAt:
            createdAt != null ? Value(createdAt!) : const Value.absent(),
        updatedAt:
            updatedAt != null ? Value(updatedAt!) : const Value.absent(),
      );

  static PlayerModel fromEntity(Player e) => PlayerModel(
        id: e.id,
        playerLeagueId: e.playerLeagueId,
        teamId: e.teamId,
        fullName: e.fullName,
        position: e.position,
        status: e.status,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );
}


/// ============ TEAM PLAYER CATEGORY ============
// أعد تسمية idLeague -> leagueId لتطابق الجدول TeamPlayerCategories.league_id
class TeamPlayerCategoryModel {
  final int? id;
  final String name;
  final int leagueId;

  TeamPlayerCategoryModel({
    this.id,
    required this.name,
    required this.leagueId,
  });

  TeamPlayerCategoryModel copyWith({
    int? id,
    String? name,
    int? leagueId,
  }) => TeamPlayerCategoryModel(
    id: id ?? this.id,
    name: name ?? this.name,
    leagueId: leagueId ?? this.leagueId,
  );

  // API JSON
  factory TeamPlayerCategoryModel.fromJson(Map<String, dynamic> j) =>
      TeamPlayerCategoryModel(
        id: j['id'],
        name: j['name'] ?? '',
        leagueId: j['league_id'] ?? j['leagueId'],
      );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'name': name,
    'league_id': leagueId,
  };

  // Drift
  TeamPlayerCategoriesCompanion toCompanion() =>
      TeamPlayerCategoriesCompanion.insert(
        name: name,
        leagueId: leagueId,
      );

  static TeamPlayerCategoryModel fromEntity(TeamPlayerCategory e) =>
      TeamPlayerCategoryModel(
        id: e.id,
        name: e.name,
        leagueId: e.leagueId,
      );
}

/// =============== LEAGUE PLAYER =================
class LeaguePlayerModel {
  final int? id;
  final int leagueId;
  final int userId;
   int? teamPlayerCategoryId;

  LeaguePlayerModel({
    this.id,
    required this.leagueId,
    required this.userId,
     this.teamPlayerCategoryId,
  });

  LeaguePlayerModel copyWith({
    int? id,
    int? leagueId,
    int? userId,
    int? teamPlayerCategoryId,
  }) => LeaguePlayerModel(
    id: id ?? this.id,
    leagueId: leagueId ?? this.leagueId,
    userId: userId ?? this.userId,
    teamPlayerCategoryId: teamPlayerCategoryId ?? this.teamPlayerCategoryId,
  );

  // API JSON
  factory LeaguePlayerModel.fromJson(Map<String, dynamic> j) => LeaguePlayerModel(
    id: j['id'],
    leagueId: j['league_id'] ?? j['leagueId'],
    // دعم user_id و userId
    userId: j['user_id'] ?? j['userId'],
    teamPlayerCategoryId: j['team_player_category_id'] ?? j['teamPlayerCategoryId'],
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'league_id': leagueId,
    'user_id': userId,
    'team_player_category_id': teamPlayerCategoryId,
  };

  // Drift
  LeaguePlayersCompanion toCompanionInsert() => LeaguePlayersCompanion.insert(
    leagueId: leagueId,
    userId: userId,
    teamPlayerCategoryId: teamPlayerCategoryId != null
        ? Value(teamPlayerCategoryId!)
        : const Value.absent(),  );

  LeaguePlayersCompanion toCompanionUpdate() => LeaguePlayersCompanion(
    leagueId: Value(leagueId),
    userId: Value(userId),
    teamPlayerCategoryId: Value(teamPlayerCategoryId!),
  );

  static LeaguePlayerModel fromEntity(LeaguePlayer e) => LeaguePlayerModel(
    id: e.id,
    leagueId: e.leagueId,
    teamPlayerCategoryId: e.teamPlayerCategoryId,
    userId: e.userId,
  );
}
