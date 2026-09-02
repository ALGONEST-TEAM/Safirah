class MatchStatisticsModel {
  final int matchId;
  final String selectedPeriod;
  final List<StatPeriodModel> periods;
  final StatTeamsModel? teams;
  final List<StatSectionModel> sections;
  final String syncedAt;

  MatchStatisticsModel({
    required this.matchId,
    required this.selectedPeriod,
    required this.periods,
    this.teams,
    required this.sections,
    required this.syncedAt,
  });

  factory MatchStatisticsModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsModel(
      matchId: json['match_id'] ?? 0,
      selectedPeriod: json['selected_period'] ?? 'all',
      periods: json['periods'] != null
          ? (json['periods'] as List)
              .map((e) => StatPeriodModel.fromJson(e))
              .toList()
          : [],
      teams: json['teams'] != null ? StatTeamsModel.fromJson(json['teams']) : null,
      sections: json['sections'] != null
          ? (json['sections'] as List)
              .map((e) => StatSectionModel.fromJson(e))
              .toList()
          : [],
      syncedAt: json['synced_at'] ?? '',
    );
  }

  factory MatchStatisticsModel.empty() {
    return MatchStatisticsModel(
      matchId: 0,
      selectedPeriod: 'all',
      periods: [],
      sections: [],
      syncedAt: '',
    );
  }
}

class StatPeriodModel {
  final String key;
  final String labelAr;
  final String labelEn;
  final bool available;
  final bool selected;

  StatPeriodModel({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.available,
    required this.selected,
  });

  factory StatPeriodModel.fromJson(Map<String, dynamic> json) {
    return StatPeriodModel(
      key: json['key'] ?? '',
      labelAr: json['label_ar'] ?? '',
      labelEn: json['label_en'] ?? '',
      available: json['available'] ?? false,
      selected: json['selected'] ?? false,
    );
  }
}

class StatTeamsModel {
  final StatTeamModel? home;
  final StatTeamModel? away;

  StatTeamsModel({this.home, this.away});

  factory StatTeamsModel.fromJson(Map<String, dynamic> json) {
    return StatTeamsModel(
      home: json['home'] != null ? StatTeamModel.fromJson(json['home']) : null,
      away: json['away'] != null ? StatTeamModel.fromJson(json['away']) : null,
    );
  }
}

class StatTeamModel {
  final int id;
  final int sportmonksId;
  final String name;
  final String imagePath;
  final String color;

  String get logo => imagePath;

  StatTeamModel({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.imagePath,
    required this.color,
  });

  factory StatTeamModel.fromJson(Map<String, dynamic> json) {
    return StatTeamModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
      color: json['color'] ?? '',
    );
  }
}

class StatSectionModel {
  final String key;
  final String labelAr;
  final String labelEn;
  final List<StatItemModel> items;

  StatSectionModel({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.items,
  });

  factory StatSectionModel.fromJson(Map<String, dynamic> json) {
    return StatSectionModel(
      key: json['key'] ?? '',
      labelAr: json['label_ar'] ?? '',
      labelEn: json['label_en'] ?? '',
      items: json['items'] != null
          ? (json['items'] as List)
              .map((e) => StatItemModel.fromJson(e))
              .toList()
          : [],
    );
  }
}

class StatItemModel {
  final int typeId;
  final String code;
  final String labelAr;
  final String labelEn;
  final num home;
  final num away;
  final String? unit;
  final String leader;
  final StatComparisonModel? comparison;

  StatItemModel({
    required this.typeId,
    required this.code,
    required this.labelAr,
    required this.labelEn,
    required this.home,
    required this.away,
    this.unit,
    required this.leader,
    this.comparison,
  });

  String get title => labelAr.isNotEmpty ? labelAr : labelEn;

  double get homeVal => home.toDouble();
  double get awayVal => away.toDouble();

  String get homeText => (unit == 'percentage' || code.contains('possession'))
      ? '$home%'
      : '$home';

  String get awayText => (unit == 'percentage' || code.contains('possession'))
      ? '$away%'
      : '$away';

  bool get lowerIsBetter =>
      code == 'offsides' ||
      code == 'yellowcards' ||
      code == 'redcards' ||
      code == 'fouls';

  factory StatItemModel.fromJson(Map<String, dynamic> json) {
    return StatItemModel(
      typeId: json['type_id'] ?? 0,
      code: json['code'] ?? '',
      labelAr: json['label_ar'] ?? '',
      labelEn: json['label_en'] ?? '',
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
      unit: json['unit'],
      leader: json['leader'] ?? '',
      comparison: json['comparison'] != null
          ? StatComparisonModel.fromJson(json['comparison'])
          : null,
    );
  }
}

class StatComparisonModel {
  final num homePercentage;
  final num awayPercentage;

  StatComparisonModel({
    required this.homePercentage,
    required this.awayPercentage,
  });

  factory StatComparisonModel.fromJson(Map<String, dynamic> json) {
    return StatComparisonModel(
      homePercentage: json['home_percentage'] ?? 0,
      awayPercentage: json['away_percentage'] ?? 0,
    );
  }
}
