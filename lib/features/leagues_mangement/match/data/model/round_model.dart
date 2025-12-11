import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';

import '../../../group/data/model/model.dart';
import 'match_model.dart';

class RoundModel {
  final int? id;
  final int leagueId;
  final String roundName;
  final String roundType; // group|knockout|final|placement|qualifier
  final DateTime? createdAt;

  /// ✅ المجموعات التابعة للجولة
  final List<GroupModel> groups;
  final List<MatchModel>? matches;


  const RoundModel({
    this.id,
    required this.leagueId,
    required this.roundName,
    required this.roundType,
    this.createdAt,
    this.matches,
    this.groups = const [], // افتراضيًا فارغة
  });

  RoundModel copyWith({
    int? id,
    int? leagueId,
    String? roundName,
    String? roundType,
    DateTime? createdAt,
    List<GroupModel>? groups,
    List<MatchModel>?matches
  }) =>
      RoundModel(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        roundName: roundName ?? this.roundName,
        roundType: roundType ?? this.roundType,
        createdAt: createdAt ?? this.createdAt,
        groups: groups ?? this.groups,
        matches: matches??this.matches
      );

  factory RoundModel.fromJson(Map<String, dynamic> j) => RoundModel(
        id: j['id'] as int?,
        leagueId: (j['league_id'] ?? j['leagueId']) as int,
        roundName:
            (j['round_name'] ?? j['roundName'] ?? j['name']) as String? ?? '',
        roundType: (j['round_type'] ?? j['roundType']) as String? ?? 'group',
        createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
        groups: (j['groups'] as List<dynamic>?)
                ?.map((x) => GroupModel.fromJson(x as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'league_id': leagueId,
        'round_name': roundName,
        'round_type': roundType,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (groups.isNotEmpty) 'groups': groups.map((g) => g.toJson()).toList(),
      };

  RoundsCompanion toCompanionInsert() => RoundsCompanion.insert(
        leagueId: leagueId,
        name: roundName,
        roundType: roundType,
      );

  RoundsCompanion toCompanionUpdate() => RoundsCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        leagueId: Value(leagueId),
        name: Value(roundName),
        roundType: Value(roundType),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      );

  static RoundModel fromEntity(Round e) => RoundModel(
        id: e.id,
        leagueId: e.leagueId,
        roundName: e.name,
        roundType: e.roundType,
        createdAt: e.createdAt,
      );

  /// 🔗 دالة لربط المجموعات بعد الجلب من قاعدة البيانات
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
