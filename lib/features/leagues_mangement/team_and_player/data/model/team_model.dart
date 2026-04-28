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
     List<PlayerModel>?player

  }) => TeamModel(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueId: leagueId ?? this.leagueId,
        teamName: teamName ?? this.teamName,
        logoUrl: logoUrl ?? this.logoUrl,
        status: status ?? this.status,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
    player: player??this.player
      );

  static String? _readLogoUrl(Map<String, dynamic> j) {
    final raw = j['logo_url'] ?? j['logo_path'] ?? j['logo'];
    if (raw == null) return null;

    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      final nested = map['url'] ?? map['path'] ?? map['logo_url'] ?? map['logo_path'];
      final value = nested?.toString().trim();
      return (value == null || value.isEmpty) ? null : value;
    }

    final value = raw.toString().trim();
    return value.isEmpty ? null : value;
  }

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
        logoUrl: _readLogoUrl(j),
        status: (j['status'] ?? '').toString(),
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
  final String? teamName; // اسم الفريق (للعرض فقط، غير مخزن في قاعدة البيانات)
  final String? syncId;

  PlayerModel({
    this.id,
    this.playerLeagueSyncId,
    this.teamSyncId,
    this.fullName,
    this.position,
    this.teamName,
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
    String? teamName,
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
      teamName: teamName ?? this.teamName,
    );
  }

  // -------- JSON (API / local cache) ----------
  factory PlayerModel.fromJson(Map<String, dynamic> j) {
    final playerLeagueSyncId =
        (j['player_league_sync_id'] ??
                j['league_player_sync_id'] ??
                j['leaguePlayerSyncId'] ??
                '')
            .toString()
            .trim();
    final rawSyncId = (j['sync_id'] ?? j['syncId'])?.toString().trim();
    final dynamic teamRaw = j['team'];
    String? parsedTeamName;

    if (teamRaw is Map) {
      final map = Map<String, dynamic>.from(teamRaw);
      parsedTeamName = map['team_name']?.toString();
    }

    parsedTeamName ??= j['team_name']?.toString();
    parsedTeamName ??= j['teamName']?.toString();

    // أحياناً يرجع team كسلسلة أو قيمة أخرى
    if (parsedTeamName == null && teamRaw is String && teamRaw.isNotEmpty) {
      parsedTeamName = teamRaw;
    }

    return PlayerModel(
      id: j['id'] as int?,
      playerLeagueSyncId:
          playerLeagueSyncId.isEmpty ? null : playerLeagueSyncId,
      syncId: (rawSyncId != null && rawSyncId.isNotEmpty)
          ? rawSyncId
          : (playerLeagueSyncId.isNotEmpty
              ? 'league-player:$playerLeagueSyncId'
              : null),
      teamSyncId: (j['team_sync_id'] ?? '').toString(),
      fullName: (j['full_name'] ?? j['fullName'] ?? j['name'])?.toString(),
      position: j['position'] as String?,
      status: (j['status'] ?? 'main') as String,
      createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
      updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
      teamName: parsedTeamName,
    );
  }

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

/// ================= PLAYER STATS (API) =================
/// عنصر واحد داخل top_scorer/top_assist/... => { count: x, player: {...} }
class PlayerStatItemModel {
  final int count;
  final PlayerModel player;

  const PlayerStatItemModel({required this.count, required this.player});

  factory PlayerStatItemModel.fromJson(Map<String, dynamic> j) {
    return PlayerStatItemModel(
      count: (j['count'] is num) ? (j['count'] as num).toInt() : int.tryParse('${j['count']}') ?? 0,
      player: PlayerModel.fromJson(Map<String, dynamic>.from(j['player'] as Map)),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'player': player.toJson(),
      };

  static List<PlayerStatItemModel> fromJsonList(dynamic v) {
    final list = (v as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => PlayerStatItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}

/// غلاف كل الإحصائيات كما يرجعها الـ API
class LeaguePlayerStatsModel {
  final List<PlayerStatItemModel> topScorer;
  final List<PlayerStatItemModel> topAssist;
  final List<PlayerStatItemModel> topContributor;
  final List<PlayerStatItemModel> topYellowCards;
  final List<PlayerStatItemModel> topRedCards;

  const LeaguePlayerStatsModel({
    this.topScorer = const [],
    this.topAssist = const [],
    this.topContributor = const [],
    this.topYellowCards = const [],
    this.topRedCards = const [],
  });

  factory LeaguePlayerStatsModel.fromJson(Map<String, dynamic> j) {
    return LeaguePlayerStatsModel(
      topScorer: PlayerStatItemModel.fromJsonList(j['top_scorer'] ?? j['topScorer']),
      topAssist: PlayerStatItemModel.fromJsonList(j['top_assist'] ?? j['topAssist']),
      topContributor: PlayerStatItemModel.fromJsonList(j['top_contributor'] ?? j['topContributor']),
      topYellowCards: PlayerStatItemModel.fromJsonList(j['top_yellow_cards'] ?? j['topYellowCards']),
      topRedCards: PlayerStatItemModel.fromJsonList(j['top_red_cards'] ?? j['topRedCards']),
    );
  }

  Map<String, dynamic> toJson() => {
        'top_scorer': topScorer.map((e) => e.toJson()).toList(),
        'top_assist': topAssist.map((e) => e.toJson()).toList(),
        'top_contributor': topContributor.map((e) => e.toJson()).toList(),
        'top_yellow_cards': topYellowCards.map((e) => e.toJson()).toList(),
        'top_red_cards': topRedCards.map((e) => e.toJson()).toList(),
      };
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
