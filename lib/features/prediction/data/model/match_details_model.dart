class MatchDetailsModel {
  final int id;
  final String apiId;
  final String name;
  final int? round;
  final String date;
  final String time;
  final String status;
  final MatchStateModel? state;
  final MatchScoreModel? score;
  final MatchCompetitionModel? competition;
  final MatchTeamsModel? teams;
  final MatchVenueModel? venue;
  final int? attendance;
  final List<MatchOfficialModel> officials;
  final List<MatchKeyStatisticModel> keyStatistics;
  final MatchBestPlayerModel? bestPlayer;
  final int? minute;
  final int? second;
  final bool? ticking;
  final int? timeAdded;
  final bool isInPredictionSystem;
  final bool hasPrediction;
  final int? userHomeScore;
  final int? userAwayScore;
  final int? predictionId;
  final String? lastGoalSide;
  final DateTime? lastGoalTime;

  MatchDetailsModel({
    required this.id,
    required this.apiId,
    required this.name,
    this.round,
    required this.date,
    required this.time,
    required this.status,
    this.state,
    this.score,
    this.competition,
    this.teams,
    this.venue,
    this.attendance,
    required this.officials,
    required this.keyStatistics,
    this.bestPlayer,
    this.minute,
    this.second,
    this.ticking,
    this.timeAdded,
    this.isInPredictionSystem = false,
    this.hasPrediction = false,
    this.userHomeScore,
    this.userAwayScore,
    this.predictionId,
    this.lastGoalSide,
    this.lastGoalTime,
  });

  MatchOfficialModel? get mainReferee {
    if (officials.isEmpty) return null;
    try {
      return officials.firstWhere(
        (o) => o.typeId == 6 || o.role == 'حكم' || o.role.contains('حكم رئيسي'),
      );
    } catch (_) {
      return officials.first;
    }
  }

  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? prediction;
    if (json['prediction'] is Map) {
      prediction = Map<String, dynamic>.from(json['prediction']);
    } else if (json['prediction'] is List &&
        (json['prediction'] as List).isNotEmpty &&
        (json['prediction'] as List).first is Map) {
      prediction =
          Map<String, dynamic>.from((json['prediction'] as List).first);
    } else if (json['user_prediction'] is Map) {
      prediction = Map<String, dynamic>.from(json['user_prediction']);
    } else if (json['user_prediction'] is List &&
        (json['user_prediction'] as List).isNotEmpty &&
        (json['user_prediction'] as List).first is Map) {
      prediction =
          Map<String, dynamic>.from((json['user_prediction'] as List).first);
    } else if (json['my_prediction'] is Map) {
      prediction = Map<String, dynamic>.from(json['my_prediction']);
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is num) return value.toInt();
      return int.tryParse(value.toString());
    }

    final rawHomeScore = prediction?['home_score'] ??
        prediction?['user_home_score'] ??
        prediction?['home'] ??
        json['user_home_score'] ??
        json['prediction_home_score'];

    final rawAwayScore = prediction?['away_score'] ??
        prediction?['user_away_score'] ??
        prediction?['away'] ??
        json['user_away_score'] ??
        json['prediction_away_score'];

    final rawPredictionId = prediction?['id'] ??
        prediction?['prediction_id'] ??
        json['prediction_id'];

    return MatchDetailsModel(
      id: json['id'] ?? 0,
      apiId: json['api_id'] ?? '',
      name: json['name'] ?? '',
      round: json['round'],
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status']?.toString() ?? '',
      state: json['state'] != null ? MatchStateModel.fromJson(json['state']) : null,
      score: json['score'] != null ? MatchScoreModel.fromJson(json['score']) : null,
      competition: json['competition'] != null ? MatchCompetitionModel.fromJson(json['competition']) : null,
      teams: json['teams'] != null ? MatchTeamsModel.fromJson(json['teams']) : null,
      venue: json['venue'] != null ? MatchVenueModel.fromJson(json['venue']) : null,
      attendance: json['attendance'],
      officials: json['officials'] != null
          ? (json['officials'] as List).map((i) => MatchOfficialModel.fromJson(i)).toList()
          : [],
      keyStatistics: json['key_statistics'] != null
          ? (json['key_statistics'] as List).map((i) => MatchKeyStatisticModel.fromJson(i)).toList()
          : [],
      bestPlayer: json['best_player'] != null ? MatchBestPlayerModel.fromJson(json['best_player']) : null,
      minute: (json['match_clock']?['minute'] ?? json['minute']) != null
          ? int.tryParse((json['match_clock']?['minute'] ?? json['minute']).toString())
          : null,
      second: (json['match_clock']?['second'] ?? json['second']) != null
          ? int.tryParse((json['match_clock']?['second'] ?? json['second']).toString())
          : null,
      ticking: (json['match_clock']?['ticking'] ?? json['ticking']) == true ||
          (json['match_clock']?['ticking'] ?? json['ticking']) == 1 ||
          (json['match_clock']?['ticking'] ?? json['ticking']).toString() == 'true',
      timeAdded: (json['match_clock']?['added_time'] ?? json['match_clock']?['time_added'] ?? json['time_added']) != null
          ? int.tryParse((json['match_clock']?['added_time'] ?? json['match_clock']?['time_added'] ?? json['time_added']).toString())
          : null,
      isInPredictionSystem: json['is_in_prediction_system'] == true ||
          json['is_in_prediction_system'] == 1 ||
          json['is_in_prediction_system']?.toString() == 'true',
      hasPrediction: json['has_prediction'] == true ||
          json['has_prediction'] == 1 ||
          json['has_prediction']?.toString() == 'true' ||
          prediction != null,
      userHomeScore: parseInt(rawHomeScore),
      userAwayScore: parseInt(rawAwayScore),
      predictionId: parseInt(rawPredictionId),
    );
  }

  MatchDetailsModel copyWith({
    int? id,
    String? apiId,
    String? name,
    int? round,
    String? date,
    String? time,
    String? status,
    MatchStateModel? state,
    MatchScoreModel? score,
    MatchCompetitionModel? competition,
    MatchTeamsModel? teams,
    MatchVenueModel? venue,
    int? attendance,
    List<MatchOfficialModel>? officials,
    List<MatchKeyStatisticModel>? keyStatistics,
    MatchBestPlayerModel? bestPlayer,
    int? minute,
    int? second,
    bool? ticking,
    int? timeAdded,
    bool? isInPredictionSystem,
    bool? hasPrediction,
    int? userHomeScore,
    int? userAwayScore,
    int? predictionId,
    String? lastGoalSide,
    DateTime? lastGoalTime,
  }) {
    return MatchDetailsModel(
      id: id ?? this.id,
      apiId: apiId ?? this.apiId,
      name: name ?? this.name,
      round: round ?? this.round,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      state: state ?? this.state,
      score: score ?? this.score,
      competition: competition ?? this.competition,
      teams: teams ?? this.teams,
      venue: venue ?? this.venue,
      attendance: attendance ?? this.attendance,
      officials: officials ?? this.officials,
      keyStatistics: keyStatistics ?? this.keyStatistics,
      bestPlayer: bestPlayer ?? this.bestPlayer,
      minute: minute ?? this.minute,
      second: second ?? this.second,
      ticking: ticking ?? this.ticking,
      timeAdded: timeAdded ?? this.timeAdded,
      isInPredictionSystem: isInPredictionSystem ?? this.isInPredictionSystem,
      hasPrediction: hasPrediction ?? this.hasPrediction,
      userHomeScore: userHomeScore ?? this.userHomeScore,
      userAwayScore: userAwayScore ?? this.userAwayScore,
      predictionId: predictionId ?? this.predictionId,
      lastGoalSide: lastGoalSide ?? this.lastGoalSide,
      lastGoalTime: lastGoalTime ?? this.lastGoalTime,
    );
  }

  factory MatchDetailsModel.empty() {
    return MatchDetailsModel(
      id: 0,
      apiId: '',
      name: '',
      date: '',
      time: '',
      status: '',
      officials: [],
      keyStatistics: [],
      isInPredictionSystem: false,
    );
  }
}

