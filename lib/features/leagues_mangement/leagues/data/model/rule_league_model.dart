import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/safirah_database.dart';

class LeagueRuleModel {
  final int? id;
  final String syncId;
  final String leagueSyncId;
  final String description;
  final bool isMandatory;

  LeagueRuleModel({
    this.id,
    String? syncId,
    required this.leagueSyncId,
    required this.description,
    this.isMandatory = false,
  }) : syncId = syncId ?? const Uuid().v4();

  LeagueRuleModel copyWith({
    int? id,
    String? syncId,
    String? leagueSyncId,
    String? description,
    bool? isMandatory,
  }) {
    return LeagueRuleModel(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      description: description ?? this.description,
      isMandatory: isMandatory ?? this.isMandatory,
    );
  }

  // API JSON
  factory LeagueRuleModel.fromJson(Map<String, dynamic> j) => LeagueRuleModel(
        syncId: j['sync_id'] ?? j['syncId'],
        leagueSyncId: j['league_sync_id'],
        description: j['description'] ?? '',
        isMandatory: j['is_mandatory'] ?? j['isMandatory'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'league_sync_id': leagueSyncId,
        'sync_id': syncId,
        'description': description,
        'is_mandatory': isMandatory,
      };

  LeagueRulesCompanion toCompanion(String leagueSyncId) {
    return LeagueRulesCompanion.insert(
      leagueSyncId: leagueSyncId,
      syncId: syncId,
      description: description,
      isMandatory: Value(isMandatory),
    );
  }

  factory LeagueRuleModel.fromEntity(LeagueRule entity) {
    return LeagueRuleModel(
      id: entity.id,
      leagueSyncId: entity.leagueSyncId,
      syncId: entity.syncId,
      description: entity.description,
      isMandatory: entity.isMandatory,
    );
  }

  static List<LeagueRuleModel> fromJsonList(List json) {
    return json
        .map((e) => LeagueRuleModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }
}

class RuleUIModel {
  final int? id;
  final String rule;
  final bool selected;
  final bool isDefault;

  RuleUIModel({
    this.id,
    required this.rule,
    this.selected = false,
    this.isDefault = false,
  });

  RuleUIModel copyWith({
    int? id,
    String? rule,
    bool? selected,
    bool? isDefault,
  }) {
    return RuleUIModel(
      id: id ?? this.id,
      rule: rule ?? this.rule,
      selected: selected ?? this.selected,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
