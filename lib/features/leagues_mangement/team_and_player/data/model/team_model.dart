import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';

class TeamModel {
  final int? id;
  final String syncId;
  final int? leagueId;
  final String? leagueSyncId;
  final String teamName;
  final String? logoUrl;
  final String status;
  final List<PlayerModel>?player;
  TeamModel({
    this.id,
    String? syncId,
    this.leagueId,
    required this.teamName,
    this.logoUrl,
    this.leagueSyncId,
    this.status = 'placeholder',
    this.player
  }) : syncId = syncId ?? const Uuid().v4();

  TeamModel copyWith({
    int? id,
    String? syncId,
    int? leagueId,
    String? teamName,
    String? logoUrl,
    String? status,
    String? leagueSyncId,
  }) => TeamModel(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueId: leagueId ?? this.leagueId,
        teamName: teamName ?? this.teamName,
        logoUrl: logoUrl ?? this.logoUrl,
        status: status ?? this.status,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      );

  // API JSON
  factory TeamModel.fromJson(Map<String, dynamic> j) =>
      TeamModel(
        syncId: j['sync_id'] ?? j['syncId'],
      //  leagueSyncId: j['league_sync_id'] ?? j['leagueId']??'',
        teamName: j['team_name'] ?? j['name'] ?? '',
       player:  j['players'] != null
           ? (j['players'] as List)
           .map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
           .toList()
           : [],
       // logoUrl: j['logo_url'] ??'',
       // status: j['status'] ??'',
      );

  Map<String, dynamic> toJson() =>
      {
        'sync_id': syncId,
        'team_name': teamName,
        if (logoUrl != null) 'logo_url': logoUrl,
        'status': status,
      };

  // Drift
  TeamsCompanion toCompanion() =>
      TeamsCompanion.insert(
        syncId: syncId,
        teamName: teamName,
        logoUrl: logoUrl != null ? Value(logoUrl!) : const Value.absent(),
        status: Value(status),
        leagueSyncId: leagueSyncId!,
      );

  static TeamModel fromEntity(Team e) =>
      TeamModel(
        id: e.id,
        syncId: e.syncId,
        leagueSyncId: e.leagueSyncId,
        teamName: e.teamName,
        logoUrl: e.logoUrl,
        status: e.status,
      );

  static List<TeamModel> fromJsonList(List json) {
    return json.map((e) => TeamModel.fromJson(e)).toList();
  }
}
/// ================= PLAYER =================

class PlayerModel {
  final int? id;
  final String? playerLeagueSyncId; // FK -> LeaguePlayers.id
  final String? teamSyncId; // FK -> Teams.id (nullable)
  final String? fullName;
  final String? position; // GK|DF|MF|FW (nullable)
  final String status; // main | sub (إلخ)
  final DateTime? createdAt; // اختياري للقراءة/العرض
  final DateTime? updatedAt; // اختياري للقراءة/العرض

  final String? syncId;

  PlayerModel({
    this.id,
    this.playerLeagueSyncId,
    this.teamSyncId,
     this.fullName,
    this.position,
    this.status = 'main',
    String? syncId,
    this.createdAt,
    this.updatedAt,
  }) : syncId = syncId ?? const Uuid().v4();

  PlayerModel copyWith({
    int? id,
    String? playersLeagueId,
    String? teamSyncId,
    String? syncId,
    String? fullName,
    String? position,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      playerLeagueSyncId: playersLeagueId ?? this.playerLeagueSyncId,
      teamSyncId: teamSyncId ?? this.teamSyncId,
      syncId: syncId ?? this.syncId,
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
        playerLeagueSyncId: (j['player_league_id'] ?? j['playerLeagueId']),
        teamSyncId: (j['team_id'] ?? j['teamId']),
        fullName: (j['full_name'] ?? j['fullName'] ?? j['name']),
        position: j['position'] as String?,
        status: (j['status'] ?? 'main') as String,
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
    'sync_id':syncId,
        'league_player_sync_id': playerLeagueSyncId??'',
        'team_sync_id': teamSyncId,
        'full_name': fullName??'',
        'status': status,
        if (position != null) 'position': position,
      };

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
    return null;
  }

  // -------- Drift mapping ----------
  PlayersCompanion toCompanionInsert() => PlayersCompanion.insert(
        playerLeagueSyncId: playerLeagueSyncId!,
        fullName: fullName!,
        teamSyncId: teamSyncId!,
        position: position != null ? Value(position!) : const Value.absent(),
        status: Value(status),
        syncId: syncId!,
      );

  PlayersCompanion toCompanionUpdate() => PlayersCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        playerLeagueSyncId: Value(playerLeagueSyncId!),
        teamSyncId:
            teamSyncId != null ? Value(teamSyncId!) : const Value.absent(),
        fullName: Value(fullName??''),
        position: position != null ? Value(position!) : const Value.absent(),
        status: Value(status),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
        updatedAt: updatedAt != null ? Value(updatedAt!) : const Value.absent(),
      );

  static PlayerModel fromEntity(Player e) => PlayerModel(
        id: e.id,
        playerLeagueSyncId: e.playerLeagueSyncId,
        teamSyncId: e.teamSyncId,
        fullName: e.fullName,
        position: e.position,
        status: e.status,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
        syncId: e.syncId,
      );
}

