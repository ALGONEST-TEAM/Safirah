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
        id: j['id'],
        syncId: j['sync_id'] ?? j['syncId'],
    leagueSyncId: j['league_id'] ?? j['leagueId'],
        description: j['description'] ?? '',
        isMandatory: j['is_mandatory'] ?? j['isMandatory'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'sync_id': syncId,
        'league_id': leagueSyncId,
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
