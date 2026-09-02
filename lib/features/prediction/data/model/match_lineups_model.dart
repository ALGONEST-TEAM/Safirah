class MatchLineupsModel {
  final int matchId;
  final String fixtureId;
  final String selectedTeam;
  final MatchLineupStatusModel? lineupStatus;
  final List<MatchLineupTeamModel> teams;

  MatchLineupsModel({
    required this.matchId,
    required this.fixtureId,
    required this.selectedTeam,
    this.lineupStatus,
    required this.teams,
  });

  factory MatchLineupsModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupsModel(
      matchId: json['match_id'] ?? 0,
      fixtureId: json['fixture_id']?.toString() ?? '',
      selectedTeam: json['selected_team'] ?? 'all',
      lineupStatus: json['lineup_status'] != null
          ? MatchLineupStatusModel.fromJson(json['lineup_status'])
          : null,
      teams: json['teams'] != null
          ? (json['teams'] as List)
              .map((e) => MatchLineupTeamModel.fromJson(e))
              .toList()
          : [],
    );
  }

  factory MatchLineupsModel.empty(int matchId) {
    return MatchLineupsModel(
      matchId: matchId,
      fixtureId: '',
      selectedTeam: 'all',
      teams: [],
    );
  }

  MatchLineupTeamModel? get homeTeam =>
      teams.firstWhere((t) => t.side == 'home', orElse: () => teams.isNotEmpty ? teams.first : MatchLineupTeamModel.empty('home'));

  MatchLineupTeamModel? get awayTeam =>
      teams.firstWhere((t) => t.side == 'away', orElse: () => teams.length > 1 ? teams[1] : MatchLineupTeamModel.empty('away'));
}

class MatchLineupStatusModel {
  final String code;
  final String labelAr;
  final bool isConfirmed;

  MatchLineupStatusModel({
    required this.code,
    required this.labelAr,
    required this.isConfirmed,
  });

  factory MatchLineupStatusModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupStatusModel(
      code: json['code'] ?? '',
      labelAr: json['label_ar'] ?? '',
      isConfirmed: json['is_confirmed'] ?? false,
    );
  }
}

class MatchLineupTeamModel {
  final int id;
  final int sportmonksId;
  final String side;
  final String name;
  final String shortCode;
  final String logo;
  final String color;
  final String formation;
  final List<MatchLineupPlayerModel> starters;
  final List<MatchLineupPlayerModel> bench;
  final MatchLineupCoachModel? coach;
  final List<MatchLineupSubEventModel> substitutions;
  final List<MatchLineupPlayerModel> unavailablePlayers;

  MatchLineupTeamModel({
    required this.id,
    required this.sportmonksId,
    required this.side,
    required this.name,
    required this.shortCode,
    required this.logo,
    required this.color,
    required this.formation,
    required this.starters,
    required this.bench,
    this.coach,
    required this.substitutions,
    required this.unavailablePlayers,
  });

  factory MatchLineupTeamModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupTeamModel(
      id: json['id'] ?? 0,
      sportmonksId: json['sportmonks_id'] ?? 0,
      side: json['side'] ?? '',
      name: json['name'] ?? '',
      shortCode: json['short_code'] ?? '',
      logo: json['logo'] ?? '',
      color: json['color'] ?? '',
      formation: json['formation'] ?? '4-4-2',
      starters: json['starters'] != null
          ? (json['starters'] as List)
              .map((e) => MatchLineupPlayerModel.fromJson(e))
              .toList()
          : [],
      bench: json['bench'] != null
          ? (json['bench'] as List)
              .map((e) => MatchLineupPlayerModel.fromJson(e))
              .toList()
          : [],
      coach: json['coach'] != null
          ? MatchLineupCoachModel.fromJson(json['coach'])
          : null,
      substitutions: json['substitutions'] != null
          ? (json['substitutions'] as List)
              .map((e) => MatchLineupSubEventModel.fromJson(e))
              .toList()
          : [],
      unavailablePlayers: json['unavailable_players'] != null
          ? (json['unavailable_players'] as List)
              .map((e) => MatchLineupPlayerModel.fromJson(e))
              .toList()
          : [],
    );
  }

  factory MatchLineupTeamModel.empty(String side) {
    return MatchLineupTeamModel(
      id: 0,
      sportmonksId: 0,
      side: side,
      name: '',
      shortCode: '',
      logo: '',
      color: '',
      formation: '4-4-2',
      starters: [],
      bench: [],
      substitutions: [],
      unavailablePlayers: [],
    );
  }
}

