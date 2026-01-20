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

  factory LeagueForPredictionModel.fromJson(Map<String, dynamic> json) {
    return LeagueForPredictionModel(
        id: json['id'],
        name: json['name'] ?? '',
        logo: json['logo'] ?? '',
        matches: MatchesPredictionsModel.fromJsonList(json['matches'] ?? []));
  }

  static List<LeagueForPredictionModel> fromJsonList(List json) {
    return json.map((e) => LeagueForPredictionModel.fromJson(e)).toList();
  }
}

class LeaguesContainerModel {
  final String date;
  final List<LeagueForPredictionModel> leagues;

  LeaguesContainerModel({
    required this.date,
    required this.leagues,
  });

  factory LeaguesContainerModel.fromJson(Map<String, dynamic> json) {
    return LeaguesContainerModel(
        date: json['label'] ?? '',
        leagues: LeagueForPredictionModel.fromJsonList(json['competitions'] ?? []));
  }

  static List<LeaguesContainerModel> fromJsonList(List json) {
    return json.map((e) => LeaguesContainerModel.fromJson(e)).toList();
  }
}

