import 'package:dio/dio.dart';

class RoleModel {
  final int? id;
  final String? syncId;
  final String? nameAr;
  final String? nameEn;

  const RoleModel({
    this.id,
    this.syncId,
    this.nameAr,
    this.nameEn,
  });

  factory RoleModel.fromJson(Map<String, dynamic> j) => RoleModel(
        id: j['id'] as int?,
        syncId: (j['sync_id'] ?? j['syncId'])?.toString(),
        nameAr: (j['name_ar'] ?? j['nameAr'])?.toString(),
        nameEn: (j['name_en'] ?? j['nameEn'] ?? j['name'])?.toString(),
      );

  static List<RoleModel> fromJsonList(List json) {
    return json
        .whereType<Map>()
        .map((e) => e.map((k, v) => MapEntry(k.toString(), v)))
        .map(RoleModel.fromJson)
        .toList();
  }

  /// مفتاح الدور الذي سنعتمد عليه داخلياً.
  /// حالياً نعتمد nameEn بعد تحويله لصيغة ثابتة.
  String get key {
    final raw = (nameEn ?? '').trim();
    return raw.toLowerCase();
  }
}
class UserAccessForLeagueModel {
  final int leagueId;
  final List<RoleModel> roles;

  const UserAccessForLeagueModel({
    required this.leagueId,
    required this.roles,
  });

  /// مفاتيح الأدوار بشكل مبسط للاستخدام في الـ authorization mapping.
  List<String> get roleKeys => roles.map((e) => e.key).where((e) => e.isNotEmpty).toSet().toList();

  factory UserAccessForLeagueModel.fromJson(Map<String, dynamic> json) {
    final rawLeagueId = json['league_id'] ?? json['leagueId'] ?? json['league'];
    final leagueId = rawLeagueId is int
        ? rawLeagueId
        : int.tryParse(rawLeagueId?.toString() ?? '') ?? -1;

    if (leagueId <= 0) {
      throw DioException(
        requestOptions: RequestOptions(path: '/authorization/access'),
        error: 'Missing/invalid league_id',
      );
    }

    final rawRoles = (json['roles'] as List?) ?? const [];

    return UserAccessForLeagueModel(
      leagueId: leagueId,
      roles: RoleModel.fromJsonList(rawRoles),
    );
  }

  static List<UserAccessForLeagueModel> fromJsonList(List json) {
    return json
        .map((e) => UserAccessForLeagueModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class LeagueUserAccessModel {
  final int? id;

  /// قد لا يُرسل السيرفر league_id، لذلك نخليه اختياري.
  final int? leagueId;

  /// المفتاح الأساسي عندنا الآن.
  final String? leagueSyncId;
  final String? status;
  final String? startDate;
  final String? endDate;
  final List<RoleModel> roles;

  const LeagueUserAccessModel({
    this.id,
    this.leagueId,
    this.leagueSyncId,
    this.status,
    this.startDate,
    this.endDate,
    this.roles = const [],
  });

  List<String> get roleKeys =>
      roles.map((e) => e.key).where((e) => e.isNotEmpty).toSet().toList();

  factory LeagueUserAccessModel.fromJson(Map<String, dynamic> j) {
    final rawLeagueId = j['league_id'] ?? j['leagueId'] ?? j['league'];
    final leagueId = rawLeagueId == null
        ? null
        : (rawLeagueId is int
            ? rawLeagueId
            : int.tryParse(rawLeagueId.toString()));

    final leagueSyncId = (j['league_sync_id'] ?? j['leagueSyncId'])?.toString();

    // ✅ بعض الـ APIs تعتمد على league_sync_id فقط بدون league_id.
    // لا نرمي خطأ هنا طالما leagueSyncId موجود.
    if ((leagueSyncId == null || leagueSyncId.trim().isEmpty) &&
        (leagueId == null || leagueId <= 0)) {
      throw DioException(
        requestOptions: RequestOptions(path: '/authorization/access'),
        error: 'Missing league_sync_id (and league_id)',
      );
    }

    final rawRoles = (j['roles'] as List?) ?? const [];

    return LeagueUserAccessModel(
      id: j['id'] as int?,
      leagueId: leagueId,
      leagueSyncId: leagueSyncId,
      status: (j['status'])?.toString(),
      startDate: (j['start_date'] ?? j['startDate'])?.toString(),
      endDate: (j['end_date'] ?? j['endDate'])?.toString(),
      roles: RoleModel.fromJsonList(rawRoles),
    );
  }

  static List<LeagueUserAccessModel> fromJsonList(List json) {
    return json
        .whereType<Map>()
        .map((e) => e.map((k, v) => MapEntry(k.toString(), v)))
        .map(LeagueUserAccessModel.fromJson)
        .toList();
  }
}

/// استجابة السيرفر: {"data": [ LeagueUserAccessModel, ... ]}
class UserAccessForAllLeaguesModel {
  final List<LeagueUserAccessModel> data;

  const UserAccessForAllLeaguesModel({
    required this.data,
  });

  factory UserAccessForAllLeaguesModel.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['data'] as List?) ?? const [];
    return UserAccessForAllLeaguesModel(
      data: LeagueUserAccessModel.fromJsonList(rawItems),
    );
  }

  /// ✅ في بعض endpoints (مثل my-leagues) يكون res.data['data'] نفسه List.
  factory UserAccessForAllLeaguesModel.fromJsonList(List json) {
    return UserAccessForAllLeaguesModel(
      data: LeagueUserAccessModel.fromJsonList(json),
    );
  }
}
class UserModelForAuthorization {
  final int? id;
  final String? syncId;
  final String ?leagueSyncId;
  final String? name;
  final int? authorizationType;
  final int? userId;
  const UserModelForAuthorization({
    this.id,
    this.syncId,
    required this.leagueSyncId,
    this.name,
    this.authorizationType,
    this.userId,
  });

  UserModelForAuthorization copyWith({
    int? userId,
    String? leagueSyncId,
    String? syncId,
    String? name,
    int? authorizationType
  }) =>
      UserModelForAuthorization(
        userId: userId ?? this.userId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        authorizationType: authorizationType ?? this.authorizationType,
      );

  factory UserModelForAuthorization.fromJson(Map<String, dynamic> j) => UserModelForAuthorization(
    id: j['id'] as int?,
    name: j['name'] as String?, leagueSyncId: '',
  );

  Map<String, dynamic> toJson() => {
    'league_id': leagueSyncId,
    'league_participant_role_id': authorizationType,
    'user_id':userId
  };

  static List<UserModelForAuthorization> fromJsonList(List json) {
    return json
        .map((e) => UserModelForAuthorization.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}