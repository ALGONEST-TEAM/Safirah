import '../../../../../core/database/safirah_database.dart';
import '../../../match_term_event/data/model/goal_model.dart';
import '../../../match_term_event/data/model/match_term_model.dart';
import '../../../match_term_event/data/model/warring_model.dart';
import '../../../team_and_player/data/model/team_model.dart';

class MatchModel {
  final int? id;
  final int? leagueId;
  final int? roundId;
  final int? homeTeamId;
  final int? awayTeamId;
  final int? stadiumId;

  final DateTime? matchDate;
  final DateTime? scheduledStartTime;
  final DateTime? startTime;
  final DateTime? endTime;

  final int homeScore;
  final int awayScore;
  final String status;

  final TeamModel? homeTeam;
  final TeamModel? awayTeam;

  final List<MatchTermModel> matchTerms;
  final List<GoalModel> goals;
  final List<WarningModel> warnings;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MatchModel({
    this.id,
     this.leagueId,
     this.roundId,
    this.homeTeamId,
    this.awayTeamId,
    this.stadiumId,
    this.matchDate,
    this.scheduledStartTime,
    this.startTime,
    this.endTime,
    this.homeScore = 0,
    this.awayScore = 0,
    this.status = 'scheduled',
    this.homeTeam,
    this.awayTeam,
    this.matchTerms = const [],
    this.goals = const [],
    this.warnings = const [],
    this.createdAt,
    this.updatedAt,
  });

  MatchModel copyWith({
    int? id,
    int? leagueId,
    int? roundId,
    int? homeTeamId,
    int? awayTeamId,
    int? stadiumId,
    DateTime? matchDate,
    DateTime? scheduledStartTime,
    DateTime? startTime,
    DateTime? endTime,
    int? homeScore,
    int? awayScore,
    String? status,
    TeamModel? homeTeam,
    TeamModel? awayTeam,
    List<MatchTermModel>? matchTerms,
    List<GoalModel>? goals,
    List<WarningModel>? warnings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MatchModel(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        roundId: roundId ?? this.roundId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        stadiumId: stadiumId ?? this.stadiumId,
        matchDate: matchDate ?? this.matchDate,
        scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        homeScore: homeScore ?? this.homeScore,
        awayScore: awayScore ?? this.awayScore,
        status: status ?? this.status,
        homeTeam: homeTeam ?? this.homeTeam,
        awayTeam: awayTeam ?? this.awayTeam,
        matchTerms: matchTerms ?? this.matchTerms,
        goals: goals ?? this.goals,
        warnings: warnings ?? this.warnings,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  /// ✅ من JSON
  factory MatchModel.fromJson(Map<String, dynamic> j) => MatchModel(
    id: j['id'] as int?,
    leagueId: (j['league_id'] ?? j['leagueId']) as int,
    roundId: (j['round_id'] ?? j['roundId']) as int,
    homeTeamId: (j['home_team_id'] ?? j['homeTeamId']) as int?,
    awayTeamId: (j['away_team_id'] ?? j['awayTeamId']) as int?,
    stadiumId: (j['stadium_id'] ?? j['stadiumId']) as int?,
    matchDate: _parseDate(j['match_date'] ?? j['matchDate']),
    scheduledStartTime: _parseDate(j['scheduled_start_time'] ?? j['scheduledStartTime']),
    startTime: _parseDate(j['start_time'] ?? j['startTime']),
    endTime: _parseDate(j['end_time'] ?? j['endTime']),
    homeScore: (j['home_score'] ?? j['homeScore'] ?? 0) as int,
    awayScore: (j['away_score'] ?? j['awayScore'] ?? 0) as int,
    status: (j['status'] ?? 'scheduled') as String,
    homeTeam: j['home_team'] != null
        ? TeamModel.fromJson(j['home_team'] as Map<String, dynamic>)
        : null,
    awayTeam: j['away_team'] != null
        ? TeamModel.fromJson(j['away_team'] as Map<String, dynamic>)
        : null,
    matchTerms: j['match_terms'] != null
        ? (j['match_terms'] as List)
        .map((e) => MatchTermModel.fromEntity(MatchTerm.fromJson(e)))
        .toList()
        : [],
    goals: j['goals'] != null
        ? (j['goals'] as List)
        .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
        .toList()
        : [],
    warnings: j['warnings'] != null
        ? (j['warnings'] as List)
        .map((e) => WarningModel.fromJson(e as Map<String, dynamic>))
        .toList()
        : [],
    createdAt: _parseDate(j['created_at'] ?? j['createdAt']),
    updatedAt: _parseDate(j['updated_at'] ?? j['updatedAt']),
  );

  /// ✅ إلى JSON
  Map<String, dynamic> toJson() => {
  'id': id,
  'league_id': leagueId,
  'round_id': roundId,
  'home_team_id': homeTeamId,
  'away_team_id': awayTeamId,
  'stadium_id': stadiumId,
  'match_date': matchDate?.toIso8601String(),
  'scheduled_start_time': scheduledStartTime?.toIso8601String(),
  'start_time': startTime?.toIso8601String(),
  'end_time': endTime?.toIso8601String(),
  'home_score': homeScore,
  'away_score': awayScore,
  'status': status,
  'home_team': homeTeam?.toJson(),
  'away_team': awayTeam?.toJson(),
  'match_terms': matchTerms.map((e) => e.toJson()).toList(),
  'goals': goals.map((e) => e.toJson()).toList(),
  'warnings': warnings.map((e) => e.toJson()).toList(),
  'created_at': createdAt?.toIso8601String(),
  'updated_at': updatedAt?.toIso8601String(),
  };

  /// ✅ من Drift entity مع العلاقات
  static MatchModel fromEntityWithRelations(
      Matche m, {
        Team? home,
        Team? away,
        List<MatchTermModel>? matchTerms,
        List<GoalModel>? goals,
        List<WarningModel>? warnings,
      }) =>
      MatchModel(
        id: m.id,
        leagueId: m.leagueId,
        roundId: m.roundId,
        homeTeamId: m.homeTeamId,
        awayTeamId: m.awayTeamId,

        matchDate: m.matchDate,
        scheduledStartTime: m.scheduledStartTime,
        startTime: m.startTime,
        endTime: m.endTime,
        homeScore: m.homeScore,
        awayScore: m.awayScore,
        status: m.status,
        homeTeam: home != null ? TeamModel.fromEntity(home) : null,
        awayTeam: away != null ? TeamModel.fromEntity(away) : null,
        matchTerms: matchTerms ?? [],
        goals: goals ?? [],
        warnings: warnings ?? [],
        createdAt: m.createdAt,
        updatedAt: m.updatedAt,
      );
}

// === helper function ===
DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}
