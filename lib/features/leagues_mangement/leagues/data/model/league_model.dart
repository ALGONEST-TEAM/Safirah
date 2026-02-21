// import 'package:drift/drift.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../../../../core/database/safirah_database.dart';
// import '../../../team_and_player/data/model/team_model.dart';
//
// class LeagueModel {
//   final int? id;
//   final String syncId;
//   final String? name;
//   final String? type;
//   final int? organizerId;
//   final String? scope;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final int? maxTeams;
//   final int? maxMainPlayers;
//   final int? maxSubPlayers;
//   final bool isPrivate;
//   final String status;
//   final String? subscriptionPrice;
//   final String? logoPath;
//
//   LeagueModel({
//     this.id,
//     String? syncId,
//     this.name,
//     this.type,
//     this.organizerId,
//     this.scope,
//     this.startDate,
//     this.endDate,
//     this.maxTeams,
//     this.maxMainPlayers,
//     this.maxSubPlayers,
//     this.isPrivate = false,
//     this.status = 'active',
//     this.subscriptionPrice,
//     this.logoPath,
//   }) : syncId = syncId ?? const Uuid().v4();
//
//   LeagueModel copyWith({
//
//     String? syncId,
//     String? name,
//     String? type,
//     int? organizerId,
//     String? scope,
//     DateTime? startDate,
//     DateTime? endDate,
//     int? maxTeams,
//     int? maxMainPlayers,
//     int? maxSubPlayers,
//     bool? isPrivate,
//     String? status,
//     String? subscriptionPrice,
//     String? logoPath,
//   }) {
//     return LeagueModel(
//
//       syncId: syncId ?? this.syncId,
//       name: name ?? this.name,
//       type: type ?? this.type,
//       organizerId: organizerId ?? this.organizerId,
//       scope: scope ?? this.scope,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       maxTeams: maxTeams ?? this.maxTeams,
//       maxMainPlayers: maxMainPlayers ?? this.maxMainPlayers,
//       maxSubPlayers: maxSubPlayers ?? this.maxSubPlayers,
//       isPrivate: isPrivate ?? this.isPrivate,
//       status: status ?? this.status,
//       subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
//       logoPath: logoPath ?? this.logoPath,
//     );
//   }
//
//   // ===== API JSON =====
//   factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
//         id: json['id'],
//         syncId: json['sync_id'] ?? json['syncId'],
//         name: json['league_name'] ?? json['name'] ?? '',
//         type: json['league_type'] ?? json['type'],
//         organizerId: json['organizer_id'],
//         scope: json['league_scope'] ?? json['scope'],
//         startDate: json['start_date'] != null
//             ? DateTime.tryParse(json['start_date'])
//             : null,
//         endDate: json['end_date'] != null
//             ? DateTime.tryParse(json['end_date'])
//             : null,
//         maxTeams: json['max_team'] ?? json['maxTeams'],
//         maxMainPlayers: json['max_main_player'] ?? json['maxMainPlayers'],
//         maxSubPlayers: json['max_sub_player'] ?? json['maxSubPlayers'],
//         isPrivate: json['is_private'] ?? json['isPrivate'] ?? false,
//         status: json['status'] ?? 'active',
//         subscriptionPrice: json['subscription_price'],
//         logoPath: json['logo_path'] ?? json['logoPath'],
//       );
//
//   Map<String, dynamic> toJson() => {
//         'sync_id': syncId,
//         'name': name,
//         if (type != null) 'type': type,
//         if (organizerId != null) 'organizer_id': organizerId,
//         if (scope != null) 'league_scope': scope,
//         if (startDate != null) 'start_date': startDate!.toIso8601String(),
//         if (endDate != null) 'end_date': endDate!.toIso8601String(),
//         if (maxTeams != null) 'max_teams': maxTeams,
//         if (maxMainPlayers != null) 'max_main_players': maxMainPlayers,
//         if (maxSubPlayers != null) 'max_sub_players': maxSubPlayers,
//         'is_private': isPrivate,
//         'status': status,
//         if (subscriptionPrice != null) 'subscription_price': subscriptionPrice,
//         if (logoPath != null) 'logo_path': logoPath,
//       };
//
//   // ===== Drift Mapping =====
//
//   static List<LeagueModel> fromJsonLeagueList(List json) {
//     return json.map((e) => LeagueModel.fromJson(e)).toList();
//   }
//
//     LeaguesCompanion toCompanionUpsert() => LeaguesCompanion(
//     syncId: Value(syncId),
//     name: Value(name ?? ''),
//     type: type != null ? Value(type!) : const Value.absent(),
//     organizerId: organizerId != null ? Value(organizerId!) : const Value.absent(),
//     scope: scope != null ? Value(scope!) : const Value.absent(),
//     startDate: startDate != null ? Value(startDate!) : const Value.absent(),
//     endDate: endDate != null ? Value(endDate!) : const Value.absent(),
//     maxTeams: maxTeams != null ? Value(maxTeams!) : const Value.absent(),
//     maxMainPlayers: maxMainPlayers != null ? Value(maxMainPlayers!) : const Value.absent(),
//     maxSubPlayers: maxSubPlayers != null ? Value(maxSubPlayers!) : const Value.absent(),
//     isPrivate: Value(isPrivate),
//     status: Value(status),
//     subscriptionPrice: Value(subscriptionPrice ?? ''),
//     logoPath: logoPath != null ? Value(logoPath!) : const Value.absent(),
//   );
//
//   LeaguesCompanion toCompanion() => LeaguesCompanion.insert(
//         syncId: syncId,
//
//         name: name ?? '',
//         type: type != null ? Value(type!) : const Value.absent(),
//         organizerId:
//             organizerId != null ? Value(organizerId!) : const Value.absent(),
//         scope: scope != null ? Value(scope!) : const Value.absent(),
//         startDate:
//             startDate != null ? Value(startDate!) : const Value.absent(),
//         endDate: endDate != null ? Value(endDate!) : const Value.absent(),
//         maxTeams: maxTeams != null ? Value(maxTeams!) : const Value.absent(),
//         maxMainPlayers: maxMainPlayers != null
//             ? Value(maxMainPlayers!)
//             : const Value.absent(),
//         maxSubPlayers: maxSubPlayers != null
//             ? Value(maxSubPlayers!)
//             : const Value.absent(),
//         isPrivate: Value(isPrivate),
//         status: Value(status),
//         subscriptionPrice: subscriptionPrice ?? '',
//         logoPath: logoPath != null ? Value(logoPath!) : const Value.absent(),
//       );
//
//   static LeagueModel fromEntity(League e) => LeagueModel(
//         id: e.id,
//         syncId: e.syncId,
//         name: e.name,
//         type: e.type,
//         organizerId: e.organizerId,
//         scope: e.scope,
//         startDate: e.startDate,
//         endDate: e.endDate,
//         maxTeams: e.maxTeams,
//         maxMainPlayers: e.maxMainPlayers,
//         maxSubPlayers: e.maxSubPlayers,
//         isPrivate: e.isPrivate,
//         status: e.status,
//         subscriptionPrice: e.subscriptionPrice,
//         logoPath: e.logoPath,
//       );
// }
// class LeagueBundleModel {
//   final LeagueModel league;
//   final List<TeamModel> teams;
//   final List<TeamPlayerCategoryModel> categories;
//
//   LeagueBundleModel({
//     required this.league,
//     required this.teams,
//     required this.categories,
//   });
//
//   factory LeagueBundleModel.fromJson(Map<String, dynamic> j) {
//     return LeagueBundleModel(
//       league: LeagueModel.fromJson(j['data'] as Map<String, dynamic>),
//       teams: (j['teams'] as List? ?? const [])
//           .map((e) => TeamModel.fromJson(Map<String, dynamic>.from(e)))
//           .toList(),
//       categories: (j['team_player_categories'] as List? ?? const [])
//           .map((e) => TeamPlayerCategoryModel.fromJson(Map<String, dynamic>.from(e)))
//           .toList(),
//     );
//   }
// }
// lib/features/league/data/model/league_model.dart
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';
import '../../../team_and_player/data/model/team_model.dart';

