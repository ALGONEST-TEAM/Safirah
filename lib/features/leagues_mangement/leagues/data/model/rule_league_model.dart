import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';

class LeagueRuleModel {
  final int? id;
  final int leagueId;
  final String description;
  final bool isMandatory;

  LeagueRuleModel({
    this.id,
    required this.leagueId,
    required this.description,
    this.isMandatory = false,
  });

  LeagueRulesCompanion toCompanion(int idLeague) {
    return LeagueRulesCompanion.insert(
      leagueId: idLeague,
      description: description,
      isMandatory: Value(isMandatory),
    );
  }

  factory LeagueRuleModel.fromEntity(LeagueRule entity) {
    return LeagueRuleModel(
      id: entity.id,
      leagueId: entity.leagueId,
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
