class MatchFixtureStandingsModel {
  final int matchId;
  final MatchStandingsCompetitionModel? competition;
  final MatchStandingsSeasonModel? season;
  final List<MatchStandingsColumnModel> columns;
  final MatchStandingsFiltersModel? filters;
  final List<MatchStandingsTableContainerModel> tables;
  final String syncedAt;

  MatchFixtureStandingsModel({
    required this.matchId,
    this.competition,
    this.season,
    required this.columns,
    this.filters,
    required this.tables,
    required this.syncedAt,
  });

  factory MatchFixtureStandingsModel.fromJson(Map<String, dynamic> json) {
    return MatchFixtureStandingsModel(
      matchId: json['match_id'] ?? 0,
      competition: json['competition'] != null
          ? MatchStandingsCompetitionModel.fromJson(json['competition'])
          : null,
      season: json['season'] != null
          ? MatchStandingsSeasonModel.fromJson(json['season'])
          : null,
      columns: json['columns'] != null
          ? (json['columns'] as List)
              .map((e) => MatchStandingsColumnModel.fromJson(e))
              .toList()
          : [],
      filters: json['filters'] != null
          ? MatchStandingsFiltersModel.fromJson(json['filters'])
          : null,
      tables: json['tables'] != null
          ? (json['tables'] as List)
              .map((e) => MatchStandingsTableContainerModel.fromJson(e))
              .toList()
          : [],
      syncedAt: json['synced_at'] ?? '',
    );
  }

  factory MatchFixtureStandingsModel.empty() {
    return MatchFixtureStandingsModel(
      matchId: 0,
      columns: [],
      tables: [],
      syncedAt: '',
    );
  }
}

class MatchStandingsCompetitionModel {
  final int id;
  final String sportmonksId;
  final String name;
  final String imagePath;

  MatchStandingsCompetitionModel({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.imagePath,
  });

  factory MatchStandingsCompetitionModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsCompetitionModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id']?.toString() ?? '',
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }
}

class MatchStandingsSeasonModel {
  final int id;
  final int competitionSeasonId;
  final String sportmonksId;
  final String name;
  final String? year;

  MatchStandingsSeasonModel({
    required this.id,
    required this.competitionSeasonId,
    required this.sportmonksId,
    required this.name,
    this.year,
  });

  factory MatchStandingsSeasonModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsSeasonModel(
      id: json['id'] ?? 0,
      competitionSeasonId: json['competition_season_id'] ?? 0,
      sportmonksId: json['sportmonks_id']?.toString() ?? '',
      name: json['name'] ?? '',
      year: json['year']?.toString(),
    );
  }
}

class MatchStandingsColumnModel {
  final String key;
  final String labelAr;
  final String labelEn;

  MatchStandingsColumnModel({
    required this.key,
    required this.labelAr,
    required this.labelEn,
  });

  factory MatchStandingsColumnModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsColumnModel(
      key: json['key'] ?? '',
      labelAr: json['label_ar'] ?? '',
      labelEn: json['label_en'] ?? '',
    );
  }
}

class MatchStandingsFiltersModel {
  final String selectedGroup;
  final List<MatchStandingsGroupModel> groups;

  MatchStandingsFiltersModel({
    required this.selectedGroup,
    required this.groups,
  });

  factory MatchStandingsFiltersModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsFiltersModel(
      selectedGroup: json['selected_group'] ?? 'all',
      groups: json['groups'] != null
          ? (json['groups'] as List)
              .map((e) => MatchStandingsGroupModel.fromJson(e))
              .toList()
          : [],
    );
  }
}

class MatchStandingsGroupModel {
  final String key;
  final int? id;
  final String labelAr;
  final String labelEn;
  final bool selected;

  MatchStandingsGroupModel({
    required this.key,
    this.id,
    required this.labelAr,
    required this.labelEn,
    required this.selected,
  });