class MatchStateModel {
  final int id;
  final String name;
  final String code;
  final bool hasStarted;

  MatchStateModel({
    required this.id,
    required this.name,
    required this.code,
    required this.hasStarted,
  });

  MatchStateModel copyWith({
    int? id,
    String? name,
    String? code,
    bool? hasStarted,
  }) {
    return MatchStateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      hasStarted: hasStarted ?? this.hasStarted,
    );
  }

  factory MatchStateModel.fromJson(Map<String, dynamic> json) {
    return MatchStateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      hasStarted: json['has_started'] ?? false,
    );
  }
}

class MatchScoreModel {
  final int home;
  final int away;
  final String resultInfo;

  MatchScoreModel({
    required this.home,
    required this.away,
    required this.resultInfo,
  });

  MatchScoreModel copyWith({
    int? home,
    int? away,
    String? resultInfo,
  }) {
    return MatchScoreModel(
      home: home ?? this.home,
      away: away ?? this.away,
      resultInfo: resultInfo ?? this.resultInfo,
    );
  }

  factory MatchScoreModel.fromJson(Map<String, dynamic> json) {
    return MatchScoreModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
      resultInfo: json['result_info'] ?? '',
    );
  }
}

class MatchSeasonModel {
  final int id;
  final String name;

  MatchSeasonModel({
    required this.id,
    required this.name,
  });

