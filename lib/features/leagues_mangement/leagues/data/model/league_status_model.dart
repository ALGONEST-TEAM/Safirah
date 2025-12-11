import 'package:drift/drift.dart';
import '../../../../../core/database/safirah_database.dart';

class LeagueStatusModel {
  final int? id;
  final int leagueId;
  final bool hasGroups;
  final bool hasTeamsInGroups;
  final bool hasMatches;
  final bool hasPlayersInTeams;
  final bool isReady;
  final DateTime? updatedAt;

  const LeagueStatusModel({
    this.id,
    required this.leagueId,
    this.hasGroups = false,
    this.hasTeamsInGroups = false,
    this.hasMatches = false,
    this.hasPlayersInTeams = false,
    this.isReady = false,
     this.updatedAt,
  });

  factory LeagueStatusModel.fromEntity(LeagueStatusData e) => LeagueStatusModel(
    leagueId: e.leagueId,
    hasGroups: e.hasGroups,
    hasTeamsInGroups: e.hasTeamsInGroups,
    hasMatches: e.hasMatches,
    hasPlayersInTeams: e.hasPlayersAssigned,
    updatedAt: e.updatedAt,
  );

  LeagueStatusCompanion toCompanionUpdate() => LeagueStatusCompanion(
    leagueId: Value(leagueId),
    hasGroups: Value(hasGroups),
    hasTeamsInGroups: Value(hasTeamsInGroups),
    hasMatches: Value(hasMatches),
    hasPlayersAssigned: Value(hasPlayersInTeams),
    updatedAt: Value(DateTime.now()),
  );
}
