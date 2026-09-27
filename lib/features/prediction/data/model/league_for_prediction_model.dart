import 'matches_predictions_model.dart';

class LeagueForPredictionModel {
  final int id;
  final String name;
  final String logo;
  final List<MatchesPredictionsModel> matches;

  LeagueForPredictionModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.matches,
  });

  LeagueForPredictionModel copyWith({
    int? id,
    String? name,
    String? logo,
    List<MatchesPredictionsModel>? matches,
  }) {
    return LeagueForPredictionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      matches: matches ?? this.matches,
    );
  }

  factory LeagueForPredictionModel.fromJson(Map<String, dynamic> json) {
    return LeagueForPredictionModel(
        id: int.tryParse((json['id'] ?? 0).toString()) ?? 0,
        name: (json['name'] ?? '').toString(),
        logo: (json['logo'] ?? '').toString(),
        matches: MatchesPredictionsModel.fromJsonList(json['matches'] as List? ?? []));
  }

  static List<LeagueForPredictionModel> fromJsonList(List? json) {
    if (json == null) return [];
    return json
        .whereType<Map<String, dynamic>>()
        .map((e) => LeagueForPredictionModel.fromJson(e))
        .toList();
  }
}

class LeaguesContainerModel {
  final String date;
  final List<LeagueForPredictionModel> leagues;

  LeaguesContainerModel({
    required this.date,
    required this.leagues,
  });

  LeaguesContainerModel copyWith({
    String? date,
    List<LeagueForPredictionModel>? leagues,
  }) {
    return LeaguesContainerModel(
      date: date ?? this.date,
      leagues: leagues ?? this.leagues,
    );
  }

  factory LeaguesContainerModel.fromJson(Map<String, dynamic> json) {
    return LeaguesContainerModel(
        date: (json['label'] ?? json['date'] ?? '').toString(),
        leagues: LeagueForPredictionModel.fromJsonList(
            (json['competitions'] ?? json['leagues']) as List? ?? []));
  }

  static List<LeaguesContainerModel> fromJsonList(List? json) {
    if (json == null) return [];
    return json
        .whereType<Map<String, dynamic>>()
        .map((e) => LeaguesContainerModel.fromJson(e))
        .toList();
  }
}

