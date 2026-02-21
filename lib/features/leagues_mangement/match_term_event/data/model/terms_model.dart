import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class TermModel {
  final int? id;
  final String syncId;
  final String name;
  final String type;
  final int order;
  final DateTime? createdAt;

  const TermModel({
    this.id,
    required this.syncId,
    required this.name,
    required this.type,
    required this.order,
    this.createdAt,
  });

  // ✅ التحويل من Entity (drift)
  factory TermModel.fromEntity(Term term) => TermModel(
        id: term.id,
        syncId: term.syncId,
        name: term.name,
        type: term.type,
        order: term.order,
        createdAt: term.createdAt,
      );

  // ✅ التحويل إلى Companion للإدخال
  TermsCompanion toCompanionInsert() => TermsCompanion.insert(
        syncId: syncId,
        name: name,
        type: type,
        order: order,
      );

  // ✅ التحويل إلى Companion للتحديث
  TermsCompanion toCompanionUpdate() => TermsCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        syncId: Value(syncId),
        name: Value(name),
        type: Value(type),
        order: Value(order),
        createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      );

  // ✅ JSON
  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
        id: json['id'] as int?,
        syncId: (json['sync_id'] ?? json['syncId']) as String,
        name: json['name'] as String,
        type: json['type'] as String,
        order: json['order'] as int,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'sync_id': syncId,
        'name': name,
        'type': type,
        'order': order,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };

  TermModel copyWith({
    int? id,
    String? syncId,
    String? name,
    String? type,
    int? order,
    DateTime? createdAt,
  }) =>
      TermModel(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
      );
}

class LeagueTermModel {
  final int? id;
  final String syncId;
  final String leagueSyncId;
  final String termSyncId;
  final String? termName; // من جدول terms
  final String? termType; // من جدول terms
  final int durationMinutes;
  final int? orderTerm;
  LeagueTermModel({
    this.id,
    required this.syncId,
    this.orderTerm,
    required this.leagueSyncId,
    required this.termSyncId,
    this.termName,
    this.termType,
    required this.durationMinutes,
  });
LeagueTermModel copyWith({
  int? id,
  String? syncId,
  String? leagueSyncId,
  String? termSyncId,
  String? termName,
  String? termType,
  int? durationMinutes,
  int? orderTerm,
}) {
  return LeagueTermModel(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    leagueSyncId: leagueSyncId ?? this.leagueSyncId,
    termSyncId: termSyncId ?? this.termSyncId,
    termName: termName ?? this.termName,
    termType: termType ?? this.termType,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    orderTerm: orderTerm ?? this.orderTerm,
  );
}
  factory LeagueTermModel.fromEntity(LeagueTerm entity) {
    return LeagueTermModel(
      id: entity.id,
      syncId: entity.syncId,
      leagueSyncId: entity.leagueSyncId,
      termSyncId: entity.termSyncId,
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
      syncId: leagueTerm.syncId,
      leagueSyncId: leagueTerm.leagueSyncId,
      termSyncId: leagueTerm.termSyncId,
      termName: term.name,
      termType: term.type,
      durationMinutes: leagueTerm.durationMinutes,
    );
  }

  LeagueTermsCompanion toCompanion() {
    return LeagueTermsCompanion.insert(
      syncId: syncId,
      leagueSyncId: leagueSyncId,
      termSyncId: termSyncId,
      durationMinutes: Value(durationMinutes),
    );
  }

  // 🔁 للتحويل إلى JSON (للتخزين أو العرض)
  Map<String, dynamic> toJson() => {
        'sync_id': syncId,
        'term_sync_id': orderTerm,
        'duration_minutes': durationMinutes,
      };

  // 🧱 Factory من JSON (للتحويل من API أو تخزين محلي)
  factory LeagueTermModel.fromJson(Map<String, dynamic> json) => LeagueTermModel(
        id: json['id'] as int?,
        syncId: (json['sync_id'] ?? json['syncId']) as String,
        leagueSyncId: json['leagueSyncId'] as String,
        termSyncId: (json['termSyncId'] ?? json['term_sync_id']) as String,
        termName: json['termName'] as String?,
        termType: json['termType'] as String?,
        durationMinutes: json['durationMinutes'] as int,
      );

  // ⚙️ نسخ مع تعديل (copyWith)

}
