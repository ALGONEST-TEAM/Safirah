class MatchesPredictionsModel {
  final int matchId;
  final String matchDate;
  final String matchTime;
  final num? status;
  final String? statusColor;
  final String? resultInfo;
  final bool? hasPrediction;
  final bool? isSpecialMatch;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final num? homeScore;
  final num? awayScore;
  final num? pointsEarned;
  final int? productionId;

  MatchesPredictionsModel({
    required this.matchId,
    required this.matchDate,
    required this.matchTime,
    this.status,
    this.statusColor,
    this.resultInfo,
    this.hasPrediction,
    this.isSpecialMatch,
    required this.homeTeam,
    required this.awayTeam,
    this.pointsEarned,
    this.homeScore,
    this.awayScore,
    this.productionId,
  });

  factory MatchesPredictionsModel.fromJson(Map<String, dynamic> json) {
    final prediction = json['prediction'] as Map<String, dynamic>?;

    return MatchesPredictionsModel(
      matchId: json['match_id'],
      matchDate: json['match_date'] ?? '',
      matchTime: json['match_time'] ?? '',
      status: json['state_id'] ?? 0,
      resultInfo: json['result_info'] ?? '',
      hasPrediction: json['has_prediction'] ?? false,
      isSpecialMatch: json['is_special_match'] ?? false,
      homeTeam: TeamModel.fromJson(json['home_team']),
      awayTeam: TeamModel.fromJson(json['away_team']),
      statusColor: json['status_color'] ?? '',
      pointsEarned: json['points_earned'] ?? 0,
      homeScore: prediction?['home_score'] ?? 0,
      awayScore: prediction?['away_score'] ?? 0,
      productionId: json['id']??0,
    );
  }

  static List<MatchesPredictionsModel> fromJsonList(List json) {
    return json.map((e) => MatchesPredictionsModel.fromJson(e)).toList();
  }
}

class TeamModel {
  final int id;
  final String name;
  final String logo;
  final int? score;

  TeamModel({
    required this.id,
    required this.name,
    required this.logo,
    this.score,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