  factory MatchSeasonModel.fromJson(Map<String, dynamic> json) {
    return MatchSeasonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class MatchCompetitionModel {
  final int id;
  final String name;
  final String logo;
  final MatchSeasonModel? season;

  MatchCompetitionModel({
    required this.id,
    required this.name,
    required this.logo,
    this.season,
  });

  factory MatchCompetitionModel.fromJson(Map<String, dynamic> json) {
    return MatchCompetitionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      season: json['season'] != null ? MatchSeasonModel.fromJson(json['season']) : null,
    );
  }
}

class MatchTeamsModel {
  final MatchTeamModel? home;
  final MatchTeamModel? away;

  MatchTeamsModel({this.home, this.away});

  factory MatchTeamsModel.fromJson(Map<String, dynamic> json) {
    return MatchTeamsModel(
      home: json['home'] != null ? MatchTeamModel.fromJson(json['home']) : null,
      away: json['away'] != null ? MatchTeamModel.fromJson(json['away']) : null,
    );
  }
}

class MatchTeamModel {
  final int id;
  final int? sportmonksId;
  final int? teamId;
  final String name;
  final String logo;
  final String color;
  final int score;

  MatchTeamModel({
    required this.id,
    this.sportmonksId,
    this.teamId,
    required this.name,
    required this.logo,
    required this.color,
    required this.score,
  });

  static String _extractColor(dynamic colorsJson, dynamic colorJson) {
    if (colorsJson != null) {
      if (colorsJson is Map) {
        if (colorsJson['participant'] != null && colorsJson['participant'].toString().isNotEmpty) {
          return colorsJson['participant'].toString();
        }
        if (colorsJson['primary'] != null && colorsJson['primary'].toString().isNotEmpty) {
          return colorsJson['primary'].toString();
        }
        if (colorsJson['color'] != null && colorsJson['color'].toString().isNotEmpty) {
          return colorsJson['color'].toString();
        }
        if (colorsJson['home'] != null && colorsJson['home'].toString().isNotEmpty) {
          return colorsJson['home'].toString();
        }
        if (colorsJson['away'] != null && colorsJson['away'].toString().isNotEmpty) {
          return colorsJson['away'].toString();
        }
        if (colorsJson.values.isNotEmpty) {
          final firstVal = colorsJson.values.first;
          if (firstVal != null && firstVal.toString().isNotEmpty) {
            return firstVal.toString();
          }
        }
      } else if (colorsJson is String && colorsJson.isNotEmpty) {
        return colorsJson;
      } else if (colorsJson is List && colorsJson.isNotEmpty) {
        return colorsJson.first.toString();
      }
    }
    if (colorJson != null && colorJson.toString().isNotEmpty) {
      return colorJson.toString();
    }
    return '';
  }