  factory MatchStandingsGroupModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsGroupModel(
      key: json['key'] ?? '',
      id: json['id'],
      labelAr: json['label_ar'] ?? '',
      labelEn: json['label_en'] ?? '',
      selected: json['selected'] ?? false,
    );
  }
}

class MatchStandingsTableContainerModel {
  final MatchStandingsStageModel? stage;
  final MatchStandingsRoundModel? round;
  final List<MatchTeamStandingItemModel> standings;
  final List<MatchStandingsRuleModel> rulesLegend;

  MatchStandingsTableContainerModel({
    this.stage,
    this.round,
    required this.standings,
    this.rulesLegend = const [],
  });

  factory MatchStandingsTableContainerModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsTableContainerModel(
      stage: json['stage'] != null
          ? MatchStandingsStageModel.fromJson(json['stage'])
          : null,
      round: json['round'] != null
          ? MatchStandingsRoundModel.fromJson(json['round'])
          : null,
      standings: json['standings'] != null
          ? (json['standings'] as List)
              .map((e) => MatchTeamStandingItemModel.fromJson(e))
              .toList()
          : [],
      rulesLegend: json['rules_legend'] != null
          ? (json['rules_legend'] as List)
              .map((e) => MatchStandingsRuleModel.fromJson(e))
              .toList()
          : [],
    );
  }
}

class MatchStandingsStageModel {
  final int id;
  final String name;

  MatchStandingsStageModel({required this.id, required this.name});

  factory MatchStandingsStageModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsStageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class MatchStandingsRoundModel {
  final int id;
  final String name;

  MatchStandingsRoundModel({required this.id, required this.name});

  factory MatchStandingsRoundModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsRoundModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class MatchTeamStandingItemModel {
  final int position;
  final MatchStandingsTeamDetailModel? team;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;
  final String result;
  final bool isMatchTeam;
  final String? matchTeamSide;
  final MatchStandingsRuleModel? rule;

  MatchTeamStandingItemModel({
    required this.position,
    this.team,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
    required this.result,
    required this.isMatchTeam,
    this.matchTeamSide,
    this.rule,
  });

  factory MatchTeamStandingItemModel.fromJson(Map<String, dynamic> json) {
    return MatchTeamStandingItemModel(
      position: json['position'] ?? 0,
      team: json['team'] != null
          ? MatchStandingsTeamDetailModel.fromJson(json['team'])
          : null,
      played: json['played'] ?? 0,
      won: json['won'] ?? 0,
      drawn: json['drawn'] ?? 0,
      lost: json['lost'] ?? 0,
      goalsFor: json['goals_for'] ?? 0,
      goalsAgainst: json['goals_against'] ?? 0,
      goalDifference: json['goal_difference'] ?? 0,
      points: json['points'] ?? 0,
      result: json['result'] ?? '',
      isMatchTeam: json['is_match_team'] ?? false,
      matchTeamSide: json['match_team_side'],
      rule: json['rule'] != null ? MatchStandingsRuleModel.fromJson(json['rule']) : null,
    );
  }
}

class MatchStandingsRuleModel {
  final int id;
  final String code;
  final String name;
  final String color;

  MatchStandingsRuleModel({
    required this.id,
    required this.code,
    required this.name,
    required this.color,
  });

  factory MatchStandingsRuleModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsRuleModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      color: json['color'] ?? '',
    );
  }
}

class MatchStandingsTeamDetailModel {
  final int id;
  final int sportmonksId;
  final String name;
  final String? shortCode;
  final String imagePath;

  MatchStandingsTeamDetailModel({
    required this.id,
    required this.sportmonksId,
    required this.name,
    this.shortCode,
    required this.imagePath,
  });

  factory MatchStandingsTeamDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchStandingsTeamDetailModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      name: json['name'] ?? '',
      shortCode: json['short_code'],
      imagePath: json['image_path'] ?? '',
    );
  }
}
