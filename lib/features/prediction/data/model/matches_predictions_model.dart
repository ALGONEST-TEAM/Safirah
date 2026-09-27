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
      matchId: int.tryParse((json['match_id'] ?? json['id'] ?? 0).toString()) ?? 0,
      matchDate: (json['match_date'] ?? '').toString(),
      matchTime: (json['match_time'] ?? '').toString(),
      status: json['state_id'] != null ? num.tryParse(json['state_id'].toString()) ?? 0 : 0,
      resultInfo: (json['result_info'] ?? '').toString(),
      hasPrediction: json['has_prediction'] == true || json['has_prediction'] == 1 || json['has_prediction'].toString() == 'true',
      isSpecialMatch: json['is_special_match'] == true || json['is_special_match'] == 1 || json['is_special_match'].toString() == 'true',
      homeTeam: TeamModelForPrediction.fromJson(json['home_team']),
      awayTeam: TeamModelForPrediction.fromJson(json['away_team']),
      statusColor: (json['status_color'] ?? '').toString(),
      pointsEarned: json['points_earned'] != null ? num.tryParse(json['points_earned'].toString()) ?? 0 : 0,
      homeScore: prediction?['home_score'] != null ? num.tryParse(prediction!['home_score'].toString()) ?? 0 : 0,
      awayScore: prediction?['away_score'] != null ? num.tryParse(prediction!['away_score'].toString()) ?? 0 : 0,
      productionId: int.tryParse((json['id'] ?? 0).toString()) ?? 0,
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

  static List<MatchesPredictionsModel> fromJsonList(List? json) {
    if (json == null) return [];
    return json
        .whereType<Map<String, dynamic>>()
        .map((e) => MatchesPredictionsModel.fromJson(e))
        .toList();
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

  factory TeamModelForPrediction.fromJson(dynamic json) {
    if (json == null || json is! Map) {
      return TeamModelForPrediction(id: 0, name: '', logo: '', score: 0);
    }
    return TeamModelForPrediction(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      name: (json['name'] ?? '').toString(),
      logo: (json['logo'] ?? '').toString(),
      score: json['score'] != null ? int.tryParse(json['score'].toString()) ?? 0 : 0,
    );
  }
}