/// ============ TEAM PLAYER CATEGORY ============
// أع�� تسمية idLeague -> leagueId لتطابق الجدول TeamPlayerCategories.league_id
class TeamPlayerCategoryModel {
  final int? id;
  final String syncId;
  final String name;
  final int? leagueId;
  final String? leagueSyncId;

  TeamPlayerCategoryModel({
    this.id,
    String? syncId,
    required this.name,
    this.leagueSyncId,
    this.leagueId,
  }) : syncId = syncId ?? const Uuid().v4();

  TeamPlayerCategoryModel copyWith({
    int? id,
    String? syncId,
    String? name,
    int? leagueId,
    String? leagueSyncId,
  }) =>
      TeamPlayerCategoryModel(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        name: name ?? this.name,
        leagueId: leagueId ?? this.leagueId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      );

  // API JSON
  factory TeamPlayerCategoryModel.fromJson(Map<String, dynamic> j) =>
      TeamPlayerCategoryModel(
        id: j['id'],
        syncId: j['sync_id'] ?? j['syncId'],
        name: j['name'] ?? '',
        leagueId: j['league_id'] ?? j['leagueId'],
      );

  Map<String, dynamic> toJson() => {
        'sync_id': syncId,
        'name': name,
      };

  // Drift
  TeamPlayerCategoriesCompanion toCompanion() =>
      TeamPlayerCategoriesCompanion.insert(
          syncId: syncId, name: name, leagueSyncId: leagueSyncId!);

  static TeamPlayerCategoryModel fromEntity(TeamPlayerCategory e) =>
      TeamPlayerCategoryModel(
        id: e.id,
        syncId: e.syncId,
        name: e.name,
      );
}

/// =============== LEAGUE PLAYER =================
class LeaguePlayerModel {
  final int? id;
  final int? idInvitation;
  final String syncId;
  final String? leagueSyncId;

  final String? name;
  final String? code;

  int? teamPlayerCategoryId;

  LeaguePlayerModel(
      {this.id,
      this.idInvitation,
      String? syncId,
      this.teamPlayerCategoryId,
      this.name,
      this.leagueSyncId,
      this.code})
      : syncId = syncId ?? const Uuid().v4();

  LeaguePlayerModel copyWith({
    int? id,
    int? idInvitation,
    String? syncId,
    int? leagueId,
    int? userId,
    String? leagueSyncId,
    int? teamPlayerCategoryId,
    String? name,
    String? code,
  }) =>
      LeaguePlayerModel(
        id: id ?? this.id,
        idInvitation: idInvitation ?? this.idInvitation,
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        teamPlayerCategoryId: teamPlayerCategoryId ?? this.teamPlayerCategoryId,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory LeaguePlayerModel.fromJson(Map<String, dynamic> j) {
    final dynamic user = j['user'];
    final String? userName =
        user is Map<String, dynamic> ? user['name']?.toString() : null;

    final String? fallbackName = (j['name'] ??
            j['user_name'] ??
            j['username'] ??
            j['full_name'])
        ?.toString();

    return LeaguePlayerModel(
      id: j['id'],
      syncId: j['sync_id'] ?? j['sync_Id'],
      name: userName ?? fallbackName,
      teamPlayerCategoryId:
          j['team_player_category_id'] ?? j['teamPlayerCategoryId'],
      code: j['code']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'sync_id': syncId,
        'team_player_category_id': teamPlayerCategoryId,
      };

  static List<LeaguePlayerModel> fromJsonLeaguePlayerList(List json) {
    return json.map((e) => LeaguePlayerModel.fromJson(e)).toList();
  }

  static LeaguePlayerModel fromEntity(LeaguePlayer e) => LeaguePlayerModel(
        id: e.id,
        syncId: e.syncId,
        name: e.name,
        leagueSyncId: e.leagueSyncId,
        teamPlayerCategoryId: e.teamPlayerCategoryId,
      );
}

class InvitationsPlayersModel {
  final int? id;
  final String? action;
  final String? userName;
  final String? code;
  final String? leagueSyncId;

  InvitationsPlayersModel(
      {this.id, this.userName, this.code, this.action, this.leagueSyncId});

  InvitationsPlayersModel copyWith({int? id, String? userName}) =>
      InvitationsPlayersModel(
        id: id ?? this.id,
        userName: userName ?? this.userName,
      );

  factory InvitationsPlayersModel.fromJson(Map<String, dynamic> j) =>
      InvitationsPlayersModel(
        id: j['invitation_id'],
        userName: j['user_name'],
      );

  static List<InvitationsPlayersModel> fromJsonInvitationsPlayersList(
      List json) {
    return json.map((e) => InvitationsPlayersModel.fromJson(e)).toList();
  }
}
