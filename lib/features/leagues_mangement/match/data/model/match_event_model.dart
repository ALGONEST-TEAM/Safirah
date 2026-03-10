import 'package:flutter/foundation.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';

class MatchEventModel {
  const MatchEventModel({
    required this.minute,
    required this.type,
    required this.teamName,
    this.playerName,
    this.extraText,
    this.scoreText,
  });
  final String minute;
  final MatchEventType type;
  final String teamName;
  final String? playerName;
  final String? extraText;
  final String? scoreText;

  MatchEventModel copyWith({
    String? minute,
    MatchEventType? type,
    String? teamName,
    String? playerName,
    String? extraText,
    String? scoreText,
  }) {
    return MatchEventModel(
      minute: minute ?? this.minute,
      type: type ?? this.type,
      teamName: teamName ?? this.teamName,
      playerName: playerName ?? this.playerName,
      extraText: extraText ?? this.extraText,
      scoreText: scoreText ?? this.scoreText,
    );
  }

  factory MatchEventModel.fromJson(Map<String, dynamic> j) {
    return MatchEventModel(
      minute: (j['minute'] ?? j['minute_text'] ?? '').toString(),
      type: MatchEventTypeX.tryParse(j['type']) ?? MatchEventType.goal,
      teamName: (j['team_name'] ?? j['team'] ?? '').toString(),
      playerName: j['player_name']?.toString(),
      extraText: j['extra_text']?.toString(),
      scoreText: j['score_text']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minute': minute,
      'type': type.apiValue,
      'team_name': teamName,
      if (playerName != null) 'player_name': playerName,
      if (extraText != null) 'extra_text': extraText,
      if (scoreText != null) 'score_text': scoreText,
    };
  }

  static List<MatchEventModel> fromJsonList(List json) {
    return json
        .whereType<Map>()
        .map((e) => MatchEventModel.fromJson(e.cast<String, dynamic>()))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<MatchEventModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}

enum MatchEventType { goal, yellowCard, redCard, substitution, scoreSeparator }

extension MatchEventTypeX on MatchEventType {
  String get apiValue {
    switch (this) {
      case MatchEventType.goal:
        return 'goal';
      case MatchEventType.yellowCard:
        return 'yellow_card';
      case MatchEventType.redCard:
        return 'red_card';
      case MatchEventType.substitution:
        return 'substitution';
      case MatchEventType.scoreSeparator:
        return 'score_separator';
    }
  }

  static MatchEventType? tryParse(dynamic v) {
    final s = v?.toString().trim().toLowerCase();
    switch (s) {
      case 'goal':
        return MatchEventType.goal;
      case 'yellow_card':
      case 'yellowcard':
      case 'yellow':
        return MatchEventType.yellowCard;
      case 'red_card':
      case 'redcard':
      case 'red':
        return MatchEventType.redCard;
      case 'substitution':
      case 'sub':
        return MatchEventType.substitution;
      case 'score_separator':
      case 'separator':
      case 'score':
        return MatchEventType.scoreSeparator;
      default:
        return null;
    }
  }
}

/// مودل موحّد لبيانات صفحة تفاصيل المباراة (الهيدر + أحداث المباراة)
///
/// يفترض أن الـ API يرجع هذا الـ payload مرة واحدة.
class MatchDetailsModel {
  const MatchDetailsModel({
    required this.leagueName,
    required this.roundName,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.statusText,
    required this.homeScorers,
    required this.awayScorers,
    required this.events,
  });

  final String leagueName;
  final String roundName;

  final TeamModel homeTeam;
  final TeamModel awayTeam;

  final int homeScore;
  final int awayScore;

  final String statusText;

  final List<String> homeScorers;

  final List<String> awayScorers;

  final List<MatchEventModel> events;

  MatchDetailsModel copyWith({
    String? leagueName,
    String? roundName,
    TeamModel? homeTeam,
    TeamModel? awayTeam,
    int? homeScore,
    int? awayScore,
    String? statusText,
    List<String>? homeScorers,
    List<String>? awayScorers,
    List<MatchEventModel>? events,
  }) {
    return MatchDetailsModel(
      leagueName: leagueName ?? this.leagueName,
      roundName: roundName ?? this.roundName,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      statusText: statusText ?? this.statusText,
      homeScorers: homeScorers ?? this.homeScorers,
      awayScorers: awayScorers ?? this.awayScorers,
      events: events ?? this.events,
    );
  }

  factory MatchDetailsModel.fromJson(Map<String, dynamic> j) {
    return MatchDetailsModel(
      leagueName: (j['league_name'] ?? j['league'] ?? '').toString(),
      roundName: (j['round_name'] ?? j['round'] ?? '').toString(),
      homeTeam: (TeamModel.fromJson(j['home_team']) ),
      awayTeam: (TeamModel.fromJson(j['away_team'])),
      homeScore: _asInt(j['home_score']),
      awayScore: _asInt(j['away_score']),
      statusText: (j['status_text'] ?? j['status'] ?? '').toString(),
      homeScorers: _asStringList(j['home_scorers'] ?? j['home_scorers_text']),
      awayScorers: _asStringList(j['away_scorers'] ?? j['away_scorers_text']),
      events: j['events'] is List
          ? MatchEventModel.fromJsonList(j['events'] as List)
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league_name': leagueName,
      'round_name': roundName,
      'home_team_name': homeTeam,
      'away_team_name': awayTeam,
      'home_score': homeScore,
      'away_score': awayScore,
      'status_text': statusText,
      'home_scorers': homeScorers,
      'away_scorers': awayScorers,
      'events': MatchEventModel.toJsonList(events),
    };
  }

  static int _asInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  static List<String> _asStringList(dynamic v) {
    if (v is List) {
      return v.map((e) => e.toString()).toList();
    }
    if (v == null) return const [];
    final s = v.toString().trim();
    if (s.isEmpty) return const [];
    if (s.contains(',')) {
      return s
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [s];
  }
}
