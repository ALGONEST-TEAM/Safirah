class MatchesPredictionsModel {
  final int matchId;
  final String matchDate;
  final String matchTime;
  final num? status;
  final String? statusColor;
  final String? resultInfo;
  final bool? hasPrediction;
  final bool? isSpecialMatch;
  final TeamModelForPrediction homeTeam;
  final TeamModelForPrediction awayTeam;
  final num? homeScore;
  final num? awayScore;
  final num? pointsEarned;
  final int? productionId;
  final int? minute;
  final int? second;
  final bool? ticking;
  final int? timeAdded;
  final String? lastGoalSide;
  final DateTime? lastGoalTime;

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
    this.minute,
    this.second,
    this.ticking,
    this.timeAdded,
    this.lastGoalSide,
    this.lastGoalTime,
  });

  factory MatchesPredictionsModel.fromJson(Map<String, dynamic> json) {
    final prediction = json['prediction'] as Map<String, dynamic>?;

    final clock = json['match_clock'] as Map<String, dynamic>?;
    final rawMinute = clock?['minute'] ?? json['minute'];
    final rawSecond = clock?['second'] ?? json['second'];
    final rawTicking = clock?['ticking'] ?? json['ticking'];
    final rawTimeAdded = clock?['added_time'] ?? clock?['time_added'] ?? json['time_added'];

    return MatchesPredictionsModel(
      matchId: json['match_id'],
      matchDate: json['match_date'] ?? '',
      matchTime: json['match_time'] ?? '',
      status: json['state_id'] ?? 0,
      resultInfo: json['result_info'] ?? '',
      hasPrediction: json['has_prediction'] ?? false,
      isSpecialMatch: json['is_special_match'] ?? false,
      homeTeam: TeamModelForPrediction.fromJson(json['home_team']),
      awayTeam: TeamModelForPrediction.fromJson(json['away_team']),
      statusColor: json['status_color'] ?? '',
      pointsEarned: json['points_earned'] ?? 0,
      homeScore: prediction?['home_score'] ?? 0,
      awayScore: prediction?['away_score'] ?? 0,
      productionId: json['id'] ?? 0,
      minute: rawMinute != null ? int.tryParse(rawMinute.toString()) : null,
      second: rawSecond != null ? int.tryParse(rawSecond.toString()) : null,
      ticking: rawTicking == true || rawTicking == 1 || rawTicking.toString() == 'true',
      timeAdded: rawTimeAdded != null ? int.tryParse(rawTimeAdded.toString()) : null,
    );
  }

  MatchesPredictionsModel copyWith({
    int? matchId,
    String? matchDate,
    String? matchTime,
    num? status,
    String? statusColor,
    String? resultInfo,
    bool? hasPrediction,
    bool? isSpecialMatch,
    TeamModelForPrediction? homeTeam,
    TeamModelForPrediction? awayTeam,
    num? pointsEarned,
    num? homeScore,
    num? awayScore,
    int? productionId,
    int? minute,
    int? second,
    bool? ticking,
    int? timeAdded,
    String? lastGoalSide,
    DateTime? lastGoalTime,
  }) {
    return MatchesPredictionsModel(
      matchId: matchId ?? this.matchId,
      matchDate: matchDate ?? this.matchDate,
      matchTime: matchTime ?? this.matchTime,
      status: status ?? this.status,
      statusColor: statusColor ?? this.statusColor,
      resultInfo: resultInfo ?? this.resultInfo,
      hasPrediction: hasPrediction ?? this.hasPrediction,
      isSpecialMatch: isSpecialMatch ?? this.isSpecialMatch,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      productionId: productionId ?? this.productionId,
      minute: minute ?? this.minute,
      second: second ?? this.second,
      ticking: ticking ?? this.ticking,
      timeAdded: timeAdded ?? this.timeAdded,
      lastGoalSide: lastGoalSide ?? this.lastGoalSide,
      lastGoalTime: lastGoalTime ?? this.lastGoalTime,
    );
  }

  static List<MatchesPredictionsModel> fromJsonList(List json) {
    return json.map((e) => MatchesPredictionsModel.fromJson(e)).toList();
  }
}

class TeamModelForPrediction {
  final int id;
  final String name;
  final String logo;
  final int? score;

  TeamModelForPrediction({
    required this.id,
    required this.name,
    required this.logo,
    this.score,
  });

  TeamModelForPrediction copyWith({
    int? id,
    String? name,
    String? logo,
    int? score,
  }) {
    return TeamModelForPrediction(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      score: score ?? this.score,
    );
  }

  factory TeamModelForPrediction.fromJson(Map<String, dynamic> json) {
    return TeamModelForPrediction(
      id: json['id'],
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
