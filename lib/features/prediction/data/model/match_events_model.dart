import '../../presentation/widgets/match_details/match_events_list_widget.dart';

class MatchEventsModel {
  final int matchId;
  final String fixtureId;
  final int revision;
  final MatchEventStatusModel? status;
  final MatchEventScoreModel? score;
  final MatchEventTeamsModel? teams;
  final MatchEventCountsModel? counts;
  final List<MatchSingleEventModel> highlights;
  final List<MatchSingleEventModel> allEvents;
  final List<MatchEventPeriodModel> periods;

  MatchEventsModel({
    required this.matchId,
    required this.fixtureId,
    required this.revision,
    this.status,
    this.score,
    this.teams,
    this.counts,
    required this.highlights,
    required this.allEvents,
    required this.periods,
  });

  factory MatchEventsModel.fromJson(Map<String, dynamic> json) {
    List<MatchSingleEventModel> parseEvents(dynamic list) {
      if (list is List) {
        return list
            .map((e) => MatchSingleEventModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    }

    List<MatchEventPeriodModel> parsePeriods(dynamic list) {
      if (list is List) {
        return list
            .map((e) => MatchEventPeriodModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    }

    return MatchEventsModel(
      matchId: json['match_id'] ?? 0,
      fixtureId: json['fixture_id']?.toString() ?? '',
      revision: json['revision'] ?? 0,
      status: json['status'] != null
          ? MatchEventStatusModel.fromJson(json['status'])
          : null,
      score: json['score'] != null
          ? MatchEventScoreModel.fromJson(json['score'])
          : null,
      teams: json['teams'] != null
          ? MatchEventTeamsModel.fromJson(json['teams'])
          : null,
      counts: json['counts'] != null
          ? MatchEventCountsModel.fromJson(json['counts'])
          : null,
      highlights: parseEvents(json['highlights']),
      allEvents: parseEvents(json['all_events']),
      periods: parsePeriods(json['periods']),
    );
  }

  factory MatchEventsModel.empty(int matchId) {
    return MatchEventsModel(
      matchId: matchId,
      fixtureId: '',
      revision: 0,
      highlights: [],
      allEvents: [],
      periods: [],
    );
  }
}

class MatchEventStatusModel {
  final int stateId;
  final String code;
  final String name;
  final bool eventsAvailable;

  MatchEventStatusModel({
    required this.stateId,
    required this.code,
    required this.name,
    required this.eventsAvailable,
  });

  factory MatchEventStatusModel.fromJson(Map<String, dynamic> json) {
    return MatchEventStatusModel(
      stateId: json['state_id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      eventsAvailable: json['events_available'] ?? false,
    );
  }
}

class MatchEventScoreModel {
  final int home;
  final int away;
  final String display;

  MatchEventScoreModel({
    required this.home,
    required this.away,
    required this.display,
  });

  factory MatchEventScoreModel.fromJson(Map<String, dynamic> json) {
    return MatchEventScoreModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
      display: json['display'] ?? '',
    );
  }
}

class MatchEventTeamsModel {
  final MatchEventTeamDetailModel? home;
  final MatchEventTeamDetailModel? away;

  MatchEventTeamsModel({this.home, this.away});

  factory MatchEventTeamsModel.fromJson(Map<String, dynamic> json) {
    return MatchEventTeamsModel(
      home: json['home'] != null
          ? MatchEventTeamDetailModel.fromJson(json['home'])
          : null,
      away: json['away'] != null
          ? MatchEventTeamDetailModel.fromJson(json['away'])
          : null,
    );
  }
}

class MatchEventTeamDetailModel {
  final int id;
  final int sportmonksId;
  final String side;
  final String name;
  final String shortCode;
  final String logo;
  final String color;

  MatchEventTeamDetailModel({
    required this.id,
    required this.sportmonksId,
    required this.side,
    required this.name,
    required this.shortCode,
    required this.logo,
    required this.color,
  });

  factory MatchEventTeamDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchEventTeamDetailModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      side: json['side'] ?? '',
      name: json['name'] ?? '',
      shortCode: json['short_code'] ?? '',
      logo: json['logo'] ?? '',
      color: json['color'] ?? '',
    );
  }
}

class MatchEventCountsModel {
  final int highlights;
  final int allEvents;

  MatchEventCountsModel({
    required this.highlights,
    required this.allEvents,
  });

  factory MatchEventCountsModel.fromJson(Map<String, dynamic> json) {
    return MatchEventCountsModel(
      highlights: json['highlights'] ?? 0,
      allEvents: json['all_events'] ?? 0,
    );
  }
}

class MatchSingleEventModel {
  final int id;
  final String category;
  final String name;
  final String time;
  final MatchEventTeamModel? team;
  final MatchEventPlayerModel? player;
  final MatchEventPlayerModel? relatedPlayer;
  final String? result;
  final bool cancelled;

  MatchSingleEventModel({
    required this.id,
    required this.category,
    required this.name,
    required this.time,
    this.team,
    this.player,
    this.relatedPlayer,
    this.result,
    required this.cancelled,
  });

  factory MatchSingleEventModel.fromJson(Map<String, dynamic> json) {
    return MatchSingleEventModel(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      time: json['time']?.toString() ?? '',
      team: json['team'] != null ? MatchEventTeamModel.fromJson(json['team']) : null,
      player: json['player'] != null ? MatchEventPlayerModel.fromJson(json['player']) : null,
      relatedPlayer: json['related_player'] != null
          ? MatchEventPlayerModel.fromJson(json['related_player'])
          : null,
      result: json['result']?.toString(),
      cancelled: json['cancelled'] ?? false,
    );
  }

  bool get isHome => team?.side == 'home';

  int get parsedMinute {
    final clean = time.replaceAll("'", "").split('+').first.trim();
    return int.tryParse(clean) ?? 0;
  }

  String get displayTime => time.replaceAll("'", "").trim();

  /// Convert API single event to UI `MatchEventItem`
  MatchEventItem toUIItem() {
    MatchEventType type;
    final cat = category.toLowerCase();

    if (cat.contains('substitution')) {
      type = MatchEventType.substitution;
    } else if (cat.contains('penalty_missed')) {
      type = MatchEventType.penaltyMissed;
    } else if (cat.contains('red_card') || cat.contains('yellow_red')) {
      type = MatchEventType.redCard;
    } else if (cat.contains('yellow_card')) {
      type = MatchEventType.yellowCard;
    } else if (cat.contains('penalty_goal')) {
      type = cancelled ? MatchEventType.canceledGoal : MatchEventType.penaltyGoal;
    } else if (cat.contains('goal_disallowed')) {
      type = MatchEventType.canceledGoal;
    } else if (cat.contains('goal')) {
      type = cancelled ? MatchEventType.canceledGoal : MatchEventType.goal;
    } else {
      type = MatchEventType.yellowCard;
    }

    String? playerNameStr = player?.name;
    String? extraNameStr;

    if (type == MatchEventType.substitution) {
      playerNameStr = player?.name; // In
      extraNameStr = relatedPlayer?.name; // Out
    } else if (type == MatchEventType.goal || type == MatchEventType.penaltyGoal || type == MatchEventType.canceledGoal) {
      playerNameStr = player?.name ?? name;
      extraNameStr = relatedPlayer?.name;
    } else {
      playerNameStr = player?.name ?? name;
    }

    return MatchEventItem(
      minute: displayTime.isNotEmpty ? displayTime : parsedMinute,
      type: type,
      playerName: playerNameStr,
      extraName: extraNameStr,
      isHome: isHome,
      score: result,
      label: name,
    );
  }
}

class MatchEventTeamModel {
  final int id;
  final String side;
  final String name;

  MatchEventTeamModel({
    required this.id,
    required this.side,
    required this.name,
  });

  factory MatchEventTeamModel.fromJson(Map<String, dynamic> json) {
    return MatchEventTeamModel(
      id: json['id'] ?? 0,
      side: json['side'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class MatchEventPlayerModel {
  final int id;
  final String name;

  MatchEventPlayerModel({
    required this.id,
    required this.name,
  });

  factory MatchEventPlayerModel.fromJson(Map<String, dynamic> json) {
    return MatchEventPlayerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class MatchEventPeriodModel {
  final int sportmonksPeriodId;
  final String code;
  final String name;
  final int? timeAdded;
  final String? scoreAtEnd;

  MatchEventPeriodModel({
    required this.sportmonksPeriodId,
    required this.code,
    required this.name,
    this.timeAdded,
    this.scoreAtEnd,
  });

  factory MatchEventPeriodModel.fromJson(Map<String, dynamic> json) {
    final typeObj = json['type'] as Map<String, dynamic>?;
    final clockObj = json['clock'] as Map<String, dynamic>?;
    final scoreObj = json['score_at_end'] as Map<String, dynamic>?;

    return MatchEventPeriodModel(
      sportmonksPeriodId: json['sportmonks_period_id'] ?? 0,
      code: typeObj?['code']?.toString() ?? json['description']?.toString() ?? '',
      name: typeObj?['name']?.toString() ?? typeObj?['label_ar']?.toString() ?? '',
      timeAdded: clockObj?['time_added'] != null
          ? int.tryParse(clockObj!['time_added'].toString())
          : null,
      scoreAtEnd: scoreObj?['display']?.toString(),
    );
  }
}
