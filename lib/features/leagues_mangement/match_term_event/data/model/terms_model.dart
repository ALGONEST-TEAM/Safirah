import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class TermModel {
  final int? id;
  final String name;
  final String type;
  final int order;
  final DateTime? createdAt;

  const TermModel({
    this.id,
    required this.name,
    required this.type,
    required this.order,
    this.createdAt,
  });

  // ✅ التحويل من Entity (drift)
  factory TermModel.fromEntity(Term term) => TermModel(
        id: term.id,
        name: term.name,
        type: term.type,
        order: term.order,
        createdAt: term.createdAt,
      );

  // ✅ التحويل إلى Companion للإدخال
  TermsCompanion toCompanionInsert() => TermsCompanion.insert(
        name: name,
        type: type,
        order: order,
      );

  // ✅ التحويل إلى Companion للتحديث
  TermsCompanion toCompanionUpdate() => TermsCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        name: Value(name),
        type: Value(type),
        order: Value(order),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      );

  // ✅ JSON
  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        type: json['type'] as String,
        order: json['order'] as int,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'type': type,
        'order': order,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };

  TermModel copyWith({
    int? id,
    String? name,
    String? type,
    int? order,
    DateTime? createdAt,
  }) =>
      TermModel(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
      );
}

class LeagueTermModel {
  final int? id;
  final int leagueId;
  final int termId;
  final String? termName; // من جدول terms
  final String? termType; // من جدول terms
  final int durationMinutes;

  LeagueTermModel({
    this.id,
    required this.leagueId,
    required this.termId,
    this.termName,
    this.termType,
    required this.durationMinutes,
  });

  // 🏗️ Factory من جدول LeagueTerms (Drift Entity)
  factory LeagueTermModel.fromEntity(LeagueTerm entity) {
    return LeagueTermModel(
      id: entity.id,
      leagueId: entity.leagueId,
      termId: entity.termId,
      durationMinutes: entity.durationMinutes,
    );
  }

  // 🧩 Factory عند الربط مع جدول Terms (join)
  factory LeagueTermModel.fromEntityWithTerm({
    required LeagueTerm leagueTerm,
    required Term term,
  }) {
    return LeagueTermModel(
      id: leagueTerm.id,
      leagueId: leagueTerm.leagueId,
      termId: leagueTerm.termId,
      termName: term.name,
      termType: term.type,
      durationMinutes: leagueTerm.durationMinutes,
    );
  }

  // 🧾 لتحويل إلى Companion (للإدراج في قاعدة البيانات)
  LeagueTermsCompanion toCompanion() {
    return LeagueTermsCompanion.insert(
      leagueId: leagueId,
      termId: termId,
      durationMinutes: Value(durationMinutes),
    );
  }

  // 🔁 للتحويل إلى JSON (للتخزين أو العرض)
  Map<String, dynamic> toJson() => {
        'id': id,
        'leagueId': leagueId,
        'termId': termId,
        'termName': termName,
        'termType': termType,
        'durationMinutes': durationMinutes,
      };

  // 🧱 Factory من JSON (للتحويل من API أو تخزين محلي)
  factory LeagueTermModel.fromJson(Map<String, dynamic> json) =>
      LeagueTermModel(
        id: json['id'] as int?,
        leagueId: json['leagueId'] as int,
        termId: json['termId'] as int,
        termName: json['termName'] as String?,
        termType: json['termType'] as String?,
        durationMinutes: json['durationMinutes'] as int,
      );

  // ⚙️ نسخ مع تعديل (copyWith)
  LeagueTermModel copyWith({
    int? id,
    int? leagueId,
    int? termId,
    String? termName,
    String? termType,
    int? durationMinutes,
  }) {
    return LeagueTermModel(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      termId: termId ?? this.termId,
      termName: termName ?? this.termName,
      termType: termType ?? this.termType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }
}
