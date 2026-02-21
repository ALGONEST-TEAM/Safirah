import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';

class LeagueStatusModel {
  final int? id;
  final String leagueSyncId;
  final bool hasGroups;
  final bool hasTeamsInGroups;
  final bool hasMatches;
  final bool hasPlayersInTeams;
  final bool isReady;
  final DateTime? updatedAt;

  const LeagueStatusModel({
    this.id,
    required this.leagueSyncId,
    this.hasGroups = false,
    this.hasTeamsInGroups = false,
    this.hasMatches = false,
    this.hasPlayersInTeams = false,
    this.isReady = false,
    this.updatedAt,
  });

  factory LeagueStatusModel.fromEntity(LeagueStatusData e) => LeagueStatusModel(
        leagueSyncId: e.leagueSyncId,
        hasGroups: e.hasGroups,
        hasTeamsInGroups: e.hasTeamsInGroups,
        hasMatches: e.hasMatches,
        hasPlayersInTeams: e.hasPlayersAssigned,
        updatedAt: e.updatedAt,
      );

  factory LeagueStatusModel.fromJson(Map<String, dynamic> json) =>
      LeagueStatusModel(
        id: json['id'] as int?,
        leagueSyncId: json['league_sync_id'] as String,
        hasGroups: json['has_groups'] as bool? ?? false,
        hasTeamsInGroups: json['has_teams_in_groups'] as bool? ?? false,
        hasMatches: json['has_matches'] as bool? ?? false,
        hasPlayersInTeams: json['has_players_assigned'] as bool? ?? false,
        isReady: json['isReady'] as bool? ?? false,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
      );

  LeagueStatusCompanion toCompanionUpdate() => LeagueStatusCompanion(
        leagueSyncId: Value(leagueSyncId),
        hasGroups: Value(hasGroups),
        hasTeamsInGroups: Value(hasTeamsInGroups),
        hasMatches: Value(hasMatches),
        hasPlayersAssigned: Value(hasPlayersInTeams),
        updatedAt: Value(DateTime.now()),
      );
}
