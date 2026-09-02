import 'package:intl/intl.dart';
import 'league_for_prediction_model.dart';
import 'matches_predictions_model.dart';

class TeamMatchesModel {
  final TeamMatchTeamInfo team;
  final TeamMatchItem? current;
  final List<TeamMatchItem> previous;
  final List<TeamMatchItem> upcoming;
  final TeamMatchCounts counts;

  TeamMatchesModel({
    required this.team,
    this.current,
    required this.previous,
    required this.upcoming,
    required this.counts,
  });

  factory TeamMatchesModel.fromJson(Map<String, dynamic> json) {
    return TeamMatchesModel(
      team: json['team'] != null
          ? TeamMatchTeamInfo.fromJson(json['team'])
          : TeamMatchTeamInfo.empty(),
      current: json['current'] != null
          ? TeamMatchItem.fromJson(json['current'])
          : null,
      previous: json['previous'] != null
          ? (json['previous'] as List).map((e) => TeamMatchItem.fromJson(e)).toList()
          : [],
      upcoming: json['upcoming'] != null
          ? (json['upcoming'] as List).map((e) => TeamMatchItem.fromJson(e)).toList()
          : [],
      counts: json['counts'] != null
          ? TeamMatchCounts.fromJson(json['counts'])
          : TeamMatchCounts.empty(),
    );
  }

  factory TeamMatchesModel.empty() {
    return TeamMatchesModel(
      team: TeamMatchTeamInfo.empty(),
      previous: [],
      upcoming: [],
      counts: TeamMatchCounts.empty(),
    );
  }
}

class TeamMatchTeamInfo {
  final int id;
  final int sportmonksId;
  final String name;
  final String shortCode;
  final String imagePath;
  // Fields for future API additions as requested by the user
  final String? coachName;
  final String? leagueName;
  final String? leagueLogo;

  TeamMatchTeamInfo({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.shortCode,
    required this.imagePath,
    this.coachName,
    this.leagueName,
    this.leagueLogo,
  });

  factory TeamMatchTeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamMatchTeamInfo(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      name: json['name'] ?? '',
      shortCode: json['short_code'] ?? '',
      imagePath: json['image_path'] ?? '',
      coachName: json['coach_name'],
      leagueName: json['league_name'],
      leagueLogo: json['league_logo'],
    );
  }

  factory TeamMatchTeamInfo.empty() {
    return TeamMatchTeamInfo(
      id: 0,
      sportmonksId: 0,
      name: '',
      shortCode: '',
      imagePath: '',
    );
  }
}

class TeamMatchItem {
  final int sportmonksFixtureId;
  final int? predictionMatchId;
  final String startingAt;
  final TeamMatchState state;
  final TeamMatchLeague league;
  final TeamMatchSeason season;
  final TeamMatchBasicTeam homeTeam;
  final TeamMatchBasicTeam awayTeam;
  final TeamMatchScore? score;
  final TeamMatchVenue? venue;
  final String teamSide;
  final String? outcome;
  final String? resultInfo;

  TeamMatchItem({
    required this.sportmonksFixtureId,
    this.predictionMatchId,
    required this.startingAt,
    required this.state,
    required this.league,
    required this.season,
    required this.homeTeam,
    required this.awayTeam,
    this.score,
    this.venue,
    required this.teamSide,
    this.outcome,
    this.resultInfo,
  });

  factory TeamMatchItem.fromJson(Map<String, dynamic> json) {
    return TeamMatchItem(
      sportmonksFixtureId: json['sportmonks_fixture_id'] ?? 0,
      predictionMatchId: json['prediction_match_id'],
      startingAt: json['starting_at'] ?? '',
      state: json['state'] != null
          ? TeamMatchState.fromJson(json['state'])
          : TeamMatchState.empty(),
      league: json['league'] != null
          ? TeamMatchLeague.fromJson(json['league'])
          : TeamMatchLeague.empty(),
      season: json['season'] != null
          ? TeamMatchSeason.fromJson(json['season'])
          : TeamMatchSeason.empty(),
      homeTeam: json['home_team'] != null
          ? TeamMatchBasicTeam.fromJson(json['home_team'])
          : TeamMatchBasicTeam.empty(),
      awayTeam: json['away_team'] != null
          ? TeamMatchBasicTeam.fromJson(json['away_team'])
          : TeamMatchBasicTeam.empty(),
      score: json['score'] != null ? TeamMatchScore.fromJson(json['score']) : null,
      venue: json['venue'] != null ? TeamMatchVenue.fromJson(json['venue']) : null,
      teamSide: json['team_side'] ?? '',
      outcome: json['outcome'],
      resultInfo: json['result_info'],
    );
  }

