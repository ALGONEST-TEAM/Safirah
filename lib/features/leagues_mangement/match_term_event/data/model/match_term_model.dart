import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';

class MatchTermModel {
  final int id;

  /// Stable identifier used for relations (FKs) and sync.
  final String syncId;

  final String matchSyncId;
  final String leagueTermSyncId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int additionalMinutes;
  final bool isFinished;
  final String? leagueTermName; // اسم الشوط من الدوري
  final String? termName;       // مثل: "الشوط الأول", "الشوط الإضافي الثاني"
  final String? termType;       // regular / extra / penalty

  MatchTermModel({
    required this.id,
    required this.syncId,
    required this.matchSyncId,
    required this.leagueTermSyncId,
    this.startTime,
    this.endTime,
    this.additionalMinutes = 0,
    this.isFinished = false,
    this.leagueTermName,
    this.termName,
    this.termType,
  });


  /// ✅ التحويل من كيان قاعدة البيانات إلى الموديل
  factory MatchTermModel.fromEntity(MatchTerm entity) {
    return MatchTermModel(
      id: entity.id,
      syncId: entity.syncId,
      matchSyncId: entity.matchSyncId,
      leagueTermSyncId: entity.leagueTermSyncId,
      startTime: entity.startTime,
      endTime: entity.endTime,
      additionalMinutes: entity.additionalMinutes,
      isFinished: entity.isFinished,
    );
  }

  /// ✅ التحويل من JSON إلى موديل
  factory MatchTermModel.fromJson(Map<String, dynamic> json) => MatchTermModel(
        id: json['id'] as int,
        syncId: (json['sync_id'] ?? json['syncId']) ?? '',
        matchSyncId: (json['match_sync_id'] ?? json['matchSyncId']) ??'',
        leagueTermSyncId:
            (json['league_term_sync_id'] ?? json['leagueTermSyncId'])??'' ,
        // startTime: json['start_time'] != null
        //     ? DateTime.tryParse(json['start_time'] ??'')
        //     : null,
        // endTime: json['end_time'] != null
        //     ? DateTime.tryParse(json['end_time'] ??'')
        //     : null,
        additionalMinutes: json['additional_minutes'] as int? ?? 0,
        isFinished: json['is_finished'] as bool? ?? false,
        // leagueTermName: json['leagueTermName'] as String?,
        // termName: json['term']['name'] ??'',
        // termType: json['termType'] as String?,
      );

  /// ✅ التحويل إلى Companion (لعمليات الإدخال)
  MatchTermsCompanion toCompanionInsert() {
    return MatchTermsCompanion.insert(
      syncId: const Uuid().v4(),
      matchSyncId: matchSyncId,
      leagueTermSyncId: leagueTermSyncId,
      startTime: Value(startTime),
      endTime: Value(endTime),
      additionalMinutes: Value(additionalMinutes),
      isFinished: Value(isFinished),
    );
  }

  /// ✅ التحويل إلى Companion (للتحديث)
  MatchTermsCompanion toCompanionUpdate() {
    return MatchTermsCompanion(
      id: Value(id),
      matchSyncId: Value(matchSyncId),
      leagueTermSyncId: Value(leagueTermSyncId),
      startTime: Value(startTime),
      endTime: Value(endTime),
      additionalMinutes: Value(additionalMinutes),
      isFinished: Value(isFinished),
    );
  }

  /// ✅ التحويل إلى JSON
  Map<String, dynamic> toJson() => {
        'sync_id': syncId,
       // 'match_sync_id': matchSyncId,
        'league_term_sync_id': leagueTermSyncId,
        if (startTime != null) 'start_time': startTime!.toIso8601String(),
        if (endTime != null) 'end_time': endTime!.toIso8601String(),
        'additional_minutes': additionalMinutes,
        'is_finished': isFinished,
        // if (leagueTermName != null) 'leagueTermName': leagueTermName,
        // if (termName != null) 'termName': termName,
        // if (termType != null) 'termType': termType,
      };

  /// ✅ نسخة محدثة (copyWith)
  MatchTermModel copyWith({
    int? id,
    String? syncId,
    String? matchSyncId,
    String? leagueTermSyncId,
    DateTime? startTime,
    DateTime? endTime,
    int? additionalMinutes,
    bool? isFinished,
    String? leagueTermName,
    String? termName,
    String? termType,
  }) {
    return MatchTermModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      leagueTermSyncId: leagueTermSyncId ?? this.leagueTermSyncId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      additionalMinutes: additionalMinutes ?? this.additionalMinutes,
      isFinished: isFinished ?? this.isFinished,
      leagueTermName: leagueTermName ?? this.leagueTermName,
      termName: termName ?? this.termName,
      termType: termType ?? this.termType,
    );
  }
  static List<MatchTermModel> fromJsonList(List json) {
    return json.map((e) => MatchTermModel.fromJson(e)).toList();
  }
}