class LeagueModel {
  final int? id;
  final String syncId;

  final String? name;
  final String? type;
  final int? organizerId;
  final String? scope;

  final DateTime? startDate;
  final DateTime? endDate;

  final int? maxTeams;
  final int? maxMainPlayers;
  final int? maxSubPlayers;

  final bool isPrivate;
  final String status;

  final String? subscriptionPrice;

  /// Remote path/url from API
  final String? logoPath;

  /// Local persisted file path (Documents/images/...)
  /// Not coming from API; stored locally in DB
  final String? logoLocalPath;

  LeagueModel({
    this.id,
    String? syncId,
    this.name,
    this.type,
    this.organizerId,
    this.scope,
    this.startDate,
    this.endDate,
    this.maxTeams,
    this.maxMainPlayers,
    this.maxSubPlayers,
    this.isPrivate = false,
    this.status = 'active',
    this.subscriptionPrice,
    this.logoPath,
    this.logoLocalPath,
  }) : syncId = (syncId != null && syncId.trim().isNotEmpty)
      ? syncId.trim()
      : const Uuid().v4();

  LeagueModel copyWith({
    int? id,
    String? syncId,
    String? name,
    String? type,
    int? organizerId,
    String? scope,
    DateTime? startDate,
    DateTime? endDate,
    int? maxTeams,
    int? maxMainPlayers,
    int? maxSubPlayers,
    bool? isPrivate,
    String? status,
    String? subscriptionPrice,
    String? logoPath,
    String? logoLocalPath,
  }) {
    return LeagueModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      name: name ?? this.name,
      type: type ?? this.type,
      organizerId: organizerId ?? this.organizerId,
      scope: scope ?? this.scope,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxTeams: maxTeams ?? this.maxTeams,
      maxMainPlayers: maxMainPlayers ?? this.maxMainPlayers,
      maxSubPlayers: maxSubPlayers ?? this.maxSubPlayers,
      isPrivate: isPrivate ?? this.isPrivate,
      status: status ?? this.status,
      subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
      logoPath: logoPath ?? this.logoPath,
      logoLocalPath: logoLocalPath ?? this.logoLocalPath,
    );
  }

  // --------------------------
  // API JSON
  // --------------------------
  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
    id: json['id'] as int?,
    syncId: (json['sync_id'] ?? json['syncId']) as String?,
    name: (json['league_name'] ?? json['name']) as String?,
    type: (json['league_type'] ?? json['type']) as String?,
    organizerId: json['organizer_id'] as int?,
    scope: (json['league_scope'] ?? json['scope']) as String?,
    startDate: _parseDate(json['start_date'] ?? json['startDate']),
    endDate: _parseDate(json['end_date'] ?? json['endDate']),
    maxTeams: (json['max_team'] ?? json['maxTeams']) as int?,
    maxMainPlayers:
    (json['max_main_player'] ?? json['maxMainPlayers']) as int?,
    maxSubPlayers: (json['max_sub_player'] ?? json['maxSubPlayers']) as int?,
    isPrivate: (json['is_private'] ?? json['isPrivate'] ?? false) as bool,
    status: (json['status'] as String?) ?? 'active',
    subscriptionPrice: json['subscription_price']?.toString(),
    logoPath: (json['logo_path'] ?? json['logoPath'] ?? json['logo_url'])
    as String?,
    // logoLocalPath: لا يأتي من API
  );

  /// JSON للـ API (بدون ملفات)
  Map<String, dynamic> toJson() => {
    'sync_id': syncId,
    'name': name,
    if (type != null) 'type': type,
    if (organizerId != null) 'organizer_id': organizerId,
    if (scope != null) 'league_scope': scope,
    if (startDate != null) 'start_date': startDate!.toIso8601String(),
    if (endDate != null) 'end_date': endDate!.toIso8601String(),
    if (maxTeams != null) 'max_teams': maxTeams,
    if (maxMainPlayers != null) 'max_main_players': maxMainPlayers,
    if (maxSubPlayers != null) 'max_sub_players': maxSubPlayers,
    'is_private': isPrivate,
    'status': status,
    if (subscriptionPrice != null) 'subscription_price': subscriptionPrice,
    if (logoPath != null) 'logo_path': logoPath,
  };

  static List<LeagueModel> fromJsonLeagueList(List json) {
    return json
        .whereType<Map>()
        .map((e) => LeagueModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // --------------------------
  // Drift mapping
  // --------------------------
  LeaguesCompanion toCompanion() => LeaguesCompanion.insert(
    syncId: syncId,
    name: name ?? '',
    type: type != null ? Value(type!) : const Value.absent(),
    organizerId:
    organizerId != null ? Value(organizerId!) : const Value.absent(),
    scope: scope != null ? Value(scope!) : const Value.absent(),
    startDate:
    startDate != null ? Value(startDate!) : const Value.absent(),
    endDate: endDate != null ? Value(endDate!) : const Value.absent(),
    maxTeams: maxTeams != null ? Value(maxTeams!) : const Value.absent(),
    maxMainPlayers: maxMainPlayers != null
        ? Value(maxMainPlayers!)
        : const Value.absent(),
    maxSubPlayers: maxSubPlayers != null
        ? Value(maxSubPlayers!)
        : const Value.absent(),
    isPrivate: Value(isPrivate),
    status: Value(status),
    subscriptionPrice: subscriptionPrice ?? '',
    logoPath: logoPath != null ? Value(logoPath!) : const Value.absent(),
    // ✅ NEW
    logoLocalPath:
    logoLocalPath != null ? Value(logoLocalPath!) : const Value.absent(),
  );

  /// Upsert companion (use insertOnConflictUpdate)
  LeaguesCompanion toCompanionUpsert() => LeaguesCompanion(
    syncId: Value(syncId),
    name: Value(name ?? ''),
    type: type != null ? Value(type!) : const Value.absent(),
    organizerId:
    organizerId != null ? Value(organizerId!) : const Value.absent(),
    scope: scope != null ? Value(scope!) : const Value.absent(),
    startDate:
    startDate != null ? Value(startDate!) : const Value.absent(),
    endDate: endDate != null ? Value(endDate!) : const Value.absent(),
    maxTeams: maxTeams != null ? Value(maxTeams!) : const Value.absent(),
    maxMainPlayers: maxMainPlayers != null
        ? Value(maxMainPlayers!)
        : const Value.absent(),
    maxSubPlayers: maxSubPlayers != null
        ? Value(maxSubPlayers!)
        : const Value.absent(),
    isPrivate: Value(isPrivate),
    status: Value(status),
    subscriptionPrice: Value(subscriptionPrice ?? ''),
    logoPath: logoPath != null ? Value(logoPath!) : const Value.absent(),
    // ✅ NEW: لا تكتبها إلا إذا عندك قيمة (حتى ما تمسحها)
    logoLocalPath:
    logoLocalPath != null ? Value(logoLocalPath!) : const Value.absent(),
  );

  static LeagueModel fromEntity(League e) => LeagueModel(
    id: e.id,
    syncId: e.syncId,
    name: e.name,
    type: e.type,
    organizerId: e.organizerId,
    scope: e.scope,
    startDate: e.startDate,
    endDate: e.endDate,
    maxTeams: e.maxTeams,
    maxMainPlayers: e.maxMainPlayers,
    maxSubPlayers: e.maxSubPlayers,
    isPrivate: e.isPrivate,
    status: e.status,
    subscriptionPrice: e.subscriptionPrice,
    logoPath: e.logoPath,
    // ✅ NEW
    logoLocalPath: e.logoLocalPath,
  );
}

DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.trim().isNotEmpty) return DateTime.tryParse(v);
  return null;
}

class LeagueBundleModel {
  final LeagueModel league;
  final List<TeamModel> teams;
  final List<TeamPlayerCategoryModel> categories;

  LeagueBundleModel({
    required this.league,
    required this.teams,
    required this.categories,
  });

  factory LeagueBundleModel.fromJson(Map<String, dynamic> j) {
    return LeagueBundleModel(
      league: LeagueModel.fromJson(j['data'] as Map<String, dynamic>),
      teams: (j['teams'] as List? ?? const [])
          .map((e) => TeamModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      categories: (j['team_player_categories'] as List? ?? const [])
          .map((e) => TeamPlayerCategoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}