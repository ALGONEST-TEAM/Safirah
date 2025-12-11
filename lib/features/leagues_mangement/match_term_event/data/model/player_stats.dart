class PlayerStatsState {
  final int goals;
  final int assists;
  final int yellow;
  final int red;

  PlayerStatsState({
    this.goals = 0,
    this.assists = 0,
    this.yellow = 0,
    this.red = 0,
  });

  PlayerStatsState copyWith({
    int? goals,
    int? assists,
    int? yellow,
    int? red,
  }) {
    return PlayerStatsState(
      goals: goals ?? this.goals,
      assists: assists ?? this.assists,
      yellow: yellow ?? this.yellow,
      red: red ?? this.red,
    );
  }
}
class PlayerStats {
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;

  PlayerStats({
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
  });
}