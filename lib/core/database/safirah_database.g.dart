// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safirah_database.dart';

// ignore_for_file: type=lint
class $LeaguesTable extends Leagues with TableInfo<$LeaguesTable, League> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaguesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionPriceMeta =
      const VerificationMeta('subscriptionPrice');
  @override
  late final GeneratedColumn<String> subscriptionPrice =
      GeneratedColumn<String>('subscription_price', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _organizerIdMeta =
      const VerificationMeta('organizerId');
  @override
  late final GeneratedColumn<int> organizerId = GeneratedColumn<int>(
      'organizer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
      'scope', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _maxTeamsMeta =
      const VerificationMeta('maxTeams');
  @override
  late final GeneratedColumn<int> maxTeams = GeneratedColumn<int>(
      'max_teams', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxMainPlayersMeta =
      const VerificationMeta('maxMainPlayers');
  @override
  late final GeneratedColumn<int> maxMainPlayers = GeneratedColumn<int>(
      'max_main_players', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxSubPlayersMeta =
      const VerificationMeta('maxSubPlayers');
  @override
  late final GeneratedColumn<int> maxSubPlayers = GeneratedColumn<int>(
      'max_sub_players', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isPrivateMeta =
      const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
      'is_private', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_private" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        subscriptionPrice,
        type,
        organizerId,
        scope,
        logoPath,
        startDate,
        endDate,
        maxTeams,
        maxMainPlayers,
        maxSubPlayers,
        isPrivate,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leagues';
  @override
  VerificationContext validateIntegrity(Insertable<League> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('subscription_price')) {
      context.handle(
          _subscriptionPriceMeta,
          subscriptionPrice.isAcceptableOrUnknown(
              data['subscription_price']!, _subscriptionPriceMeta));
    } else if (isInserting) {
      context.missing(_subscriptionPriceMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('organizer_id')) {
      context.handle(
          _organizerIdMeta,
          organizerId.isAcceptableOrUnknown(
              data['organizer_id']!, _organizerIdMeta));
    }
    if (data.containsKey('scope')) {
      context.handle(
          _scopeMeta, scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('max_teams')) {
      context.handle(_maxTeamsMeta,
          maxTeams.isAcceptableOrUnknown(data['max_teams']!, _maxTeamsMeta));
    }
    if (data.containsKey('max_main_players')) {
      context.handle(
          _maxMainPlayersMeta,
          maxMainPlayers.isAcceptableOrUnknown(
              data['max_main_players']!, _maxMainPlayersMeta));
    }
    if (data.containsKey('max_sub_players')) {
      context.handle(
          _maxSubPlayersMeta,
          maxSubPlayers.isAcceptableOrUnknown(
              data['max_sub_players']!, _maxSubPlayersMeta));
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  League map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return League(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      subscriptionPrice: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}subscription_price'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      organizerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}organizer_id']),
      scope: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scope']),
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      maxTeams: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_teams']),
      maxMainPlayers: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_main_players']),
      maxSubPlayers: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_sub_players']),
      isPrivate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_private'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $LeaguesTable createAlias(String alias) {
    return $LeaguesTable(attachedDatabase, alias);
  }
}

class League extends DataClass implements Insertable<League> {
  final int id;
  final String name;
  final String subscriptionPrice;
  final String? type;
  final int? organizerId;
  final String? scope;
  final String? logoPath;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? maxTeams;
  final int? maxMainPlayers;
  final int? maxSubPlayers;
  final bool isPrivate;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const League(
      {required this.id,
      required this.name,
      required this.subscriptionPrice,
      this.type,
      this.organizerId,
      this.scope,
      this.logoPath,
      this.startDate,
      this.endDate,
      this.maxTeams,
      this.maxMainPlayers,
      this.maxSubPlayers,
      required this.isPrivate,
      required this.status,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['subscription_price'] = Variable<String>(subscriptionPrice);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || organizerId != null) {
      map['organizer_id'] = Variable<int>(organizerId);
    }
    if (!nullToAbsent || scope != null) {
      map['scope'] = Variable<String>(scope);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || maxTeams != null) {
      map['max_teams'] = Variable<int>(maxTeams);
    }
    if (!nullToAbsent || maxMainPlayers != null) {
      map['max_main_players'] = Variable<int>(maxMainPlayers);
    }
    if (!nullToAbsent || maxSubPlayers != null) {
      map['max_sub_players'] = Variable<int>(maxSubPlayers);
    }
    map['is_private'] = Variable<bool>(isPrivate);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LeaguesCompanion toCompanion(bool nullToAbsent) {
    return LeaguesCompanion(
      id: Value(id),
      name: Value(name),
      subscriptionPrice: Value(subscriptionPrice),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      organizerId: organizerId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizerId),
      scope:
          scope == null && nullToAbsent ? const Value.absent() : Value(scope),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      maxTeams: maxTeams == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTeams),
      maxMainPlayers: maxMainPlayers == null && nullToAbsent
          ? const Value.absent()
          : Value(maxMainPlayers),
      maxSubPlayers: maxSubPlayers == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSubPlayers),
      isPrivate: Value(isPrivate),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory League.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return League(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      subscriptionPrice: serializer.fromJson<String>(json['subscriptionPrice']),
      type: serializer.fromJson<String?>(json['type']),
      organizerId: serializer.fromJson<int?>(json['organizerId']),
      scope: serializer.fromJson<String?>(json['scope']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      maxTeams: serializer.fromJson<int?>(json['maxTeams']),
      maxMainPlayers: serializer.fromJson<int?>(json['maxMainPlayers']),
      maxSubPlayers: serializer.fromJson<int?>(json['maxSubPlayers']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'subscriptionPrice': serializer.toJson<String>(subscriptionPrice),
      'type': serializer.toJson<String?>(type),
      'organizerId': serializer.toJson<int?>(organizerId),
      'scope': serializer.toJson<String?>(scope),
      'logoPath': serializer.toJson<String?>(logoPath),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'maxTeams': serializer.toJson<int?>(maxTeams),
      'maxMainPlayers': serializer.toJson<int?>(maxMainPlayers),
      'maxSubPlayers': serializer.toJson<int?>(maxSubPlayers),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  League copyWith(
          {int? id,
          String? name,
          String? subscriptionPrice,
          Value<String?> type = const Value.absent(),
          Value<int?> organizerId = const Value.absent(),
          Value<String?> scope = const Value.absent(),
          Value<String?> logoPath = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<int?> maxTeams = const Value.absent(),
          Value<int?> maxMainPlayers = const Value.absent(),
          Value<int?> maxSubPlayers = const Value.absent(),
          bool? isPrivate,
          String? status,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      League(
        id: id ?? this.id,
        name: name ?? this.name,
        subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
        type: type.present ? type.value : this.type,
        organizerId: organizerId.present ? organizerId.value : this.organizerId,
        scope: scope.present ? scope.value : this.scope,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        maxTeams: maxTeams.present ? maxTeams.value : this.maxTeams,
        maxMainPlayers:
            maxMainPlayers.present ? maxMainPlayers.value : this.maxMainPlayers,
        maxSubPlayers:
            maxSubPlayers.present ? maxSubPlayers.value : this.maxSubPlayers,
        isPrivate: isPrivate ?? this.isPrivate,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  League copyWithCompanion(LeaguesCompanion data) {
    return League(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      subscriptionPrice: data.subscriptionPrice.present
          ? data.subscriptionPrice.value
          : this.subscriptionPrice,
      type: data.type.present ? data.type.value : this.type,
      organizerId:
          data.organizerId.present ? data.organizerId.value : this.organizerId,
      scope: data.scope.present ? data.scope.value : this.scope,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      maxTeams: data.maxTeams.present ? data.maxTeams.value : this.maxTeams,
      maxMainPlayers: data.maxMainPlayers.present
          ? data.maxMainPlayers.value
          : this.maxMainPlayers,
      maxSubPlayers: data.maxSubPlayers.present
          ? data.maxSubPlayers.value
          : this.maxSubPlayers,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('League(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subscriptionPrice: $subscriptionPrice, ')
          ..write('type: $type, ')
          ..write('organizerId: $organizerId, ')
          ..write('scope: $scope, ')
          ..write('logoPath: $logoPath, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('maxTeams: $maxTeams, ')
          ..write('maxMainPlayers: $maxMainPlayers, ')
          ..write('maxSubPlayers: $maxSubPlayers, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      subscriptionPrice,
      type,
      organizerId,
      scope,
      logoPath,
      startDate,
      endDate,
      maxTeams,
      maxMainPlayers,
      maxSubPlayers,
      isPrivate,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is League &&
          other.id == this.id &&
          other.name == this.name &&
          other.subscriptionPrice == this.subscriptionPrice &&
          other.type == this.type &&
          other.organizerId == this.organizerId &&
          other.scope == this.scope &&
          other.logoPath == this.logoPath &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.maxTeams == this.maxTeams &&
          other.maxMainPlayers == this.maxMainPlayers &&
          other.maxSubPlayers == this.maxSubPlayers &&
          other.isPrivate == this.isPrivate &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LeaguesCompanion extends UpdateCompanion<League> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> subscriptionPrice;
  final Value<String?> type;
  final Value<int?> organizerId;
  final Value<String?> scope;
  final Value<String?> logoPath;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> maxTeams;
  final Value<int?> maxMainPlayers;
  final Value<int?> maxSubPlayers;
  final Value<bool> isPrivate;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const LeaguesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.subscriptionPrice = const Value.absent(),
    this.type = const Value.absent(),
    this.organizerId = const Value.absent(),
    this.scope = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.maxTeams = const Value.absent(),
    this.maxMainPlayers = const Value.absent(),
    this.maxSubPlayers = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeaguesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String subscriptionPrice,
    this.type = const Value.absent(),
    this.organizerId = const Value.absent(),
    this.scope = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.maxTeams = const Value.absent(),
    this.maxMainPlayers = const Value.absent(),
    this.maxSubPlayers = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        subscriptionPrice = Value(subscriptionPrice);
  static Insertable<League> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? subscriptionPrice,
    Expression<String>? type,
    Expression<int>? organizerId,
    Expression<String>? scope,
    Expression<String>? logoPath,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? maxTeams,
    Expression<int>? maxMainPlayers,
    Expression<int>? maxSubPlayers,
    Expression<bool>? isPrivate,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (subscriptionPrice != null) 'subscription_price': subscriptionPrice,
      if (type != null) 'type': type,
      if (organizerId != null) 'organizer_id': organizerId,
      if (scope != null) 'scope': scope,
      if (logoPath != null) 'logo_path': logoPath,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (maxTeams != null) 'max_teams': maxTeams,
      if (maxMainPlayers != null) 'max_main_players': maxMainPlayers,
      if (maxSubPlayers != null) 'max_sub_players': maxSubPlayers,
      if (isPrivate != null) 'is_private': isPrivate,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeaguesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? subscriptionPrice,
      Value<String?>? type,
      Value<int?>? organizerId,
      Value<String?>? scope,
      Value<String?>? logoPath,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<int?>? maxTeams,
      Value<int?>? maxMainPlayers,
      Value<int?>? maxSubPlayers,
      Value<bool>? isPrivate,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return LeaguesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
      type: type ?? this.type,
      organizerId: organizerId ?? this.organizerId,
      scope: scope ?? this.scope,
      logoPath: logoPath ?? this.logoPath,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxTeams: maxTeams ?? this.maxTeams,
      maxMainPlayers: maxMainPlayers ?? this.maxMainPlayers,
      maxSubPlayers: maxSubPlayers ?? this.maxSubPlayers,
      isPrivate: isPrivate ?? this.isPrivate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (subscriptionPrice.present) {
      map['subscription_price'] = Variable<String>(subscriptionPrice.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (organizerId.present) {
      map['organizer_id'] = Variable<int>(organizerId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (maxTeams.present) {
      map['max_teams'] = Variable<int>(maxTeams.value);
    }
    if (maxMainPlayers.present) {
      map['max_main_players'] = Variable<int>(maxMainPlayers.value);
    }
    if (maxSubPlayers.present) {
      map['max_sub_players'] = Variable<int>(maxSubPlayers.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subscriptionPrice: $subscriptionPrice, ')
          ..write('type: $type, ')
          ..write('organizerId: $organizerId, ')
          ..write('scope: $scope, ')
          ..write('logoPath: $logoPath, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('maxTeams: $maxTeams, ')
          ..write('maxMainPlayers: $maxMainPlayers, ')
          ..write('maxSubPlayers: $maxSubPlayers, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LeagueRulesTable extends LeagueRules
    with TableInfo<$LeagueRulesTable, LeagueRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeagueRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES leagues (id)'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isMandatoryMeta =
      const VerificationMeta('isMandatory');
  @override
  late final GeneratedColumn<bool> isMandatory = GeneratedColumn<bool>(
      'is_mandatory', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_mandatory" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, description, isMandatory, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_rules';
  @override
  VerificationContext validateIntegrity(Insertable<LeagueRule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_mandatory')) {
      context.handle(
          _isMandatoryMeta,
          isMandatory.isAcceptableOrUnknown(
              data['is_mandatory']!, _isMandatoryMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeagueRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeagueRule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isMandatory: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_mandatory'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LeagueRulesTable createAlias(String alias) {
    return $LeagueRulesTable(attachedDatabase, alias);
  }
}

class LeagueRule extends DataClass implements Insertable<LeagueRule> {
  final int id;
  final int leagueId;
  final String description;
  final bool isMandatory;
  final DateTime createdAt;
  const LeagueRule(
      {required this.id,
      required this.leagueId,
      required this.description,
      required this.isMandatory,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['description'] = Variable<String>(description);
    map['is_mandatory'] = Variable<bool>(isMandatory);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LeagueRulesCompanion toCompanion(bool nullToAbsent) {
    return LeagueRulesCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      description: Value(description),
      isMandatory: Value(isMandatory),
      createdAt: Value(createdAt),
    );
  }

  factory LeagueRule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeagueRule(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      description: serializer.fromJson<String>(json['description']),
      isMandatory: serializer.fromJson<bool>(json['isMandatory']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'description': serializer.toJson<String>(description),
      'isMandatory': serializer.toJson<bool>(isMandatory),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LeagueRule copyWith(
          {int? id,
          int? leagueId,
          String? description,
          bool? isMandatory,
          DateTime? createdAt}) =>
      LeagueRule(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        description: description ?? this.description,
        isMandatory: isMandatory ?? this.isMandatory,
        createdAt: createdAt ?? this.createdAt,
      );
  LeagueRule copyWithCompanion(LeagueRulesCompanion data) {
    return LeagueRule(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      description:
          data.description.present ? data.description.value : this.description,
      isMandatory:
          data.isMandatory.present ? data.isMandatory.value : this.isMandatory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeagueRule(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('description: $description, ')
          ..write('isMandatory: $isMandatory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, leagueId, description, isMandatory, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueRule &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.description == this.description &&
          other.isMandatory == this.isMandatory &&
          other.createdAt == this.createdAt);
}

class LeagueRulesCompanion extends UpdateCompanion<LeagueRule> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<String> description;
  final Value<bool> isMandatory;
  final Value<DateTime> createdAt;
  const LeagueRulesCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.description = const Value.absent(),
    this.isMandatory = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LeagueRulesCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required String description,
    this.isMandatory = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        description = Value(description);
  static Insertable<LeagueRule> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<String>? description,
    Expression<bool>? isMandatory,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (description != null) 'description': description,
      if (isMandatory != null) 'is_mandatory': isMandatory,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LeagueRulesCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<String>? description,
      Value<bool>? isMandatory,
      Value<DateTime>? createdAt}) {
    return LeagueRulesCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      description: description ?? this.description,
      isMandatory: isMandatory ?? this.isMandatory,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isMandatory.present) {
      map['is_mandatory'] = Variable<bool>(isMandatory.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeagueRulesCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('description: $description, ')
          ..write('isMandatory: $isMandatory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _teamNameMeta =
      const VerificationMeta('teamName');
  @override
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
      'team_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _logoUrlMeta =
      const VerificationMeta('logoUrl');
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
      'logo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('placeholder'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, teamName, logoUrl, status, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(Insertable<Team> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('team_name')) {
      context.handle(_teamNameMeta,
          teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta));
    } else if (isInserting) {
      context.missing(_teamNameMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(_logoUrlMeta,
          logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      teamName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_name'])!,
      logoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_url']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final int id;
  final int leagueId;
  final String teamName;
  final String? logoUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Team(
      {required this.id,
      required this.leagueId,
      required this.teamName,
      this.logoUrl,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['team_name'] = Variable<String>(teamName);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      teamName: Value(teamName),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Team.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      teamName: serializer.fromJson<String>(json['teamName']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'teamName': serializer.toJson<String>(teamName),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Team copyWith(
          {int? id,
          int? leagueId,
          String? teamName,
          Value<String?> logoUrl = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Team(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        teamName: teamName ?? this.teamName,
        logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('teamName: $teamName, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, leagueId, teamName, logoUrl, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.teamName == this.teamName &&
          other.logoUrl == this.logoUrl &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<String> teamName;
  final Value<String?> logoUrl;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.teamName = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required String teamName,
    this.logoUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        teamName = Value(teamName);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<String>? teamName,
    Expression<String>? logoUrl,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (teamName != null) 'team_name': teamName,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TeamsCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<String>? teamName,
      Value<String?>? logoUrl,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TeamsCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      teamName: teamName ?? this.teamName,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('teamName: $teamName, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TeamPlayerCategoriesTable extends TeamPlayerCategories
    with TableInfo<$TeamPlayerCategoriesTable, TeamPlayerCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamPlayerCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, leagueId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_player_categories';
  @override
  VerificationContext validateIntegrity(Insertable<TeamPlayerCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamPlayerCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamPlayerCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TeamPlayerCategoriesTable createAlias(String alias) {
    return $TeamPlayerCategoriesTable(attachedDatabase, alias);
  }
}

class TeamPlayerCategory extends DataClass
    implements Insertable<TeamPlayerCategory> {
  final int id;
  final int leagueId;
  final String name;
  const TeamPlayerCategory(
      {required this.id, required this.leagueId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['name'] = Variable<String>(name);
    return map;
  }

  TeamPlayerCategoriesCompanion toCompanion(bool nullToAbsent) {
    return TeamPlayerCategoriesCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      name: Value(name),
    );
  }

  factory TeamPlayerCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPlayerCategory(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'name': serializer.toJson<String>(name),
    };
  }

  TeamPlayerCategory copyWith({int? id, int? leagueId, String? name}) =>
      TeamPlayerCategory(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        name: name ?? this.name,
      );
  TeamPlayerCategory copyWithCompanion(TeamPlayerCategoriesCompanion data) {
    return TeamPlayerCategory(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerCategory(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, leagueId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPlayerCategory &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.name == this.name);
}

class TeamPlayerCategoriesCompanion
    extends UpdateCompanion<TeamPlayerCategory> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<String> name;
  const TeamPlayerCategoriesCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.name = const Value.absent(),
  });
  TeamPlayerCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required String name,
  })  : leagueId = Value(leagueId),
        name = Value(name);
  static Insertable<TeamPlayerCategory> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (name != null) 'name': name,
    });
  }

  TeamPlayerCategoriesCompanion copyWith(
      {Value<int>? id, Value<int>? leagueId, Value<String>? name}) {
    return TeamPlayerCategoriesCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $LeaguePlayersTable extends LeaguePlayers
    with TableInfo<$LeaguePlayersTable, LeaguePlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaguePlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _teamPlayerCategoryIdMeta =
      const VerificationMeta('teamPlayerCategoryId');
  @override
  late final GeneratedColumn<int> teamPlayerCategoryId = GeneratedColumn<int>(
      'team_player_category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES team_player_categories (id) ON DELETE SET NULL'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, userId, teamPlayerCategoryId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_players';
  @override
  VerificationContext validateIntegrity(Insertable<LeaguePlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('team_player_category_id')) {
      context.handle(
          _teamPlayerCategoryIdMeta,
          teamPlayerCategoryId.isAcceptableOrUnknown(
              data['team_player_category_id']!, _teamPlayerCategoryIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeaguePlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaguePlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      teamPlayerCategoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}team_player_category_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LeaguePlayersTable createAlias(String alias) {
    return $LeaguePlayersTable(attachedDatabase, alias);
  }
}

class LeaguePlayer extends DataClass implements Insertable<LeaguePlayer> {
  final int id;
  final int leagueId;
  final int userId;
  final int? teamPlayerCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LeaguePlayer(
      {required this.id,
      required this.leagueId,
      required this.userId,
      this.teamPlayerCategoryId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || teamPlayerCategoryId != null) {
      map['team_player_category_id'] = Variable<int>(teamPlayerCategoryId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LeaguePlayersCompanion toCompanion(bool nullToAbsent) {
    return LeaguePlayersCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      userId: Value(userId),
      teamPlayerCategoryId: teamPlayerCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(teamPlayerCategoryId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LeaguePlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaguePlayer(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      userId: serializer.fromJson<int>(json['userId']),
      teamPlayerCategoryId:
          serializer.fromJson<int?>(json['teamPlayerCategoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'userId': serializer.toJson<int>(userId),
      'teamPlayerCategoryId': serializer.toJson<int?>(teamPlayerCategoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LeaguePlayer copyWith(
          {int? id,
          int? leagueId,
          int? userId,
          Value<int?> teamPlayerCategoryId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LeaguePlayer(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        userId: userId ?? this.userId,
        teamPlayerCategoryId: teamPlayerCategoryId.present
            ? teamPlayerCategoryId.value
            : this.teamPlayerCategoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LeaguePlayer copyWithCompanion(LeaguePlayersCompanion data) {
    return LeaguePlayer(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      userId: data.userId.present ? data.userId.value : this.userId,
      teamPlayerCategoryId: data.teamPlayerCategoryId.present
          ? data.teamPlayerCategoryId.value
          : this.teamPlayerCategoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaguePlayer(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('userId: $userId, ')
          ..write('teamPlayerCategoryId: $teamPlayerCategoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, leagueId, userId, teamPlayerCategoryId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaguePlayer &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.userId == this.userId &&
          other.teamPlayerCategoryId == this.teamPlayerCategoryId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LeaguePlayersCompanion extends UpdateCompanion<LeaguePlayer> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<int> userId;
  final Value<int?> teamPlayerCategoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LeaguePlayersCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.userId = const Value.absent(),
    this.teamPlayerCategoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeaguePlayersCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required int userId,
    this.teamPlayerCategoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        userId = Value(userId);
  static Insertable<LeaguePlayer> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<int>? userId,
    Expression<int>? teamPlayerCategoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (userId != null) 'user_id': userId,
      if (teamPlayerCategoryId != null)
        'team_player_category_id': teamPlayerCategoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeaguePlayersCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<int>? userId,
      Value<int?>? teamPlayerCategoryId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LeaguePlayersCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      userId: userId ?? this.userId,
      teamPlayerCategoryId: teamPlayerCategoryId ?? this.teamPlayerCategoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (teamPlayerCategoryId.present) {
      map['team_player_category_id'] =
          Variable<int>(teamPlayerCategoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguePlayersCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('userId: $userId, ')
          ..write('teamPlayerCategoryId: $teamPlayerCategoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playerLeagueIdMeta =
      const VerificationMeta('playerLeagueId');
  @override
  late final GeneratedColumn<int> playerLeagueId = GeneratedColumn<int>(
      'player_league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES league_players (id) ON DELETE CASCADE'));
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES teams (id) ON DELETE SET NULL'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('main'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        playerLeagueId,
        teamId,
        fullName,
        position,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_league_id')) {
      context.handle(
          _playerLeagueIdMeta,
          playerLeagueId.isAcceptableOrUnknown(
              data['player_league_id']!, _playerLeagueIdMeta));
    } else if (isInserting) {
      context.missing(_playerLeagueIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playerLeagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_league_id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final int playerLeagueId;
  final int? teamId;
  final String fullName;
  final String? position;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Player(
      {required this.id,
      required this.playerLeagueId,
      this.teamId,
      required this.fullName,
      this.position,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_league_id'] = Variable<int>(playerLeagueId);
    if (!nullToAbsent || teamId != null) {
      map['team_id'] = Variable<int>(teamId);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      playerLeagueId: Value(playerLeagueId),
      teamId:
          teamId == null && nullToAbsent ? const Value.absent() : Value(teamId),
      fullName: Value(fullName),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      playerLeagueId: serializer.fromJson<int>(json['playerLeagueId']),
      teamId: serializer.fromJson<int?>(json['teamId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      position: serializer.fromJson<String?>(json['position']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerLeagueId': serializer.toJson<int>(playerLeagueId),
      'teamId': serializer.toJson<int?>(teamId),
      'fullName': serializer.toJson<String>(fullName),
      'position': serializer.toJson<String?>(position),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Player copyWith(
          {int? id,
          int? playerLeagueId,
          Value<int?> teamId = const Value.absent(),
          String? fullName,
          Value<String?> position = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Player(
        id: id ?? this.id,
        playerLeagueId: playerLeagueId ?? this.playerLeagueId,
        teamId: teamId.present ? teamId.value : this.teamId,
        fullName: fullName ?? this.fullName,
        position: position.present ? position.value : this.position,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      playerLeagueId: data.playerLeagueId.present
          ? data.playerLeagueId.value
          : this.playerLeagueId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      position: data.position.present ? data.position.value : this.position,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('playerLeagueId: $playerLeagueId, ')
          ..write('teamId: $teamId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerLeagueId, teamId, fullName,
      position, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.playerLeagueId == this.playerLeagueId &&
          other.teamId == this.teamId &&
          other.fullName == this.fullName &&
          other.position == this.position &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<int> playerLeagueId;
  final Value<int?> teamId;
  final Value<String> fullName;
  final Value<String?> position;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.playerLeagueId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.position = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required int playerLeagueId,
    this.teamId = const Value.absent(),
    required String fullName,
    this.position = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : playerLeagueId = Value(playerLeagueId),
        fullName = Value(fullName);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<int>? playerLeagueId,
    Expression<int>? teamId,
    Expression<String>? fullName,
    Expression<String>? position,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerLeagueId != null) 'player_league_id': playerLeagueId,
      if (teamId != null) 'team_id': teamId,
      if (fullName != null) 'full_name': fullName,
      if (position != null) 'position': position,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<int>? playerLeagueId,
      Value<int?>? teamId,
      Value<String>? fullName,
      Value<String?>? position,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PlayersCompanion(
      id: id ?? this.id,
      playerLeagueId: playerLeagueId ?? this.playerLeagueId,
      teamId: teamId ?? this.teamId,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerLeagueId.present) {
      map['player_league_id'] = Variable<int>(playerLeagueId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('playerLeagueId: $playerLeagueId, ')
          ..write('teamId: $teamId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DraftProgressTable extends DraftProgress
    with TableInfo<$DraftProgressTable, DraftProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _catsJsonMeta =
      const VerificationMeta('catsJson');
  @override
  late final GeneratedColumn<String> catsJson = GeneratedColumn<String>(
      'cats_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _unassignedJsonMeta =
      const VerificationMeta('unassignedJson');
  @override
  late final GeneratedColumn<String> unassignedJson = GeneratedColumn<String>(
      'unassigned_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _currentNameMeta =
      const VerificationMeta('currentName');
  @override
  late final GeneratedColumn<String> currentName = GeneratedColumn<String>(
      'current_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _currentPickJsonMeta =
      const VerificationMeta('currentPickJson');
  @override
  late final GeneratedColumn<String> currentPickJson = GeneratedColumn<String>(
      'current_pick_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        leagueId,
        catsJson,
        unassignedJson,
        currentName,
        currentPickJson,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_progress';
  @override
  VerificationContext validateIntegrity(Insertable<DraftProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    }
    if (data.containsKey('cats_json')) {
      context.handle(_catsJsonMeta,
          catsJson.isAcceptableOrUnknown(data['cats_json']!, _catsJsonMeta));
    }
    if (data.containsKey('unassigned_json')) {
      context.handle(
          _unassignedJsonMeta,
          unassignedJson.isAcceptableOrUnknown(
              data['unassigned_json']!, _unassignedJsonMeta));
    }
    if (data.containsKey('current_name')) {
      context.handle(
          _currentNameMeta,
          currentName.isAcceptableOrUnknown(
              data['current_name']!, _currentNameMeta));
    }
    if (data.containsKey('current_pick_json')) {
      context.handle(
          _currentPickJsonMeta,
          currentPickJson.isAcceptableOrUnknown(
              data['current_pick_json']!, _currentPickJsonMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {leagueId};
  @override
  DraftProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftProgressData(
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      catsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cats_json'])!,
      unassignedJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}unassigned_json'])!,
      currentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_name'])!,
      currentPickJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_pick_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DraftProgressTable createAlias(String alias) {
    return $DraftProgressTable(attachedDatabase, alias);
  }
}

class DraftProgressData extends DataClass
    implements Insertable<DraftProgressData> {
  final int leagueId;
  final String catsJson;
  final String unassignedJson;
  final String currentName;
  final String currentPickJson;
  final DateTime updatedAt;
  const DraftProgressData(
      {required this.leagueId,
      required this.catsJson,
      required this.unassignedJson,
      required this.currentName,
      required this.currentPickJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['league_id'] = Variable<int>(leagueId);
    map['cats_json'] = Variable<String>(catsJson);
    map['unassigned_json'] = Variable<String>(unassignedJson);
    map['current_name'] = Variable<String>(currentName);
    map['current_pick_json'] = Variable<String>(currentPickJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DraftProgressCompanion toCompanion(bool nullToAbsent) {
    return DraftProgressCompanion(
      leagueId: Value(leagueId),
      catsJson: Value(catsJson),
      unassignedJson: Value(unassignedJson),
      currentName: Value(currentName),
      currentPickJson: Value(currentPickJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory DraftProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftProgressData(
      leagueId: serializer.fromJson<int>(json['leagueId']),
      catsJson: serializer.fromJson<String>(json['catsJson']),
      unassignedJson: serializer.fromJson<String>(json['unassignedJson']),
      currentName: serializer.fromJson<String>(json['currentName']),
      currentPickJson: serializer.fromJson<String>(json['currentPickJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'leagueId': serializer.toJson<int>(leagueId),
      'catsJson': serializer.toJson<String>(catsJson),
      'unassignedJson': serializer.toJson<String>(unassignedJson),
      'currentName': serializer.toJson<String>(currentName),
      'currentPickJson': serializer.toJson<String>(currentPickJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DraftProgressData copyWith(
          {int? leagueId,
          String? catsJson,
          String? unassignedJson,
          String? currentName,
          String? currentPickJson,
          DateTime? updatedAt}) =>
      DraftProgressData(
        leagueId: leagueId ?? this.leagueId,
        catsJson: catsJson ?? this.catsJson,
        unassignedJson: unassignedJson ?? this.unassignedJson,
        currentName: currentName ?? this.currentName,
        currentPickJson: currentPickJson ?? this.currentPickJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DraftProgressData copyWithCompanion(DraftProgressCompanion data) {
    return DraftProgressData(
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      catsJson: data.catsJson.present ? data.catsJson.value : this.catsJson,
      unassignedJson: data.unassignedJson.present
          ? data.unassignedJson.value
          : this.unassignedJson,
      currentName:
          data.currentName.present ? data.currentName.value : this.currentName,
      currentPickJson: data.currentPickJson.present
          ? data.currentPickJson.value
          : this.currentPickJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftProgressData(')
          ..write('leagueId: $leagueId, ')
          ..write('catsJson: $catsJson, ')
          ..write('unassignedJson: $unassignedJson, ')
          ..write('currentName: $currentName, ')
          ..write('currentPickJson: $currentPickJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(leagueId, catsJson, unassignedJson,
      currentName, currentPickJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftProgressData &&
          other.leagueId == this.leagueId &&
          other.catsJson == this.catsJson &&
          other.unassignedJson == this.unassignedJson &&
          other.currentName == this.currentName &&
          other.currentPickJson == this.currentPickJson &&
          other.updatedAt == this.updatedAt);
}

class DraftProgressCompanion extends UpdateCompanion<DraftProgressData> {
  final Value<int> leagueId;
  final Value<String> catsJson;
  final Value<String> unassignedJson;
  final Value<String> currentName;
  final Value<String> currentPickJson;
  final Value<DateTime> updatedAt;
  const DraftProgressCompanion({
    this.leagueId = const Value.absent(),
    this.catsJson = const Value.absent(),
    this.unassignedJson = const Value.absent(),
    this.currentName = const Value.absent(),
    this.currentPickJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DraftProgressCompanion.insert({
    this.leagueId = const Value.absent(),
    this.catsJson = const Value.absent(),
    this.unassignedJson = const Value.absent(),
    this.currentName = const Value.absent(),
    this.currentPickJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<DraftProgressData> custom({
    Expression<int>? leagueId,
    Expression<String>? catsJson,
    Expression<String>? unassignedJson,
    Expression<String>? currentName,
    Expression<String>? currentPickJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (leagueId != null) 'league_id': leagueId,
      if (catsJson != null) 'cats_json': catsJson,
      if (unassignedJson != null) 'unassigned_json': unassignedJson,
      if (currentName != null) 'current_name': currentName,
      if (currentPickJson != null) 'current_pick_json': currentPickJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DraftProgressCompanion copyWith(
      {Value<int>? leagueId,
      Value<String>? catsJson,
      Value<String>? unassignedJson,
      Value<String>? currentName,
      Value<String>? currentPickJson,
      Value<DateTime>? updatedAt}) {
    return DraftProgressCompanion(
      leagueId: leagueId ?? this.leagueId,
      catsJson: catsJson ?? this.catsJson,
      unassignedJson: unassignedJson ?? this.unassignedJson,
      currentName: currentName ?? this.currentName,
      currentPickJson: currentPickJson ?? this.currentPickJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (catsJson.present) {
      map['cats_json'] = Variable<String>(catsJson.value);
    }
    if (unassignedJson.present) {
      map['unassigned_json'] = Variable<String>(unassignedJson.value);
    }
    if (currentName.present) {
      map['current_name'] = Variable<String>(currentName.value);
    }
    if (currentPickJson.present) {
      map['current_pick_json'] = Variable<String>(currentPickJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftProgressCompanion(')
          ..write('leagueId: $leagueId, ')
          ..write('catsJson: $catsJson, ')
          ..write('unassignedJson: $unassignedJson, ')
          ..write('currentName: $currentName, ')
          ..write('currentPickJson: $currentPickJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, entityType, entityId, operation, payload, synced, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final int entityId;
  final String operation;
  final String payload;
  final bool synced;
  final DateTime createdAt;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.synced,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? entityType,
          int? entityId,
          String? operation,
          String? payload,
          bool? synced,
          DateTime? createdAt}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, entityType, entityId, operation, payload, synced, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
    required String operation,
    required String payload,
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<int>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<bool>? synced,
      Value<DateTime>? createdAt}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GroupTable extends Group with TableInfo<$GroupTable, GroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES leagues (id)'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _qualifiedTeamNumberMeta =
      const VerificationMeta('qualifiedTeamNumber');
  @override
  late final GeneratedColumn<int> qualifiedTeamNumber = GeneratedColumn<int>(
      'qualified_team_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, groupName, createdAt, qualifiedTeamNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group';
  @override
  VerificationContext validateIntegrity(Insertable<GroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('qualified_team_number')) {
      context.handle(
          _qualifiedTeamNumberMeta,
          qualifiedTeamNumber.isAcceptableOrUnknown(
              data['qualified_team_number']!, _qualifiedTeamNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      qualifiedTeamNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}qualified_team_number'])!,
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final int leagueId;
  final String groupName;
  final DateTime createdAt;
  final int qualifiedTeamNumber;
  const GroupData(
      {required this.id,
      required this.leagueId,
      required this.groupName,
      required this.createdAt,
      required this.qualifiedTeamNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['group_name'] = Variable<String>(groupName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['qualified_team_number'] = Variable<int>(qualifiedTeamNumber);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      groupName: Value(groupName),
      createdAt: Value(createdAt),
      qualifiedTeamNumber: Value(qualifiedTeamNumber),
    );
  }

  factory GroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      qualifiedTeamNumber:
          serializer.fromJson<int>(json['qualifiedTeamNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'groupName': serializer.toJson<String>(groupName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'qualifiedTeamNumber': serializer.toJson<int>(qualifiedTeamNumber),
    };
  }

  GroupData copyWith(
          {int? id,
          int? leagueId,
          String? groupName,
          DateTime? createdAt,
          int? qualifiedTeamNumber}) =>
      GroupData(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        groupName: groupName ?? this.groupName,
        createdAt: createdAt ?? this.createdAt,
        qualifiedTeamNumber: qualifiedTeamNumber ?? this.qualifiedTeamNumber,
      );
  GroupData copyWithCompanion(GroupCompanion data) {
    return GroupData(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      qualifiedTeamNumber: data.qualifiedTeamNumber.present
          ? data.qualifiedTeamNumber.value
          : this.qualifiedTeamNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('groupName: $groupName, ')
          ..write('createdAt: $createdAt, ')
          ..write('qualifiedTeamNumber: $qualifiedTeamNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, leagueId, groupName, createdAt, qualifiedTeamNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.groupName == this.groupName &&
          other.createdAt == this.createdAt &&
          other.qualifiedTeamNumber == this.qualifiedTeamNumber);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<String> groupName;
  final Value<DateTime> createdAt;
  final Value<int> qualifiedTeamNumber;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.qualifiedTeamNumber = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required String groupName,
    this.createdAt = const Value.absent(),
    this.qualifiedTeamNumber = const Value.absent(),
  })  : leagueId = Value(leagueId),
        groupName = Value(groupName);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<String>? groupName,
    Expression<DateTime>? createdAt,
    Expression<int>? qualifiedTeamNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (groupName != null) 'group_name': groupName,
      if (createdAt != null) 'created_at': createdAt,
      if (qualifiedTeamNumber != null)
        'qualified_team_number': qualifiedTeamNumber,
    });
  }

  GroupCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<String>? groupName,
      Value<DateTime>? createdAt,
      Value<int>? qualifiedTeamNumber}) {
    return GroupCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      groupName: groupName ?? this.groupName,
      createdAt: createdAt ?? this.createdAt,
      qualifiedTeamNumber: qualifiedTeamNumber ?? this.qualifiedTeamNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (qualifiedTeamNumber.present) {
      map['qualified_team_number'] = Variable<int>(qualifiedTeamNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('groupName: $groupName, ')
          ..write('createdAt: $createdAt, ')
          ..write('qualifiedTeamNumber: $qualifiedTeamNumber')
          ..write(')'))
        .toString();
  }
}

class $GroupTeamTable extends GroupTeam
    with TableInfo<$GroupTeamTable, GroupTeamData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTeamTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES "group" (id) ON DELETE CASCADE'));
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES teams (id) ON DELETE CASCADE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, teamId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_team';
  @override
  VerificationContext validateIntegrity(Insertable<GroupTeamData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupTeamData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupTeamData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $GroupTeamTable createAlias(String alias) {
    return $GroupTeamTable(attachedDatabase, alias);
  }
}

class GroupTeamData extends DataClass implements Insertable<GroupTeamData> {
  final int id;
  final int groupId;
  final int teamId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GroupTeamData(
      {required this.id,
      required this.groupId,
      required this.teamId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['team_id'] = Variable<int>(teamId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GroupTeamCompanion toCompanion(bool nullToAbsent) {
    return GroupTeamCompanion(
      id: Value(id),
      groupId: Value(groupId),
      teamId: Value(teamId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GroupTeamData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupTeamData(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'teamId': serializer.toJson<int>(teamId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GroupTeamData copyWith(
          {int? id,
          int? groupId,
          int? teamId,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GroupTeamData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        teamId: teamId ?? this.teamId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GroupTeamData copyWithCompanion(GroupTeamCompanion data) {
    return GroupTeamData(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupTeamData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('teamId: $teamId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, teamId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupTeamData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.teamId == this.teamId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GroupTeamCompanion extends UpdateCompanion<GroupTeamData> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<int> teamId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GroupTeamCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GroupTeamCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required int teamId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : groupId = Value(groupId),
        teamId = Value(teamId);
  static Insertable<GroupTeamData> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? teamId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (teamId != null) 'team_id': teamId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GroupTeamCompanion copyWith(
      {Value<int>? id,
      Value<int>? groupId,
      Value<int>? teamId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return GroupTeamCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      teamId: teamId ?? this.teamId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupTeamCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('teamId: $teamId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RoundsTable extends Rounds with TableInfo<$RoundsTable, Round> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'round_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES "group" (id) ON DELETE CASCADE'));
  static const VerificationMeta _roundTypeMeta =
      const VerificationMeta('roundType');
  @override
  late final GeneratedColumn<String> roundType = GeneratedColumn<String>(
      'round_type', aliasedName, false,
      check: () => roundType
          .isIn(['group', 'knockout', 'final', 'placement', 'qualifier']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, name, groupId, roundType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rounds';
  @override
  VerificationContext validateIntegrity(Insertable<Round> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('round_name')) {
      context.handle(_nameMeta,
          name.isAcceptableOrUnknown(data['round_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('round_type')) {
      context.handle(_roundTypeMeta,
          roundType.isAcceptableOrUnknown(data['round_type']!, _roundTypeMeta));
    } else if (isInserting) {
      context.missing(_roundTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Round map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Round(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_name'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id']),
      roundType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RoundsTable createAlias(String alias) {
    return $RoundsTable(attachedDatabase, alias);
  }
}

class Round extends DataClass implements Insertable<Round> {
  final int id;
  final int leagueId;
  final String name;
  final int? groupId;
  final String roundType;
  final DateTime createdAt;
  const Round(
      {required this.id,
      required this.leagueId,
      required this.name,
      this.groupId,
      required this.roundType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['round_name'] = Variable<String>(name);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    map['round_type'] = Variable<String>(roundType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoundsCompanion toCompanion(bool nullToAbsent) {
    return RoundsCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      name: Value(name),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      roundType: Value(roundType),
      createdAt: Value(createdAt),
    );
  }

  factory Round.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Round(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      name: serializer.fromJson<String>(json['name']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      roundType: serializer.fromJson<String>(json['roundType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'name': serializer.toJson<String>(name),
      'groupId': serializer.toJson<int?>(groupId),
      'roundType': serializer.toJson<String>(roundType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Round copyWith(
          {int? id,
          int? leagueId,
          String? name,
          Value<int?> groupId = const Value.absent(),
          String? roundType,
          DateTime? createdAt}) =>
      Round(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        name: name ?? this.name,
        groupId: groupId.present ? groupId.value : this.groupId,
        roundType: roundType ?? this.roundType,
        createdAt: createdAt ?? this.createdAt,
      );
  Round copyWithCompanion(RoundsCompanion data) {
    return Round(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      name: data.name.present ? data.name.value : this.name,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      roundType: data.roundType.present ? data.roundType.value : this.roundType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Round(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name, ')
          ..write('groupId: $groupId, ')
          ..write('roundType: $roundType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, leagueId, name, groupId, roundType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Round &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.name == this.name &&
          other.groupId == this.groupId &&
          other.roundType == this.roundType &&
          other.createdAt == this.createdAt);
}

class RoundsCompanion extends UpdateCompanion<Round> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<String> name;
  final Value<int?> groupId;
  final Value<String> roundType;
  final Value<DateTime> createdAt;
  const RoundsCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.name = const Value.absent(),
    this.groupId = const Value.absent(),
    this.roundType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RoundsCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required String name,
    this.groupId = const Value.absent(),
    required String roundType,
    this.createdAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        name = Value(name),
        roundType = Value(roundType);
  static Insertable<Round> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<String>? name,
    Expression<int>? groupId,
    Expression<String>? roundType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (name != null) 'round_name': name,
      if (groupId != null) 'group_id': groupId,
      if (roundType != null) 'round_type': roundType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RoundsCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<String>? name,
      Value<int?>? groupId,
      Value<String>? roundType,
      Value<DateTime>? createdAt}) {
    return RoundsCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      roundType: roundType ?? this.roundType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (name.present) {
      map['round_name'] = Variable<String>(name.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (roundType.present) {
      map['round_type'] = Variable<String>(roundType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundsCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name, ')
          ..write('groupId: $groupId, ')
          ..write('roundType: $roundType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, Matche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _roundIdMeta =
      const VerificationMeta('roundId');
  @override
  late final GeneratedColumn<int> roundId = GeneratedColumn<int>(
      'round_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES rounds (id) ON DELETE CASCADE'));
  static const VerificationMeta _homeTeamIdMeta =
      const VerificationMeta('homeTeamId');
  @override
  late final GeneratedColumn<int> homeTeamId = GeneratedColumn<int>(
      'home_team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES teams (id) ON DELETE RESTRICT'));
  static const VerificationMeta _awayTeamIdMeta =
      const VerificationMeta('awayTeamId');
  @override
  late final GeneratedColumn<int> awayTeamId = GeneratedColumn<int>(
      'away_team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES teams (id) ON DELETE RESTRICT'));
  static const VerificationMeta _matchDateMeta =
      const VerificationMeta('matchDate');
  @override
  late final GeneratedColumn<DateTime> matchDate = GeneratedColumn<DateTime>(
      'match_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _scheduledStartTimeMeta =
      const VerificationMeta('scheduledStartTime');
  @override
  late final GeneratedColumn<DateTime> scheduledStartTime =
      GeneratedColumn<DateTime>('scheduled_start_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _homeScoreMeta =
      const VerificationMeta('homeScore');
  @override
  late final GeneratedColumn<int> homeScore = GeneratedColumn<int>(
      'home_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _awayScoreMeta =
      const VerificationMeta('awayScore');
  @override
  late final GeneratedColumn<int> awayScore = GeneratedColumn<int>(
      'away_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status =
      GeneratedColumn<String>('status', aliasedName, false,
          check: () => status.isIn([
                'scheduled',
                'live',
                'unscheduled',
                'finished',
                'canceled',
                'walkover',
                'postponed'
              ]),
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('unscheduled'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        leagueId,
        roundId,
        homeTeamId,
        awayTeamId,
        matchDate,
        scheduledStartTime,
        startTime,
        endTime,
        homeScore,
        awayScore,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(Insertable<Matche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('round_id')) {
      context.handle(_roundIdMeta,
          roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta));
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('home_team_id')) {
      context.handle(
          _homeTeamIdMeta,
          homeTeamId.isAcceptableOrUnknown(
              data['home_team_id']!, _homeTeamIdMeta));
    } else if (isInserting) {
      context.missing(_homeTeamIdMeta);
    }
    if (data.containsKey('away_team_id')) {
      context.handle(
          _awayTeamIdMeta,
          awayTeamId.isAcceptableOrUnknown(
              data['away_team_id']!, _awayTeamIdMeta));
    } else if (isInserting) {
      context.missing(_awayTeamIdMeta);
    }
    if (data.containsKey('match_date')) {
      context.handle(_matchDateMeta,
          matchDate.isAcceptableOrUnknown(data['match_date']!, _matchDateMeta));
    } else if (isInserting) {
      context.missing(_matchDateMeta);
    }
    if (data.containsKey('scheduled_start_time')) {
      context.handle(
          _scheduledStartTimeMeta,
          scheduledStartTime.isAcceptableOrUnknown(
              data['scheduled_start_time']!, _scheduledStartTimeMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('home_score')) {
      context.handle(_homeScoreMeta,
          homeScore.isAcceptableOrUnknown(data['home_score']!, _homeScoreMeta));
    }
    if (data.containsKey('away_score')) {
      context.handle(_awayScoreMeta,
          awayScore.isAcceptableOrUnknown(data['away_score']!, _awayScoreMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Matche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Matche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      roundId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round_id'])!,
      homeTeamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}home_team_id'])!,
      awayTeamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}away_team_id'])!,
      matchDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}match_date'])!,
      scheduledStartTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}scheduled_start_time']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      homeScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}home_score'])!,
      awayScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}away_score'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class Matche extends DataClass implements Insertable<Matche> {
  final int id;
  final int leagueId;
  final int roundId;
  final int homeTeamId;
  final int awayTeamId;
  final DateTime matchDate;
  final DateTime? scheduledStartTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final int homeScore;
  final int awayScore;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Matche(
      {required this.id,
      required this.leagueId,
      required this.roundId,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.matchDate,
      this.scheduledStartTime,
      this.startTime,
      this.endTime,
      required this.homeScore,
      required this.awayScore,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['round_id'] = Variable<int>(roundId);
    map['home_team_id'] = Variable<int>(homeTeamId);
    map['away_team_id'] = Variable<int>(awayTeamId);
    map['match_date'] = Variable<DateTime>(matchDate);
    if (!nullToAbsent || scheduledStartTime != null) {
      map['scheduled_start_time'] = Variable<DateTime>(scheduledStartTime);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['home_score'] = Variable<int>(homeScore);
    map['away_score'] = Variable<int>(awayScore);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      roundId: Value(roundId),
      homeTeamId: Value(homeTeamId),
      awayTeamId: Value(awayTeamId),
      matchDate: Value(matchDate),
      scheduledStartTime: scheduledStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledStartTime),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      homeScore: Value(homeScore),
      awayScore: Value(awayScore),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Matche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Matche(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      roundId: serializer.fromJson<int>(json['roundId']),
      homeTeamId: serializer.fromJson<int>(json['homeTeamId']),
      awayTeamId: serializer.fromJson<int>(json['awayTeamId']),
      matchDate: serializer.fromJson<DateTime>(json['matchDate']),
      scheduledStartTime:
          serializer.fromJson<DateTime?>(json['scheduledStartTime']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      homeScore: serializer.fromJson<int>(json['homeScore']),
      awayScore: serializer.fromJson<int>(json['awayScore']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'roundId': serializer.toJson<int>(roundId),
      'homeTeamId': serializer.toJson<int>(homeTeamId),
      'awayTeamId': serializer.toJson<int>(awayTeamId),
      'matchDate': serializer.toJson<DateTime>(matchDate),
      'scheduledStartTime': serializer.toJson<DateTime?>(scheduledStartTime),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'homeScore': serializer.toJson<int>(homeScore),
      'awayScore': serializer.toJson<int>(awayScore),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Matche copyWith(
          {int? id,
          int? leagueId,
          int? roundId,
          int? homeTeamId,
          int? awayTeamId,
          DateTime? matchDate,
          Value<DateTime?> scheduledStartTime = const Value.absent(),
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          int? homeScore,
          int? awayScore,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Matche(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        roundId: roundId ?? this.roundId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        matchDate: matchDate ?? this.matchDate,
        scheduledStartTime: scheduledStartTime.present
            ? scheduledStartTime.value
            : this.scheduledStartTime,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        homeScore: homeScore ?? this.homeScore,
        awayScore: awayScore ?? this.awayScore,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Matche copyWithCompanion(MatchesCompanion data) {
    return Matche(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      homeTeamId:
          data.homeTeamId.present ? data.homeTeamId.value : this.homeTeamId,
      awayTeamId:
          data.awayTeamId.present ? data.awayTeamId.value : this.awayTeamId,
      matchDate: data.matchDate.present ? data.matchDate.value : this.matchDate,
      scheduledStartTime: data.scheduledStartTime.present
          ? data.scheduledStartTime.value
          : this.scheduledStartTime,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      homeScore: data.homeScore.present ? data.homeScore.value : this.homeScore,
      awayScore: data.awayScore.present ? data.awayScore.value : this.awayScore,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Matche(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('roundId: $roundId, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('matchDate: $matchDate, ')
          ..write('scheduledStartTime: $scheduledStartTime, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('homeScore: $homeScore, ')
          ..write('awayScore: $awayScore, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      leagueId,
      roundId,
      homeTeamId,
      awayTeamId,
      matchDate,
      scheduledStartTime,
      startTime,
      endTime,
      homeScore,
      awayScore,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Matche &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.roundId == this.roundId &&
          other.homeTeamId == this.homeTeamId &&
          other.awayTeamId == this.awayTeamId &&
          other.matchDate == this.matchDate &&
          other.scheduledStartTime == this.scheduledStartTime &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.homeScore == this.homeScore &&
          other.awayScore == this.awayScore &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MatchesCompanion extends UpdateCompanion<Matche> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<int> roundId;
  final Value<int> homeTeamId;
  final Value<int> awayTeamId;
  final Value<DateTime> matchDate;
  final Value<DateTime?> scheduledStartTime;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int> homeScore;
  final Value<int> awayScore;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.roundId = const Value.absent(),
    this.homeTeamId = const Value.absent(),
    this.awayTeamId = const Value.absent(),
    this.matchDate = const Value.absent(),
    this.scheduledStartTime = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.homeScore = const Value.absent(),
    this.awayScore = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required int roundId,
    required int homeTeamId,
    required int awayTeamId,
    required DateTime matchDate,
    this.scheduledStartTime = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.homeScore = const Value.absent(),
    this.awayScore = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        roundId = Value(roundId),
        homeTeamId = Value(homeTeamId),
        awayTeamId = Value(awayTeamId),
        matchDate = Value(matchDate);
  static Insertable<Matche> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<int>? roundId,
    Expression<int>? homeTeamId,
    Expression<int>? awayTeamId,
    Expression<DateTime>? matchDate,
    Expression<DateTime>? scheduledStartTime,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? homeScore,
    Expression<int>? awayScore,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (roundId != null) 'round_id': roundId,
      if (homeTeamId != null) 'home_team_id': homeTeamId,
      if (awayTeamId != null) 'away_team_id': awayTeamId,
      if (matchDate != null) 'match_date': matchDate,
      if (scheduledStartTime != null)
        'scheduled_start_time': scheduledStartTime,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (homeScore != null) 'home_score': homeScore,
      if (awayScore != null) 'away_score': awayScore,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MatchesCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<int>? roundId,
      Value<int>? homeTeamId,
      Value<int>? awayTeamId,
      Value<DateTime>? matchDate,
      Value<DateTime?>? scheduledStartTime,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<int>? homeScore,
      Value<int>? awayScore,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return MatchesCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      roundId: roundId ?? this.roundId,
      homeTeamId: homeTeamId ?? this.homeTeamId,
      awayTeamId: awayTeamId ?? this.awayTeamId,
      matchDate: matchDate ?? this.matchDate,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (roundId.present) {
      map['round_id'] = Variable<int>(roundId.value);
    }
    if (homeTeamId.present) {
      map['home_team_id'] = Variable<int>(homeTeamId.value);
    }
    if (awayTeamId.present) {
      map['away_team_id'] = Variable<int>(awayTeamId.value);
    }
    if (matchDate.present) {
      map['match_date'] = Variable<DateTime>(matchDate.value);
    }
    if (scheduledStartTime.present) {
      map['scheduled_start_time'] =
          Variable<DateTime>(scheduledStartTime.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (homeScore.present) {
      map['home_score'] = Variable<int>(homeScore.value);
    }
    if (awayScore.present) {
      map['away_score'] = Variable<int>(awayScore.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('roundId: $roundId, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('matchDate: $matchDate, ')
          ..write('scheduledStartTime: $scheduledStartTime, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('homeScore: $homeScore, ')
          ..write('awayScore: $awayScore, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $QualifiedTeamTable extends QualifiedTeam
    with TableInfo<$QualifiedTeamTable, QualifiedTeamData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QualifiedTeamTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES leagues (id) ON DELETE CASCADE'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES "group" (id) ON DELETE CASCADE'));
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES teams (id) ON DELETE CASCADE'));
  static const VerificationMeta _playedMeta = const VerificationMeta('played');
  @override
  late final GeneratedColumn<int> played = GeneratedColumn<int>(
      'played', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _winsMeta = const VerificationMeta('wins');
  @override
  late final GeneratedColumn<int> wins = GeneratedColumn<int>(
      'wins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _drawsMeta = const VerificationMeta('draws');
  @override
  late final GeneratedColumn<int> draws = GeneratedColumn<int>(
      'draws', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lossesMeta = const VerificationMeta('losses');
  @override
  late final GeneratedColumn<int> losses = GeneratedColumn<int>(
      'losses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _goalsForMeta =
      const VerificationMeta('goalsFor');
  @override
  late final GeneratedColumn<int> goalsFor = GeneratedColumn<int>(
      'goals_for', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _goalsAgainstMeta =
      const VerificationMeta('goalsAgainst');
  @override
  late final GeneratedColumn<int> goalsAgainst = GeneratedColumn<int>(
      'goals_against', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _qualificationTypeMeta =
      const VerificationMeta('qualificationType');
  @override
  late final GeneratedColumn<String> qualificationType =
      GeneratedColumn<String>('qualification_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        leagueId,
        groupId,
        teamId,
        played,
        wins,
        draws,
        losses,
        goalsFor,
        goalsAgainst,
        points,
        qualificationType,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qualified_team';
  @override
  VerificationContext validateIntegrity(Insertable<QualifiedTeamData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('played')) {
      context.handle(_playedMeta,
          played.isAcceptableOrUnknown(data['played']!, _playedMeta));
    }
    if (data.containsKey('wins')) {
      context.handle(
          _winsMeta, wins.isAcceptableOrUnknown(data['wins']!, _winsMeta));
    }
    if (data.containsKey('draws')) {
      context.handle(
          _drawsMeta, draws.isAcceptableOrUnknown(data['draws']!, _drawsMeta));
    }
    if (data.containsKey('losses')) {
      context.handle(_lossesMeta,
          losses.isAcceptableOrUnknown(data['losses']!, _lossesMeta));
    }
    if (data.containsKey('goals_for')) {
      context.handle(_goalsForMeta,
          goalsFor.isAcceptableOrUnknown(data['goals_for']!, _goalsForMeta));
    }
    if (data.containsKey('goals_against')) {
      context.handle(
          _goalsAgainstMeta,
          goalsAgainst.isAcceptableOrUnknown(
              data['goals_against']!, _goalsAgainstMeta));
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    }
    if (data.containsKey('qualification_type')) {
      context.handle(
          _qualificationTypeMeta,
          qualificationType.isAcceptableOrUnknown(
              data['qualification_type']!, _qualificationTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QualifiedTeamData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QualifiedTeamData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      played: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}played'])!,
      wins: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wins'])!,
      draws: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}draws'])!,
      losses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}losses'])!,
      goalsFor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goals_for'])!,
      goalsAgainst: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goals_against'])!,
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      qualificationType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}qualification_type']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $QualifiedTeamTable createAlias(String alias) {
    return $QualifiedTeamTable(attachedDatabase, alias);
  }
}

class QualifiedTeamData extends DataClass
    implements Insertable<QualifiedTeamData> {
  final int id;
  final int leagueId;
  final int groupId;
  final int teamId;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String? qualificationType;
  final DateTime createdAt;
  final DateTime updatedAt;
  const QualifiedTeamData(
      {required this.id,
      required this.leagueId,
      required this.groupId,
      required this.teamId,
      required this.played,
      required this.wins,
      required this.draws,
      required this.losses,
      required this.goalsFor,
      required this.goalsAgainst,
      required this.points,
      this.qualificationType,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['group_id'] = Variable<int>(groupId);
    map['team_id'] = Variable<int>(teamId);
    map['played'] = Variable<int>(played);
    map['wins'] = Variable<int>(wins);
    map['draws'] = Variable<int>(draws);
    map['losses'] = Variable<int>(losses);
    map['goals_for'] = Variable<int>(goalsFor);
    map['goals_against'] = Variable<int>(goalsAgainst);
    map['points'] = Variable<int>(points);
    if (!nullToAbsent || qualificationType != null) {
      map['qualification_type'] = Variable<String>(qualificationType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  QualifiedTeamCompanion toCompanion(bool nullToAbsent) {
    return QualifiedTeamCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      groupId: Value(groupId),
      teamId: Value(teamId),
      played: Value(played),
      wins: Value(wins),
      draws: Value(draws),
      losses: Value(losses),
      goalsFor: Value(goalsFor),
      goalsAgainst: Value(goalsAgainst),
      points: Value(points),
      qualificationType: qualificationType == null && nullToAbsent
          ? const Value.absent()
          : Value(qualificationType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory QualifiedTeamData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QualifiedTeamData(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      groupId: serializer.fromJson<int>(json['groupId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      played: serializer.fromJson<int>(json['played']),
      wins: serializer.fromJson<int>(json['wins']),
      draws: serializer.fromJson<int>(json['draws']),
      losses: serializer.fromJson<int>(json['losses']),
      goalsFor: serializer.fromJson<int>(json['goalsFor']),
      goalsAgainst: serializer.fromJson<int>(json['goalsAgainst']),
      points: serializer.fromJson<int>(json['points']),
      qualificationType:
          serializer.fromJson<String?>(json['qualificationType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'groupId': serializer.toJson<int>(groupId),
      'teamId': serializer.toJson<int>(teamId),
      'played': serializer.toJson<int>(played),
      'wins': serializer.toJson<int>(wins),
      'draws': serializer.toJson<int>(draws),
      'losses': serializer.toJson<int>(losses),
      'goalsFor': serializer.toJson<int>(goalsFor),
      'goalsAgainst': serializer.toJson<int>(goalsAgainst),
      'points': serializer.toJson<int>(points),
      'qualificationType': serializer.toJson<String?>(qualificationType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  QualifiedTeamData copyWith(
          {int? id,
          int? leagueId,
          int? groupId,
          int? teamId,
          int? played,
          int? wins,
          int? draws,
          int? losses,
          int? goalsFor,
          int? goalsAgainst,
          int? points,
          Value<String?> qualificationType = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      QualifiedTeamData(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        groupId: groupId ?? this.groupId,
        teamId: teamId ?? this.teamId,
        played: played ?? this.played,
        wins: wins ?? this.wins,
        draws: draws ?? this.draws,
        losses: losses ?? this.losses,
        goalsFor: goalsFor ?? this.goalsFor,
        goalsAgainst: goalsAgainst ?? this.goalsAgainst,
        points: points ?? this.points,
        qualificationType: qualificationType.present
            ? qualificationType.value
            : this.qualificationType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  QualifiedTeamData copyWithCompanion(QualifiedTeamCompanion data) {
    return QualifiedTeamData(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      played: data.played.present ? data.played.value : this.played,
      wins: data.wins.present ? data.wins.value : this.wins,
      draws: data.draws.present ? data.draws.value : this.draws,
      losses: data.losses.present ? data.losses.value : this.losses,
      goalsFor: data.goalsFor.present ? data.goalsFor.value : this.goalsFor,
      goalsAgainst: data.goalsAgainst.present
          ? data.goalsAgainst.value
          : this.goalsAgainst,
      points: data.points.present ? data.points.value : this.points,
      qualificationType: data.qualificationType.present
          ? data.qualificationType.value
          : this.qualificationType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QualifiedTeamData(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('groupId: $groupId, ')
          ..write('teamId: $teamId, ')
          ..write('played: $played, ')
          ..write('wins: $wins, ')
          ..write('draws: $draws, ')
          ..write('losses: $losses, ')
          ..write('goalsFor: $goalsFor, ')
          ..write('goalsAgainst: $goalsAgainst, ')
          ..write('points: $points, ')
          ..write('qualificationType: $qualificationType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      leagueId,
      groupId,
      teamId,
      played,
      wins,
      draws,
      losses,
      goalsFor,
      goalsAgainst,
      points,
      qualificationType,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QualifiedTeamData &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.groupId == this.groupId &&
          other.teamId == this.teamId &&
          other.played == this.played &&
          other.wins == this.wins &&
          other.draws == this.draws &&
          other.losses == this.losses &&
          other.goalsFor == this.goalsFor &&
          other.goalsAgainst == this.goalsAgainst &&
          other.points == this.points &&
          other.qualificationType == this.qualificationType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QualifiedTeamCompanion extends UpdateCompanion<QualifiedTeamData> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<int> groupId;
  final Value<int> teamId;
  final Value<int> played;
  final Value<int> wins;
  final Value<int> draws;
  final Value<int> losses;
  final Value<int> goalsFor;
  final Value<int> goalsAgainst;
  final Value<int> points;
  final Value<String?> qualificationType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const QualifiedTeamCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.played = const Value.absent(),
    this.wins = const Value.absent(),
    this.draws = const Value.absent(),
    this.losses = const Value.absent(),
    this.goalsFor = const Value.absent(),
    this.goalsAgainst = const Value.absent(),
    this.points = const Value.absent(),
    this.qualificationType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  QualifiedTeamCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required int groupId,
    required int teamId,
    this.played = const Value.absent(),
    this.wins = const Value.absent(),
    this.draws = const Value.absent(),
    this.losses = const Value.absent(),
    this.goalsFor = const Value.absent(),
    this.goalsAgainst = const Value.absent(),
    this.points = const Value.absent(),
    this.qualificationType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        groupId = Value(groupId),
        teamId = Value(teamId);
  static Insertable<QualifiedTeamData> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<int>? groupId,
    Expression<int>? teamId,
    Expression<int>? played,
    Expression<int>? wins,
    Expression<int>? draws,
    Expression<int>? losses,
    Expression<int>? goalsFor,
    Expression<int>? goalsAgainst,
    Expression<int>? points,
    Expression<String>? qualificationType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (groupId != null) 'group_id': groupId,
      if (teamId != null) 'team_id': teamId,
      if (played != null) 'played': played,
      if (wins != null) 'wins': wins,
      if (draws != null) 'draws': draws,
      if (losses != null) 'losses': losses,
      if (goalsFor != null) 'goals_for': goalsFor,
      if (goalsAgainst != null) 'goals_against': goalsAgainst,
      if (points != null) 'points': points,
      if (qualificationType != null) 'qualification_type': qualificationType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  QualifiedTeamCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<int>? groupId,
      Value<int>? teamId,
      Value<int>? played,
      Value<int>? wins,
      Value<int>? draws,
      Value<int>? losses,
      Value<int>? goalsFor,
      Value<int>? goalsAgainst,
      Value<int>? points,
      Value<String?>? qualificationType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return QualifiedTeamCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      groupId: groupId ?? this.groupId,
      teamId: teamId ?? this.teamId,
      played: played ?? this.played,
      wins: wins ?? this.wins,
      draws: draws ?? this.draws,
      losses: losses ?? this.losses,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      points: points ?? this.points,
      qualificationType: qualificationType ?? this.qualificationType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (played.present) {
      map['played'] = Variable<int>(played.value);
    }
    if (wins.present) {
      map['wins'] = Variable<int>(wins.value);
    }
    if (draws.present) {
      map['draws'] = Variable<int>(draws.value);
    }
    if (losses.present) {
      map['losses'] = Variable<int>(losses.value);
    }
    if (goalsFor.present) {
      map['goals_for'] = Variable<int>(goalsFor.value);
    }
    if (goalsAgainst.present) {
      map['goals_against'] = Variable<int>(goalsAgainst.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (qualificationType.present) {
      map['qualification_type'] = Variable<String>(qualificationType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QualifiedTeamCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('groupId: $groupId, ')
          ..write('teamId: $teamId, ')
          ..write('played: $played, ')
          ..write('wins: $wins, ')
          ..write('draws: $draws, ')
          ..write('losses: $losses, ')
          ..write('goalsFor: $goalsFor, ')
          ..write('goalsAgainst: $goalsAgainst, ')
          ..write('points: $points, ')
          ..write('qualificationType: $qualificationType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LeagueStatusTable extends LeagueStatus
    with TableInfo<$LeagueStatusTable, LeagueStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeagueStatusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES leagues (id)'));
  static const VerificationMeta _hasGroupsMeta =
      const VerificationMeta('hasGroups');
  @override
  late final GeneratedColumn<bool> hasGroups = GeneratedColumn<bool>(
      'has_groups', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_groups" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasTeamsInGroupsMeta =
      const VerificationMeta('hasTeamsInGroups');
  @override
  late final GeneratedColumn<bool> hasTeamsInGroups = GeneratedColumn<bool>(
      'has_teams_in_groups', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_teams_in_groups" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasMatchesMeta =
      const VerificationMeta('hasMatches');
  @override
  late final GeneratedColumn<bool> hasMatches = GeneratedColumn<bool>(
      'has_matches', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_matches" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasPlayersAssignedMeta =
      const VerificationMeta('hasPlayersAssigned');
  @override
  late final GeneratedColumn<bool> hasPlayersAssigned = GeneratedColumn<bool>(
      'has_players_assigned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_players_assigned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        leagueId,
        hasGroups,
        hasTeamsInGroups,
        hasMatches,
        hasPlayersAssigned,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_status';
  @override
  VerificationContext validateIntegrity(Insertable<LeagueStatusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    }
    if (data.containsKey('has_groups')) {
      context.handle(_hasGroupsMeta,
          hasGroups.isAcceptableOrUnknown(data['has_groups']!, _hasGroupsMeta));
    }
    if (data.containsKey('has_teams_in_groups')) {
      context.handle(
          _hasTeamsInGroupsMeta,
          hasTeamsInGroups.isAcceptableOrUnknown(
              data['has_teams_in_groups']!, _hasTeamsInGroupsMeta));
    }
    if (data.containsKey('has_matches')) {
      context.handle(
          _hasMatchesMeta,
          hasMatches.isAcceptableOrUnknown(
              data['has_matches']!, _hasMatchesMeta));
    }
    if (data.containsKey('has_players_assigned')) {
      context.handle(
          _hasPlayersAssignedMeta,
          hasPlayersAssigned.isAcceptableOrUnknown(
              data['has_players_assigned']!, _hasPlayersAssignedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {leagueId};
  @override
  LeagueStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeagueStatusData(
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      hasGroups: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_groups'])!,
      hasTeamsInGroups: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_teams_in_groups'])!,
      hasMatches: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_matches'])!,
      hasPlayersAssigned: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_players_assigned'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $LeagueStatusTable createAlias(String alias) {
    return $LeagueStatusTable(attachedDatabase, alias);
  }
}

class LeagueStatusData extends DataClass
    implements Insertable<LeagueStatusData> {
  final int leagueId;
  final bool hasGroups;
  final bool hasTeamsInGroups;
  final bool hasMatches;
  final bool hasPlayersAssigned;
  final DateTime? updatedAt;
  const LeagueStatusData(
      {required this.leagueId,
      required this.hasGroups,
      required this.hasTeamsInGroups,
      required this.hasMatches,
      required this.hasPlayersAssigned,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['league_id'] = Variable<int>(leagueId);
    map['has_groups'] = Variable<bool>(hasGroups);
    map['has_teams_in_groups'] = Variable<bool>(hasTeamsInGroups);
    map['has_matches'] = Variable<bool>(hasMatches);
    map['has_players_assigned'] = Variable<bool>(hasPlayersAssigned);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LeagueStatusCompanion toCompanion(bool nullToAbsent) {
    return LeagueStatusCompanion(
      leagueId: Value(leagueId),
      hasGroups: Value(hasGroups),
      hasTeamsInGroups: Value(hasTeamsInGroups),
      hasMatches: Value(hasMatches),
      hasPlayersAssigned: Value(hasPlayersAssigned),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LeagueStatusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeagueStatusData(
      leagueId: serializer.fromJson<int>(json['leagueId']),
      hasGroups: serializer.fromJson<bool>(json['hasGroups']),
      hasTeamsInGroups: serializer.fromJson<bool>(json['hasTeamsInGroups']),
      hasMatches: serializer.fromJson<bool>(json['hasMatches']),
      hasPlayersAssigned: serializer.fromJson<bool>(json['hasPlayersAssigned']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'leagueId': serializer.toJson<int>(leagueId),
      'hasGroups': serializer.toJson<bool>(hasGroups),
      'hasTeamsInGroups': serializer.toJson<bool>(hasTeamsInGroups),
      'hasMatches': serializer.toJson<bool>(hasMatches),
      'hasPlayersAssigned': serializer.toJson<bool>(hasPlayersAssigned),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LeagueStatusData copyWith(
          {int? leagueId,
          bool? hasGroups,
          bool? hasTeamsInGroups,
          bool? hasMatches,
          bool? hasPlayersAssigned,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      LeagueStatusData(
        leagueId: leagueId ?? this.leagueId,
        hasGroups: hasGroups ?? this.hasGroups,
        hasTeamsInGroups: hasTeamsInGroups ?? this.hasTeamsInGroups,
        hasMatches: hasMatches ?? this.hasMatches,
        hasPlayersAssigned: hasPlayersAssigned ?? this.hasPlayersAssigned,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  LeagueStatusData copyWithCompanion(LeagueStatusCompanion data) {
    return LeagueStatusData(
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      hasGroups: data.hasGroups.present ? data.hasGroups.value : this.hasGroups,
      hasTeamsInGroups: data.hasTeamsInGroups.present
          ? data.hasTeamsInGroups.value
          : this.hasTeamsInGroups,
      hasMatches:
          data.hasMatches.present ? data.hasMatches.value : this.hasMatches,
      hasPlayersAssigned: data.hasPlayersAssigned.present
          ? data.hasPlayersAssigned.value
          : this.hasPlayersAssigned,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeagueStatusData(')
          ..write('leagueId: $leagueId, ')
          ..write('hasGroups: $hasGroups, ')
          ..write('hasTeamsInGroups: $hasTeamsInGroups, ')
          ..write('hasMatches: $hasMatches, ')
          ..write('hasPlayersAssigned: $hasPlayersAssigned, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(leagueId, hasGroups, hasTeamsInGroups,
      hasMatches, hasPlayersAssigned, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueStatusData &&
          other.leagueId == this.leagueId &&
          other.hasGroups == this.hasGroups &&
          other.hasTeamsInGroups == this.hasTeamsInGroups &&
          other.hasMatches == this.hasMatches &&
          other.hasPlayersAssigned == this.hasPlayersAssigned &&
          other.updatedAt == this.updatedAt);
}

class LeagueStatusCompanion extends UpdateCompanion<LeagueStatusData> {
  final Value<int> leagueId;
  final Value<bool> hasGroups;
  final Value<bool> hasTeamsInGroups;
  final Value<bool> hasMatches;
  final Value<bool> hasPlayersAssigned;
  final Value<DateTime?> updatedAt;
  const LeagueStatusCompanion({
    this.leagueId = const Value.absent(),
    this.hasGroups = const Value.absent(),
    this.hasTeamsInGroups = const Value.absent(),
    this.hasMatches = const Value.absent(),
    this.hasPlayersAssigned = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeagueStatusCompanion.insert({
    this.leagueId = const Value.absent(),
    this.hasGroups = const Value.absent(),
    this.hasTeamsInGroups = const Value.absent(),
    this.hasMatches = const Value.absent(),
    this.hasPlayersAssigned = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<LeagueStatusData> custom({
    Expression<int>? leagueId,
    Expression<bool>? hasGroups,
    Expression<bool>? hasTeamsInGroups,
    Expression<bool>? hasMatches,
    Expression<bool>? hasPlayersAssigned,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (leagueId != null) 'league_id': leagueId,
      if (hasGroups != null) 'has_groups': hasGroups,
      if (hasTeamsInGroups != null) 'has_teams_in_groups': hasTeamsInGroups,
      if (hasMatches != null) 'has_matches': hasMatches,
      if (hasPlayersAssigned != null)
        'has_players_assigned': hasPlayersAssigned,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeagueStatusCompanion copyWith(
      {Value<int>? leagueId,
      Value<bool>? hasGroups,
      Value<bool>? hasTeamsInGroups,
      Value<bool>? hasMatches,
      Value<bool>? hasPlayersAssigned,
      Value<DateTime?>? updatedAt}) {
    return LeagueStatusCompanion(
      leagueId: leagueId ?? this.leagueId,
      hasGroups: hasGroups ?? this.hasGroups,
      hasTeamsInGroups: hasTeamsInGroups ?? this.hasTeamsInGroups,
      hasMatches: hasMatches ?? this.hasMatches,
      hasPlayersAssigned: hasPlayersAssigned ?? this.hasPlayersAssigned,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (hasGroups.present) {
      map['has_groups'] = Variable<bool>(hasGroups.value);
    }
    if (hasTeamsInGroups.present) {
      map['has_teams_in_groups'] = Variable<bool>(hasTeamsInGroups.value);
    }
    if (hasMatches.present) {
      map['has_matches'] = Variable<bool>(hasMatches.value);
    }
    if (hasPlayersAssigned.present) {
      map['has_players_assigned'] = Variable<bool>(hasPlayersAssigned.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeagueStatusCompanion(')
          ..write('leagueId: $leagueId, ')
          ..write('hasGroups: $hasGroups, ')
          ..write('hasTeamsInGroups: $hasTeamsInGroups, ')
          ..write('hasMatches: $hasMatches, ')
          ..write('hasPlayersAssigned: $hasPlayersAssigned, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TermsTable extends Terms with TableInfo<$TermsTable, Term> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, type, order, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terms';
  @override
  VerificationContext validateIntegrity(Insertable<Term> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Term map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Term(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TermsTable createAlias(String alias) {
    return $TermsTable(attachedDatabase, alias);
  }
}

class Term extends DataClass implements Insertable<Term> {
  final int id;
  final String name;

  /// نوع الشوط: عادي regular، إضافي extra، ركلات ترجيح penalty
  final String type;

  /// الترتيب (الشوط الأول = 1، الثاني = 2 ...)
  final int order;

  /// التاريخ في حال احتجنا تحديث الأشواط مستقبلًا
  final DateTime createdAt;
  const Term(
      {required this.id,
      required this.name,
      required this.type,
      required this.order,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['order'] = Variable<int>(order);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TermsCompanion toCompanion(bool nullToAbsent) {
    return TermsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      order: Value(order),
      createdAt: Value(createdAt),
    );
  }

  factory Term.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Term(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      order: serializer.fromJson<int>(json['order']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'order': serializer.toJson<int>(order),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Term copyWith(
          {int? id,
          String? name,
          String? type,
          int? order,
          DateTime? createdAt}) =>
      Term(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
      );
  Term copyWithCompanion(TermsCompanion data) {
    return Term(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      order: data.order.present ? data.order.value : this.order,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Term(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, order, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Term &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.order == this.order &&
          other.createdAt == this.createdAt);
}

class TermsCompanion extends UpdateCompanion<Term> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> order;
  final Value<DateTime> createdAt;
  const TermsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TermsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required int order,
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        type = Value(type),
        order = Value(order);
  static Insertable<Term> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? order,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TermsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<int>? order,
      Value<DateTime>? createdAt}) {
    return TermsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LeagueTermsTable extends LeagueTerms
    with TableInfo<$LeagueTermsTable, LeagueTerm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeagueTermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leagueIdMeta =
      const VerificationMeta('leagueId');
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
      'league_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES leagues (id)'));
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES terms (id)'));
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(45));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, leagueId, termId, durationMinutes, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_terms';
  @override
  VerificationContext validateIntegrity(Insertable<LeagueTerm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('league_id')) {
      context.handle(_leagueIdMeta,
          leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta));
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('term_id')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['term_id']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeagueTerm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeagueTerm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leagueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_id'])!,
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}term_id'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LeagueTermsTable createAlias(String alias) {
    return $LeagueTermsTable(attachedDatabase, alias);
  }
}

class LeagueTerm extends DataClass implements Insertable<LeagueTerm> {
  final int id;
  final int leagueId;
  final int termId;
  final int durationMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LeagueTerm(
      {required this.id,
      required this.leagueId,
      required this.termId,
      required this.durationMinutes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_id'] = Variable<int>(leagueId);
    map['term_id'] = Variable<int>(termId);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LeagueTermsCompanion toCompanion(bool nullToAbsent) {
    return LeagueTermsCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      termId: Value(termId),
      durationMinutes: Value(durationMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LeagueTerm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeagueTerm(
      id: serializer.fromJson<int>(json['id']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      termId: serializer.fromJson<int>(json['termId']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueId': serializer.toJson<int>(leagueId),
      'termId': serializer.toJson<int>(termId),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LeagueTerm copyWith(
          {int? id,
          int? leagueId,
          int? termId,
          int? durationMinutes,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LeagueTerm(
        id: id ?? this.id,
        leagueId: leagueId ?? this.leagueId,
        termId: termId ?? this.termId,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LeagueTerm copyWithCompanion(LeagueTermsCompanion data) {
    return LeagueTerm(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      termId: data.termId.present ? data.termId.value : this.termId,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeagueTerm(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('termId: $termId, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, leagueId, termId, durationMinutes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueTerm &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.termId == this.termId &&
          other.durationMinutes == this.durationMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LeagueTermsCompanion extends UpdateCompanion<LeagueTerm> {
  final Value<int> id;
  final Value<int> leagueId;
  final Value<int> termId;
  final Value<int> durationMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LeagueTermsCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.termId = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeagueTermsCompanion.insert({
    this.id = const Value.absent(),
    required int leagueId,
    required int termId,
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueId = Value(leagueId),
        termId = Value(termId);
  static Insertable<LeagueTerm> custom({
    Expression<int>? id,
    Expression<int>? leagueId,
    Expression<int>? termId,
    Expression<int>? durationMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (termId != null) 'term_id': termId,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeagueTermsCompanion copyWith(
      {Value<int>? id,
      Value<int>? leagueId,
      Value<int>? termId,
      Value<int>? durationMinutes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LeagueTermsCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      termId: termId ?? this.termId,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (termId.present) {
      map['term_id'] = Variable<int>(termId.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeagueTermsCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('termId: $termId, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MatchTermsTable extends MatchTerms
    with TableInfo<$MatchTermsTable, MatchTerm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchTermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES matches (id)'));
  static const VerificationMeta _leagueTermIdMeta =
      const VerificationMeta('leagueTermId');
  @override
  late final GeneratedColumn<int> leagueTermId = GeneratedColumn<int>(
      'league_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES league_terms (id)'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _additionalMinutesMeta =
      const VerificationMeta('additionalMinutes');
  @override
  late final GeneratedColumn<int> additionalMinutes = GeneratedColumn<int>(
      'additional_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_finished" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        matchId,
        leagueTermId,
        startTime,
        endTime,
        additionalMinutes,
        isFinished,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_terms';
  @override
  VerificationContext validateIntegrity(Insertable<MatchTerm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('league_term_id')) {
      context.handle(
          _leagueTermIdMeta,
          leagueTermId.isAcceptableOrUnknown(
              data['league_term_id']!, _leagueTermIdMeta));
    } else if (isInserting) {
      context.missing(_leagueTermIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('additional_minutes')) {
      context.handle(
          _additionalMinutesMeta,
          additionalMinutes.isAcceptableOrUnknown(
              data['additional_minutes']!, _additionalMinutesMeta));
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchTerm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchTerm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
      leagueTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}league_term_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      additionalMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}additional_minutes'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MatchTermsTable createAlias(String alias) {
    return $MatchTermsTable(attachedDatabase, alias);
  }
}

class MatchTerm extends DataClass implements Insertable<MatchTerm> {
  final int id;
  final int matchId;
  final int leagueTermId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int additionalMinutes;
  final bool isFinished;
  final DateTime createdAt;
  const MatchTerm(
      {required this.id,
      required this.matchId,
      required this.leagueTermId,
      this.startTime,
      this.endTime,
      required this.additionalMinutes,
      required this.isFinished,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['league_term_id'] = Variable<int>(leagueTermId);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['additional_minutes'] = Variable<int>(additionalMinutes);
    map['is_finished'] = Variable<bool>(isFinished);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MatchTermsCompanion toCompanion(bool nullToAbsent) {
    return MatchTermsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      leagueTermId: Value(leagueTermId),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      additionalMinutes: Value(additionalMinutes),
      isFinished: Value(isFinished),
      createdAt: Value(createdAt),
    );
  }

  factory MatchTerm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchTerm(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      leagueTermId: serializer.fromJson<int>(json['leagueTermId']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      additionalMinutes: serializer.fromJson<int>(json['additionalMinutes']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'leagueTermId': serializer.toJson<int>(leagueTermId),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'additionalMinutes': serializer.toJson<int>(additionalMinutes),
      'isFinished': serializer.toJson<bool>(isFinished),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MatchTerm copyWith(
          {int? id,
          int? matchId,
          int? leagueTermId,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          int? additionalMinutes,
          bool? isFinished,
          DateTime? createdAt}) =>
      MatchTerm(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        leagueTermId: leagueTermId ?? this.leagueTermId,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        additionalMinutes: additionalMinutes ?? this.additionalMinutes,
        isFinished: isFinished ?? this.isFinished,
        createdAt: createdAt ?? this.createdAt,
      );
  MatchTerm copyWithCompanion(MatchTermsCompanion data) {
    return MatchTerm(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      leagueTermId: data.leagueTermId.present
          ? data.leagueTermId.value
          : this.leagueTermId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      additionalMinutes: data.additionalMinutes.present
          ? data.additionalMinutes.value
          : this.additionalMinutes,
      isFinished:
          data.isFinished.present ? data.isFinished.value : this.isFinished,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchTerm(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('leagueTermId: $leagueTermId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('additionalMinutes: $additionalMinutes, ')
          ..write('isFinished: $isFinished, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, leagueTermId, startTime, endTime,
      additionalMinutes, isFinished, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchTerm &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.leagueTermId == this.leagueTermId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.additionalMinutes == this.additionalMinutes &&
          other.isFinished == this.isFinished &&
          other.createdAt == this.createdAt);
}

class MatchTermsCompanion extends UpdateCompanion<MatchTerm> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> leagueTermId;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int> additionalMinutes;
  final Value<bool> isFinished;
  final Value<DateTime> createdAt;
  const MatchTermsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.leagueTermId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.additionalMinutes = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MatchTermsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int leagueTermId,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.additionalMinutes = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : matchId = Value(matchId),
        leagueTermId = Value(leagueTermId);
  static Insertable<MatchTerm> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? leagueTermId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? additionalMinutes,
    Expression<bool>? isFinished,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (leagueTermId != null) 'league_term_id': leagueTermId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (additionalMinutes != null) 'additional_minutes': additionalMinutes,
      if (isFinished != null) 'is_finished': isFinished,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MatchTermsCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchId,
      Value<int>? leagueTermId,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<int>? additionalMinutes,
      Value<bool>? isFinished,
      Value<DateTime>? createdAt}) {
    return MatchTermsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      leagueTermId: leagueTermId ?? this.leagueTermId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      additionalMinutes: additionalMinutes ?? this.additionalMinutes,
      isFinished: isFinished ?? this.isFinished,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (leagueTermId.present) {
      map['league_term_id'] = Variable<int>(leagueTermId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (additionalMinutes.present) {
      map['additional_minutes'] = Variable<int>(additionalMinutes.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchTermsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('leagueTermId: $leagueTermId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('additionalMinutes: $additionalMinutes, ')
          ..write('isFinished: $isFinished, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MatchTermPauseTable extends MatchTermPause
    with TableInfo<$MatchTermPauseTable, MatchTermPauseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchTermPauseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchTermIdMeta =
      const VerificationMeta('matchTermId');
  @override
  late final GeneratedColumn<int> matchTermId = GeneratedColumn<int>(
      'match_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES match_terms (id) ON DELETE CASCADE'));
  static const VerificationMeta _startPauseMeta =
      const VerificationMeta('startPause');
  @override
  late final GeneratedColumn<DateTime> startPause = GeneratedColumn<DateTime>(
      'start_pause', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endPauseMeta =
      const VerificationMeta('endPause');
  @override
  late final GeneratedColumn<DateTime> endPause = GeneratedColumn<DateTime>(
      'end_pause', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, matchTermId, startPause, endPause];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_term_pause';
  @override
  VerificationContext validateIntegrity(Insertable<MatchTermPauseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_term_id')) {
      context.handle(
          _matchTermIdMeta,
          matchTermId.isAcceptableOrUnknown(
              data['match_term_id']!, _matchTermIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermIdMeta);
    }
    if (data.containsKey('start_pause')) {
      context.handle(
          _startPauseMeta,
          startPause.isAcceptableOrUnknown(
              data['start_pause']!, _startPauseMeta));
    } else if (isInserting) {
      context.missing(_startPauseMeta);
    }
    if (data.containsKey('end_pause')) {
      context.handle(_endPauseMeta,
          endPause.isAcceptableOrUnknown(data['end_pause']!, _endPauseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchTermPauseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchTermPauseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_term_id'])!,
      startPause: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_pause'])!,
      endPause: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_pause']),
    );
  }

  @override
  $MatchTermPauseTable createAlias(String alias) {
    return $MatchTermPauseTable(attachedDatabase, alias);
  }
}

class MatchTermPauseData extends DataClass
    implements Insertable<MatchTermPauseData> {
  final int id;
  final int matchTermId;
  final DateTime startPause;
  final DateTime? endPause;
  const MatchTermPauseData(
      {required this.id,
      required this.matchTermId,
      required this.startPause,
      this.endPause});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_term_id'] = Variable<int>(matchTermId);
    map['start_pause'] = Variable<DateTime>(startPause);
    if (!nullToAbsent || endPause != null) {
      map['end_pause'] = Variable<DateTime>(endPause);
    }
    return map;
  }

  MatchTermPauseCompanion toCompanion(bool nullToAbsent) {
    return MatchTermPauseCompanion(
      id: Value(id),
      matchTermId: Value(matchTermId),
      startPause: Value(startPause),
      endPause: endPause == null && nullToAbsent
          ? const Value.absent()
          : Value(endPause),
    );
  }

  factory MatchTermPauseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchTermPauseData(
      id: serializer.fromJson<int>(json['id']),
      matchTermId: serializer.fromJson<int>(json['matchTermId']),
      startPause: serializer.fromJson<DateTime>(json['startPause']),
      endPause: serializer.fromJson<DateTime?>(json['endPause']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchTermId': serializer.toJson<int>(matchTermId),
      'startPause': serializer.toJson<DateTime>(startPause),
      'endPause': serializer.toJson<DateTime?>(endPause),
    };
  }

  MatchTermPauseData copyWith(
          {int? id,
          int? matchTermId,
          DateTime? startPause,
          Value<DateTime?> endPause = const Value.absent()}) =>
      MatchTermPauseData(
        id: id ?? this.id,
        matchTermId: matchTermId ?? this.matchTermId,
        startPause: startPause ?? this.startPause,
        endPause: endPause.present ? endPause.value : this.endPause,
      );
  MatchTermPauseData copyWithCompanion(MatchTermPauseCompanion data) {
    return MatchTermPauseData(
      id: data.id.present ? data.id.value : this.id,
      matchTermId:
          data.matchTermId.present ? data.matchTermId.value : this.matchTermId,
      startPause:
          data.startPause.present ? data.startPause.value : this.startPause,
      endPause: data.endPause.present ? data.endPause.value : this.endPause,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchTermPauseData(')
          ..write('id: $id, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('startPause: $startPause, ')
          ..write('endPause: $endPause')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchTermId, startPause, endPause);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchTermPauseData &&
          other.id == this.id &&
          other.matchTermId == this.matchTermId &&
          other.startPause == this.startPause &&
          other.endPause == this.endPause);
}

class MatchTermPauseCompanion extends UpdateCompanion<MatchTermPauseData> {
  final Value<int> id;
  final Value<int> matchTermId;
  final Value<DateTime> startPause;
  final Value<DateTime?> endPause;
  const MatchTermPauseCompanion({
    this.id = const Value.absent(),
    this.matchTermId = const Value.absent(),
    this.startPause = const Value.absent(),
    this.endPause = const Value.absent(),
  });
  MatchTermPauseCompanion.insert({
    this.id = const Value.absent(),
    required int matchTermId,
    required DateTime startPause,
    this.endPause = const Value.absent(),
  })  : matchTermId = Value(matchTermId),
        startPause = Value(startPause);
  static Insertable<MatchTermPauseData> custom({
    Expression<int>? id,
    Expression<int>? matchTermId,
    Expression<DateTime>? startPause,
    Expression<DateTime>? endPause,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchTermId != null) 'match_term_id': matchTermId,
      if (startPause != null) 'start_pause': startPause,
      if (endPause != null) 'end_pause': endPause,
    });
  }

  MatchTermPauseCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchTermId,
      Value<DateTime>? startPause,
      Value<DateTime?>? endPause}) {
    return MatchTermPauseCompanion(
      id: id ?? this.id,
      matchTermId: matchTermId ?? this.matchTermId,
      startPause: startPause ?? this.startPause,
      endPause: endPause ?? this.endPause,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchTermId.present) {
      map['match_term_id'] = Variable<int>(matchTermId.value);
    }
    if (startPause.present) {
      map['start_pause'] = Variable<DateTime>(startPause.value);
    }
    if (endPause.present) {
      map['end_pause'] = Variable<DateTime>(endPause.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchTermPauseCompanion(')
          ..write('id: $id, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('startPause: $startPause, ')
          ..write('endPause: $endPause')
          ..write(')'))
        .toString();
  }
}

class $WarningsTable extends Warnings with TableInfo<$WarningsTable, Warning> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES matches (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES players (id)'));
  static const VerificationMeta _matchTermIdMeta =
      const VerificationMeta('matchTermId');
  @override
  late final GeneratedColumn<int> matchTermId = GeneratedColumn<int>(
      'match_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES match_terms (id)'));
  static const VerificationMeta _warningTimeMeta =
      const VerificationMeta('warningTime');
  @override
  late final GeneratedColumn<int> warningTime = GeneratedColumn<int>(
      'warning_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _warningTypeMeta =
      const VerificationMeta('warningType');
  @override
  late final GeneratedColumn<String> warningType = GeneratedColumn<String>(
      'warning_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        matchId,
        playerId,
        matchTermId,
        warningTime,
        warningType,
        reason,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warnings';
  @override
  VerificationContext validateIntegrity(Insertable<Warning> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('match_term_id')) {
      context.handle(
          _matchTermIdMeta,
          matchTermId.isAcceptableOrUnknown(
              data['match_term_id']!, _matchTermIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermIdMeta);
    }
    if (data.containsKey('warning_time')) {
      context.handle(
          _warningTimeMeta,
          warningTime.isAcceptableOrUnknown(
              data['warning_time']!, _warningTimeMeta));
    } else if (isInserting) {
      context.missing(_warningTimeMeta);
    }
    if (data.containsKey('warning_type')) {
      context.handle(
          _warningTypeMeta,
          warningType.isAcceptableOrUnknown(
              data['warning_type']!, _warningTypeMeta));
    } else if (isInserting) {
      context.missing(_warningTypeMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Warning map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Warning(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      matchTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_term_id'])!,
      warningTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warning_time'])!,
      warningType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warning_type'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $WarningsTable createAlias(String alias) {
    return $WarningsTable(attachedDatabase, alias);
  }
}

class Warning extends DataClass implements Insertable<Warning> {
  final int id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int warningTime;
  final String warningType;
  final String? reason;
  final String status;
  const Warning(
      {required this.id,
      required this.matchId,
      required this.playerId,
      required this.matchTermId,
      required this.warningTime,
      required this.warningType,
      this.reason,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['player_id'] = Variable<int>(playerId);
    map['match_term_id'] = Variable<int>(matchTermId);
    map['warning_time'] = Variable<int>(warningTime);
    map['warning_type'] = Variable<String>(warningType);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  WarningsCompanion toCompanion(bool nullToAbsent) {
    return WarningsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      warningTime: Value(warningTime),
      warningType: Value(warningType),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      status: Value(status),
    );
  }

  factory Warning.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Warning(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      matchTermId: serializer.fromJson<int>(json['matchTermId']),
      warningTime: serializer.fromJson<int>(json['warningTime']),
      warningType: serializer.fromJson<String>(json['warningType']),
      reason: serializer.fromJson<String?>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'playerId': serializer.toJson<int>(playerId),
      'matchTermId': serializer.toJson<int>(matchTermId),
      'warningTime': serializer.toJson<int>(warningTime),
      'warningType': serializer.toJson<String>(warningType),
      'reason': serializer.toJson<String?>(reason),
      'status': serializer.toJson<String>(status),
    };
  }

  Warning copyWith(
          {int? id,
          int? matchId,
          int? playerId,
          int? matchTermId,
          int? warningTime,
          String? warningType,
          Value<String?> reason = const Value.absent(),
          String? status}) =>
      Warning(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        playerId: playerId ?? this.playerId,
        matchTermId: matchTermId ?? this.matchTermId,
        warningTime: warningTime ?? this.warningTime,
        warningType: warningType ?? this.warningType,
        reason: reason.present ? reason.value : this.reason,
        status: status ?? this.status,
      );
  Warning copyWithCompanion(WarningsCompanion data) {
    return Warning(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      matchTermId:
          data.matchTermId.present ? data.matchTermId.value : this.matchTermId,
      warningTime:
          data.warningTime.present ? data.warningTime.value : this.warningTime,
      warningType:
          data.warningType.present ? data.warningType.value : this.warningType,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Warning(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('warningTime: $warningTime, ')
          ..write('warningType: $warningType, ')
          ..write('reason: $reason, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, playerId, matchTermId,
      warningTime, warningType, reason, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Warning &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.playerId == this.playerId &&
          other.matchTermId == this.matchTermId &&
          other.warningTime == this.warningTime &&
          other.warningType == this.warningType &&
          other.reason == this.reason &&
          other.status == this.status);
}

class WarningsCompanion extends UpdateCompanion<Warning> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> playerId;
  final Value<int> matchTermId;
  final Value<int> warningTime;
  final Value<String> warningType;
  final Value<String?> reason;
  final Value<String> status;
  const WarningsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.matchTermId = const Value.absent(),
    this.warningTime = const Value.absent(),
    this.warningType = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
  });
  WarningsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int playerId,
    required int matchTermId,
    required int warningTime,
    required String warningType,
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
  })  : matchId = Value(matchId),
        playerId = Value(playerId),
        matchTermId = Value(matchTermId),
        warningTime = Value(warningTime),
        warningType = Value(warningType);
  static Insertable<Warning> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? playerId,
    Expression<int>? matchTermId,
    Expression<int>? warningTime,
    Expression<String>? warningType,
    Expression<String>? reason,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (playerId != null) 'player_id': playerId,
      if (matchTermId != null) 'match_term_id': matchTermId,
      if (warningTime != null) 'warning_time': warningTime,
      if (warningType != null) 'warning_type': warningType,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
    });
  }

  WarningsCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchId,
      Value<int>? playerId,
      Value<int>? matchTermId,
      Value<int>? warningTime,
      Value<String>? warningType,
      Value<String?>? reason,
      Value<String>? status}) {
    return WarningsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      warningTime: warningTime ?? this.warningTime,
      warningType: warningType ?? this.warningType,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (matchTermId.present) {
      map['match_term_id'] = Variable<int>(matchTermId.value);
    }
    if (warningTime.present) {
      map['warning_time'] = Variable<int>(warningTime.value);
    }
    if (warningType.present) {
      map['warning_type'] = Variable<String>(warningType.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarningsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('warningTime: $warningTime, ')
          ..write('warningType: $warningType, ')
          ..write('reason: $reason, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES matches (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES players (id)'));
  static const VerificationMeta _matchTermIdMeta =
      const VerificationMeta('matchTermId');
  @override
  late final GeneratedColumn<int> matchTermId = GeneratedColumn<int>(
      'match_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES match_terms (id)'));
  static const VerificationMeta _goalTimeMeta =
      const VerificationMeta('goalTime');
  @override
  late final GeneratedColumn<int> goalTime = GeneratedColumn<int>(
      'goal_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _goalTypeMeta =
      const VerificationMeta('goalType');
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
      'goal_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, matchId, playerId, matchTermId, goalTime, goalType, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('match_term_id')) {
      context.handle(
          _matchTermIdMeta,
          matchTermId.isAcceptableOrUnknown(
              data['match_term_id']!, _matchTermIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermIdMeta);
    }
    if (data.containsKey('goal_time')) {
      context.handle(_goalTimeMeta,
          goalTime.isAcceptableOrUnknown(data['goal_time']!, _goalTimeMeta));
    } else if (isInserting) {
      context.missing(_goalTimeMeta);
    }
    if (data.containsKey('goal_type')) {
      context.handle(_goalTypeMeta,
          goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta));
    } else if (isInserting) {
      context.missing(_goalTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      matchTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_term_id'])!,
      goalTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_time'])!,
      goalType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int goalTime;
  final String goalType;
  final String status;
  const Goal(
      {required this.id,
      required this.matchId,
      required this.playerId,
      required this.matchTermId,
      required this.goalTime,
      required this.goalType,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['player_id'] = Variable<int>(playerId);
    map['match_term_id'] = Variable<int>(matchTermId);
    map['goal_time'] = Variable<int>(goalTime);
    map['goal_type'] = Variable<String>(goalType);
    map['status'] = Variable<String>(status);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      goalTime: Value(goalTime),
      goalType: Value(goalType),
      status: Value(status),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      matchTermId: serializer.fromJson<int>(json['matchTermId']),
      goalTime: serializer.fromJson<int>(json['goalTime']),
      goalType: serializer.fromJson<String>(json['goalType']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'playerId': serializer.toJson<int>(playerId),
      'matchTermId': serializer.toJson<int>(matchTermId),
      'goalTime': serializer.toJson<int>(goalTime),
      'goalType': serializer.toJson<String>(goalType),
      'status': serializer.toJson<String>(status),
    };
  }

  Goal copyWith(
          {int? id,
          int? matchId,
          int? playerId,
          int? matchTermId,
          int? goalTime,
          String? goalType,
          String? status}) =>
      Goal(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        playerId: playerId ?? this.playerId,
        matchTermId: matchTermId ?? this.matchTermId,
        goalTime: goalTime ?? this.goalTime,
        goalType: goalType ?? this.goalType,
        status: status ?? this.status,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      matchTermId:
          data.matchTermId.present ? data.matchTermId.value : this.matchTermId,
      goalTime: data.goalTime.present ? data.goalTime.value : this.goalTime,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('goalTime: $goalTime, ')
          ..write('goalType: $goalType, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, matchId, playerId, matchTermId, goalTime, goalType, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.playerId == this.playerId &&
          other.matchTermId == this.matchTermId &&
          other.goalTime == this.goalTime &&
          other.goalType == this.goalType &&
          other.status == this.status);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> playerId;
  final Value<int> matchTermId;
  final Value<int> goalTime;
  final Value<String> goalType;
  final Value<String> status;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.matchTermId = const Value.absent(),
    this.goalTime = const Value.absent(),
    this.goalType = const Value.absent(),
    this.status = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int playerId,
    required int matchTermId,
    required int goalTime,
    required String goalType,
    this.status = const Value.absent(),
  })  : matchId = Value(matchId),
        playerId = Value(playerId),
        matchTermId = Value(matchTermId),
        goalTime = Value(goalTime),
        goalType = Value(goalType);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? playerId,
    Expression<int>? matchTermId,
    Expression<int>? goalTime,
    Expression<String>? goalType,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (playerId != null) 'player_id': playerId,
      if (matchTermId != null) 'match_term_id': matchTermId,
      if (goalTime != null) 'goal_time': goalTime,
      if (goalType != null) 'goal_type': goalType,
      if (status != null) 'status': status,
    });
  }

  GoalsCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchId,
      Value<int>? playerId,
      Value<int>? matchTermId,
      Value<int>? goalTime,
      Value<String>? goalType,
      Value<String>? status}) {
    return GoalsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      goalTime: goalTime ?? this.goalTime,
      goalType: goalType ?? this.goalType,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (matchTermId.present) {
      map['match_term_id'] = Variable<int>(matchTermId.value);
    }
    if (goalTime.present) {
      map['goal_time'] = Variable<int>(goalTime.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('goalTime: $goalTime, ')
          ..write('goalType: $goalType, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $AssistsTable extends Assists with TableInfo<$AssistsTable, Assist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES matches (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES players (id)'));
  static const VerificationMeta _matchTermIdMeta =
      const VerificationMeta('matchTermId');
  @override
  late final GeneratedColumn<int> matchTermId = GeneratedColumn<int>(
      'match_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES match_terms (id)'));
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goals (id)'));
  static const VerificationMeta _assistTimeMeta =
      const VerificationMeta('assistTime');
  @override
  late final GeneratedColumn<int> assistTime = GeneratedColumn<int>(
      'assist_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, matchId, playerId, matchTermId, goalId, assistTime, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assists';
  @override
  VerificationContext validateIntegrity(Insertable<Assist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('match_term_id')) {
      context.handle(
          _matchTermIdMeta,
          matchTermId.isAcceptableOrUnknown(
              data['match_term_id']!, _matchTermIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermIdMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('assist_time')) {
      context.handle(
          _assistTimeMeta,
          assistTime.isAcceptableOrUnknown(
              data['assist_time']!, _assistTimeMeta));
    } else if (isInserting) {
      context.missing(_assistTimeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      matchTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_term_id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id'])!,
      assistTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}assist_time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $AssistsTable createAlias(String alias) {
    return $AssistsTable(attachedDatabase, alias);
  }
}

class Assist extends DataClass implements Insertable<Assist> {
  final int id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int goalId;
  final int assistTime;
  final String status;
  const Assist(
      {required this.id,
      required this.matchId,
      required this.playerId,
      required this.matchTermId,
      required this.goalId,
      required this.assistTime,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['player_id'] = Variable<int>(playerId);
    map['match_term_id'] = Variable<int>(matchTermId);
    map['goal_id'] = Variable<int>(goalId);
    map['assist_time'] = Variable<int>(assistTime);
    map['status'] = Variable<String>(status);
    return map;
  }

  AssistsCompanion toCompanion(bool nullToAbsent) {
    return AssistsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      goalId: Value(goalId),
      assistTime: Value(assistTime),
      status: Value(status),
    );
  }

  factory Assist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assist(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      matchTermId: serializer.fromJson<int>(json['matchTermId']),
      goalId: serializer.fromJson<int>(json['goalId']),
      assistTime: serializer.fromJson<int>(json['assistTime']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'playerId': serializer.toJson<int>(playerId),
      'matchTermId': serializer.toJson<int>(matchTermId),
      'goalId': serializer.toJson<int>(goalId),
      'assistTime': serializer.toJson<int>(assistTime),
      'status': serializer.toJson<String>(status),
    };
  }

  Assist copyWith(
          {int? id,
          int? matchId,
          int? playerId,
          int? matchTermId,
          int? goalId,
          int? assistTime,
          String? status}) =>
      Assist(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        playerId: playerId ?? this.playerId,
        matchTermId: matchTermId ?? this.matchTermId,
        goalId: goalId ?? this.goalId,
        assistTime: assistTime ?? this.assistTime,
        status: status ?? this.status,
      );
  Assist copyWithCompanion(AssistsCompanion data) {
    return Assist(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      matchTermId:
          data.matchTermId.present ? data.matchTermId.value : this.matchTermId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      assistTime:
          data.assistTime.present ? data.assistTime.value : this.assistTime,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assist(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('goalId: $goalId, ')
          ..write('assistTime: $assistTime, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, matchId, playerId, matchTermId, goalId, assistTime, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assist &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.playerId == this.playerId &&
          other.matchTermId == this.matchTermId &&
          other.goalId == this.goalId &&
          other.assistTime == this.assistTime &&
          other.status == this.status);
}

class AssistsCompanion extends UpdateCompanion<Assist> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> playerId;
  final Value<int> matchTermId;
  final Value<int> goalId;
  final Value<int> assistTime;
  final Value<String> status;
  const AssistsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.matchTermId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.assistTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  AssistsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int playerId,
    required int matchTermId,
    required int goalId,
    required int assistTime,
    this.status = const Value.absent(),
  })  : matchId = Value(matchId),
        playerId = Value(playerId),
        matchTermId = Value(matchTermId),
        goalId = Value(goalId),
        assistTime = Value(assistTime);
  static Insertable<Assist> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? playerId,
    Expression<int>? matchTermId,
    Expression<int>? goalId,
    Expression<int>? assistTime,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (playerId != null) 'player_id': playerId,
      if (matchTermId != null) 'match_term_id': matchTermId,
      if (goalId != null) 'goal_id': goalId,
      if (assistTime != null) 'assist_time': assistTime,
      if (status != null) 'status': status,
    });
  }

  AssistsCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchId,
      Value<int>? playerId,
      Value<int>? matchTermId,
      Value<int>? goalId,
      Value<int>? assistTime,
      Value<String>? status}) {
    return AssistsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      goalId: goalId ?? this.goalId,
      assistTime: assistTime ?? this.assistTime,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (matchTermId.present) {
      map['match_term_id'] = Variable<int>(matchTermId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (assistTime.present) {
      map['assist_time'] = Variable<int>(assistTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssistsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('goalId: $goalId, ')
          ..write('assistTime: $assistTime, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $PlayerMatchParticipationTable extends PlayerMatchParticipation
    with
        TableInfo<$PlayerMatchParticipationTable,
            PlayerMatchParticipationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerMatchParticipationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES matches (id) ON DELETE CASCADE'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES players (id) ON DELETE CASCADE'));
  static const VerificationMeta _matchTermIdMeta =
      const VerificationMeta('matchTermId');
  @override
  late final GeneratedColumn<int> matchTermId = GeneratedColumn<int>(
      'match_term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES match_terms (id) ON DELETE CASCADE'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
      'start_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
      'end_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _substitutedPlayerIdMeta =
      const VerificationMeta('substitutedPlayerId');
  @override
  late final GeneratedColumn<int> substitutedPlayerId = GeneratedColumn<int>(
      'substituted_player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES players (id) ON DELETE CASCADE'));
  static const VerificationMeta _participationTypeMeta =
      const VerificationMeta('participationType');
  @override
  late final GeneratedColumn<String> participationType =
      GeneratedColumn<String>('participation_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        matchId,
        playerId,
        matchTermId,
        startTime,
        endTime,
        substitutedPlayerId,
        participationType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_match_participation';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayerMatchParticipationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('match_term_id')) {
      context.handle(
          _matchTermIdMeta,
          matchTermId.isAcceptableOrUnknown(
              data['match_term_id']!, _matchTermIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('substituted_player_id')) {
      context.handle(
          _substitutedPlayerIdMeta,
          substitutedPlayerId.isAcceptableOrUnknown(
              data['substituted_player_id']!, _substitutedPlayerIdMeta));
    } else if (isInserting) {
      context.missing(_substitutedPlayerIdMeta);
    }
    if (data.containsKey('participation_type')) {
      context.handle(
          _participationTypeMeta,
          participationType.isAcceptableOrUnknown(
              data['participation_type']!, _participationTypeMeta));
    } else if (isInserting) {
      context.missing(_participationTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerMatchParticipationData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerMatchParticipationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      matchTermId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_term_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time']),
      substitutedPlayerId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}substituted_player_id'])!,
      participationType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}participation_type'])!,
    );
  }

  @override
  $PlayerMatchParticipationTable createAlias(String alias) {
    return $PlayerMatchParticipationTable(attachedDatabase, alias);
  }
}

class PlayerMatchParticipationData extends DataClass
    implements Insertable<PlayerMatchParticipationData> {
  final int id;
  final int matchId;
  final int playerId;
  final int matchTermId;
  final int? startTime;
  final int? endTime;
  final int substitutedPlayerId;
  final String participationType;
  const PlayerMatchParticipationData(
      {required this.id,
      required this.matchId,
      required this.playerId,
      required this.matchTermId,
      this.startTime,
      this.endTime,
      required this.substitutedPlayerId,
      required this.participationType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['player_id'] = Variable<int>(playerId);
    map['match_term_id'] = Variable<int>(matchTermId);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<int>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<int>(endTime);
    }
    map['substituted_player_id'] = Variable<int>(substitutedPlayerId);
    map['participation_type'] = Variable<String>(participationType);
    return map;
  }

  PlayerMatchParticipationCompanion toCompanion(bool nullToAbsent) {
    return PlayerMatchParticipationCompanion(
      id: Value(id),
      matchId: Value(matchId),
      playerId: Value(playerId),
      matchTermId: Value(matchTermId),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      substitutedPlayerId: Value(substitutedPlayerId),
      participationType: Value(participationType),
    );
  }

  factory PlayerMatchParticipationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerMatchParticipationData(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      matchTermId: serializer.fromJson<int>(json['matchTermId']),
      startTime: serializer.fromJson<int?>(json['startTime']),
      endTime: serializer.fromJson<int?>(json['endTime']),
      substitutedPlayerId:
          serializer.fromJson<int>(json['substitutedPlayerId']),
      participationType: serializer.fromJson<String>(json['participationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'playerId': serializer.toJson<int>(playerId),
      'matchTermId': serializer.toJson<int>(matchTermId),
      'startTime': serializer.toJson<int?>(startTime),
      'endTime': serializer.toJson<int?>(endTime),
      'substitutedPlayerId': serializer.toJson<int>(substitutedPlayerId),
      'participationType': serializer.toJson<String>(participationType),
    };
  }

  PlayerMatchParticipationData copyWith(
          {int? id,
          int? matchId,
          int? playerId,
          int? matchTermId,
          Value<int?> startTime = const Value.absent(),
          Value<int?> endTime = const Value.absent(),
          int? substitutedPlayerId,
          String? participationType}) =>
      PlayerMatchParticipationData(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        playerId: playerId ?? this.playerId,
        matchTermId: matchTermId ?? this.matchTermId,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        substitutedPlayerId: substitutedPlayerId ?? this.substitutedPlayerId,
        participationType: participationType ?? this.participationType,
      );
  PlayerMatchParticipationData copyWithCompanion(
      PlayerMatchParticipationCompanion data) {
    return PlayerMatchParticipationData(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      matchTermId:
          data.matchTermId.present ? data.matchTermId.value : this.matchTermId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      substitutedPlayerId: data.substitutedPlayerId.present
          ? data.substitutedPlayerId.value
          : this.substitutedPlayerId,
      participationType: data.participationType.present
          ? data.participationType.value
          : this.participationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerMatchParticipationData(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('substitutedPlayerId: $substitutedPlayerId, ')
          ..write('participationType: $participationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, playerId, matchTermId, startTime,
      endTime, substitutedPlayerId, participationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerMatchParticipationData &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.playerId == this.playerId &&
          other.matchTermId == this.matchTermId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.substitutedPlayerId == this.substitutedPlayerId &&
          other.participationType == this.participationType);
}

class PlayerMatchParticipationCompanion
    extends UpdateCompanion<PlayerMatchParticipationData> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> playerId;
  final Value<int> matchTermId;
  final Value<int?> startTime;
  final Value<int?> endTime;
  final Value<int> substitutedPlayerId;
  final Value<String> participationType;
  const PlayerMatchParticipationCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.matchTermId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.substitutedPlayerId = const Value.absent(),
    this.participationType = const Value.absent(),
  });
  PlayerMatchParticipationCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int playerId,
    required int matchTermId,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    required int substitutedPlayerId,
    required String participationType,
  })  : matchId = Value(matchId),
        playerId = Value(playerId),
        matchTermId = Value(matchTermId),
        substitutedPlayerId = Value(substitutedPlayerId),
        participationType = Value(participationType);
  static Insertable<PlayerMatchParticipationData> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? playerId,
    Expression<int>? matchTermId,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<int>? substitutedPlayerId,
    Expression<String>? participationType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (playerId != null) 'player_id': playerId,
      if (matchTermId != null) 'match_term_id': matchTermId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (substitutedPlayerId != null)
        'substituted_player_id': substitutedPlayerId,
      if (participationType != null) 'participation_type': participationType,
    });
  }

  PlayerMatchParticipationCompanion copyWith(
      {Value<int>? id,
      Value<int>? matchId,
      Value<int>? playerId,
      Value<int>? matchTermId,
      Value<int?>? startTime,
      Value<int?>? endTime,
      Value<int>? substitutedPlayerId,
      Value<String>? participationType}) {
    return PlayerMatchParticipationCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      matchTermId: matchTermId ?? this.matchTermId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      substitutedPlayerId: substitutedPlayerId ?? this.substitutedPlayerId,
      participationType: participationType ?? this.participationType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (matchTermId.present) {
      map['match_term_id'] = Variable<int>(matchTermId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (substitutedPlayerId.present) {
      map['substituted_player_id'] = Variable<int>(substitutedPlayerId.value);
    }
    if (participationType.present) {
      map['participation_type'] = Variable<String>(participationType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerMatchParticipationCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('matchTermId: $matchTermId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('substitutedPlayerId: $substitutedPlayerId, ')
          ..write('participationType: $participationType')
          ..write(')'))
        .toString();
  }
}

abstract class _$Safirah extends GeneratedDatabase {
  _$Safirah(QueryExecutor e) : super(e);
  $SafirahManager get managers => $SafirahManager(this);
  late final $LeaguesTable leagues = $LeaguesTable(this);
  late final $LeagueRulesTable leagueRules = $LeagueRulesTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $TeamPlayerCategoriesTable teamPlayerCategories =
      $TeamPlayerCategoriesTable(this);
  late final $LeaguePlayersTable leaguePlayers = $LeaguePlayersTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $DraftProgressTable draftProgress = $DraftProgressTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $GroupTable group = $GroupTable(this);
  late final $GroupTeamTable groupTeam = $GroupTeamTable(this);
  late final $RoundsTable rounds = $RoundsTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $QualifiedTeamTable qualifiedTeam = $QualifiedTeamTable(this);
  late final $LeagueStatusTable leagueStatus = $LeagueStatusTable(this);
  late final $TermsTable terms = $TermsTable(this);
  late final $LeagueTermsTable leagueTerms = $LeagueTermsTable(this);
  late final $MatchTermsTable matchTerms = $MatchTermsTable(this);
  late final $MatchTermPauseTable matchTermPause = $MatchTermPauseTable(this);
  late final $WarningsTable warnings = $WarningsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $AssistsTable assists = $AssistsTable(this);
  late final $PlayerMatchParticipationTable playerMatchParticipation =
      $PlayerMatchParticipationTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        leagues,
        leagueRules,
        teams,
        teamPlayerCategories,
        leaguePlayers,
        players,
        draftProgress,
        syncQueue,
        group,
        groupTeam,
        rounds,
        matches,
        qualifiedTeam,
        leagueStatus,
        terms,
        leagueTerms,
        matchTerms,
        matchTermPause,
        warnings,
        goals,
        assists,
        playerMatchParticipation
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('teams', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('team_player_categories', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('league_players', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('team_player_categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('league_players', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('league_players',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('players', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('teams',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('players', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('group',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('group_team', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('teams',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('group_team', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('rounds', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('group',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('rounds', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('matches', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('rounds',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('matches', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('qualified_team', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('group',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('qualified_team', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('teams',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('qualified_team', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('match_terms',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('match_term_pause', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('matches',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('player_match_participation',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('players',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('player_match_participation',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('match_terms',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('player_match_participation',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('players',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('player_match_participation',
                  kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$LeaguesTableCreateCompanionBuilder = LeaguesCompanion Function({
  Value<int> id,
  required String name,
  required String subscriptionPrice,
  Value<String?> type,
  Value<int?> organizerId,
  Value<String?> scope,
  Value<String?> logoPath,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<int?> maxTeams,
  Value<int?> maxMainPlayers,
  Value<int?> maxSubPlayers,
  Value<bool> isPrivate,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$LeaguesTableUpdateCompanionBuilder = LeaguesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> subscriptionPrice,
  Value<String?> type,
  Value<int?> organizerId,
  Value<String?> scope,
  Value<String?> logoPath,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<int?> maxTeams,
  Value<int?> maxMainPlayers,
  Value<int?> maxSubPlayers,
  Value<bool> isPrivate,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$LeaguesTableReferences
    extends BaseReferences<_$Safirah, $LeaguesTable, League> {
  $$LeaguesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LeagueRulesTable, List<LeagueRule>>
      _leagueRulesRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.leagueRules,
              aliasName:
                  $_aliasNameGenerator(db.leagues.id, db.leagueRules.leagueId));

  $$LeagueRulesTableProcessedTableManager get leagueRulesRefs {
    final manager = $$LeagueRulesTableTableManager($_db, $_db.leagueRules)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leagueRulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TeamsTable, List<Team>> _teamsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.teams,
          aliasName: $_aliasNameGenerator(db.leagues.id, db.teams.leagueId));

  $$TeamsTableProcessedTableManager get teamsRefs {
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_teamsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TeamPlayerCategoriesTable,
      List<TeamPlayerCategory>> _teamPlayerCategoriesRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.teamPlayerCategories,
          aliasName: $_aliasNameGenerator(
              db.leagues.id, db.teamPlayerCategories.leagueId));

  $$TeamPlayerCategoriesTableProcessedTableManager
      get teamPlayerCategoriesRefs {
    final manager =
        $$TeamPlayerCategoriesTableTableManager($_db, $_db.teamPlayerCategories)
            .filter((f) => f.leagueId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_teamPlayerCategoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LeaguePlayersTable, List<LeaguePlayer>>
      _leaguePlayersRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.leaguePlayers,
          aliasName:
              $_aliasNameGenerator(db.leagues.id, db.leaguePlayers.leagueId));

  $$LeaguePlayersTableProcessedTableManager get leaguePlayersRefs {
    final manager = $$LeaguePlayersTableTableManager($_db, $_db.leaguePlayers)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leaguePlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GroupTable, List<GroupData>> _groupRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.group,
          aliasName: $_aliasNameGenerator(db.leagues.id, db.group.leagueId));

  $$GroupTableProcessedTableManager get groupRefs {
    final manager = $$GroupTableTableManager($_db, $_db.group)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_groupRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RoundsTable, List<Round>> _roundsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.rounds,
          aliasName: $_aliasNameGenerator(db.leagues.id, db.rounds.leagueId));

  $$RoundsTableProcessedTableManager get roundsRefs {
    final manager = $$RoundsTableTableManager($_db, $_db.rounds)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_roundsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MatchesTable, List<Matche>> _matchesRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.matches,
          aliasName: $_aliasNameGenerator(db.leagues.id, db.matches.leagueId));

  $$MatchesTableProcessedTableManager get matchesRefs {
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_matchesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QualifiedTeamTable, List<QualifiedTeamData>>
      _qualifiedTeamRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.qualifiedTeam,
          aliasName:
              $_aliasNameGenerator(db.leagues.id, db.qualifiedTeam.leagueId));

  $$QualifiedTeamTableProcessedTableManager get qualifiedTeamRefs {
    final manager = $$QualifiedTeamTableTableManager($_db, $_db.qualifiedTeam)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_qualifiedTeamRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LeagueStatusTable, List<LeagueStatusData>>
      _leagueStatusRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.leagueStatus,
          aliasName:
              $_aliasNameGenerator(db.leagues.id, db.leagueStatus.leagueId));

  $$LeagueStatusTableProcessedTableManager get leagueStatusRefs {
    final manager = $$LeagueStatusTableTableManager($_db, $_db.leagueStatus)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leagueStatusRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LeagueTermsTable, List<LeagueTerm>>
      _leagueTermsRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.leagueTerms,
              aliasName:
                  $_aliasNameGenerator(db.leagues.id, db.leagueTerms.leagueId));

  $$LeagueTermsTableProcessedTableManager get leagueTermsRefs {
    final manager = $$LeagueTermsTableTableManager($_db, $_db.leagueTerms)
        .filter((f) => f.leagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leagueTermsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LeaguesTableFilterComposer extends Composer<_$Safirah, $LeaguesTable> {
  $$LeaguesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subscriptionPrice => $composableBuilder(
      column: $table.subscriptionPrice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get organizerId => $composableBuilder(
      column: $table.organizerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxTeams => $composableBuilder(
      column: $table.maxTeams, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxMainPlayers => $composableBuilder(
      column: $table.maxMainPlayers,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxSubPlayers => $composableBuilder(
      column: $table.maxSubPlayers, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> leagueRulesRefs(
      Expression<bool> Function($$LeagueRulesTableFilterComposer f) f) {
    final $$LeagueRulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueRules,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueRulesTableFilterComposer(
              $db: $db,
              $table: $db.leagueRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teamsRefs(
      Expression<bool> Function($$TeamsTableFilterComposer f) f) {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teamPlayerCategoriesRefs(
      Expression<bool> Function($$TeamPlayerCategoriesTableFilterComposer f)
          f) {
    final $$TeamPlayerCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teamPlayerCategories,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamPlayerCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.teamPlayerCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> leaguePlayersRefs(
      Expression<bool> Function($$LeaguePlayersTableFilterComposer f) f) {
    final $$LeaguePlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableFilterComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> groupRefs(
      Expression<bool> Function($$GroupTableFilterComposer f) f) {
    final $$GroupTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableFilterComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> roundsRefs(
      Expression<bool> Function($$RoundsTableFilterComposer f) f) {
    final $$RoundsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableFilterComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> matchesRefs(
      Expression<bool> Function($$MatchesTableFilterComposer f) f) {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> qualifiedTeamRefs(
      Expression<bool> Function($$QualifiedTeamTableFilterComposer f) f) {
    final $$QualifiedTeamTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableFilterComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> leagueStatusRefs(
      Expression<bool> Function($$LeagueStatusTableFilterComposer f) f) {
    final $$LeagueStatusTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueStatus,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueStatusTableFilterComposer(
              $db: $db,
              $table: $db.leagueStatus,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> leagueTermsRefs(
      Expression<bool> Function($$LeagueTermsTableFilterComposer f) f) {
    final $$LeagueTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableFilterComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeaguesTableOrderingComposer
    extends Composer<_$Safirah, $LeaguesTable> {
  $$LeaguesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subscriptionPrice => $composableBuilder(
      column: $table.subscriptionPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get organizerId => $composableBuilder(
      column: $table.organizerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoPath => $composableBuilder(
      column: $table.logoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxTeams => $composableBuilder(
      column: $table.maxTeams, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxMainPlayers => $composableBuilder(
      column: $table.maxMainPlayers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxSubPlayers => $composableBuilder(
      column: $table.maxSubPlayers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LeaguesTableAnnotationComposer
    extends Composer<_$Safirah, $LeaguesTable> {
  $$LeaguesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get subscriptionPrice => $composableBuilder(
      column: $table.subscriptionPrice, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get organizerId => $composableBuilder(
      column: $table.organizerId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get maxTeams =>
      $composableBuilder(column: $table.maxTeams, builder: (column) => column);

  GeneratedColumn<int> get maxMainPlayers => $composableBuilder(
      column: $table.maxMainPlayers, builder: (column) => column);

  GeneratedColumn<int> get maxSubPlayers => $composableBuilder(
      column: $table.maxSubPlayers, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> leagueRulesRefs<T extends Object>(
      Expression<T> Function($$LeagueRulesTableAnnotationComposer a) f) {
    final $$LeagueRulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueRules,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueRulesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagueRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teamsRefs<T extends Object>(
      Expression<T> Function($$TeamsTableAnnotationComposer a) f) {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teamPlayerCategoriesRefs<T extends Object>(
      Expression<T> Function($$TeamPlayerCategoriesTableAnnotationComposer a)
          f) {
    final $$TeamPlayerCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.teamPlayerCategories,
            getReferencedColumn: (t) => t.leagueId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeamPlayerCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.teamPlayerCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> leaguePlayersRefs<T extends Object>(
      Expression<T> Function($$LeaguePlayersTableAnnotationComposer a) f) {
    final $$LeaguePlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> groupRefs<T extends Object>(
      Expression<T> Function($$GroupTableAnnotationComposer a) f) {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableAnnotationComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> roundsRefs<T extends Object>(
      Expression<T> Function($$RoundsTableAnnotationComposer a) f) {
    final $$RoundsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableAnnotationComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> matchesRefs<T extends Object>(
      Expression<T> Function($$MatchesTableAnnotationComposer a) f) {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> qualifiedTeamRefs<T extends Object>(
      Expression<T> Function($$QualifiedTeamTableAnnotationComposer a) f) {
    final $$QualifiedTeamTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableAnnotationComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> leagueStatusRefs<T extends Object>(
      Expression<T> Function($$LeagueStatusTableAnnotationComposer a) f) {
    final $$LeagueStatusTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueStatus,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueStatusTableAnnotationComposer(
              $db: $db,
              $table: $db.leagueStatus,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> leagueTermsRefs<T extends Object>(
      Expression<T> Function($$LeagueTermsTableAnnotationComposer a) f) {
    final $$LeagueTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.leagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeaguesTableTableManager extends RootTableManager<
    _$Safirah,
    $LeaguesTable,
    League,
    $$LeaguesTableFilterComposer,
    $$LeaguesTableOrderingComposer,
    $$LeaguesTableAnnotationComposer,
    $$LeaguesTableCreateCompanionBuilder,
    $$LeaguesTableUpdateCompanionBuilder,
    (League, $$LeaguesTableReferences),
    League,
    PrefetchHooks Function(
        {bool leagueRulesRefs,
        bool teamsRefs,
        bool teamPlayerCategoriesRefs,
        bool leaguePlayersRefs,
        bool groupRefs,
        bool roundsRefs,
        bool matchesRefs,
        bool qualifiedTeamRefs,
        bool leagueStatusRefs,
        bool leagueTermsRefs})> {
  $$LeaguesTableTableManager(_$Safirah db, $LeaguesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaguesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaguesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaguesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> subscriptionPrice = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<int?> organizerId = const Value.absent(),
            Value<String?> scope = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> maxTeams = const Value.absent(),
            Value<int?> maxMainPlayers = const Value.absent(),
            Value<int?> maxSubPlayers = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LeaguesCompanion(
            id: id,
            name: name,
            subscriptionPrice: subscriptionPrice,
            type: type,
            organizerId: organizerId,
            scope: scope,
            logoPath: logoPath,
            startDate: startDate,
            endDate: endDate,
            maxTeams: maxTeams,
            maxMainPlayers: maxMainPlayers,
            maxSubPlayers: maxSubPlayers,
            isPrivate: isPrivate,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String subscriptionPrice,
            Value<String?> type = const Value.absent(),
            Value<int?> organizerId = const Value.absent(),
            Value<String?> scope = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> maxTeams = const Value.absent(),
            Value<int?> maxMainPlayers = const Value.absent(),
            Value<int?> maxSubPlayers = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LeaguesCompanion.insert(
            id: id,
            name: name,
            subscriptionPrice: subscriptionPrice,
            type: type,
            organizerId: organizerId,
            scope: scope,
            logoPath: logoPath,
            startDate: startDate,
            endDate: endDate,
            maxTeams: maxTeams,
            maxMainPlayers: maxMainPlayers,
            maxSubPlayers: maxSubPlayers,
            isPrivate: isPrivate,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LeaguesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {leagueRulesRefs = false,
              teamsRefs = false,
              teamPlayerCategoriesRefs = false,
              leaguePlayersRefs = false,
              groupRefs = false,
              roundsRefs = false,
              matchesRefs = false,
              qualifiedTeamRefs = false,
              leagueStatusRefs = false,
              leagueTermsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (leagueRulesRefs) db.leagueRules,
                if (teamsRefs) db.teams,
                if (teamPlayerCategoriesRefs) db.teamPlayerCategories,
                if (leaguePlayersRefs) db.leaguePlayers,
                if (groupRefs) db.group,
                if (roundsRefs) db.rounds,
                if (matchesRefs) db.matches,
                if (qualifiedTeamRefs) db.qualifiedTeam,
                if (leagueStatusRefs) db.leagueStatus,
                if (leagueTermsRefs) db.leagueTerms
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (leagueRulesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._leagueRulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .leagueRulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (teamsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._teamsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0).teamsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (teamPlayerCategoriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LeaguesTableReferences
                            ._teamPlayerCategoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .teamPlayerCategoriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (leaguePlayersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LeaguesTableReferences
                            ._leaguePlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .leaguePlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (groupRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._groupRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0).groupRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (roundsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._roundsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0).roundsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (matchesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._matchesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0).matchesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (qualifiedTeamRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LeaguesTableReferences
                            ._qualifiedTeamRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .qualifiedTeamRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (leagueStatusRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._leagueStatusRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .leagueStatusRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items),
                  if (leagueTermsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LeaguesTableReferences._leagueTermsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguesTableReferences(db, table, p0)
                                .leagueTermsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.leagueId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LeaguesTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeaguesTable,
    League,
    $$LeaguesTableFilterComposer,
    $$LeaguesTableOrderingComposer,
    $$LeaguesTableAnnotationComposer,
    $$LeaguesTableCreateCompanionBuilder,
    $$LeaguesTableUpdateCompanionBuilder,
    (League, $$LeaguesTableReferences),
    League,
    PrefetchHooks Function(
        {bool leagueRulesRefs,
        bool teamsRefs,
        bool teamPlayerCategoriesRefs,
        bool leaguePlayersRefs,
        bool groupRefs,
        bool roundsRefs,
        bool matchesRefs,
        bool qualifiedTeamRefs,
        bool leagueStatusRefs,
        bool leagueTermsRefs})>;
typedef $$LeagueRulesTableCreateCompanionBuilder = LeagueRulesCompanion
    Function({
  Value<int> id,
  required int leagueId,
  required String description,
  Value<bool> isMandatory,
  Value<DateTime> createdAt,
});
typedef $$LeagueRulesTableUpdateCompanionBuilder = LeagueRulesCompanion
    Function({
  Value<int> id,
  Value<int> leagueId,
  Value<String> description,
  Value<bool> isMandatory,
  Value<DateTime> createdAt,
});

final class $$LeagueRulesTableReferences
    extends BaseReferences<_$Safirah, $LeagueRulesTable, LeagueRule> {
  $$LeagueRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.leagueRules.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LeagueRulesTableFilterComposer
    extends Composer<_$Safirah, $LeagueRulesTable> {
  $$LeagueRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueRulesTableOrderingComposer
    extends Composer<_$Safirah, $LeagueRulesTable> {
  $$LeagueRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueRulesTableAnnotationComposer
    extends Composer<_$Safirah, $LeagueRulesTable> {
  $$LeagueRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueRulesTableTableManager extends RootTableManager<
    _$Safirah,
    $LeagueRulesTable,
    LeagueRule,
    $$LeagueRulesTableFilterComposer,
    $$LeagueRulesTableOrderingComposer,
    $$LeagueRulesTableAnnotationComposer,
    $$LeagueRulesTableCreateCompanionBuilder,
    $$LeagueRulesTableUpdateCompanionBuilder,
    (LeagueRule, $$LeagueRulesTableReferences),
    LeagueRule,
    PrefetchHooks Function({bool leagueId})> {
  $$LeagueRulesTableTableManager(_$Safirah db, $LeagueRulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeagueRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeagueRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeagueRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isMandatory = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LeagueRulesCompanion(
            id: id,
            leagueId: leagueId,
            description: description,
            isMandatory: isMandatory,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required String description,
            Value<bool> isMandatory = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LeagueRulesCompanion.insert(
            id: id,
            leagueId: leagueId,
            description: description,
            isMandatory: isMandatory,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LeagueRulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({leagueId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$LeagueRulesTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$LeagueRulesTableReferences._leagueIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LeagueRulesTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeagueRulesTable,
    LeagueRule,
    $$LeagueRulesTableFilterComposer,
    $$LeagueRulesTableOrderingComposer,
    $$LeagueRulesTableAnnotationComposer,
    $$LeagueRulesTableCreateCompanionBuilder,
    $$LeagueRulesTableUpdateCompanionBuilder,
    (LeagueRule, $$LeagueRulesTableReferences),
    LeagueRule,
    PrefetchHooks Function({bool leagueId})>;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  required int leagueId,
  required String teamName,
  Value<String?> logoUrl,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  Value<int> leagueId,
  Value<String> teamName,
  Value<String?> logoUrl,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$TeamsTableReferences
    extends BaseReferences<_$Safirah, $TeamsTable, Team> {
  $$TeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues
      .createAlias($_aliasNameGenerator(db.teams.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.players,
          aliasName: $_aliasNameGenerator(db.teams.id, db.players.teamId));

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.teamId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GroupTeamTable, List<GroupTeamData>>
      _groupTeamRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.groupTeam,
          aliasName: $_aliasNameGenerator(db.teams.id, db.groupTeam.teamId));

  $$GroupTeamTableProcessedTableManager get groupTeamRefs {
    final manager = $$GroupTeamTableTableManager($_db, $_db.groupTeam)
        .filter((f) => f.teamId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_groupTeamRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QualifiedTeamTable, List<QualifiedTeamData>>
      _qualifiedTeamRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.qualifiedTeam,
              aliasName:
                  $_aliasNameGenerator(db.teams.id, db.qualifiedTeam.teamId));

  $$QualifiedTeamTableProcessedTableManager get qualifiedTeamRefs {
    final manager = $$QualifiedTeamTableTableManager($_db, $_db.qualifiedTeam)
        .filter((f) => f.teamId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_qualifiedTeamRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeamsTableFilterComposer extends Composer<_$Safirah, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamName => $composableBuilder(
      column: $table.teamName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> playersRefs(
      Expression<bool> Function($$PlayersTableFilterComposer f) f) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> groupTeamRefs(
      Expression<bool> Function($$GroupTeamTableFilterComposer f) f) {
    final $$GroupTeamTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupTeam,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTeamTableFilterComposer(
              $db: $db,
              $table: $db.groupTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> qualifiedTeamRefs(
      Expression<bool> Function($$QualifiedTeamTableFilterComposer f) f) {
    final $$QualifiedTeamTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableFilterComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamsTableOrderingComposer extends Composer<_$Safirah, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamName => $composableBuilder(
      column: $table.teamName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeamsTableAnnotationComposer extends Composer<_$Safirah, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> playersRefs<T extends Object>(
      Expression<T> Function($$PlayersTableAnnotationComposer a) f) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> groupTeamRefs<T extends Object>(
      Expression<T> Function($$GroupTeamTableAnnotationComposer a) f) {
    final $$GroupTeamTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupTeam,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTeamTableAnnotationComposer(
              $db: $db,
              $table: $db.groupTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> qualifiedTeamRefs<T extends Object>(
      Expression<T> Function($$QualifiedTeamTableAnnotationComposer a) f) {
    final $$QualifiedTeamTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableAnnotationComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamsTableTableManager extends RootTableManager<
    _$Safirah,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function(
        {bool leagueId,
        bool playersRefs,
        bool groupTeamRefs,
        bool qualifiedTeamRefs})> {
  $$TeamsTableTableManager(_$Safirah db, $TeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<String> teamName = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TeamsCompanion(
            id: id,
            leagueId: leagueId,
            teamName: teamName,
            logoUrl: logoUrl,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required String teamName,
            Value<String?> logoUrl = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TeamsCompanion.insert(
            id: id,
            leagueId: leagueId,
            teamName: teamName,
            logoUrl: logoUrl,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TeamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false,
              playersRefs = false,
              groupTeamRefs = false,
              qualifiedTeamRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playersRefs) db.players,
                if (groupTeamRefs) db.groupTeam,
                if (qualifiedTeamRefs) db.qualifiedTeam
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable: $$TeamsTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$TeamsTableReferences._leagueIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._playersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0).playersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.teamId == item.id),
                        typedResults: items),
                  if (groupTeamRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._groupTeamRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0).groupTeamRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.teamId == item.id),
                        typedResults: items),
                  if (qualifiedTeamRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._qualifiedTeamRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0)
                                .qualifiedTeamRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.teamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeamsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function(
        {bool leagueId,
        bool playersRefs,
        bool groupTeamRefs,
        bool qualifiedTeamRefs})>;
typedef $$TeamPlayerCategoriesTableCreateCompanionBuilder
    = TeamPlayerCategoriesCompanion Function({
  Value<int> id,
  required int leagueId,
  required String name,
});
typedef $$TeamPlayerCategoriesTableUpdateCompanionBuilder
    = TeamPlayerCategoriesCompanion Function({
  Value<int> id,
  Value<int> leagueId,
  Value<String> name,
});

final class $$TeamPlayerCategoriesTableReferences extends BaseReferences<
    _$Safirah, $TeamPlayerCategoriesTable, TeamPlayerCategory> {
  $$TeamPlayerCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.teamPlayerCategories.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LeaguePlayersTable, List<LeaguePlayer>>
      _leaguePlayersRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.leaguePlayers,
              aliasName: $_aliasNameGenerator(db.teamPlayerCategories.id,
                  db.leaguePlayers.teamPlayerCategoryId));

  $$LeaguePlayersTableProcessedTableManager get leaguePlayersRefs {
    final manager = $$LeaguePlayersTableTableManager($_db, $_db.leaguePlayers)
        .filter((f) => f.teamPlayerCategoryId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leaguePlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeamPlayerCategoriesTableFilterComposer
    extends Composer<_$Safirah, $TeamPlayerCategoriesTable> {
  $$TeamPlayerCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> leaguePlayersRefs(
      Expression<bool> Function($$LeaguePlayersTableFilterComposer f) f) {
    final $$LeaguePlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.teamPlayerCategoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableFilterComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamPlayerCategoriesTableOrderingComposer
    extends Composer<_$Safirah, $TeamPlayerCategoriesTable> {
  $$TeamPlayerCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeamPlayerCategoriesTableAnnotationComposer
    extends Composer<_$Safirah, $TeamPlayerCategoriesTable> {
  $$TeamPlayerCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> leaguePlayersRefs<T extends Object>(
      Expression<T> Function($$LeaguePlayersTableAnnotationComposer a) f) {
    final $$LeaguePlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.teamPlayerCategoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamPlayerCategoriesTableTableManager extends RootTableManager<
    _$Safirah,
    $TeamPlayerCategoriesTable,
    TeamPlayerCategory,
    $$TeamPlayerCategoriesTableFilterComposer,
    $$TeamPlayerCategoriesTableOrderingComposer,
    $$TeamPlayerCategoriesTableAnnotationComposer,
    $$TeamPlayerCategoriesTableCreateCompanionBuilder,
    $$TeamPlayerCategoriesTableUpdateCompanionBuilder,
    (TeamPlayerCategory, $$TeamPlayerCategoriesTableReferences),
    TeamPlayerCategory,
    PrefetchHooks Function({bool leagueId, bool leaguePlayersRefs})> {
  $$TeamPlayerCategoriesTableTableManager(
      _$Safirah db, $TeamPlayerCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamPlayerCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamPlayerCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamPlayerCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              TeamPlayerCategoriesCompanion(
            id: id,
            leagueId: leagueId,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required String name,
          }) =>
              TeamPlayerCategoriesCompanion.insert(
            id: id,
            leagueId: leagueId,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TeamPlayerCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false, leaguePlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (leaguePlayersRefs) db.leaguePlayers
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable: $$TeamPlayerCategoriesTableReferences
                        ._leagueIdTable(db),
                    referencedColumn: $$TeamPlayerCategoriesTableReferences
                        ._leagueIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (leaguePlayersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TeamPlayerCategoriesTableReferences
                            ._leaguePlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamPlayerCategoriesTableReferences(db, table, p0)
                                .leaguePlayersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.teamPlayerCategoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeamPlayerCategoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$Safirah,
        $TeamPlayerCategoriesTable,
        TeamPlayerCategory,
        $$TeamPlayerCategoriesTableFilterComposer,
        $$TeamPlayerCategoriesTableOrderingComposer,
        $$TeamPlayerCategoriesTableAnnotationComposer,
        $$TeamPlayerCategoriesTableCreateCompanionBuilder,
        $$TeamPlayerCategoriesTableUpdateCompanionBuilder,
        (TeamPlayerCategory, $$TeamPlayerCategoriesTableReferences),
        TeamPlayerCategory,
        PrefetchHooks Function({bool leagueId, bool leaguePlayersRefs})>;
typedef $$LeaguePlayersTableCreateCompanionBuilder = LeaguePlayersCompanion
    Function({
  Value<int> id,
  required int leagueId,
  required int userId,
  Value<int?> teamPlayerCategoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$LeaguePlayersTableUpdateCompanionBuilder = LeaguePlayersCompanion
    Function({
  Value<int> id,
  Value<int> leagueId,
  Value<int> userId,
  Value<int?> teamPlayerCategoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$LeaguePlayersTableReferences
    extends BaseReferences<_$Safirah, $LeaguePlayersTable, LeaguePlayer> {
  $$LeaguePlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.leaguePlayers.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamPlayerCategoriesTable _teamPlayerCategoryIdTable(_$Safirah db) =>
      db.teamPlayerCategories.createAlias($_aliasNameGenerator(
          db.leaguePlayers.teamPlayerCategoryId, db.teamPlayerCategories.id));

  $$TeamPlayerCategoriesTableProcessedTableManager? get teamPlayerCategoryId {
    if ($_item.teamPlayerCategoryId == null) return null;
    final manager =
        $$TeamPlayerCategoriesTableTableManager($_db, $_db.teamPlayerCategories)
            .filter((f) => f.id($_item.teamPlayerCategoryId!));
    final item =
        $_typedResult.readTableOrNull(_teamPlayerCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.players,
          aliasName: $_aliasNameGenerator(
              db.leaguePlayers.id, db.players.playerLeagueId));

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.playerLeagueId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LeaguePlayersTableFilterComposer
    extends Composer<_$Safirah, $LeaguePlayersTable> {
  $$LeaguePlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamPlayerCategoriesTableFilterComposer get teamPlayerCategoryId {
    final $$TeamPlayerCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamPlayerCategoryId,
        referencedTable: $db.teamPlayerCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamPlayerCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.teamPlayerCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> playersRefs(
      Expression<bool> Function($$PlayersTableFilterComposer f) f) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.playerLeagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeaguePlayersTableOrderingComposer
    extends Composer<_$Safirah, $LeaguePlayersTable> {
  $$LeaguePlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamPlayerCategoriesTableOrderingComposer get teamPlayerCategoryId {
    final $$TeamPlayerCategoriesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.teamPlayerCategoryId,
            referencedTable: $db.teamPlayerCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeamPlayerCategoriesTableOrderingComposer(
                  $db: $db,
                  $table: $db.teamPlayerCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LeaguePlayersTableAnnotationComposer
    extends Composer<_$Safirah, $LeaguePlayersTable> {
  $$LeaguePlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamPlayerCategoriesTableAnnotationComposer get teamPlayerCategoryId {
    final $$TeamPlayerCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.teamPlayerCategoryId,
            referencedTable: $db.teamPlayerCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeamPlayerCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.teamPlayerCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> playersRefs<T extends Object>(
      Expression<T> Function($$PlayersTableAnnotationComposer a) f) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.playerLeagueId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeaguePlayersTableTableManager extends RootTableManager<
    _$Safirah,
    $LeaguePlayersTable,
    LeaguePlayer,
    $$LeaguePlayersTableFilterComposer,
    $$LeaguePlayersTableOrderingComposer,
    $$LeaguePlayersTableAnnotationComposer,
    $$LeaguePlayersTableCreateCompanionBuilder,
    $$LeaguePlayersTableUpdateCompanionBuilder,
    (LeaguePlayer, $$LeaguePlayersTableReferences),
    LeaguePlayer,
    PrefetchHooks Function(
        {bool leagueId, bool teamPlayerCategoryId, bool playersRefs})> {
  $$LeaguePlayersTableTableManager(_$Safirah db, $LeaguePlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaguePlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaguePlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaguePlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int?> teamPlayerCategoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeaguePlayersCompanion(
            id: id,
            leagueId: leagueId,
            userId: userId,
            teamPlayerCategoryId: teamPlayerCategoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required int userId,
            Value<int?> teamPlayerCategoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeaguePlayersCompanion.insert(
            id: id,
            leagueId: leagueId,
            userId: userId,
            teamPlayerCategoryId: teamPlayerCategoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LeaguePlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false,
              teamPlayerCategoryId = false,
              playersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (playersRefs) db.players],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$LeaguePlayersTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$LeaguePlayersTableReferences._leagueIdTable(db).id,
                  ) as T;
                }
                if (teamPlayerCategoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamPlayerCategoryId,
                    referencedTable: $$LeaguePlayersTableReferences
                        ._teamPlayerCategoryIdTable(db),
                    referencedColumn: $$LeaguePlayersTableReferences
                        ._teamPlayerCategoryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LeaguePlayersTableReferences
                            ._playersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeaguePlayersTableReferences(db, table, p0)
                                .playersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.playerLeagueId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LeaguePlayersTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeaguePlayersTable,
    LeaguePlayer,
    $$LeaguePlayersTableFilterComposer,
    $$LeaguePlayersTableOrderingComposer,
    $$LeaguePlayersTableAnnotationComposer,
    $$LeaguePlayersTableCreateCompanionBuilder,
    $$LeaguePlayersTableUpdateCompanionBuilder,
    (LeaguePlayer, $$LeaguePlayersTableReferences),
    LeaguePlayer,
    PrefetchHooks Function(
        {bool leagueId, bool teamPlayerCategoryId, bool playersRefs})>;
typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  required int playerLeagueId,
  Value<int?> teamId,
  required String fullName,
  Value<String?> position,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<int> playerLeagueId,
  Value<int?> teamId,
  Value<String> fullName,
  Value<String?> position,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PlayersTableReferences
    extends BaseReferences<_$Safirah, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguePlayersTable _playerLeagueIdTable(_$Safirah db) =>
      db.leaguePlayers.createAlias(
          $_aliasNameGenerator(db.players.playerLeagueId, db.leaguePlayers.id));

  $$LeaguePlayersTableProcessedTableManager? get playerLeagueId {
    if ($_item.playerLeagueId == null) return null;
    final manager = $$LeaguePlayersTableTableManager($_db, $_db.leaguePlayers)
        .filter((f) => f.id($_item.playerLeagueId!));
    final item = $_typedResult.readTableOrNull(_playerLeagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _teamIdTable(_$Safirah db) => db.teams
      .createAlias($_aliasNameGenerator(db.players.teamId, db.teams.id));

  $$TeamsTableProcessedTableManager? get teamId {
    if ($_item.teamId == null) return null;
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id($_item.teamId!));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$WarningsTable, List<Warning>> _warningsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.warnings,
          aliasName: $_aliasNameGenerator(db.players.id, db.warnings.playerId));

  $$WarningsTableProcessedTableManager get warningsRefs {
    final manager = $$WarningsTableTableManager($_db, $_db.warnings)
        .filter((f) => f.playerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_warningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoalsTable, List<Goal>> _goalsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.goals,
          aliasName: $_aliasNameGenerator(db.players.id, db.goals.playerId));

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.playerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssistsTable, List<Assist>> _assistsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.assists,
          aliasName: $_aliasNameGenerator(db.players.id, db.assists.playerId));

  $$AssistsTableProcessedTableManager get assistsRefs {
    final manager = $$AssistsTableTableManager($_db, $_db.assists)
        .filter((f) => f.playerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_assistsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlayersTableFilterComposer extends Composer<_$Safirah, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguePlayersTableFilterComposer get playerLeagueId {
    final $$LeaguePlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerLeagueId,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableFilterComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get teamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> warningsRefs(
      Expression<bool> Function($$WarningsTableFilterComposer f) f) {
    final $$WarningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableFilterComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goalsRefs(
      Expression<bool> Function($$GoalsTableFilterComposer f) f) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> assistsRefs(
      Expression<bool> Function($$AssistsTableFilterComposer f) f) {
    final $$AssistsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableFilterComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$Safirah, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguePlayersTableOrderingComposer get playerLeagueId {
    final $$LeaguePlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerLeagueId,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableOrderingComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get teamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$Safirah, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguePlayersTableAnnotationComposer get playerLeagueId {
    final $$LeaguePlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerLeagueId,
        referencedTable: $db.leaguePlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguePlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.leaguePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get teamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> warningsRefs<T extends Object>(
      Expression<T> Function($$WarningsTableAnnotationComposer a) f) {
    final $$WarningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableAnnotationComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
      Expression<T> Function($$GoalsTableAnnotationComposer a) f) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> assistsRefs<T extends Object>(
      Expression<T> Function($$AssistsTableAnnotationComposer a) f) {
    final $$AssistsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableAnnotationComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlayersTableTableManager extends RootTableManager<
    _$Safirah,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, $$PlayersTableReferences),
    Player,
    PrefetchHooks Function(
        {bool playerLeagueId,
        bool teamId,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs})> {
  $$PlayersTableTableManager(_$Safirah db, $PlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> playerLeagueId = const Value.absent(),
            Value<int?> teamId = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> position = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            playerLeagueId: playerLeagueId,
            teamId: teamId,
            fullName: fullName,
            position: position,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int playerLeagueId,
            Value<int?> teamId = const Value.absent(),
            required String fullName,
            Value<String?> position = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            playerLeagueId: playerLeagueId,
            teamId: teamId,
            fullName: fullName,
            position: position,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlayersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {playerLeagueId = false,
              teamId = false,
              warningsRefs = false,
              goalsRefs = false,
              assistsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (warningsRefs) db.warnings,
                if (goalsRefs) db.goals,
                if (assistsRefs) db.assists
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (playerLeagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerLeagueId,
                    referencedTable:
                        $$PlayersTableReferences._playerLeagueIdTable(db),
                    referencedColumn:
                        $$PlayersTableReferences._playerLeagueIdTable(db).id,
                  ) as T;
                }
                if (teamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamId,
                    referencedTable: $$PlayersTableReferences._teamIdTable(db),
                    referencedColumn:
                        $$PlayersTableReferences._teamIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (warningsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PlayersTableReferences._warningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlayersTableReferences(db, table, p0)
                                .warningsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items),
                  if (goalsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PlayersTableReferences._goalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlayersTableReferences(db, table, p0).goalsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items),
                  if (assistsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PlayersTableReferences._assistsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlayersTableReferences(db, table, p0).assistsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlayersTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, $$PlayersTableReferences),
    Player,
    PrefetchHooks Function(
        {bool playerLeagueId,
        bool teamId,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs})>;
typedef $$DraftProgressTableCreateCompanionBuilder = DraftProgressCompanion
    Function({
  Value<int> leagueId,
  Value<String> catsJson,
  Value<String> unassignedJson,
  Value<String> currentName,
  Value<String> currentPickJson,
  Value<DateTime> updatedAt,
});
typedef $$DraftProgressTableUpdateCompanionBuilder = DraftProgressCompanion
    Function({
  Value<int> leagueId,
  Value<String> catsJson,
  Value<String> unassignedJson,
  Value<String> currentName,
  Value<String> currentPickJson,
  Value<DateTime> updatedAt,
});

class $$DraftProgressTableFilterComposer
    extends Composer<_$Safirah, $DraftProgressTable> {
  $$DraftProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get leagueId => $composableBuilder(
      column: $table.leagueId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get catsJson => $composableBuilder(
      column: $table.catsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unassignedJson => $composableBuilder(
      column: $table.unassignedJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentName => $composableBuilder(
      column: $table.currentName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentPickJson => $composableBuilder(
      column: $table.currentPickJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DraftProgressTableOrderingComposer
    extends Composer<_$Safirah, $DraftProgressTable> {
  $$DraftProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get leagueId => $composableBuilder(
      column: $table.leagueId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get catsJson => $composableBuilder(
      column: $table.catsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unassignedJson => $composableBuilder(
      column: $table.unassignedJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentName => $composableBuilder(
      column: $table.currentName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentPickJson => $composableBuilder(
      column: $table.currentPickJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DraftProgressTableAnnotationComposer
    extends Composer<_$Safirah, $DraftProgressTable> {
  $$DraftProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get leagueId =>
      $composableBuilder(column: $table.leagueId, builder: (column) => column);

  GeneratedColumn<String> get catsJson =>
      $composableBuilder(column: $table.catsJson, builder: (column) => column);

  GeneratedColumn<String> get unassignedJson => $composableBuilder(
      column: $table.unassignedJson, builder: (column) => column);

  GeneratedColumn<String> get currentName => $composableBuilder(
      column: $table.currentName, builder: (column) => column);

  GeneratedColumn<String> get currentPickJson => $composableBuilder(
      column: $table.currentPickJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DraftProgressTableTableManager extends RootTableManager<
    _$Safirah,
    $DraftProgressTable,
    DraftProgressData,
    $$DraftProgressTableFilterComposer,
    $$DraftProgressTableOrderingComposer,
    $$DraftProgressTableAnnotationComposer,
    $$DraftProgressTableCreateCompanionBuilder,
    $$DraftProgressTableUpdateCompanionBuilder,
    (
      DraftProgressData,
      BaseReferences<_$Safirah, $DraftProgressTable, DraftProgressData>
    ),
    DraftProgressData,
    PrefetchHooks Function()> {
  $$DraftProgressTableTableManager(_$Safirah db, $DraftProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> leagueId = const Value.absent(),
            Value<String> catsJson = const Value.absent(),
            Value<String> unassignedJson = const Value.absent(),
            Value<String> currentName = const Value.absent(),
            Value<String> currentPickJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DraftProgressCompanion(
            leagueId: leagueId,
            catsJson: catsJson,
            unassignedJson: unassignedJson,
            currentName: currentName,
            currentPickJson: currentPickJson,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> leagueId = const Value.absent(),
            Value<String> catsJson = const Value.absent(),
            Value<String> unassignedJson = const Value.absent(),
            Value<String> currentName = const Value.absent(),
            Value<String> currentPickJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DraftProgressCompanion.insert(
            leagueId: leagueId,
            catsJson: catsJson,
            unassignedJson: unassignedJson,
            currentName: currentName,
            currentPickJson: currentPickJson,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DraftProgressTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $DraftProgressTable,
    DraftProgressData,
    $$DraftProgressTableFilterComposer,
    $$DraftProgressTableOrderingComposer,
    $$DraftProgressTableAnnotationComposer,
    $$DraftProgressTableCreateCompanionBuilder,
    $$DraftProgressTableUpdateCompanionBuilder,
    (
      DraftProgressData,
      BaseReferences<_$Safirah, $DraftProgressTable, DraftProgressData>
    ),
    DraftProgressData,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String entityType,
  required int entityId,
  required String operation,
  required String payload,
  Value<bool> synced,
  Value<DateTime> createdAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<int> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<bool> synced,
  Value<DateTime> createdAt,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$Safirah, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$Safirah, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$Safirah, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$Safirah,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, BaseReferences<_$Safirah, $SyncQueueTable, SyncQueueData>),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$Safirah db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<int> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            synced: synced,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required int entityId,
            required String operation,
            required String payload,
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            synced: synced,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, BaseReferences<_$Safirah, $SyncQueueTable, SyncQueueData>),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$GroupTableCreateCompanionBuilder = GroupCompanion Function({
  Value<int> id,
  required int leagueId,
  required String groupName,
  Value<DateTime> createdAt,
  Value<int> qualifiedTeamNumber,
});
typedef $$GroupTableUpdateCompanionBuilder = GroupCompanion Function({
  Value<int> id,
  Value<int> leagueId,
  Value<String> groupName,
  Value<DateTime> createdAt,
  Value<int> qualifiedTeamNumber,
});

final class $$GroupTableReferences
    extends BaseReferences<_$Safirah, $GroupTable, GroupData> {
  $$GroupTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues
      .createAlias($_aliasNameGenerator(db.group.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GroupTeamTable, List<GroupTeamData>>
      _groupTeamRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.groupTeam,
          aliasName: $_aliasNameGenerator(db.group.id, db.groupTeam.groupId));

  $$GroupTeamTableProcessedTableManager get groupTeamRefs {
    final manager = $$GroupTeamTableTableManager($_db, $_db.groupTeam)
        .filter((f) => f.groupId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_groupTeamRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RoundsTable, List<Round>> _roundsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.rounds,
          aliasName: $_aliasNameGenerator(db.group.id, db.rounds.groupId));

  $$RoundsTableProcessedTableManager get roundsRefs {
    final manager = $$RoundsTableTableManager($_db, $_db.rounds)
        .filter((f) => f.groupId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_roundsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QualifiedTeamTable, List<QualifiedTeamData>>
      _qualifiedTeamRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.qualifiedTeam,
              aliasName:
                  $_aliasNameGenerator(db.group.id, db.qualifiedTeam.groupId));

  $$QualifiedTeamTableProcessedTableManager get qualifiedTeamRefs {
    final manager = $$QualifiedTeamTableTableManager($_db, $_db.qualifiedTeam)
        .filter((f) => f.groupId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_qualifiedTeamRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GroupTableFilterComposer extends Composer<_$Safirah, $GroupTable> {
  $$GroupTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber,
      builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> groupTeamRefs(
      Expression<bool> Function($$GroupTeamTableFilterComposer f) f) {
    final $$GroupTeamTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupTeam,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTeamTableFilterComposer(
              $db: $db,
              $table: $db.groupTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> roundsRefs(
      Expression<bool> Function($$RoundsTableFilterComposer f) f) {
    final $$RoundsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableFilterComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> qualifiedTeamRefs(
      Expression<bool> Function($$QualifiedTeamTableFilterComposer f) f) {
    final $$QualifiedTeamTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableFilterComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupTableOrderingComposer extends Composer<_$Safirah, $GroupTable> {
  $$GroupTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber,
      builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupTableAnnotationComposer extends Composer<_$Safirah, $GroupTable> {
  $$GroupTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> groupTeamRefs<T extends Object>(
      Expression<T> Function($$GroupTeamTableAnnotationComposer a) f) {
    final $$GroupTeamTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupTeam,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTeamTableAnnotationComposer(
              $db: $db,
              $table: $db.groupTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> roundsRefs<T extends Object>(
      Expression<T> Function($$RoundsTableAnnotationComposer a) f) {
    final $$RoundsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableAnnotationComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> qualifiedTeamRefs<T extends Object>(
      Expression<T> Function($$QualifiedTeamTableAnnotationComposer a) f) {
    final $$QualifiedTeamTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.qualifiedTeam,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QualifiedTeamTableAnnotationComposer(
              $db: $db,
              $table: $db.qualifiedTeam,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupTableTableManager extends RootTableManager<
    _$Safirah,
    $GroupTable,
    GroupData,
    $$GroupTableFilterComposer,
    $$GroupTableOrderingComposer,
    $$GroupTableAnnotationComposer,
    $$GroupTableCreateCompanionBuilder,
    $$GroupTableUpdateCompanionBuilder,
    (GroupData, $$GroupTableReferences),
    GroupData,
    PrefetchHooks Function(
        {bool leagueId,
        bool groupTeamRefs,
        bool roundsRefs,
        bool qualifiedTeamRefs})> {
  $$GroupTableTableManager(_$Safirah db, $GroupTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> qualifiedTeamNumber = const Value.absent(),
          }) =>
              GroupCompanion(
            id: id,
            leagueId: leagueId,
            groupName: groupName,
            createdAt: createdAt,
            qualifiedTeamNumber: qualifiedTeamNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required String groupName,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> qualifiedTeamNumber = const Value.absent(),
          }) =>
              GroupCompanion.insert(
            id: id,
            leagueId: leagueId,
            groupName: groupName,
            createdAt: createdAt,
            qualifiedTeamNumber: qualifiedTeamNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GroupTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false,
              groupTeamRefs = false,
              roundsRefs = false,
              qualifiedTeamRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupTeamRefs) db.groupTeam,
                if (roundsRefs) db.rounds,
                if (qualifiedTeamRefs) db.qualifiedTeam
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable: $$GroupTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$GroupTableReferences._leagueIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupTeamRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$GroupTableReferences._groupTeamRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupTableReferences(db, table, p0).groupTeamRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items),
                  if (roundsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$GroupTableReferences._roundsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupTableReferences(db, table, p0).roundsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items),
                  if (qualifiedTeamRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$GroupTableReferences._qualifiedTeamRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupTableReferences(db, table, p0)
                                .qualifiedTeamRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GroupTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $GroupTable,
    GroupData,
    $$GroupTableFilterComposer,
    $$GroupTableOrderingComposer,
    $$GroupTableAnnotationComposer,
    $$GroupTableCreateCompanionBuilder,
    $$GroupTableUpdateCompanionBuilder,
    (GroupData, $$GroupTableReferences),
    GroupData,
    PrefetchHooks Function(
        {bool leagueId,
        bool groupTeamRefs,
        bool roundsRefs,
        bool qualifiedTeamRefs})>;
typedef $$GroupTeamTableCreateCompanionBuilder = GroupTeamCompanion Function({
  Value<int> id,
  required int groupId,
  required int teamId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$GroupTeamTableUpdateCompanionBuilder = GroupTeamCompanion Function({
  Value<int> id,
  Value<int> groupId,
  Value<int> teamId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$GroupTeamTableReferences
    extends BaseReferences<_$Safirah, $GroupTeamTable, GroupTeamData> {
  $$GroupTeamTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupTable _groupIdTable(_$Safirah db) => db.group
      .createAlias($_aliasNameGenerator(db.groupTeam.groupId, db.group.id));

  $$GroupTableProcessedTableManager? get groupId {
    if ($_item.groupId == null) return null;
    final manager = $$GroupTableTableManager($_db, $_db.group)
        .filter((f) => f.id($_item.groupId!));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _teamIdTable(_$Safirah db) => db.teams
      .createAlias($_aliasNameGenerator(db.groupTeam.teamId, db.teams.id));

  $$TeamsTableProcessedTableManager? get teamId {
    if ($_item.teamId == null) return null;
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id($_item.teamId!));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GroupTeamTableFilterComposer
    extends Composer<_$Safirah, $GroupTeamTable> {
  $$GroupTeamTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$GroupTableFilterComposer get groupId {
    final $$GroupTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableFilterComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get teamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupTeamTableOrderingComposer
    extends Composer<_$Safirah, $GroupTeamTable> {
  $$GroupTeamTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$GroupTableOrderingComposer get groupId {
    final $$GroupTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableOrderingComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get teamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupTeamTableAnnotationComposer
    extends Composer<_$Safirah, $GroupTeamTable> {
  $$GroupTeamTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GroupTableAnnotationComposer get groupId {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableAnnotationComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get teamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupTeamTableTableManager extends RootTableManager<
    _$Safirah,
    $GroupTeamTable,
    GroupTeamData,
    $$GroupTeamTableFilterComposer,
    $$GroupTeamTableOrderingComposer,
    $$GroupTeamTableAnnotationComposer,
    $$GroupTeamTableCreateCompanionBuilder,
    $$GroupTeamTableUpdateCompanionBuilder,
    (GroupTeamData, $$GroupTeamTableReferences),
    GroupTeamData,
    PrefetchHooks Function({bool groupId, bool teamId})> {
  $$GroupTeamTableTableManager(_$Safirah db, $GroupTeamTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupTeamTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupTeamTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupTeamTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> groupId = const Value.absent(),
            Value<int> teamId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              GroupTeamCompanion(
            id: id,
            groupId: groupId,
            teamId: teamId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int groupId,
            required int teamId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              GroupTeamCompanion.insert(
            id: id,
            groupId: groupId,
            teamId: teamId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GroupTeamTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({groupId = false, teamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$GroupTeamTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$GroupTeamTableReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (teamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamId,
                    referencedTable:
                        $$GroupTeamTableReferences._teamIdTable(db),
                    referencedColumn:
                        $$GroupTeamTableReferences._teamIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GroupTeamTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $GroupTeamTable,
    GroupTeamData,
    $$GroupTeamTableFilterComposer,
    $$GroupTeamTableOrderingComposer,
    $$GroupTeamTableAnnotationComposer,
    $$GroupTeamTableCreateCompanionBuilder,
    $$GroupTeamTableUpdateCompanionBuilder,
    (GroupTeamData, $$GroupTeamTableReferences),
    GroupTeamData,
    PrefetchHooks Function({bool groupId, bool teamId})>;
typedef $$RoundsTableCreateCompanionBuilder = RoundsCompanion Function({
  Value<int> id,
  required int leagueId,
  required String name,
  Value<int?> groupId,
  required String roundType,
  Value<DateTime> createdAt,
});
typedef $$RoundsTableUpdateCompanionBuilder = RoundsCompanion Function({
  Value<int> id,
  Value<int> leagueId,
  Value<String> name,
  Value<int?> groupId,
  Value<String> roundType,
  Value<DateTime> createdAt,
});

final class $$RoundsTableReferences
    extends BaseReferences<_$Safirah, $RoundsTable, Round> {
  $$RoundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues
      .createAlias($_aliasNameGenerator(db.rounds.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GroupTable _groupIdTable(_$Safirah db) => db.group
      .createAlias($_aliasNameGenerator(db.rounds.groupId, db.group.id));

  $$GroupTableProcessedTableManager? get groupId {
    if ($_item.groupId == null) return null;
    final manager = $$GroupTableTableManager($_db, $_db.group)
        .filter((f) => f.id($_item.groupId!));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MatchesTable, List<Matche>> _matchesRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.matches,
          aliasName: $_aliasNameGenerator(db.rounds.id, db.matches.roundId));

  $$MatchesTableProcessedTableManager get matchesRefs {
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.roundId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_matchesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoundsTableFilterComposer extends Composer<_$Safirah, $RoundsTable> {
  $$RoundsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roundType => $composableBuilder(
      column: $table.roundType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableFilterComposer get groupId {
    final $$GroupTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableFilterComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> matchesRefs(
      Expression<bool> Function($$MatchesTableFilterComposer f) f) {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.roundId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoundsTableOrderingComposer extends Composer<_$Safirah, $RoundsTable> {
  $$RoundsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roundType => $composableBuilder(
      column: $table.roundType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableOrderingComposer get groupId {
    final $$GroupTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableOrderingComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RoundsTableAnnotationComposer
    extends Composer<_$Safirah, $RoundsTable> {
  $$RoundsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get roundType =>
      $composableBuilder(column: $table.roundType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableAnnotationComposer get groupId {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableAnnotationComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> matchesRefs<T extends Object>(
      Expression<T> Function($$MatchesTableAnnotationComposer a) f) {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.roundId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoundsTableTableManager extends RootTableManager<
    _$Safirah,
    $RoundsTable,
    Round,
    $$RoundsTableFilterComposer,
    $$RoundsTableOrderingComposer,
    $$RoundsTableAnnotationComposer,
    $$RoundsTableCreateCompanionBuilder,
    $$RoundsTableUpdateCompanionBuilder,
    (Round, $$RoundsTableReferences),
    Round,
    PrefetchHooks Function({bool leagueId, bool groupId, bool matchesRefs})> {
  $$RoundsTableTableManager(_$Safirah db, $RoundsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> groupId = const Value.absent(),
            Value<String> roundType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RoundsCompanion(
            id: id,
            leagueId: leagueId,
            name: name,
            groupId: groupId,
            roundType: roundType,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required String name,
            Value<int?> groupId = const Value.absent(),
            required String roundType,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RoundsCompanion.insert(
            id: id,
            leagueId: leagueId,
            name: name,
            groupId: groupId,
            roundType: roundType,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RoundsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false, groupId = false, matchesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchesRefs) db.matches],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable: $$RoundsTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$RoundsTableReferences._leagueIdTable(db).id,
                  ) as T;
                }
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable: $$RoundsTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$RoundsTableReferences._groupIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$RoundsTableReferences._matchesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoundsTableReferences(db, table, p0).matchesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roundId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoundsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $RoundsTable,
    Round,
    $$RoundsTableFilterComposer,
    $$RoundsTableOrderingComposer,
    $$RoundsTableAnnotationComposer,
    $$RoundsTableCreateCompanionBuilder,
    $$RoundsTableUpdateCompanionBuilder,
    (Round, $$RoundsTableReferences),
    Round,
    PrefetchHooks Function({bool leagueId, bool groupId, bool matchesRefs})>;
typedef $$MatchesTableCreateCompanionBuilder = MatchesCompanion Function({
  Value<int> id,
  required int leagueId,
  required int roundId,
  required int homeTeamId,
  required int awayTeamId,
  required DateTime matchDate,
  Value<DateTime?> scheduledStartTime,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> homeScore,
  Value<int> awayScore,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MatchesTableUpdateCompanionBuilder = MatchesCompanion Function({
  Value<int> id,
  Value<int> leagueId,
  Value<int> roundId,
  Value<int> homeTeamId,
  Value<int> awayTeamId,
  Value<DateTime> matchDate,
  Value<DateTime?> scheduledStartTime,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> homeScore,
  Value<int> awayScore,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$MatchesTableReferences
    extends BaseReferences<_$Safirah, $MatchesTable, Matche> {
  $$MatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues
      .createAlias($_aliasNameGenerator(db.matches.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoundsTable _roundIdTable(_$Safirah db) => db.rounds
      .createAlias($_aliasNameGenerator(db.matches.roundId, db.rounds.id));

  $$RoundsTableProcessedTableManager? get roundId {
    if ($_item.roundId == null) return null;
    final manager = $$RoundsTableTableManager($_db, $_db.rounds)
        .filter((f) => f.id($_item.roundId!));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _homeTeamIdTable(_$Safirah db) => db.teams
      .createAlias($_aliasNameGenerator(db.matches.homeTeamId, db.teams.id));

  $$TeamsTableProcessedTableManager? get homeTeamId {
    if ($_item.homeTeamId == null) return null;
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id($_item.homeTeamId!));
    final item = $_typedResult.readTableOrNull(_homeTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _awayTeamIdTable(_$Safirah db) => db.teams
      .createAlias($_aliasNameGenerator(db.matches.awayTeamId, db.teams.id));

  $$TeamsTableProcessedTableManager? get awayTeamId {
    if ($_item.awayTeamId == null) return null;
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id($_item.awayTeamId!));
    final item = $_typedResult.readTableOrNull(_awayTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MatchTermsTable, List<MatchTerm>>
      _matchTermsRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.matchTerms,
              aliasName:
                  $_aliasNameGenerator(db.matches.id, db.matchTerms.matchId));

  $$MatchTermsTableProcessedTableManager get matchTermsRefs {
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.matchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_matchTermsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WarningsTable, List<Warning>> _warningsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.warnings,
          aliasName: $_aliasNameGenerator(db.matches.id, db.warnings.matchId));

  $$WarningsTableProcessedTableManager get warningsRefs {
    final manager = $$WarningsTableTableManager($_db, $_db.warnings)
        .filter((f) => f.matchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_warningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoalsTable, List<Goal>> _goalsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.goals,
          aliasName: $_aliasNameGenerator(db.matches.id, db.goals.matchId));

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.matchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssistsTable, List<Assist>> _assistsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.assists,
          aliasName: $_aliasNameGenerator(db.matches.id, db.assists.matchId));

  $$AssistsTableProcessedTableManager get assistsRefs {
    final manager = $$AssistsTableTableManager($_db, $_db.assists)
        .filter((f) => f.matchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_assistsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlayerMatchParticipationTable,
      List<PlayerMatchParticipationData>> _playerMatchParticipationRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.playerMatchParticipation,
          aliasName: $_aliasNameGenerator(
              db.matches.id, db.playerMatchParticipation.matchId));

  $$PlayerMatchParticipationTableProcessedTableManager
      get playerMatchParticipationRefs {
    final manager = $$PlayerMatchParticipationTableTableManager(
            $_db, $_db.playerMatchParticipation)
        .filter((f) => f.matchId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_playerMatchParticipationRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MatchesTableFilterComposer extends Composer<_$Safirah, $MatchesTable> {
  $$MatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get matchDate => $composableBuilder(
      column: $table.matchDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledStartTime => $composableBuilder(
      column: $table.scheduledStartTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get homeScore => $composableBuilder(
      column: $table.homeScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get awayScore => $composableBuilder(
      column: $table.awayScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoundsTableFilterComposer get roundId {
    final $$RoundsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableFilterComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get homeTeamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.homeTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get awayTeamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.awayTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> matchTermsRefs(
      Expression<bool> Function($$MatchTermsTableFilterComposer f) f) {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> warningsRefs(
      Expression<bool> Function($$WarningsTableFilterComposer f) f) {
    final $$WarningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableFilterComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goalsRefs(
      Expression<bool> Function($$GoalsTableFilterComposer f) f) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> assistsRefs(
      Expression<bool> Function($$AssistsTableFilterComposer f) f) {
    final $$AssistsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableFilterComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> playerMatchParticipationRefs(
      Expression<bool> Function($$PlayerMatchParticipationTableFilterComposer f)
          f) {
    final $$PlayerMatchParticipationTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.playerMatchParticipation,
            getReferencedColumn: (t) => t.matchId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerMatchParticipationTableFilterComposer(
                  $db: $db,
                  $table: $db.playerMatchParticipation,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MatchesTableOrderingComposer
    extends Composer<_$Safirah, $MatchesTable> {
  $$MatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get matchDate => $composableBuilder(
      column: $table.matchDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledStartTime => $composableBuilder(
      column: $table.scheduledStartTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get homeScore => $composableBuilder(
      column: $table.homeScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get awayScore => $composableBuilder(
      column: $table.awayScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoundsTableOrderingComposer get roundId {
    final $$RoundsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableOrderingComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get homeTeamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.homeTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get awayTeamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.awayTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$Safirah, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get matchDate =>
      $composableBuilder(column: $table.matchDate, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledStartTime => $composableBuilder(
      column: $table.scheduledStartTime, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get homeScore =>
      $composableBuilder(column: $table.homeScore, builder: (column) => column);

  GeneratedColumn<int> get awayScore =>
      $composableBuilder(column: $table.awayScore, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoundsTableAnnotationComposer get roundId {
    final $$RoundsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roundId,
        referencedTable: $db.rounds,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoundsTableAnnotationComposer(
              $db: $db,
              $table: $db.rounds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get homeTeamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.homeTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get awayTeamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.awayTeamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> matchTermsRefs<T extends Object>(
      Expression<T> Function($$MatchTermsTableAnnotationComposer a) f) {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> warningsRefs<T extends Object>(
      Expression<T> Function($$WarningsTableAnnotationComposer a) f) {
    final $$WarningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableAnnotationComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
      Expression<T> Function($$GoalsTableAnnotationComposer a) f) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> assistsRefs<T extends Object>(
      Expression<T> Function($$AssistsTableAnnotationComposer a) f) {
    final $$AssistsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableAnnotationComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> playerMatchParticipationRefs<T extends Object>(
      Expression<T> Function(
              $$PlayerMatchParticipationTableAnnotationComposer a)
          f) {
    final $$PlayerMatchParticipationTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.playerMatchParticipation,
            getReferencedColumn: (t) => t.matchId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerMatchParticipationTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playerMatchParticipation,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MatchesTableTableManager extends RootTableManager<
    _$Safirah,
    $MatchesTable,
    Matche,
    $$MatchesTableFilterComposer,
    $$MatchesTableOrderingComposer,
    $$MatchesTableAnnotationComposer,
    $$MatchesTableCreateCompanionBuilder,
    $$MatchesTableUpdateCompanionBuilder,
    (Matche, $$MatchesTableReferences),
    Matche,
    PrefetchHooks Function(
        {bool leagueId,
        bool roundId,
        bool homeTeamId,
        bool awayTeamId,
        bool matchTermsRefs,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs,
        bool playerMatchParticipationRefs})> {
  $$MatchesTableTableManager(_$Safirah db, $MatchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<int> roundId = const Value.absent(),
            Value<int> homeTeamId = const Value.absent(),
            Value<int> awayTeamId = const Value.absent(),
            Value<DateTime> matchDate = const Value.absent(),
            Value<DateTime?> scheduledStartTime = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> homeScore = const Value.absent(),
            Value<int> awayScore = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MatchesCompanion(
            id: id,
            leagueId: leagueId,
            roundId: roundId,
            homeTeamId: homeTeamId,
            awayTeamId: awayTeamId,
            matchDate: matchDate,
            scheduledStartTime: scheduledStartTime,
            startTime: startTime,
            endTime: endTime,
            homeScore: homeScore,
            awayScore: awayScore,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required int roundId,
            required int homeTeamId,
            required int awayTeamId,
            required DateTime matchDate,
            Value<DateTime?> scheduledStartTime = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> homeScore = const Value.absent(),
            Value<int> awayScore = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MatchesCompanion.insert(
            id: id,
            leagueId: leagueId,
            roundId: roundId,
            homeTeamId: homeTeamId,
            awayTeamId: awayTeamId,
            matchDate: matchDate,
            scheduledStartTime: scheduledStartTime,
            startTime: startTime,
            endTime: endTime,
            homeScore: homeScore,
            awayScore: awayScore,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MatchesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false,
              roundId = false,
              homeTeamId = false,
              awayTeamId = false,
              matchTermsRefs = false,
              warningsRefs = false,
              goalsRefs = false,
              assistsRefs = false,
              playerMatchParticipationRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (matchTermsRefs) db.matchTerms,
                if (warningsRefs) db.warnings,
                if (goalsRefs) db.goals,
                if (assistsRefs) db.assists,
                if (playerMatchParticipationRefs) db.playerMatchParticipation
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$MatchesTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$MatchesTableReferences._leagueIdTable(db).id,
                  ) as T;
                }
                if (roundId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roundId,
                    referencedTable: $$MatchesTableReferences._roundIdTable(db),
                    referencedColumn:
                        $$MatchesTableReferences._roundIdTable(db).id,
                  ) as T;
                }
                if (homeTeamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.homeTeamId,
                    referencedTable:
                        $$MatchesTableReferences._homeTeamIdTable(db),
                    referencedColumn:
                        $$MatchesTableReferences._homeTeamIdTable(db).id,
                  ) as T;
                }
                if (awayTeamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.awayTeamId,
                    referencedTable:
                        $$MatchesTableReferences._awayTeamIdTable(db),
                    referencedColumn:
                        $$MatchesTableReferences._awayTeamIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchTermsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchesTableReferences._matchTermsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0)
                                .matchTermsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items),
                  if (warningsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchesTableReferences._warningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0)
                                .warningsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items),
                  if (goalsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchesTableReferences._goalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0).goalsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items),
                  if (assistsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchesTableReferences._assistsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0).assistsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items),
                  if (playerMatchParticipationRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MatchesTableReferences
                            ._playerMatchParticipationRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0)
                                .playerMatchParticipationRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MatchesTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $MatchesTable,
    Matche,
    $$MatchesTableFilterComposer,
    $$MatchesTableOrderingComposer,
    $$MatchesTableAnnotationComposer,
    $$MatchesTableCreateCompanionBuilder,
    $$MatchesTableUpdateCompanionBuilder,
    (Matche, $$MatchesTableReferences),
    Matche,
    PrefetchHooks Function(
        {bool leagueId,
        bool roundId,
        bool homeTeamId,
        bool awayTeamId,
        bool matchTermsRefs,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs,
        bool playerMatchParticipationRefs})>;
typedef $$QualifiedTeamTableCreateCompanionBuilder = QualifiedTeamCompanion
    Function({
  Value<int> id,
  required int leagueId,
  required int groupId,
  required int teamId,
  Value<int> played,
  Value<int> wins,
  Value<int> draws,
  Value<int> losses,
  Value<int> goalsFor,
  Value<int> goalsAgainst,
  Value<int> points,
  Value<String?> qualificationType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$QualifiedTeamTableUpdateCompanionBuilder = QualifiedTeamCompanion
    Function({
  Value<int> id,
  Value<int> leagueId,
  Value<int> groupId,
  Value<int> teamId,
  Value<int> played,
  Value<int> wins,
  Value<int> draws,
  Value<int> losses,
  Value<int> goalsFor,
  Value<int> goalsAgainst,
  Value<int> points,
  Value<String?> qualificationType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$QualifiedTeamTableReferences
    extends BaseReferences<_$Safirah, $QualifiedTeamTable, QualifiedTeamData> {
  $$QualifiedTeamTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.qualifiedTeam.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GroupTable _groupIdTable(_$Safirah db) => db.group
      .createAlias($_aliasNameGenerator(db.qualifiedTeam.groupId, db.group.id));

  $$GroupTableProcessedTableManager? get groupId {
    if ($_item.groupId == null) return null;
    final manager = $$GroupTableTableManager($_db, $_db.group)
        .filter((f) => f.id($_item.groupId!));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamsTable _teamIdTable(_$Safirah db) => db.teams
      .createAlias($_aliasNameGenerator(db.qualifiedTeam.teamId, db.teams.id));

  $$TeamsTableProcessedTableManager? get teamId {
    if ($_item.teamId == null) return null;
    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id($_item.teamId!));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QualifiedTeamTableFilterComposer
    extends Composer<_$Safirah, $QualifiedTeamTable> {
  $$QualifiedTeamTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get played => $composableBuilder(
      column: $table.played, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wins => $composableBuilder(
      column: $table.wins, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get draws => $composableBuilder(
      column: $table.draws, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get losses => $composableBuilder(
      column: $table.losses, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalsFor => $composableBuilder(
      column: $table.goalsFor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalsAgainst => $composableBuilder(
      column: $table.goalsAgainst, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qualificationType => $composableBuilder(
      column: $table.qualificationType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableFilterComposer get groupId {
    final $$GroupTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableFilterComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableFilterComposer get teamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QualifiedTeamTableOrderingComposer
    extends Composer<_$Safirah, $QualifiedTeamTable> {
  $$QualifiedTeamTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get played => $composableBuilder(
      column: $table.played, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wins => $composableBuilder(
      column: $table.wins, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get draws => $composableBuilder(
      column: $table.draws, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get losses => $composableBuilder(
      column: $table.losses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalsFor => $composableBuilder(
      column: $table.goalsFor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalsAgainst => $composableBuilder(
      column: $table.goalsAgainst,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qualificationType => $composableBuilder(
      column: $table.qualificationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableOrderingComposer get groupId {
    final $$GroupTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableOrderingComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableOrderingComposer get teamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QualifiedTeamTableAnnotationComposer
    extends Composer<_$Safirah, $QualifiedTeamTable> {
  $$QualifiedTeamTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get played =>
      $composableBuilder(column: $table.played, builder: (column) => column);

  GeneratedColumn<int> get wins =>
      $composableBuilder(column: $table.wins, builder: (column) => column);

  GeneratedColumn<int> get draws =>
      $composableBuilder(column: $table.draws, builder: (column) => column);

  GeneratedColumn<int> get losses =>
      $composableBuilder(column: $table.losses, builder: (column) => column);

  GeneratedColumn<int> get goalsFor =>
      $composableBuilder(column: $table.goalsFor, builder: (column) => column);

  GeneratedColumn<int> get goalsAgainst => $composableBuilder(
      column: $table.goalsAgainst, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get qualificationType => $composableBuilder(
      column: $table.qualificationType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupTableAnnotationComposer get groupId {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.group,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupTableAnnotationComposer(
              $db: $db,
              $table: $db.group,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamsTableAnnotationComposer get teamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QualifiedTeamTableTableManager extends RootTableManager<
    _$Safirah,
    $QualifiedTeamTable,
    QualifiedTeamData,
    $$QualifiedTeamTableFilterComposer,
    $$QualifiedTeamTableOrderingComposer,
    $$QualifiedTeamTableAnnotationComposer,
    $$QualifiedTeamTableCreateCompanionBuilder,
    $$QualifiedTeamTableUpdateCompanionBuilder,
    (QualifiedTeamData, $$QualifiedTeamTableReferences),
    QualifiedTeamData,
    PrefetchHooks Function({bool leagueId, bool groupId, bool teamId})> {
  $$QualifiedTeamTableTableManager(_$Safirah db, $QualifiedTeamTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QualifiedTeamTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QualifiedTeamTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QualifiedTeamTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<int> groupId = const Value.absent(),
            Value<int> teamId = const Value.absent(),
            Value<int> played = const Value.absent(),
            Value<int> wins = const Value.absent(),
            Value<int> draws = const Value.absent(),
            Value<int> losses = const Value.absent(),
            Value<int> goalsFor = const Value.absent(),
            Value<int> goalsAgainst = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<String?> qualificationType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              QualifiedTeamCompanion(
            id: id,
            leagueId: leagueId,
            groupId: groupId,
            teamId: teamId,
            played: played,
            wins: wins,
            draws: draws,
            losses: losses,
            goalsFor: goalsFor,
            goalsAgainst: goalsAgainst,
            points: points,
            qualificationType: qualificationType,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required int groupId,
            required int teamId,
            Value<int> played = const Value.absent(),
            Value<int> wins = const Value.absent(),
            Value<int> draws = const Value.absent(),
            Value<int> losses = const Value.absent(),
            Value<int> goalsFor = const Value.absent(),
            Value<int> goalsAgainst = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<String?> qualificationType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              QualifiedTeamCompanion.insert(
            id: id,
            leagueId: leagueId,
            groupId: groupId,
            teamId: teamId,
            played: played,
            wins: wins,
            draws: draws,
            losses: losses,
            goalsFor: goalsFor,
            goalsAgainst: goalsAgainst,
            points: points,
            qualificationType: qualificationType,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$QualifiedTeamTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false, groupId = false, teamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$QualifiedTeamTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$QualifiedTeamTableReferences._leagueIdTable(db).id,
                  ) as T;
                }
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$QualifiedTeamTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$QualifiedTeamTableReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (teamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamId,
                    referencedTable:
                        $$QualifiedTeamTableReferences._teamIdTable(db),
                    referencedColumn:
                        $$QualifiedTeamTableReferences._teamIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QualifiedTeamTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $QualifiedTeamTable,
    QualifiedTeamData,
    $$QualifiedTeamTableFilterComposer,
    $$QualifiedTeamTableOrderingComposer,
    $$QualifiedTeamTableAnnotationComposer,
    $$QualifiedTeamTableCreateCompanionBuilder,
    $$QualifiedTeamTableUpdateCompanionBuilder,
    (QualifiedTeamData, $$QualifiedTeamTableReferences),
    QualifiedTeamData,
    PrefetchHooks Function({bool leagueId, bool groupId, bool teamId})>;
typedef $$LeagueStatusTableCreateCompanionBuilder = LeagueStatusCompanion
    Function({
  Value<int> leagueId,
  Value<bool> hasGroups,
  Value<bool> hasTeamsInGroups,
  Value<bool> hasMatches,
  Value<bool> hasPlayersAssigned,
  Value<DateTime?> updatedAt,
});
typedef $$LeagueStatusTableUpdateCompanionBuilder = LeagueStatusCompanion
    Function({
  Value<int> leagueId,
  Value<bool> hasGroups,
  Value<bool> hasTeamsInGroups,
  Value<bool> hasMatches,
  Value<bool> hasPlayersAssigned,
  Value<DateTime?> updatedAt,
});

final class $$LeagueStatusTableReferences
    extends BaseReferences<_$Safirah, $LeagueStatusTable, LeagueStatusData> {
  $$LeagueStatusTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.leagueStatus.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LeagueStatusTableFilterComposer
    extends Composer<_$Safirah, $LeagueStatusTable> {
  $$LeagueStatusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get hasGroups => $composableBuilder(
      column: $table.hasGroups, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasTeamsInGroups => $composableBuilder(
      column: $table.hasTeamsInGroups,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasMatches => $composableBuilder(
      column: $table.hasMatches, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasPlayersAssigned => $composableBuilder(
      column: $table.hasPlayersAssigned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueStatusTableOrderingComposer
    extends Composer<_$Safirah, $LeagueStatusTable> {
  $$LeagueStatusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get hasGroups => $composableBuilder(
      column: $table.hasGroups, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasTeamsInGroups => $composableBuilder(
      column: $table.hasTeamsInGroups,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasMatches => $composableBuilder(
      column: $table.hasMatches, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasPlayersAssigned => $composableBuilder(
      column: $table.hasPlayersAssigned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueStatusTableAnnotationComposer
    extends Composer<_$Safirah, $LeagueStatusTable> {
  $$LeagueStatusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get hasGroups =>
      $composableBuilder(column: $table.hasGroups, builder: (column) => column);

  GeneratedColumn<bool> get hasTeamsInGroups => $composableBuilder(
      column: $table.hasTeamsInGroups, builder: (column) => column);

  GeneratedColumn<bool> get hasMatches => $composableBuilder(
      column: $table.hasMatches, builder: (column) => column);

  GeneratedColumn<bool> get hasPlayersAssigned => $composableBuilder(
      column: $table.hasPlayersAssigned, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueStatusTableTableManager extends RootTableManager<
    _$Safirah,
    $LeagueStatusTable,
    LeagueStatusData,
    $$LeagueStatusTableFilterComposer,
    $$LeagueStatusTableOrderingComposer,
    $$LeagueStatusTableAnnotationComposer,
    $$LeagueStatusTableCreateCompanionBuilder,
    $$LeagueStatusTableUpdateCompanionBuilder,
    (LeagueStatusData, $$LeagueStatusTableReferences),
    LeagueStatusData,
    PrefetchHooks Function({bool leagueId})> {
  $$LeagueStatusTableTableManager(_$Safirah db, $LeagueStatusTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeagueStatusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeagueStatusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeagueStatusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> leagueId = const Value.absent(),
            Value<bool> hasGroups = const Value.absent(),
            Value<bool> hasTeamsInGroups = const Value.absent(),
            Value<bool> hasMatches = const Value.absent(),
            Value<bool> hasPlayersAssigned = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LeagueStatusCompanion(
            leagueId: leagueId,
            hasGroups: hasGroups,
            hasTeamsInGroups: hasTeamsInGroups,
            hasMatches: hasMatches,
            hasPlayersAssigned: hasPlayersAssigned,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> leagueId = const Value.absent(),
            Value<bool> hasGroups = const Value.absent(),
            Value<bool> hasTeamsInGroups = const Value.absent(),
            Value<bool> hasMatches = const Value.absent(),
            Value<bool> hasPlayersAssigned = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              LeagueStatusCompanion.insert(
            leagueId: leagueId,
            hasGroups: hasGroups,
            hasTeamsInGroups: hasTeamsInGroups,
            hasMatches: hasMatches,
            hasPlayersAssigned: hasPlayersAssigned,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LeagueStatusTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({leagueId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$LeagueStatusTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$LeagueStatusTableReferences._leagueIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LeagueStatusTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeagueStatusTable,
    LeagueStatusData,
    $$LeagueStatusTableFilterComposer,
    $$LeagueStatusTableOrderingComposer,
    $$LeagueStatusTableAnnotationComposer,
    $$LeagueStatusTableCreateCompanionBuilder,
    $$LeagueStatusTableUpdateCompanionBuilder,
    (LeagueStatusData, $$LeagueStatusTableReferences),
    LeagueStatusData,
    PrefetchHooks Function({bool leagueId})>;
typedef $$TermsTableCreateCompanionBuilder = TermsCompanion Function({
  Value<int> id,
  required String name,
  required String type,
  required int order,
  Value<DateTime> createdAt,
});
typedef $$TermsTableUpdateCompanionBuilder = TermsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<int> order,
  Value<DateTime> createdAt,
});

final class $$TermsTableReferences
    extends BaseReferences<_$Safirah, $TermsTable, Term> {
  $$TermsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LeagueTermsTable, List<LeagueTerm>>
      _leagueTermsRefsTable(_$Safirah db) => MultiTypedResultKey.fromTable(
          db.leagueTerms,
          aliasName: $_aliasNameGenerator(db.terms.id, db.leagueTerms.termId));

  $$LeagueTermsTableProcessedTableManager get leagueTermsRefs {
    final manager = $$LeagueTermsTableTableManager($_db, $_db.leagueTerms)
        .filter((f) => f.termId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_leagueTermsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TermsTableFilterComposer extends Composer<_$Safirah, $TermsTable> {
  $$TermsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> leagueTermsRefs(
      Expression<bool> Function($$LeagueTermsTableFilterComposer f) f) {
    final $$LeagueTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.termId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableFilterComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TermsTableOrderingComposer extends Composer<_$Safirah, $TermsTable> {
  $$TermsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TermsTableAnnotationComposer extends Composer<_$Safirah, $TermsTable> {
  $$TermsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> leagueTermsRefs<T extends Object>(
      Expression<T> Function($$LeagueTermsTableAnnotationComposer a) f) {
    final $$LeagueTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.termId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TermsTableTableManager extends RootTableManager<
    _$Safirah,
    $TermsTable,
    Term,
    $$TermsTableFilterComposer,
    $$TermsTableOrderingComposer,
    $$TermsTableAnnotationComposer,
    $$TermsTableCreateCompanionBuilder,
    $$TermsTableUpdateCompanionBuilder,
    (Term, $$TermsTableReferences),
    Term,
    PrefetchHooks Function({bool leagueTermsRefs})> {
  $$TermsTableTableManager(_$Safirah db, $TermsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TermsCompanion(
            id: id,
            name: name,
            type: type,
            order: order,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String type,
            required int order,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TermsCompanion.insert(
            id: id,
            name: name,
            type: type,
            order: order,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TermsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({leagueTermsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (leagueTermsRefs) db.leagueTerms],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (leagueTermsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TermsTableReferences._leagueTermsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TermsTableReferences(db, table, p0)
                                .leagueTermsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.termId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TermsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $TermsTable,
    Term,
    $$TermsTableFilterComposer,
    $$TermsTableOrderingComposer,
    $$TermsTableAnnotationComposer,
    $$TermsTableCreateCompanionBuilder,
    $$TermsTableUpdateCompanionBuilder,
    (Term, $$TermsTableReferences),
    Term,
    PrefetchHooks Function({bool leagueTermsRefs})>;
typedef $$LeagueTermsTableCreateCompanionBuilder = LeagueTermsCompanion
    Function({
  Value<int> id,
  required int leagueId,
  required int termId,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$LeagueTermsTableUpdateCompanionBuilder = LeagueTermsCompanion
    Function({
  Value<int> id,
  Value<int> leagueId,
  Value<int> termId,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$LeagueTermsTableReferences
    extends BaseReferences<_$Safirah, $LeagueTermsTable, LeagueTerm> {
  $$LeagueTermsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$Safirah db) => db.leagues.createAlias(
      $_aliasNameGenerator(db.leagueTerms.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    if ($_item.leagueId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.id($_item.leagueId!));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TermsTable _termIdTable(_$Safirah db) => db.terms
      .createAlias($_aliasNameGenerator(db.leagueTerms.termId, db.terms.id));

  $$TermsTableProcessedTableManager? get termId {
    if ($_item.termId == null) return null;
    final manager = $$TermsTableTableManager($_db, $_db.terms)
        .filter((f) => f.id($_item.termId!));
    final item = $_typedResult.readTableOrNull(_termIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MatchTermsTable, List<MatchTerm>>
      _matchTermsRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.matchTerms,
              aliasName: $_aliasNameGenerator(
                  db.leagueTerms.id, db.matchTerms.leagueTermId));

  $$MatchTermsTableProcessedTableManager get matchTermsRefs {
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.leagueTermId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_matchTermsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LeagueTermsTableFilterComposer
    extends Composer<_$Safirah, $LeagueTermsTable> {
  $$LeagueTermsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableFilterComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TermsTableFilterComposer get termId {
    final $$TermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.termId,
        referencedTable: $db.terms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TermsTableFilterComposer(
              $db: $db,
              $table: $db.terms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> matchTermsRefs(
      Expression<bool> Function($$MatchTermsTableFilterComposer f) f) {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.leagueTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeagueTermsTableOrderingComposer
    extends Composer<_$Safirah, $LeagueTermsTable> {
  $$LeagueTermsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableOrderingComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TermsTableOrderingComposer get termId {
    final $$TermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.termId,
        referencedTable: $db.terms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TermsTableOrderingComposer(
              $db: $db,
              $table: $db.terms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LeagueTermsTableAnnotationComposer
    extends Composer<_$Safirah, $LeagueTermsTable> {
  $$LeagueTermsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeaguesTableAnnotationComposer(
              $db: $db,
              $table: $db.leagues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TermsTableAnnotationComposer get termId {
    final $$TermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.termId,
        referencedTable: $db.terms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TermsTableAnnotationComposer(
              $db: $db,
              $table: $db.terms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> matchTermsRefs<T extends Object>(
      Expression<T> Function($$MatchTermsTableAnnotationComposer a) f) {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.leagueTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LeagueTermsTableTableManager extends RootTableManager<
    _$Safirah,
    $LeagueTermsTable,
    LeagueTerm,
    $$LeagueTermsTableFilterComposer,
    $$LeagueTermsTableOrderingComposer,
    $$LeagueTermsTableAnnotationComposer,
    $$LeagueTermsTableCreateCompanionBuilder,
    $$LeagueTermsTableUpdateCompanionBuilder,
    (LeagueTerm, $$LeagueTermsTableReferences),
    LeagueTerm,
    PrefetchHooks Function({bool leagueId, bool termId, bool matchTermsRefs})> {
  $$LeagueTermsTableTableManager(_$Safirah db, $LeagueTermsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeagueTermsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeagueTermsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeagueTermsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> leagueId = const Value.absent(),
            Value<int> termId = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeagueTermsCompanion(
            id: id,
            leagueId: leagueId,
            termId: termId,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int leagueId,
            required int termId,
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeagueTermsCompanion.insert(
            id: id,
            leagueId: leagueId,
            termId: termId,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LeagueTermsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {leagueId = false, termId = false, matchTermsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchTermsRefs) db.matchTerms],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (leagueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueId,
                    referencedTable:
                        $$LeagueTermsTableReferences._leagueIdTable(db),
                    referencedColumn:
                        $$LeagueTermsTableReferences._leagueIdTable(db).id,
                  ) as T;
                }
                if (termId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.termId,
                    referencedTable:
                        $$LeagueTermsTableReferences._termIdTable(db),
                    referencedColumn:
                        $$LeagueTermsTableReferences._termIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchTermsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LeagueTermsTableReferences
                            ._matchTermsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LeagueTermsTableReferences(db, table, p0)
                                .matchTermsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.leagueTermId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LeagueTermsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeagueTermsTable,
    LeagueTerm,
    $$LeagueTermsTableFilterComposer,
    $$LeagueTermsTableOrderingComposer,
    $$LeagueTermsTableAnnotationComposer,
    $$LeagueTermsTableCreateCompanionBuilder,
    $$LeagueTermsTableUpdateCompanionBuilder,
    (LeagueTerm, $$LeagueTermsTableReferences),
    LeagueTerm,
    PrefetchHooks Function({bool leagueId, bool termId, bool matchTermsRefs})>;
typedef $$MatchTermsTableCreateCompanionBuilder = MatchTermsCompanion Function({
  Value<int> id,
  required int matchId,
  required int leagueTermId,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> additionalMinutes,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
});
typedef $$MatchTermsTableUpdateCompanionBuilder = MatchTermsCompanion Function({
  Value<int> id,
  Value<int> matchId,
  Value<int> leagueTermId,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> additionalMinutes,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
});

final class $$MatchTermsTableReferences
    extends BaseReferences<_$Safirah, $MatchTermsTable, MatchTerm> {
  $$MatchTermsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$Safirah db) => db.matches
      .createAlias($_aliasNameGenerator(db.matchTerms.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager? get matchId {
    if ($_item.matchId == null) return null;
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id($_item.matchId!));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LeagueTermsTable _leagueTermIdTable(_$Safirah db) =>
      db.leagueTerms.createAlias(
          $_aliasNameGenerator(db.matchTerms.leagueTermId, db.leagueTerms.id));

  $$LeagueTermsTableProcessedTableManager? get leagueTermId {
    if ($_item.leagueTermId == null) return null;
    final manager = $$LeagueTermsTableTableManager($_db, $_db.leagueTerms)
        .filter((f) => f.id($_item.leagueTermId!));
    final item = $_typedResult.readTableOrNull(_leagueTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MatchTermPauseTable, List<MatchTermPauseData>>
      _matchTermPauseRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.matchTermPause,
              aliasName: $_aliasNameGenerator(
                  db.matchTerms.id, db.matchTermPause.matchTermId));

  $$MatchTermPauseTableProcessedTableManager get matchTermPauseRefs {
    final manager = $$MatchTermPauseTableTableManager($_db, $_db.matchTermPause)
        .filter((f) => f.matchTermId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_matchTermPauseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WarningsTable, List<Warning>> _warningsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.warnings,
          aliasName:
              $_aliasNameGenerator(db.matchTerms.id, db.warnings.matchTermId));

  $$WarningsTableProcessedTableManager get warningsRefs {
    final manager = $$WarningsTableTableManager($_db, $_db.warnings)
        .filter((f) => f.matchTermId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_warningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoalsTable, List<Goal>> _goalsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.goals,
          aliasName:
              $_aliasNameGenerator(db.matchTerms.id, db.goals.matchTermId));

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.matchTermId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssistsTable, List<Assist>> _assistsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.assists,
          aliasName:
              $_aliasNameGenerator(db.matchTerms.id, db.assists.matchTermId));

  $$AssistsTableProcessedTableManager get assistsRefs {
    final manager = $$AssistsTableTableManager($_db, $_db.assists)
        .filter((f) => f.matchTermId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_assistsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlayerMatchParticipationTable,
      List<PlayerMatchParticipationData>> _playerMatchParticipationRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.playerMatchParticipation,
          aliasName: $_aliasNameGenerator(
              db.matchTerms.id, db.playerMatchParticipation.matchTermId));

  $$PlayerMatchParticipationTableProcessedTableManager
      get playerMatchParticipationRefs {
    final manager = $$PlayerMatchParticipationTableTableManager(
            $_db, $_db.playerMatchParticipation)
        .filter((f) => f.matchTermId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_playerMatchParticipationRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MatchTermsTableFilterComposer
    extends Composer<_$Safirah, $MatchTermsTable> {
  $$MatchTermsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get additionalMinutes => $composableBuilder(
      column: $table.additionalMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LeagueTermsTableFilterComposer get leagueTermId {
    final $$LeagueTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueTermId,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableFilterComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> matchTermPauseRefs(
      Expression<bool> Function($$MatchTermPauseTableFilterComposer f) f) {
    final $$MatchTermPauseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTermPause,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermPauseTableFilterComposer(
              $db: $db,
              $table: $db.matchTermPause,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> warningsRefs(
      Expression<bool> Function($$WarningsTableFilterComposer f) f) {
    final $$WarningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableFilterComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goalsRefs(
      Expression<bool> Function($$GoalsTableFilterComposer f) f) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> assistsRefs(
      Expression<bool> Function($$AssistsTableFilterComposer f) f) {
    final $$AssistsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableFilterComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> playerMatchParticipationRefs(
      Expression<bool> Function($$PlayerMatchParticipationTableFilterComposer f)
          f) {
    final $$PlayerMatchParticipationTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.playerMatchParticipation,
            getReferencedColumn: (t) => t.matchTermId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerMatchParticipationTableFilterComposer(
                  $db: $db,
                  $table: $db.playerMatchParticipation,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MatchTermsTableOrderingComposer
    extends Composer<_$Safirah, $MatchTermsTable> {
  $$MatchTermsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get additionalMinutes => $composableBuilder(
      column: $table.additionalMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LeagueTermsTableOrderingComposer get leagueTermId {
    final $$LeagueTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueTermId,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableOrderingComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTermsTableAnnotationComposer
    extends Composer<_$Safirah, $MatchTermsTable> {
  $$MatchTermsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get additionalMinutes => $composableBuilder(
      column: $table.additionalMinutes, builder: (column) => column);

  GeneratedColumn<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LeagueTermsTableAnnotationComposer get leagueTermId {
    final $$LeagueTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueTermId,
        referencedTable: $db.leagueTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LeagueTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.leagueTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> matchTermPauseRefs<T extends Object>(
      Expression<T> Function($$MatchTermPauseTableAnnotationComposer a) f) {
    final $$MatchTermPauseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchTermPause,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermPauseTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTermPause,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> warningsRefs<T extends Object>(
      Expression<T> Function($$WarningsTableAnnotationComposer a) f) {
    final $$WarningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.warnings,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WarningsTableAnnotationComposer(
              $db: $db,
              $table: $db.warnings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
      Expression<T> Function($$GoalsTableAnnotationComposer a) f) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> assistsRefs<T extends Object>(
      Expression<T> Function($$AssistsTableAnnotationComposer a) f) {
    final $$AssistsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.matchTermId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableAnnotationComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> playerMatchParticipationRefs<T extends Object>(
      Expression<T> Function(
              $$PlayerMatchParticipationTableAnnotationComposer a)
          f) {
    final $$PlayerMatchParticipationTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.playerMatchParticipation,
            getReferencedColumn: (t) => t.matchTermId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlayerMatchParticipationTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playerMatchParticipation,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MatchTermsTableTableManager extends RootTableManager<
    _$Safirah,
    $MatchTermsTable,
    MatchTerm,
    $$MatchTermsTableFilterComposer,
    $$MatchTermsTableOrderingComposer,
    $$MatchTermsTableAnnotationComposer,
    $$MatchTermsTableCreateCompanionBuilder,
    $$MatchTermsTableUpdateCompanionBuilder,
    (MatchTerm, $$MatchTermsTableReferences),
    MatchTerm,
    PrefetchHooks Function(
        {bool matchId,
        bool leagueTermId,
        bool matchTermPauseRefs,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs,
        bool playerMatchParticipationRefs})> {
  $$MatchTermsTableTableManager(_$Safirah db, $MatchTermsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchTermsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchTermsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchTermsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchId = const Value.absent(),
            Value<int> leagueTermId = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> additionalMinutes = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MatchTermsCompanion(
            id: id,
            matchId: matchId,
            leagueTermId: leagueTermId,
            startTime: startTime,
            endTime: endTime,
            additionalMinutes: additionalMinutes,
            isFinished: isFinished,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchId,
            required int leagueTermId,
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> additionalMinutes = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MatchTermsCompanion.insert(
            id: id,
            matchId: matchId,
            leagueTermId: leagueTermId,
            startTime: startTime,
            endTime: endTime,
            additionalMinutes: additionalMinutes,
            isFinished: isFinished,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MatchTermsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {matchId = false,
              leagueTermId = false,
              matchTermPauseRefs = false,
              warningsRefs = false,
              goalsRefs = false,
              assistsRefs = false,
              playerMatchParticipationRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (matchTermPauseRefs) db.matchTermPause,
                if (warningsRefs) db.warnings,
                if (goalsRefs) db.goals,
                if (assistsRefs) db.assists,
                if (playerMatchParticipationRefs) db.playerMatchParticipation
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable:
                        $$MatchTermsTableReferences._matchIdTable(db),
                    referencedColumn:
                        $$MatchTermsTableReferences._matchIdTable(db).id,
                  ) as T;
                }
                if (leagueTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueTermId,
                    referencedTable:
                        $$MatchTermsTableReferences._leagueTermIdTable(db),
                    referencedColumn:
                        $$MatchTermsTableReferences._leagueTermIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchTermPauseRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MatchTermsTableReferences
                            ._matchTermPauseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchTermsTableReferences(db, table, p0)
                                .matchTermPauseRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.matchTermId == item.id),
                        typedResults: items),
                  if (warningsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchTermsTableReferences._warningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchTermsTableReferences(db, table, p0)
                                .warningsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.matchTermId == item.id),
                        typedResults: items),
                  if (goalsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchTermsTableReferences._goalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchTermsTableReferences(db, table, p0)
                                .goalsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.matchTermId == item.id),
                        typedResults: items),
                  if (assistsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MatchTermsTableReferences._assistsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchTermsTableReferences(db, table, p0)
                                .assistsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.matchTermId == item.id),
                        typedResults: items),
                  if (playerMatchParticipationRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MatchTermsTableReferences
                            ._playerMatchParticipationRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchTermsTableReferences(db, table, p0)
                                .playerMatchParticipationRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.matchTermId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MatchTermsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $MatchTermsTable,
    MatchTerm,
    $$MatchTermsTableFilterComposer,
    $$MatchTermsTableOrderingComposer,
    $$MatchTermsTableAnnotationComposer,
    $$MatchTermsTableCreateCompanionBuilder,
    $$MatchTermsTableUpdateCompanionBuilder,
    (MatchTerm, $$MatchTermsTableReferences),
    MatchTerm,
    PrefetchHooks Function(
        {bool matchId,
        bool leagueTermId,
        bool matchTermPauseRefs,
        bool warningsRefs,
        bool goalsRefs,
        bool assistsRefs,
        bool playerMatchParticipationRefs})>;
typedef $$MatchTermPauseTableCreateCompanionBuilder = MatchTermPauseCompanion
    Function({
  Value<int> id,
  required int matchTermId,
  required DateTime startPause,
  Value<DateTime?> endPause,
});
typedef $$MatchTermPauseTableUpdateCompanionBuilder = MatchTermPauseCompanion
    Function({
  Value<int> id,
  Value<int> matchTermId,
  Value<DateTime> startPause,
  Value<DateTime?> endPause,
});

final class $$MatchTermPauseTableReferences extends BaseReferences<_$Safirah,
    $MatchTermPauseTable, MatchTermPauseData> {
  $$MatchTermPauseTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MatchTermsTable _matchTermIdTable(_$Safirah db) =>
      db.matchTerms.createAlias($_aliasNameGenerator(
          db.matchTermPause.matchTermId, db.matchTerms.id));

  $$MatchTermsTableProcessedTableManager? get matchTermId {
    if ($_item.matchTermId == null) return null;
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.id($_item.matchTermId!));
    final item = $_typedResult.readTableOrNull(_matchTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MatchTermPauseTableFilterComposer
    extends Composer<_$Safirah, $MatchTermPauseTable> {
  $$MatchTermPauseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endPause => $composableBuilder(
      column: $table.endPause, builder: (column) => ColumnFilters(column));

  $$MatchTermsTableFilterComposer get matchTermId {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTermPauseTableOrderingComposer
    extends Composer<_$Safirah, $MatchTermPauseTable> {
  $$MatchTermPauseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endPause => $composableBuilder(
      column: $table.endPause, builder: (column) => ColumnOrderings(column));

  $$MatchTermsTableOrderingComposer get matchTermId {
    final $$MatchTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableOrderingComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTermPauseTableAnnotationComposer
    extends Composer<_$Safirah, $MatchTermPauseTable> {
  $$MatchTermPauseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => column);

  GeneratedColumn<DateTime> get endPause =>
      $composableBuilder(column: $table.endPause, builder: (column) => column);

  $$MatchTermsTableAnnotationComposer get matchTermId {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTermPauseTableTableManager extends RootTableManager<
    _$Safirah,
    $MatchTermPauseTable,
    MatchTermPauseData,
    $$MatchTermPauseTableFilterComposer,
    $$MatchTermPauseTableOrderingComposer,
    $$MatchTermPauseTableAnnotationComposer,
    $$MatchTermPauseTableCreateCompanionBuilder,
    $$MatchTermPauseTableUpdateCompanionBuilder,
    (MatchTermPauseData, $$MatchTermPauseTableReferences),
    MatchTermPauseData,
    PrefetchHooks Function({bool matchTermId})> {
  $$MatchTermPauseTableTableManager(_$Safirah db, $MatchTermPauseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchTermPauseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchTermPauseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchTermPauseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchTermId = const Value.absent(),
            Value<DateTime> startPause = const Value.absent(),
            Value<DateTime?> endPause = const Value.absent(),
          }) =>
              MatchTermPauseCompanion(
            id: id,
            matchTermId: matchTermId,
            startPause: startPause,
            endPause: endPause,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchTermId,
            required DateTime startPause,
            Value<DateTime?> endPause = const Value.absent(),
          }) =>
              MatchTermPauseCompanion.insert(
            id: id,
            matchTermId: matchTermId,
            startPause: startPause,
            endPause: endPause,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MatchTermPauseTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({matchTermId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchTermId,
                    referencedTable:
                        $$MatchTermPauseTableReferences._matchTermIdTable(db),
                    referencedColumn: $$MatchTermPauseTableReferences
                        ._matchTermIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MatchTermPauseTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $MatchTermPauseTable,
    MatchTermPauseData,
    $$MatchTermPauseTableFilterComposer,
    $$MatchTermPauseTableOrderingComposer,
    $$MatchTermPauseTableAnnotationComposer,
    $$MatchTermPauseTableCreateCompanionBuilder,
    $$MatchTermPauseTableUpdateCompanionBuilder,
    (MatchTermPauseData, $$MatchTermPauseTableReferences),
    MatchTermPauseData,
    PrefetchHooks Function({bool matchTermId})>;
typedef $$WarningsTableCreateCompanionBuilder = WarningsCompanion Function({
  Value<int> id,
  required int matchId,
  required int playerId,
  required int matchTermId,
  required int warningTime,
  required String warningType,
  Value<String?> reason,
  Value<String> status,
});
typedef $$WarningsTableUpdateCompanionBuilder = WarningsCompanion Function({
  Value<int> id,
  Value<int> matchId,
  Value<int> playerId,
  Value<int> matchTermId,
  Value<int> warningTime,
  Value<String> warningType,
  Value<String?> reason,
  Value<String> status,
});

final class $$WarningsTableReferences
    extends BaseReferences<_$Safirah, $WarningsTable, Warning> {
  $$WarningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$Safirah db) => db.matches
      .createAlias($_aliasNameGenerator(db.warnings.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager? get matchId {
    if ($_item.matchId == null) return null;
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id($_item.matchId!));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTable _playerIdTable(_$Safirah db) => db.players
      .createAlias($_aliasNameGenerator(db.warnings.playerId, db.players.id));

  $$PlayersTableProcessedTableManager? get playerId {
    if ($_item.playerId == null) return null;
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.playerId!));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MatchTermsTable _matchTermIdTable(_$Safirah db) =>
      db.matchTerms.createAlias(
          $_aliasNameGenerator(db.warnings.matchTermId, db.matchTerms.id));

  $$MatchTermsTableProcessedTableManager? get matchTermId {
    if ($_item.matchTermId == null) return null;
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.id($_item.matchTermId!));
    final item = $_typedResult.readTableOrNull(_matchTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WarningsTableFilterComposer
    extends Composer<_$Safirah, $WarningsTable> {
  $$WarningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableFilterComposer get matchTermId {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WarningsTableOrderingComposer
    extends Composer<_$Safirah, $WarningsTable> {
  $$WarningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableOrderingComposer get matchTermId {
    final $$MatchTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableOrderingComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WarningsTableAnnotationComposer
    extends Composer<_$Safirah, $WarningsTable> {
  $$WarningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => column);

  GeneratedColumn<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableAnnotationComposer get matchTermId {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WarningsTableTableManager extends RootTableManager<
    _$Safirah,
    $WarningsTable,
    Warning,
    $$WarningsTableFilterComposer,
    $$WarningsTableOrderingComposer,
    $$WarningsTableAnnotationComposer,
    $$WarningsTableCreateCompanionBuilder,
    $$WarningsTableUpdateCompanionBuilder,
    (Warning, $$WarningsTableReferences),
    Warning,
    PrefetchHooks Function({bool matchId, bool playerId, bool matchTermId})> {
  $$WarningsTableTableManager(_$Safirah db, $WarningsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WarningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WarningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WarningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchId = const Value.absent(),
            Value<int> playerId = const Value.absent(),
            Value<int> matchTermId = const Value.absent(),
            Value<int> warningTime = const Value.absent(),
            Value<String> warningType = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WarningsCompanion(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            warningTime: warningTime,
            warningType: warningType,
            reason: reason,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchId,
            required int playerId,
            required int matchTermId,
            required int warningTime,
            required String warningType,
            Value<String?> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WarningsCompanion.insert(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            warningTime: warningTime,
            warningType: warningType,
            reason: reason,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WarningsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {matchId = false, playerId = false, matchTermId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable:
                        $$WarningsTableReferences._matchIdTable(db),
                    referencedColumn:
                        $$WarningsTableReferences._matchIdTable(db).id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$WarningsTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$WarningsTableReferences._playerIdTable(db).id,
                  ) as T;
                }
                if (matchTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchTermId,
                    referencedTable:
                        $$WarningsTableReferences._matchTermIdTable(db),
                    referencedColumn:
                        $$WarningsTableReferences._matchTermIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WarningsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $WarningsTable,
    Warning,
    $$WarningsTableFilterComposer,
    $$WarningsTableOrderingComposer,
    $$WarningsTableAnnotationComposer,
    $$WarningsTableCreateCompanionBuilder,
    $$WarningsTableUpdateCompanionBuilder,
    (Warning, $$WarningsTableReferences),
    Warning,
    PrefetchHooks Function({bool matchId, bool playerId, bool matchTermId})>;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required int matchId,
  required int playerId,
  required int matchTermId,
  required int goalTime,
  required String goalType,
  Value<String> status,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<int> matchId,
  Value<int> playerId,
  Value<int> matchTermId,
  Value<int> goalTime,
  Value<String> goalType,
  Value<String> status,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$Safirah, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$Safirah db) => db.matches
      .createAlias($_aliasNameGenerator(db.goals.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager? get matchId {
    if ($_item.matchId == null) return null;
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id($_item.matchId!));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTable _playerIdTable(_$Safirah db) => db.players
      .createAlias($_aliasNameGenerator(db.goals.playerId, db.players.id));

  $$PlayersTableProcessedTableManager? get playerId {
    if ($_item.playerId == null) return null;
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.playerId!));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MatchTermsTable _matchTermIdTable(_$Safirah db) =>
      db.matchTerms.createAlias(
          $_aliasNameGenerator(db.goals.matchTermId, db.matchTerms.id));

  $$MatchTermsTableProcessedTableManager? get matchTermId {
    if ($_item.matchTermId == null) return null;
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.id($_item.matchTermId!));
    final item = $_typedResult.readTableOrNull(_matchTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AssistsTable, List<Assist>> _assistsRefsTable(
          _$Safirah db) =>
      MultiTypedResultKey.fromTable(db.assists,
          aliasName: $_aliasNameGenerator(db.goals.id, db.assists.goalId));

  $$AssistsTableProcessedTableManager get assistsRefs {
    final manager = $$AssistsTableTableManager($_db, $_db.assists)
        .filter((f) => f.goalId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_assistsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoalsTableFilterComposer extends Composer<_$Safirah, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalTime => $composableBuilder(
      column: $table.goalTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalType => $composableBuilder(
      column: $table.goalType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableFilterComposer get matchTermId {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> assistsRefs(
      Expression<bool> Function($$AssistsTableFilterComposer f) f) {
    final $$AssistsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableFilterComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer extends Composer<_$Safirah, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalTime => $composableBuilder(
      column: $table.goalTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalType => $composableBuilder(
      column: $table.goalType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableOrderingComposer get matchTermId {
    final $$MatchTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableOrderingComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalsTableAnnotationComposer extends Composer<_$Safirah, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get goalTime =>
      $composableBuilder(column: $table.goalTime, builder: (column) => column);

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableAnnotationComposer get matchTermId {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> assistsRefs<T extends Object>(
      Expression<T> Function($$AssistsTableAnnotationComposer a) f) {
    final $$AssistsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assists,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssistsTableAnnotationComposer(
              $db: $db,
              $table: $db.assists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableTableManager extends RootTableManager<
    _$Safirah,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function(
        {bool matchId, bool playerId, bool matchTermId, bool assistsRefs})> {
  $$GoalsTableTableManager(_$Safirah db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchId = const Value.absent(),
            Value<int> playerId = const Value.absent(),
            Value<int> matchTermId = const Value.absent(),
            Value<int> goalTime = const Value.absent(),
            Value<String> goalType = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            goalTime: goalTime,
            goalType: goalType,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchId,
            required int playerId,
            required int matchTermId,
            required int goalTime,
            required String goalType,
            Value<String> status = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            goalTime: goalTime,
            goalType: goalType,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GoalsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {matchId = false,
              playerId = false,
              matchTermId = false,
              assistsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (assistsRefs) db.assists],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable: $$GoalsTableReferences._matchIdTable(db),
                    referencedColumn:
                        $$GoalsTableReferences._matchIdTable(db).id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable: $$GoalsTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$GoalsTableReferences._playerIdTable(db).id,
                  ) as T;
                }
                if (matchTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchTermId,
                    referencedTable:
                        $$GoalsTableReferences._matchTermIdTable(db),
                    referencedColumn:
                        $$GoalsTableReferences._matchTermIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assistsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$GoalsTableReferences._assistsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0).assistsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function(
        {bool matchId, bool playerId, bool matchTermId, bool assistsRefs})>;
typedef $$AssistsTableCreateCompanionBuilder = AssistsCompanion Function({
  Value<int> id,
  required int matchId,
  required int playerId,
  required int matchTermId,
  required int goalId,
  required int assistTime,
  Value<String> status,
});
typedef $$AssistsTableUpdateCompanionBuilder = AssistsCompanion Function({
  Value<int> id,
  Value<int> matchId,
  Value<int> playerId,
  Value<int> matchTermId,
  Value<int> goalId,
  Value<int> assistTime,
  Value<String> status,
});

final class $$AssistsTableReferences
    extends BaseReferences<_$Safirah, $AssistsTable, Assist> {
  $$AssistsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$Safirah db) => db.matches
      .createAlias($_aliasNameGenerator(db.assists.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager? get matchId {
    if ($_item.matchId == null) return null;
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id($_item.matchId!));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTable _playerIdTable(_$Safirah db) => db.players
      .createAlias($_aliasNameGenerator(db.assists.playerId, db.players.id));

  $$PlayersTableProcessedTableManager? get playerId {
    if ($_item.playerId == null) return null;
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.playerId!));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MatchTermsTable _matchTermIdTable(_$Safirah db) =>
      db.matchTerms.createAlias(
          $_aliasNameGenerator(db.assists.matchTermId, db.matchTerms.id));

  $$MatchTermsTableProcessedTableManager? get matchTermId {
    if ($_item.matchTermId == null) return null;
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.id($_item.matchTermId!));
    final item = $_typedResult.readTableOrNull(_matchTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GoalsTable _goalIdTable(_$Safirah db) => db.goals
      .createAlias($_aliasNameGenerator(db.assists.goalId, db.goals.id));

  $$GoalsTableProcessedTableManager? get goalId {
    if ($_item.goalId == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id($_item.goalId!));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AssistsTableFilterComposer extends Composer<_$Safirah, $AssistsTable> {
  $$AssistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableFilterComposer get matchTermId {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssistsTableOrderingComposer
    extends Composer<_$Safirah, $AssistsTable> {
  $$AssistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableOrderingComposer get matchTermId {
    final $$MatchTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableOrderingComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssistsTableAnnotationComposer
    extends Composer<_$Safirah, $AssistsTable> {
  $$AssistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableAnnotationComposer get matchTermId {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssistsTableTableManager extends RootTableManager<
    _$Safirah,
    $AssistsTable,
    Assist,
    $$AssistsTableFilterComposer,
    $$AssistsTableOrderingComposer,
    $$AssistsTableAnnotationComposer,
    $$AssistsTableCreateCompanionBuilder,
    $$AssistsTableUpdateCompanionBuilder,
    (Assist, $$AssistsTableReferences),
    Assist,
    PrefetchHooks Function(
        {bool matchId, bool playerId, bool matchTermId, bool goalId})> {
  $$AssistsTableTableManager(_$Safirah db, $AssistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchId = const Value.absent(),
            Value<int> playerId = const Value.absent(),
            Value<int> matchTermId = const Value.absent(),
            Value<int> goalId = const Value.absent(),
            Value<int> assistTime = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              AssistsCompanion(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            goalId: goalId,
            assistTime: assistTime,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchId,
            required int playerId,
            required int matchTermId,
            required int goalId,
            required int assistTime,
            Value<String> status = const Value.absent(),
          }) =>
              AssistsCompanion.insert(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            goalId: goalId,
            assistTime: assistTime,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AssistsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {matchId = false,
              playerId = false,
              matchTermId = false,
              goalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable: $$AssistsTableReferences._matchIdTable(db),
                    referencedColumn:
                        $$AssistsTableReferences._matchIdTable(db).id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$AssistsTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$AssistsTableReferences._playerIdTable(db).id,
                  ) as T;
                }
                if (matchTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchTermId,
                    referencedTable:
                        $$AssistsTableReferences._matchTermIdTable(db),
                    referencedColumn:
                        $$AssistsTableReferences._matchTermIdTable(db).id,
                  ) as T;
                }
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable: $$AssistsTableReferences._goalIdTable(db),
                    referencedColumn:
                        $$AssistsTableReferences._goalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AssistsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $AssistsTable,
    Assist,
    $$AssistsTableFilterComposer,
    $$AssistsTableOrderingComposer,
    $$AssistsTableAnnotationComposer,
    $$AssistsTableCreateCompanionBuilder,
    $$AssistsTableUpdateCompanionBuilder,
    (Assist, $$AssistsTableReferences),
    Assist,
    PrefetchHooks Function(
        {bool matchId, bool playerId, bool matchTermId, bool goalId})>;
typedef $$PlayerMatchParticipationTableCreateCompanionBuilder
    = PlayerMatchParticipationCompanion Function({
  Value<int> id,
  required int matchId,
  required int playerId,
  required int matchTermId,
  Value<int?> startTime,
  Value<int?> endTime,
  required int substitutedPlayerId,
  required String participationType,
});
typedef $$PlayerMatchParticipationTableUpdateCompanionBuilder
    = PlayerMatchParticipationCompanion Function({
  Value<int> id,
  Value<int> matchId,
  Value<int> playerId,
  Value<int> matchTermId,
  Value<int?> startTime,
  Value<int?> endTime,
  Value<int> substitutedPlayerId,
  Value<String> participationType,
});

final class $$PlayerMatchParticipationTableReferences extends BaseReferences<
    _$Safirah, $PlayerMatchParticipationTable, PlayerMatchParticipationData> {
  $$PlayerMatchParticipationTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$Safirah db) => db.matches.createAlias(
      $_aliasNameGenerator(db.playerMatchParticipation.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager? get matchId {
    if ($_item.matchId == null) return null;
    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id($_item.matchId!));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTable _playerIdTable(_$Safirah db) =>
      db.players.createAlias($_aliasNameGenerator(
          db.playerMatchParticipation.playerId, db.players.id));

  $$PlayersTableProcessedTableManager? get playerId {
    if ($_item.playerId == null) return null;
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.playerId!));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MatchTermsTable _matchTermIdTable(_$Safirah db) =>
      db.matchTerms.createAlias($_aliasNameGenerator(
          db.playerMatchParticipation.matchTermId, db.matchTerms.id));

  $$MatchTermsTableProcessedTableManager? get matchTermId {
    if ($_item.matchTermId == null) return null;
    final manager = $$MatchTermsTableTableManager($_db, $_db.matchTerms)
        .filter((f) => f.id($_item.matchTermId!));
    final item = $_typedResult.readTableOrNull(_matchTermIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlayersTable _substitutedPlayerIdTable(_$Safirah db) =>
      db.players.createAlias($_aliasNameGenerator(
          db.playerMatchParticipation.substitutedPlayerId, db.players.id));

  $$PlayersTableProcessedTableManager? get substitutedPlayerId {
    if ($_item.substitutedPlayerId == null) return null;
    final manager = $$PlayersTableTableManager($_db, $_db.players)
        .filter((f) => f.id($_item.substitutedPlayerId!));
    final item = $_typedResult.readTableOrNull(_substitutedPlayerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlayerMatchParticipationTableFilterComposer
    extends Composer<_$Safirah, $PlayerMatchParticipationTable> {
  $$PlayerMatchParticipationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get participationType => $composableBuilder(
      column: $table.participationType,
      builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableFilterComposer get matchTermId {
    final $$MatchTermsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableFilterComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableFilterComposer get substitutedPlayerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.substitutedPlayerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerMatchParticipationTableOrderingComposer
    extends Composer<_$Safirah, $PlayerMatchParticipationTable> {
  $$PlayerMatchParticipationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get participationType => $composableBuilder(
      column: $table.participationType,
      builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableOrderingComposer get matchTermId {
    final $$MatchTermsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableOrderingComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableOrderingComposer get substitutedPlayerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.substitutedPlayerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerMatchParticipationTableAnnotationComposer
    extends Composer<_$Safirah, $PlayerMatchParticipationTable> {
  $$PlayerMatchParticipationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get participationType => $composableBuilder(
      column: $table.participationType, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MatchTermsTableAnnotationComposer get matchTermId {
    final $$MatchTermsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchTermId,
        referencedTable: $db.matchTerms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTermsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchTerms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlayersTableAnnotationComposer get substitutedPlayerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.substitutedPlayerId,
        referencedTable: $db.players,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlayerMatchParticipationTableTableManager extends RootTableManager<
    _$Safirah,
    $PlayerMatchParticipationTable,
    PlayerMatchParticipationData,
    $$PlayerMatchParticipationTableFilterComposer,
    $$PlayerMatchParticipationTableOrderingComposer,
    $$PlayerMatchParticipationTableAnnotationComposer,
    $$PlayerMatchParticipationTableCreateCompanionBuilder,
    $$PlayerMatchParticipationTableUpdateCompanionBuilder,
    (PlayerMatchParticipationData, $$PlayerMatchParticipationTableReferences),
    PlayerMatchParticipationData,
    PrefetchHooks Function(
        {bool matchId,
        bool playerId,
        bool matchTermId,
        bool substitutedPlayerId})> {
  $$PlayerMatchParticipationTableTableManager(
      _$Safirah db, $PlayerMatchParticipationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerMatchParticipationTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerMatchParticipationTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerMatchParticipationTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> matchId = const Value.absent(),
            Value<int> playerId = const Value.absent(),
            Value<int> matchTermId = const Value.absent(),
            Value<int?> startTime = const Value.absent(),
            Value<int?> endTime = const Value.absent(),
            Value<int> substitutedPlayerId = const Value.absent(),
            Value<String> participationType = const Value.absent(),
          }) =>
              PlayerMatchParticipationCompanion(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            startTime: startTime,
            endTime: endTime,
            substitutedPlayerId: substitutedPlayerId,
            participationType: participationType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int matchId,
            required int playerId,
            required int matchTermId,
            Value<int?> startTime = const Value.absent(),
            Value<int?> endTime = const Value.absent(),
            required int substitutedPlayerId,
            required String participationType,
          }) =>
              PlayerMatchParticipationCompanion.insert(
            id: id,
            matchId: matchId,
            playerId: playerId,
            matchTermId: matchTermId,
            startTime: startTime,
            endTime: endTime,
            substitutedPlayerId: substitutedPlayerId,
            participationType: participationType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlayerMatchParticipationTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {matchId = false,
              playerId = false,
              matchTermId = false,
              substitutedPlayerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable: $$PlayerMatchParticipationTableReferences
                        ._matchIdTable(db),
                    referencedColumn: $$PlayerMatchParticipationTableReferences
                        ._matchIdTable(db)
                        .id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable: $$PlayerMatchParticipationTableReferences
                        ._playerIdTable(db),
                    referencedColumn: $$PlayerMatchParticipationTableReferences
                        ._playerIdTable(db)
                        .id,
                  ) as T;
                }
                if (matchTermId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchTermId,
                    referencedTable: $$PlayerMatchParticipationTableReferences
                        ._matchTermIdTable(db),
                    referencedColumn: $$PlayerMatchParticipationTableReferences
                        ._matchTermIdTable(db)
                        .id,
                  ) as T;
                }
                if (substitutedPlayerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.substitutedPlayerId,
                    referencedTable: $$PlayerMatchParticipationTableReferences
                        ._substitutedPlayerIdTable(db),
                    referencedColumn: $$PlayerMatchParticipationTableReferences
                        ._substitutedPlayerIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlayerMatchParticipationTableProcessedTableManager
    = ProcessedTableManager<
        _$Safirah,
        $PlayerMatchParticipationTable,
        PlayerMatchParticipationData,
        $$PlayerMatchParticipationTableFilterComposer,
        $$PlayerMatchParticipationTableOrderingComposer,
        $$PlayerMatchParticipationTableAnnotationComposer,
        $$PlayerMatchParticipationTableCreateCompanionBuilder,
        $$PlayerMatchParticipationTableUpdateCompanionBuilder,
        (
          PlayerMatchParticipationData,
          $$PlayerMatchParticipationTableReferences
        ),
        PlayerMatchParticipationData,
        PrefetchHooks Function(
            {bool matchId,
            bool playerId,
            bool matchTermId,
            bool substitutedPlayerId})>;

class $SafirahManager {
  final _$Safirah _db;
  $SafirahManager(this._db);
  $$LeaguesTableTableManager get leagues =>
      $$LeaguesTableTableManager(_db, _db.leagues);
  $$LeagueRulesTableTableManager get leagueRules =>
      $$LeagueRulesTableTableManager(_db, _db.leagueRules);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$TeamPlayerCategoriesTableTableManager get teamPlayerCategories =>
      $$TeamPlayerCategoriesTableTableManager(_db, _db.teamPlayerCategories);
  $$LeaguePlayersTableTableManager get leaguePlayers =>
      $$LeaguePlayersTableTableManager(_db, _db.leaguePlayers);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$DraftProgressTableTableManager get draftProgress =>
      $$DraftProgressTableTableManager(_db, _db.draftProgress);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$GroupTableTableManager get group =>
      $$GroupTableTableManager(_db, _db.group);
  $$GroupTeamTableTableManager get groupTeam =>
      $$GroupTeamTableTableManager(_db, _db.groupTeam);
  $$RoundsTableTableManager get rounds =>
      $$RoundsTableTableManager(_db, _db.rounds);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$QualifiedTeamTableTableManager get qualifiedTeam =>
      $$QualifiedTeamTableTableManager(_db, _db.qualifiedTeam);
  $$LeagueStatusTableTableManager get leagueStatus =>
      $$LeagueStatusTableTableManager(_db, _db.leagueStatus);
  $$TermsTableTableManager get terms =>
      $$TermsTableTableManager(_db, _db.terms);
  $$LeagueTermsTableTableManager get leagueTerms =>
      $$LeagueTermsTableTableManager(_db, _db.leagueTerms);
  $$MatchTermsTableTableManager get matchTerms =>
      $$MatchTermsTableTableManager(_db, _db.matchTerms);
  $$MatchTermPauseTableTableManager get matchTermPause =>
      $$MatchTermPauseTableTableManager(_db, _db.matchTermPause);
  $$WarningsTableTableManager get warnings =>
      $$WarningsTableTableManager(_db, _db.warnings);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$AssistsTableTableManager get assists =>
      $$AssistsTableTableManager(_db, _db.assists);
  $$PlayerMatchParticipationTableTableManager get playerMatchParticipation =>
      $$PlayerMatchParticipationTableTableManager(
          _db, _db.playerMatchParticipation);
}
