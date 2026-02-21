class UpcomingMatchModel {
  final int id;
  final String syncId;
  final String leagueSyncId;
  final String roundSyncId;
  final String? matchDate;
  final String? matchTime;
  final String? matchDay;
  final String status;
  final TeamInfo homeTeam;
  final TeamInfo awayTeam;

  UpcomingMatchModel({
    required this.id,
    required this.syncId,
    required this.leagueSyncId,
    required this.roundSyncId,
    required this.matchDate,
    required this.matchTime,
    required this.matchDay,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory UpcomingMatchModel.fromJson(Map<String, dynamic> json) {
    return UpcomingMatchModel(
      id: (json['id'] ?? 0) as int,
      syncId: (json['sync_id'] ?? '').toString(),
      leagueSyncId: (json['league_sync_id'] ?? '').toString(),
      roundSyncId: (json['round_sync_id'] ?? '').toString(),
      matchDate: (json['match_date'] ?? '').toString(),
      matchTime: (json['match_time'] ?? '').toString(),
      matchDay: (json['match_day'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      homeTeam:
          TeamInfo.fromJson((json['home_team'] ?? {}) as Map<String, dynamic>),
      awayTeam:
          TeamInfo.fromJson((json['away_team'] ?? {}) as Map<String, dynamic>),
    );
  }

  static List<UpcomingMatchModel> fromJsonList(List json) {
    return json
        .map((e) => UpcomingMatchModel.fromJson((e ?? {}) as Map<String, dynamic>))
        .toList();
  }
}

class TeamInfo {
  final String syncId;
  final String name;
  final String? logoUrl;

  TeamInfo({required this.syncId, required this.name, required this.logoUrl});

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      syncId: (json['sync_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      logoUrl:
          json['logo_url'] == null ? null : (json['logo_url'] ?? '').toString(),
    );
  }
}
