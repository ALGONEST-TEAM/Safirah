import 'model.dart';

class GroupDrawPayload {
  final String groupSyncId;
  final GroupModel group;
  final List<GroupTeamModel> groupTeams;
  final List<QualifiedTeamModel> qualifiedTeams;

  final Map<String, String> qualifiedTeamSyncIdByTeamId;

  const GroupDrawPayload({
    required this.groupSyncId,
    required this.group,
    required this.groupTeams,
    required this.qualifiedTeams,
    this.qualifiedTeamSyncIdByTeamId = const {},
  });

  Map<String, dynamic> toJson() => {
        'group': {
          'sync_id': groupSyncId,
          'league_id': group.leagueSyncId,
          'group_name': group.groupName,
          'qualified_team_number': group.qualifiedTeamNumber,
        },
        'group_teams': groupTeams
            .map((gt) => {
                  'team_sync_id': gt.teamSyncId,
                })
            .toList(),
        'qualified_teams': qualifiedTeams
            .map(
              (qt) => {
                if (qualifiedTeamSyncIdByTeamId.containsKey(qt.teamSyncId))
                  'sync_id': qualifiedTeamSyncIdByTeamId[qt.teamSyncId],
                'team_sync_id': qt.teamSyncId,
                'played': qt.played,
                'wins': qt.wins,
                'draws': qt.draws,
                'losses': qt.losses,
                'goals_for': qt.goalsFor,
                'goals_against': qt.goalsAgainst,
                'points': qt.points,
                'qualification_type': qt.qualificationType ?? 'auto',
              },
            )
            .toList(),
      };
}