  String _formatTime(DateTime dt) {
    int hour = dt.hour;
    final String minute = dt.minute.toString().padLeft(2, '0');
    String amPm = 'ص';
    if (hour >= 12) {
      amPm = 'م';
      if (hour > 12) hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    final String hourStr = hour.toString().padLeft(2, '0');
    return '$hourStr:$minute $amPm';
  }

  MatchesPredictionsModel toMatchPredictionModel() {
    DateTime? dt;
    try {
      dt = DateTime.parse(startingAt).toLocal();
    } catch (_) {}
    
    return MatchesPredictionsModel(
      matchId: predictionMatchId ?? sportmonksFixtureId,
      matchDate: dt != null ? DateFormat('yyyy-MM-dd').format(dt) : '',
      matchTime: dt != null ? _formatTime(dt) : '',
      status: state.id,
      resultInfo: resultInfo ?? '',
      homeTeam: TeamModelForPrediction(
        id: homeTeam.id,
        name: homeTeam.name,
        logo: homeTeam.imagePath,
        score: score?.home,
      ),
      awayTeam: TeamModelForPrediction(
        id: awayTeam.id,
        name: awayTeam.name,
        logo: awayTeam.imagePath,
        score: score?.away,
      ),
    );
  }
}

class TeamMatchState {
  final int id;
  final String name;
  final String code;

  TeamMatchState({required this.id, required this.name, required this.code});

  factory TeamMatchState.fromJson(Map<String, dynamic> json) {
    return TeamMatchState(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }

  factory TeamMatchState.empty() => TeamMatchState(id: 0, name: '', code: '');
}

class TeamMatchLeague {
  final int id;
  final String name;
  final String? imagePath;

  TeamMatchLeague({required this.id, required this.name, this.imagePath});

  factory TeamMatchLeague.fromJson(Map<String, dynamic> json) {
    return TeamMatchLeague(
      id: json['id'] ?? 0, 
      name: json['name'] ?? '',
      imagePath: json['image_path'],
    );
  }

  factory TeamMatchLeague.empty() => TeamMatchLeague(id: 0, name: '');
}

class TeamMatchSeason {
  final int id;
  final String name;

  TeamMatchSeason({required this.id, required this.name});

  factory TeamMatchSeason.fromJson(Map<String, dynamic> json) {
    return TeamMatchSeason(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  factory TeamMatchSeason.empty() => TeamMatchSeason(id: 0, name: '');
}

class TeamMatchBasicTeam {
  final int id;
  final int sportmonksId;
  final String name;
  final String imagePath;

  TeamMatchBasicTeam({
    required this.id,
    required this.sportmonksId,
    required this.name,
    required this.imagePath,
  });

  factory TeamMatchBasicTeam.fromJson(Map<String, dynamic> json) {
    return TeamMatchBasicTeam(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }

  factory TeamMatchBasicTeam.empty() => TeamMatchBasicTeam(
        id: 0,
        sportmonksId: 0,
        name: '',
        imagePath: '',
      );
}

class TeamMatchScore {
  final int home;
  final int away;
  final int? homePenalties;
  final int? awayPenalties;

  TeamMatchScore({
    required this.home,
    required this.away,
    this.homePenalties,
    this.awayPenalties,
  });

  factory TeamMatchScore.fromJson(Map<String, dynamic> json) {
    return TeamMatchScore(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
      homePenalties: json['home_penalties'],
      awayPenalties: json['away_penalties'],
    );
  }
}

class TeamMatchVenue {
  final int id;
  final String name;
  final String city;
  final String imagePath;

  TeamMatchVenue({
    required this.id,
    required this.name,
    required this.city,
    required this.imagePath,
  });

  factory TeamMatchVenue.fromJson(Map<String, dynamic> json) {
    return TeamMatchVenue(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }
}

class TeamMatchCounts {
  final int previous;
  final int upcoming;
  final bool hasCurrent;

  TeamMatchCounts({
    required this.previous,
    required this.upcoming,
    required this.hasCurrent,
  });

  factory TeamMatchCounts.fromJson(Map<String, dynamic> json) {
    return TeamMatchCounts(
      previous: json['previous'] ?? 0,
      upcoming: json['upcoming'] ?? 0,
      hasCurrent: json['has_current'] ?? false,
    );
  }

  factory TeamMatchCounts.empty() => TeamMatchCounts(
        previous: 0,
        upcoming: 0,
        hasCurrent: false,
      );
}
