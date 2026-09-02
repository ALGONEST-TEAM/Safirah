class MatchH2hModel {
  final MatchH2hCurrentMatchModel? match;
  final MatchH2hTeamsModel? teams;
  final MatchH2hSummaryModel? summary;
  final MatchH2hFiltersModel? filters;
  final int filteredTotal;
  final List<MatchH2hFixtureItemModel> fixtures;
  final String? lastSyncedAt;
  final bool isStale;
  final bool coverageComplete;

  MatchH2hModel({
    this.match,
    this.teams,
    this.summary,
    this.filters,
    required this.filteredTotal,
    required this.fixtures,
    this.lastSyncedAt,
    required this.isStale,
    required this.coverageComplete,
  });

  factory MatchH2hModel.fromJson(Map<String, dynamic> json) {
    List<MatchH2hFixtureItemModel> parseFixtures(dynamic list) {
      if (list is List) {
        return list
            .map((e) => MatchH2hFixtureItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    }

    return MatchH2hModel(
      match: json['match'] != null
          ? MatchH2hCurrentMatchModel.fromJson(json['match'])
          : null,
      teams: json['teams'] != null
          ? MatchH2hTeamsModel.fromJson(json['teams'])
          : null,
      summary: json['summary'] != null
          ? MatchH2hSummaryModel.fromJson(json['summary'])
          : null,
      filters: json['filters'] != null
          ? MatchH2hFiltersModel.fromJson(json['filters'])
          : null,
      filteredTotal: json['filtered_total'] ?? 0,
      fixtures: parseFixtures(json['fixtures']),
      lastSyncedAt: json['last_synced_at']?.toString(),
      isStale: json['is_stale'] ?? false,
      coverageComplete: json['coverage_complete'] ?? false,
    );
  }

  factory MatchH2hModel.empty(int matchId) {
    return MatchH2hModel(
      filteredTotal: 0,
      fixtures: [],
      isStale: false,
      coverageComplete: false,
    );
  }
}

class MatchH2hCurrentMatchModel {
  final int id;
  final int sportmonksFixtureId;
  final String name;
  final String date;
  final String time;
  final int stateId;
  final String status;
  final MatchH2hCompetitionModel? competition;

  MatchH2hCurrentMatchModel({
    required this.id,
    required this.sportmonksFixtureId,
    required this.name,
    required this.date,
    required this.time,
    required this.stateId,
    required this.status,
    this.competition,
  });

  factory MatchH2hCurrentMatchModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hCurrentMatchModel(
      id: json['id'] ?? 0,
      sportmonksFixtureId: json['sportmonks_fixture_id'] ?? 0,
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      stateId: json['state_id'] ?? 0,
      status: json['status']?.toString() ?? '',
      competition: json['competition'] != null
          ? MatchH2hCompetitionModel.fromJson(json['competition'])
          : null,
    );
  }
}

class MatchH2hTeamsModel {
  final MatchH2hTeamDetailModel? home;
  final MatchH2hTeamDetailModel? away;

  MatchH2hTeamsModel({this.home, this.away});

  factory MatchH2hTeamsModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hTeamsModel(
      home: json['home'] != null
          ? MatchH2hTeamDetailModel.fromJson(json['home'])
          : null,
      away: json['away'] != null
          ? MatchH2hTeamDetailModel.fromJson(json['away'])
          : null,
    );
  }
}

class MatchH2hSummaryModel {
  final int total;
  final int homeTeamWins;
  final int awayTeamWins;
  final int draws;
  final int homeTeamGoals;
  final int awayTeamGoals;

  MatchH2hSummaryModel({
    required this.total,
    required this.homeTeamWins,
    required this.awayTeamWins,
    required this.draws,
    required this.homeTeamGoals,
    required this.awayTeamGoals,
  });

  factory MatchH2hSummaryModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hSummaryModel(
      total: json['total'] ?? 0,
      homeTeamWins: json['home_team_wins'] ?? 0,
      awayTeamWins: json['away_team_wins'] ?? 0,
      draws: json['draws'] ?? 0,
      homeTeamGoals: json['home_team_goals'] ?? 0,
      awayTeamGoals: json['away_team_goals'] ?? 0,
    );
  }
}

class MatchH2hFiltersModel {
  final bool homeOnly;
  final bool sameCompetition;

  MatchH2hFiltersModel({
    required this.homeOnly,
    required this.sameCompetition,
  });

  factory MatchH2hFiltersModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hFiltersModel(
      homeOnly: json['home_only'] ?? false,
      sameCompetition: json['same_competition'] ?? false,
    );
  }
}

class MatchH2hFixtureItemModel {
  final int sportmonksFixtureId;
  final int leagueId;
  final int seasonId;
  final int stageId;
  final int roundId;
  final int stateId;
  final int homeScore;
  final int awayScore;
  final String startingAt;
  final String date;
  final String time;
  final String? resultInfo;
  final MatchH2hCompetitionModel? league;
  final MatchH2hTeamDetailModel? homeTeam;
  final MatchH2hTeamDetailModel? awayTeam;
  final MatchH2hTeamDetailModel? winnerTeam;

  MatchH2hFixtureItemModel({
    required this.sportmonksFixtureId,
    required this.leagueId,
    required this.seasonId,
    required this.stageId,
    required this.roundId,
    required this.stateId,
    required this.homeScore,
    required this.awayScore,
    required this.startingAt,
    required this.date,
    required this.time,
    this.resultInfo,
    this.league,
    this.homeTeam,
    this.awayTeam,
    this.winnerTeam,
  });

  factory MatchH2hFixtureItemModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hFixtureItemModel(
      sportmonksFixtureId: json['sportmonks_fixture_id'] ?? 0,
      leagueId: json['league_id'] ?? 0,
      seasonId: json['season_id'] ?? 0,
      stageId: json['stage_id'] ?? 0,
      roundId: json['round_id'] ?? 0,
      stateId: json['state_id'] ?? 0,
      homeScore: json['home_score'] ?? json['home_team']?['score'] ?? 0,
      awayScore: json['away_score'] ?? json['away_team']?['score'] ?? 0,
      startingAt: json['starting_at'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      resultInfo: json['result_info']?.toString(),
      league: json['league'] != null
          ? MatchH2hCompetitionModel.fromJson(json['league'])
          : null,
      homeTeam: json['home_team'] != null
          ? MatchH2hTeamDetailModel.fromJson(json['home_team'])
          : null,
      awayTeam: json['away_team'] != null
          ? MatchH2hTeamDetailModel.fromJson(json['away_team'])
          : null,
      winnerTeam: json['winner_team'] != null
          ? MatchH2hTeamDetailModel.fromJson(json['winner_team'])
          : null,
    );
  }
}

class MatchH2hTeamDetailModel {
  final int id;
  final int sportmonksId;
  final String name;
  final String shortCode;
  final String imagePath;
  final int? score;

  MatchH2hTeamDetailModel({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.shortCode,
    required this.imagePath,
    this.score,
  });

  factory MatchH2hTeamDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hTeamDetailModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      name: json['name'] ?? '',
      shortCode: json['short_code'] ?? '',
      imagePath: json['image_path'] ?? json['logo'] ?? '',
      score: json['score'],
    );
  }
}

class MatchH2hCompetitionModel {
  final int id;
  final dynamic sportmonksId;
  final String name;
  final String imagePath;

  MatchH2hCompetitionModel({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.imagePath,
  });

  factory MatchH2hCompetitionModel.fromJson(Map<String, dynamic> json) {
    return MatchH2hCompetitionModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? '',
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? json['logo'] ?? '',
    );
  }
}