class MatchLineupPlayerModel {
  final int id;
  final int lineupId;
  final String name;
  final String commonName;
  final String image;
  final int jerseyNumber;
  final bool captain;
  final double? rating;
  final String positionCode;
  final String positionLabel;
  final int? formationPosition;
  final String? formationField;
  final List<MatchLineupSubEventModel> substitutionEvents;
  final int goalsCount;
  final int assistsCount;
  final int yellowCardsCount;
  final int redCardsCount;

  MatchLineupPlayerModel({
    required this.id,
    required this.lineupId,
    required this.name,
    required this.commonName,
    required this.image,
    required this.jerseyNumber,
    required this.captain,
    this.rating,
    required this.positionCode,
    required this.positionLabel,
    this.formationPosition,
    this.formationField,
    required this.substitutionEvents,
    this.goalsCount = 0,
    this.assistsCount = 0,
    this.yellowCardsCount = 0,
    this.redCardsCount = 0,
  });

  factory MatchLineupPlayerModel.fromJson(Map<String, dynamic> json) {
    double? parsedRating;
    if (json['rating'] != null) {
      parsedRating = double.tryParse(json['rating'].toString());
    }

    final posObj = json['position'];
    String code = '';
    String label = '';
    if (posObj != null && posObj is Map) {
      code = posObj['code']?.toString() ?? '';
      label = posObj['label']?.toString() ?? '';
    }

    return MatchLineupPlayerModel(
      id: json['id'] ?? 0,
      lineupId: json['lineup_id'] ?? 0,
      name: json['name'] ?? '',
      commonName: json['common_name'] ?? json['name'] ?? '',
      image: json['image'] ?? '',
      jerseyNumber: json['jersey_number'] ?? 0,
      captain: json['captain'] ?? false,
      rating: parsedRating,
      positionCode: code,
      positionLabel: label,
      formationPosition: json['formation_position'],
      formationField: json['formation_field']?.toString(),
      substitutionEvents: json['substitution_events'] != null
          ? (json['substitution_events'] as List)
              .map((e) => MatchLineupSubEventModel.fromJson(e))
              .toList()
          : [],
      goalsCount: json['goals_count'] ?? json['goals'] ?? 0,
      assistsCount: json['assists_count'] ?? json['assists'] ?? 0,
      yellowCardsCount: json['yellow_cards_count'] ?? json['yellow_cards'] ?? 0,
      redCardsCount: json['red_cards_count'] ?? json['red_cards'] ?? 0,
    );
  }

  // Simplified position category (GK, DF, MF, FW) for pitch layout
  String get shortPositionCategory {
    final lower = positionCode.toLowerCase();
    if (lower.contains('goalkeeper') || lower == 'gk') return 'GK';
    if (lower.contains('defender') || lower == 'df') return 'DF';
    if (lower.contains('midfielder') || lower == 'mf') return 'MF';
    if (lower.contains('attacker') || lower.contains('forward') || lower == 'fw') return 'FW';
    return 'MF';
  }
}

class MatchLineupCoachModel {
  final int id;
  final String name;
  final String commonName;
  final String image;

  MatchLineupCoachModel({
    required this.id,
    required this.name,
    required this.commonName,
    required this.image,
  });

  factory MatchLineupCoachModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupCoachModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      commonName: json['common_name'] ?? json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class MatchLineupSubEventModel {
  final int eventId;
  final int playerId;
  final int relatedPlayerId;
  final String playerName;
  final String relatedPlayerName;
  final int minute;
  final int? extraMinute;
  final String direction;

  MatchLineupSubEventModel({
    required this.eventId,
    this.playerId = 0,
    this.relatedPlayerId = 0,
    this.playerName = '',
    this.relatedPlayerName = '',
    required this.minute,
    this.extraMinute,
    required this.direction,
  });

  factory MatchLineupSubEventModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupSubEventModel(
      eventId: json['id'] ?? json['event_id'] ?? 0,
      playerId: json['player_id'] ?? 0,
      relatedPlayerId: json['related_player_id'] ?? 0,
      playerName: json['player_name']?.toString() ?? '',
      relatedPlayerName: json['related_player_name']?.toString() ?? '',
      minute: json['minute'] ?? 0,
      extraMinute: json['extra_minute'],
      direction: json['direction']?.toString() ?? 'in',
    );
  }
}
