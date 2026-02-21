import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';
import '../../../group/data/model/model.dart';
import 'match_model.dart';

class RoundModel {
  final int? id;
  final String? syncId;

  /// ✅ NEW: يطابق عمود group_sync_id في جدول rounds + يأتي من API
  final String? groupSyncId;

  final String leagueSyncId;
  final String roundName;
  final String roundType;
  final DateTime? createdAt;

  final List<GroupModel> groups;
  final List<MatchModel>? matches;

  const RoundModel({
    this.id,
    this.syncId,
    this.groupSyncId, // ✅ NEW
    required this.leagueSyncId,
    required this.roundName,
    required this.roundType,
    this.createdAt,
    this.matches,
    this.groups = const [],
  });

  RoundModel copyWith({
    int? id,
    String? syncId,
    String? groupSyncId, // ✅ NEW
    String? leagueSyncId,
    String? roundName,
    String? roundType,
    DateTime? createdAt,
    List<GroupModel>? groups,
    List<MatchModel>? matches,
  }) {
    return RoundModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      groupSyncId: groupSyncId ?? this.groupSyncId, // ✅ NEW
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      roundName: roundName ?? this.roundName,
      roundType: roundType ?? this.roundType,
      createdAt: createdAt ?? this.createdAt,
      groups: groups ?? this.groups,
      matches: matches ?? this.matches,
    );
  }

  // factory RoundModel.fromJson(Map<String, dynamic> j) {
  //   final leagueId =
  //   (j['league_sync_id'] ?? j['leagueSyncId'] ?? j['league_id']) as String?;
  //
  //   // ✅ group في الـAPI الجديد: Map واحد (وليس List)
  //   final dynamic groupRaw = j['group'];
  //
  //   final List<GroupModel> groups = [];
  //
  //   if (groupRaw is Map) {
  //     final map = Map<String, dynamic>.from(groupRaw);
  //
  //     // حقن league_sync_id داخل group إذا غير موجود
  //     map.putIfAbsent('league_sync_id', () => leagueId);
  //
  //     groups.add(GroupModel.fromJson(map));
  //   } else if (groupRaw is List) {
  //     // احتياط لو رجّع List مستقبلاً
  //     for (final x in groupRaw) {
  //       if (x is Map) {
  //         final map = Map<String, dynamic>.from(x);
  //         map.putIfAbsent('league_sync_id', () => leagueId);
  //         groups.add(GroupModel.fromJson(map));
  //       }
  //     }
  //   }
  //
  //   return RoundModel(
  //     id: j['id'] as int?,
  //     syncId: (j['sync_id'] ?? j['syncId']) as String?,
  //     leagueSyncId: (leagueId ?? '').trim(),
  //     groupSyncId: (j['group_sync_id'] ?? j['groupSyncId']) as String?,
  //     roundName: (j['round_name'] ?? j['roundName'] ?? j['name']) as String? ?? '',
  //     roundType: (j['round_type'] ?? j['roundType']) as String? ?? 'group',
  //     createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
  //     groups: groups,
  //     matches: MatchModel.fromJsonList(j['matches']??[])
  //   );
  // }

  factory RoundModel.fromJson(Map<String, dynamic> j) {
    final leagueId =
    (j['league_sync_id'] ?? j['leagueSyncId'] ?? j['league_id']) as String?;

    final dynamic groupRaw = j['group'];
    final List<GroupModel> groups = [];

    if (groupRaw is Map) {
      final map = Map<String, dynamic>.from(groupRaw);
      map.putIfAbsent('league_sync_id', () => leagueId);
      groups.add(GroupModel.fromJson(map));
    } else if (groupRaw is List) {
      for (final x in groupRaw) {
        if (x is Map) {
          final map = Map<String, dynamic>.from(x);
          map.putIfAbsent('league_sync_id', () => leagueId);
          groups.add(GroupModel.fromJson(map));
        }
      }
    }

    return RoundModel(
      id: j['id'] as int?,
      syncId: (j['sync_id'] ?? j['syncId']) as String?,
      leagueSyncId: (leagueId ?? '').trim(),
      groupSyncId: (j['group_sync_id'] ?? j['groupSyncId']) as String?,
      roundName: (j['round_name'] ?? j['roundName'] ?? j['name']) as String? ?? '',
      roundType: (j['round_type'] ?? j['roundType']) as String? ?? 'group',
      createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
      groups: groups,
      // ✅ الفرق هنا
      matches: j.containsKey('matches')
          ? MatchModel.fromJsonList((j['matches'] as List?) ?? const [])
          : null,
    );
  }
  Map<String, dynamic> toJson() => {
    if (syncId != null) 'sync_id': syncId,
    'league_sync_id': leagueSyncId,
    // ✅ الصحيح: group_sync_id ليس قائمة groups! هو قيمة واحدة على مستوى الجولة
    'group_sync_id': groupSyncId,
    'round_type': roundType,
    'round_name': roundName,
    if (groups.isNotEmpty) 'groups': groups.map((g) => g.toJson()).toList(),
    if (matches?.isNotEmpty==true) 'matches': matches?.map((m) => m.toJson()).toList(),

  };

  RoundsCompanion toCompanionInsert() => RoundsCompanion.insert(
    syncId:syncId?? const Uuid().v7(),
    leagueSyncId: leagueSyncId,
    name: roundName,
    roundType: roundType,
    // ✅ NEW
    groupSyncId: groupSyncId != null ? Value(groupSyncId!) : const Value.absent(),
  );

  RoundsCompanion toCompanionUpdate() => RoundsCompanion(
    id: id != null ? Value(id!) : const Value.absent(),
    syncId: syncId != null ? Value(syncId!) : const Value.absent(),
    leagueSyncId: Value(leagueSyncId),
    name: Value(roundName),
    roundType: Value(roundType),
    // ✅ NEW
    groupSyncId: groupSyncId != null ? Value(groupSyncId!) : const Value.absent(),
    createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
  );

  static RoundModel fromEntity(Round e) => RoundModel(
    id: e.id,
    syncId: e.syncId,
    groupSyncId: e.groupSyncId, // ✅ NEW
    leagueSyncId: e.leagueSyncId,
    roundName: e.name,
    roundType: e.roundType,
    createdAt: e.createdAt,
  );

  static List<RoundModel> fromJsonList(List json) {
    return json.map((e) => RoundModel.fromJson(e)).toList();
  }

  RoundModel withGroups(List<GroupModel> groups) => copyWith(groups: groups);

  RoundModel withMatch(List<MatchModel> matches) => copyWith(matches: matches);
}

// ======= helpers =======
DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}
