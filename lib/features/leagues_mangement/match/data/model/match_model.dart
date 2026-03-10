import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/safirah_database.dart';
import '../../../match_term_event/data/model/goal_model.dart';
import '../../../match_term_event/data/model/match_term_model.dart';
import '../../../match_term_event/data/model/warring_model.dart';
import '../../../team_and_player/data/model/team_model.dart';

class MatchModel {
  final int? id;
  final String? leagueSyncId;
  final String? syncId;
  final String? roundSyncId;

  final String? homeTeamSyncId;
  final String? awayTeamSyncId;

  // ✅ NEW
  final String? refereeSyncId;
  final String? mediaSyncId;

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
    this.leagueSyncId,
    this.roundSyncId,
    this.homeTeamSyncId,
    this.awayTeamSyncId,
    this.syncId,

    // ✅ NEW
    this.refereeSyncId,
    this.mediaSyncId,

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
    String? leagueSyncId,
    String? roundSyncId,
    String? homeTeamSyncId,
    String? awayTeamSyncId,

    // ✅ NEW
    String? refereeSyncId,
    String? mediaSyncId,

    String? syncId,
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
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        roundSyncId: roundSyncId ?? this.roundSyncId,
        homeTeamSyncId: homeTeamSyncId ?? this.homeTeamSyncId,
        awayTeamSyncId: awayTeamSyncId ?? this.awayTeamSyncId,

        // ✅ NEW
        refereeSyncId: refereeSyncId ?? this.refereeSyncId,
        mediaSyncId: mediaSyncId ?? this.mediaSyncId,

        syncId: syncId ?? this.syncId,
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

  int parseIntSafe(dynamic v, {int fallback = 0}) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? fallback;
    if (v is double) return v.toInt();
    return fallback;
  }

  /// ✅ من JSON
  factory MatchModel.fromJson(Map<String, dynamic> j) => MatchModel(
    id: j['id'],
    syncId: j['sync_id'],
    leagueSyncId: (j['league_id'] ?? j['leagueId'] ?? j['league_sync_id']),
    roundSyncId: (j['round_sync_id'] ?? j['roundSyncId'] ?? j['round_id']),
    homeTeamSyncId: (j['home_team_sync_id'] ??
        j['homeTeamSyncId'] ??
        j['home_team_id']),
    awayTeamSyncId: (j['away_team_sync_id'] ??
        j['awayTeamSyncId'] ??
        j['away_team_id']),

    matchDate: _parseDate(j['match_date'] ?? j['matchDate']),
    scheduledStartTime:
    _parseDate(j['scheduled_start_time'] ?? j['scheduledStartTime']),
    startTime: _parseDate(j['start_time'] ?? j['startTime']),
    endTime: _parseDate(j['end_time'] ?? j['endTime']),
    homeScore: (j['home_score'] ?? j['homeScore']) ?? 0,
    awayScore: (j['away_score'] ?? j['awayScore']) ?? 0,
    status: (j['status'] ?? 'scheduled'),
    homeTeam: j['home_team'] != null
        ? TeamModel.fromJson(j['home_team'] as Map<String, dynamic>)
        : null,
    awayTeam: j['away_team'] != null
        ? TeamModel.fromJson(j['away_team'] as Map<String, dynamic>)
        : null,
    matchTerms: MatchTermModel.fromJsonList(j['match_terms'] ?? j['matchTerms'] ?? []),
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
    'match_sync_id': syncId,
    'league_sync_id': leagueSyncId,
    'round_sync_id': roundSyncId,
    'home_team_sync_id': homeTeamSyncId,
    'away_team_sync_id': awayTeamSyncId,
    'match_date': matchDate?.toIso8601String(),
    'scheduled_start_time': scheduledStartTime?.toIso8601String(),
    if (refereeSyncId != null) 'referee_sync_id': refereeSyncId,
    if (mediaSyncId != null) 'media_sync_id': mediaSyncId,

    'status': status,
    'match_terms': matchTerms.map((e) => e.toJson()).toList(),
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
        syncId: m.syncId,
        leagueSyncId: m.leagueSyncId,
        roundSyncId: m.roundSyncId,
        homeTeamSyncId: m.homeTeamSyncId,
        awayTeamSyncId: m.awayTeamSyncId,
        refereeSyncId: m.refereeSyncId,
        mediaSyncId: m.mediaSyncId,
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
  MatchesCompanion toUpsertCompanion({
    required String fallbackLeagueSyncId,
    required String fallbackRoundSyncId,
  }) {
    final now = DateTime.now();

    final league = (leagueSyncId ?? '').trim().isNotEmpty
        ? leagueSyncId!.trim()
        : fallbackLeagueSyncId.trim();

    final round = (roundSyncId ?? '').trim().isNotEmpty
        ? roundSyncId!.trim()
        : fallbackRoundSyncId.trim();

    return MatchesCompanion.insert(
      syncId: (syncId ?? const Uuid().v7()).trim(),
      leagueSyncId: league,
      roundSyncId: round,
      homeTeamSyncId: (homeTeamSyncId ?? '').trim(),
      awayTeamSyncId: (awayTeamSyncId ?? '').trim(),
      refereeSyncId:
      refereeSyncId != null ? Value(refereeSyncId!.trim()) : const Value.absent(),
      mediaSyncId:
      mediaSyncId != null ? Value(mediaSyncId!.trim()) : const Value.absent(),
      matchDate: matchDate ?? now,
      scheduledStartTime: scheduledStartTime != null
          ? Value(scheduledStartTime!)
          : const Value.absent(),
      startTime: startTime != null ? Value(startTime!) : const Value.absent(),
      endTime: endTime != null ? Value(endTime!) : const Value.absent(),
      homeScore: Value(homeScore),
      awayScore: Value(awayScore),
      status: Value(status),
      updatedAt: Value(updatedAt ?? now),
    );
  }
  static List<MatchModel> fromJsonList(List json) {
    return json.map((e) => MatchModel.fromJson(e)).toList();
  }
}

// === helper function ===
DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
  return null;
}
