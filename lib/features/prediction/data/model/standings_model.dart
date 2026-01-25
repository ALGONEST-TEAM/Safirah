class StandingsData {
  final String scope;
  final String season;
  final num participantsCount;
  final List<StandingItemData> items;
  final StandingItemData userItem;

  StandingsData({
    required this.scope,
    required this.season,
    required this.participantsCount,
    required this.items,
    required this.userItem,
  });

  factory StandingsData.fromJson(Map<String, dynamic> json) {
    final season = json['season'] as Map<String, dynamic>?;

    return StandingsData(
      scope: (json['scope'] ?? '').toString(),
      season: season?['name'] ?? '',
      participantsCount: (json['participants_count'] ?? 0) as num,
      items: StandingItemData.fromJsonList(json['items'] ?? []),
      userItem: json['current_user'] == null
          ? StandingItemData.empty()
          : StandingItemData.fromJson(
              json['current_user'] as Map<String, dynamic>,
            ),
    );
  }

  static StandingsData empty() {
    return StandingsData(
      scope: '',
      season: '',
      participantsCount: 0,
      items: [],
      userItem: StandingItemData.empty(),
    );
  }
}

class StandingItemData {
  final num rank;
  final num points;
  final num predictionPoints;
  final num specialPoints;
  final num correctPredictions;
  final num incorrectPredictions;
  final num totalPredictions;
  final String user;
  final String trend;

  StandingItemData({
    required this.rank,
    required this.points,
    required this.predictionPoints,
    required this.specialPoints,
    required this.correctPredictions,
    required this.incorrectPredictions,
    required this.totalPredictions,
    required this.user,
    required this.trend,
  });

  factory StandingItemData.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;

    return StandingItemData(
      rank: (json['rank'] ?? 0) as num,
      points: (json['points'] ?? 0) as num,
      predictionPoints: (json['prediction_points'] ?? 0) as num,
      specialPoints: (json['special_points'] ?? 0) as num,
      correctPredictions: (json['correct_predictions'] ?? 0) as num,
      incorrectPredictions: (json['incorrect_predictions'] ?? 0) as num,
      totalPredictions: (json['total_predictions'] ?? 0) as num,
      user: user?['name'] ?? '',
      trend: json['trend'] ?? '',
    );
  }

  static List<StandingItemData> fromJsonList(List json) {
    return json.map((e) => StandingItemData.fromJson(e)).toList();
  }

  static StandingItemData empty() {
    return StandingItemData(
      rank: 0,
      points: 0,
      predictionPoints: 0,
      specialPoints: 0,
      correctPredictions: 0,
      incorrectPredictions: 0,
      totalPredictions: 0,
      user: '',
      trend: '',
    );
  }
}