  factory MatchTeamModel.fromJson(Map<String, dynamic> json) {
    return MatchTeamModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'],
      teamId: json['team_id'],
      name: json['name'] ?? '',
      logo: json['logo'] ?? json['image_path'] ?? '',
      color: _extractColor(json['colors'], json['color']),
      score: json['score'] ?? 0,
    );
  }
}

class MatchVenueModel {
  final int id;
  final String name;
  final String address;
  final String city;
  final String surface;
  final int? capacity;
  final String image;

  MatchVenueModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.surface,
    this.capacity,
    required this.image,
  });

  factory MatchVenueModel.fromJson(Map<String, dynamic> json) {
    return MatchVenueModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      surface: json['surface'] ?? '',
      capacity: json['capacity'],
      image: json['image'] ?? '',
    );
  }
}

class MatchOfficialModel {
  final int id;
  final int typeId;
  final String role;
  final String name;
  final String commonName;
  final String image;

  MatchOfficialModel({
    required this.id,
    required this.typeId,
    required this.role,
    required this.name,
    required this.commonName,
    required this.image,
  });

  factory MatchOfficialModel.fromJson(Map<String, dynamic> json) {
    return MatchOfficialModel(
      id: json['id'] ?? 0,
      typeId: json['type_id'] ?? 0,
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      commonName: json['common_name'] ?? json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class MatchKeyStatisticModel {
  final int typeId;
  final String code;
  final String label;
  final String home;
  final String away;
  final String displayGroup;

  MatchKeyStatisticModel({
    required this.typeId,
    required this.code,
    required this.label,
    required this.home,
    required this.away,
    this.displayGroup = '',
  });

  factory MatchKeyStatisticModel.fromJson(Map<String, dynamic> json) {
    return MatchKeyStatisticModel(
      typeId: json['type_id'] ?? 0,
      code: json['code'] ?? '',
      label: json['label_ar'] ?? json['label'] ?? '',
      home: json['home']?.toString() ?? '0',
      away: json['away']?.toString() ?? '0',
      displayGroup: json['display_group'] ?? '',
    );
  }
}

class MatchBestPlayerModel {
  final int id;
  final int teamId;
  final String teamName;
  final String teamLogo;
  final String name;
  final String image;
  final double rating;

  MatchBestPlayerModel({
    required this.id,
    this.teamId = 0,
    this.teamName = '',
    this.teamLogo = '',
    required this.name,
    required this.image,
    required this.rating,
  });

  factory MatchBestPlayerModel.fromJson(Map<String, dynamic> json) {
    int extractedTeamId = json['team_id'] ?? json['participant_id'] ?? 0;
    String extractedTeamName = json['team_name'] ?? '';
    String extractedTeamLogo = json['team_logo'] ?? '';

    if (json['team'] != null && json['team'] is Map) {
      final teamMap = json['team'] as Map<String, dynamic>;
      if (extractedTeamId == 0) {
        extractedTeamId = teamMap['id'] ?? teamMap['participant_id'] ?? 0;
      }
      if (extractedTeamName.isEmpty) {
        extractedTeamName = teamMap['name'] ?? '';
      }
      if (extractedTeamLogo.isEmpty) {
        extractedTeamLogo = teamMap['logo'] ?? teamMap['image_path'] ?? '';
      }
    }

    if (json['player'] != null && json['player'] is Map) {
      final playerMap = json['player'] as Map<String, dynamic>;
      if (extractedTeamId == 0) {
        extractedTeamId = playerMap['team_id'] ?? playerMap['participant_id'] ?? 0;
      }
    }

    return MatchBestPlayerModel(
      id: json['id'] ?? json['player_id'] ?? (json['player'] is Map ? json['player']['id'] : 0) ?? 0,
      teamId: extractedTeamId,
      teamName: extractedTeamName,
      teamLogo: extractedTeamLogo,
      name: json['name'] ?? json['common_name'] ?? (json['player'] is Map ? (json['player']['name'] ?? json['player']['common_name']) : '') ?? '',
      image: json['image'] ?? json['image_path'] ?? (json['player'] is Map ? json['player']['image_path'] : '') ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
    );
  }
}
