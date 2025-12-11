import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class MatchTermModel {
  final int id;
  final int matchId;
  final int leagueTermId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int additionalMinutes;
  final bool isFinished;
  final String? leagueTermName; // اسم الشوط من الدوري
  final String? termName;       // مثل: "الشوط الأول", "الشوط الإضافي الثاني"
  final String? termType;       // regular / extra / penalty

  MatchTermModel({
    required this.id,
    required this.matchId,
    required this.leagueTermId,
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
      matchId: entity.matchId,
      leagueTermId: entity.leagueTermId,
      startTime: entity.startTime,
      endTime: entity.endTime,
      additionalMinutes: entity.additionalMinutes,
      isFinished: entity.isFinished,
    );
  }

  /// ✅ التحويل من JSON إلى موديل
  factory MatchTermModel.fromJson(Map<String, dynamic> json) => MatchTermModel(
    id: json['id'] as int,
    matchId: json['match_id'] as int,
    leagueTermId: json['league_term_id'] as int,
    startTime: json['start_time'] != null
        ? DateTime.tryParse(json['start_time'] as String)
        : null,
    endTime: json['end_time'] != null
        ? DateTime.tryParse(json['end_time'] as String)
        : null,
    additionalMinutes: json['additional_minutes'] as int? ?? 0,
    isFinished: json['is_finished'] as bool? ?? false,
    leagueTermName: json['leagueTermName'] as String?,
    termName: json['termName'] as String?,
    termType: json['termType'] as String?,
  );

  /// ✅ التحويل إلى Companion (لعمليات الإدخال)
  MatchTermsCompanion toCompanionInsert() {
    return MatchTermsCompanion.insert(
      matchId: matchId,
      leagueTermId: leagueTermId,
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
      matchId: Value(matchId),
      leagueTermId: Value(leagueTermId),
      startTime: Value(startTime),
      endTime: Value(endTime),
      additionalMinutes: Value(additionalMinutes),
      isFinished: Value(isFinished),
    );
  }

  /// ✅ التحويل إلى JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'match_id': matchId,
    'league_term_id': leagueTermId,
    if (startTime != null) 'start_time': startTime!.toIso8601String(),
    if (endTime != null) 'end_time': endTime!.toIso8601String(),
    'additional_minutes': additionalMinutes,
    'is_finished': isFinished,
    if (leagueTermName != null) 'leagueTermName': leagueTermName,
    if (termName != null) 'termName': termName,
    if (termType != null) 'termType': termType,
  };

  /// ✅ نسخة محدثة (copyWith)
  MatchTermModel copyWith({
    int? id,
    int? matchId,
    int? leagueTermId,
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
      matchId: matchId ?? this.matchId,
      leagueTermId: leagueTermId ?? this.leagueTermId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      additionalMinutes: additionalMinutes ?? this.additionalMinutes,
      isFinished: isFinished ?? this.isFinished,
      leagueTermName: leagueTermName ?? this.leagueTermName,
      termName: termName ?? this.termName,
      termType: termType ?? this.termType,
    );
  }

}
