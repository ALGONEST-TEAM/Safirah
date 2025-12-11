import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';

class LeagueModel {
  final int? id;
  final String? name;
  final String? type;
  final int? organizerId;
  final String? scope;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? maxTeams;
  final int? maxMainPlayers;
  final int? maxSubPlayers;
  final bool isPrivate;
  final String status;
  final String? subscriptionPrice;
  final String? logoPath;


  LeagueModel({
    this.id,
    this.name,
    this.type,
    this.organizerId,
    this.scope,
    this.startDate,
    this.endDate,
    this.maxTeams,
    this.maxMainPlayers,
    this.maxSubPlayers,
    this.isPrivate = false,
    this.status = 'active',
    this.subscriptionPrice,
    this.logoPath,
  });

  LeagueModel copyWith({
    int? id,
    String? name,
    String? type,
    int? organizerId,
    String? scope,
    DateTime? startDate,
    DateTime? endDate,
    int? maxTeams,
    int? maxMainPlayers,
    int? maxSubPlayers,
    bool? isPrivate,
    String? status,
    String? subscriptionPrice,
    String? logoPath,
  }) {
    return LeagueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      organizerId: organizerId ?? this.organizerId,
      scope: scope ?? this.scope,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxTeams: maxTeams ?? this.maxTeams,
      maxMainPlayers: maxMainPlayers ?? this.maxMainPlayers,
      maxSubPlayers: maxSubPlayers ?? this.maxSubPlayers,
      isPrivate: isPrivate ?? this.isPrivate,
      status: status ?? this.status,
      subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  // ===== API JSON =====
  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        id: json['id'],
        name: json['league_name'] ?? json['name'] ?? '',
        type: json['league_type'] ?? json['type'],
        organizerId: json['organizer_id'],
        scope: json['league_scope'] ?? json['scope'],
        startDate: json['start_date'] != null
            ? DateTime.tryParse(json['start_date'])
            : null,
        endDate: json['end_date'] != null
            ? DateTime.tryParse(json['end_date'])
            : null,
        maxTeams: json['max_team'] ?? json['maxTeams'],
        maxMainPlayers: json['max_main_player'] ?? json['maxMainPlayers'],
        maxSubPlayers: json['max_sub_player'] ?? json['maxSubPlayers'],
        isPrivate: json['is_private'] ?? json['isPrivate'] ?? false,
        status: json['status'] ?? 'active',
        subscriptionPrice: json['subscription_price'],
        logoPath: json['logo_path'] ?? json['logoPath'],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'league_name': name,
        if (type != null) 'league_type': type,
        if (organizerId != null) 'organizer_id': organizerId,
        if (scope != null) 'league_scope': scope,
        if (startDate != null) 'start_date': startDate!.toIso8601String(),
        if (endDate != null) 'end_date': endDate!.toIso8601String(),
        if (maxTeams != null) 'max_team': maxTeams,
        if (maxMainPlayers != null) 'max_main_player': maxMainPlayers,
        if (maxSubPlayers != null) 'max_sub_player': maxSubPlayers,
        'is_private': isPrivate,
        'status': status,
        if (subscriptionPrice != null) 'subscription_price': subscriptionPrice,
        if (logoPath != null) 'logo_path': logoPath,
      };

  // ===== Drift Mapping =====

  LeaguesCompanion toCompanion() => LeaguesCompanion.insert(
        name: name ?? '',
        type: type != null ? Value(type!) : const Value.absent(),
        organizerId:
            organizerId != null ? Value(organizerId!) : const Value.absent(),
        scope: scope != null ? Value(scope!) : const Value.absent(),
        startDate:
            startDate != null ? Value(startDate!) : const Value.absent(),
        endDate: endDate != null ? Value(endDate!) : const Value.absent(),
        maxTeams: maxTeams != null ? Value(maxTeams!) : const Value.absent(),
        maxMainPlayers: maxMainPlayers != null
            ? Value(maxMainPlayers!)
            : const Value.absent(),
        maxSubPlayers: maxSubPlayers != null
            ? Value(maxSubPlayers!)
            : const Value.absent(),
        isPrivate: Value(isPrivate),
        status: Value(status),
        subscriptionPrice: subscriptionPrice ?? '',
        logoPath: logoPath != null ? Value(logoPath!) : const Value.absent(),
      );

  static LeagueModel fromEntity(League e) => LeagueModel(
        id: e.id,
        name: e.name,
        type: e.type,
        organizerId: e.organizerId,
        scope: e.scope,
        startDate: e.startDate,
        endDate: e.endDate,
        maxTeams: e.maxTeams,
        maxMainPlayers: e.maxMainPlayers,
        maxSubPlayers: e.maxSubPlayers,
        isPrivate: e.isPrivate,
        status: e.status,
        subscriptionPrice: e.subscriptionPrice,
        logoPath: e.logoPath,
      );
}
