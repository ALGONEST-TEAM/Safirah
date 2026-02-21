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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _logoLocalPathMeta =
      const VerificationMeta('logoLocalPath');
  @override
  late final GeneratedColumn<String> logoLocalPath = GeneratedColumn<String>(
      'logo_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        syncId,
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
        updatedAt,
        logoLocalPath
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
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
    if (data.containsKey('logo_local_path')) {
      context.handle(
          _logoLocalPathMeta,
          logoLocalPath.isAcceptableOrUnknown(
              data['logo_local_path']!, _logoLocalPathMeta));
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
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
      logoLocalPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_local_path']),
    );
  }

  @override
  $LeaguesTable createAlias(String alias) {
    return $LeaguesTable(attachedDatabase, alias);
  }
}

class League extends DataClass implements Insertable<League> {
  final int id;

  /// معرف مزامنة عالمي (UUID) يُستخدم مع الـ backend بدل id المحلي.
  /// يجب أن يكون فريدًا على مستوى قاعدة البيانات.
  final String syncId;
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
  final String? logoLocalPath;
  const League(
      {required this.id,
      required this.syncId,
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
      this.updatedAt,
      this.logoLocalPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
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
    if (!nullToAbsent || logoLocalPath != null) {
      map['logo_local_path'] = Variable<String>(logoLocalPath);
    }
    return map;
  }

  LeaguesCompanion toCompanion(bool nullToAbsent) {
    return LeaguesCompanion(
      id: Value(id),
      syncId: Value(syncId),
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
      logoLocalPath: logoLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoLocalPath),
    );
  }

  factory League.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return League(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
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
      logoLocalPath: serializer.fromJson<String?>(json['logoLocalPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
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
      'logoLocalPath': serializer.toJson<String?>(logoLocalPath),
    };
  }

  League copyWith(
          {int? id,
          String? syncId,
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
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<String?> logoLocalPath = const Value.absent()}) =>
      League(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
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
        logoLocalPath:
            logoLocalPath.present ? logoLocalPath.value : this.logoLocalPath,
      );
  League copyWithCompanion(LeaguesCompanion data) {
    return League(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
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
      logoLocalPath: data.logoLocalPath.present
          ? data.logoLocalPath.value
          : this.logoLocalPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('League(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
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
          ..write('updatedAt: $updatedAt, ')
          ..write('logoLocalPath: $logoLocalPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      syncId,
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
      updatedAt,
      logoLocalPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is League &&
          other.id == this.id &&
          other.syncId == this.syncId &&
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
          other.updatedAt == this.updatedAt &&
          other.logoLocalPath == this.logoLocalPath);
}

class LeaguesCompanion extends UpdateCompanion<League> {
  final Value<int> id;
  final Value<String> syncId;
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
  final Value<String?> logoLocalPath;
  const LeaguesCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
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
    this.logoLocalPath = const Value.absent(),
  });
  LeaguesCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
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
    this.logoLocalPath = const Value.absent(),
  })  : syncId = Value(syncId),
        name = Value(name),
        subscriptionPrice = Value(subscriptionPrice);
  static Insertable<League> custom({
    Expression<int>? id,
    Expression<String>? syncId,
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
    Expression<String>? logoLocalPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
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
      if (logoLocalPath != null) 'logo_local_path': logoLocalPath,
    });
  }

  LeaguesCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
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
      Value<DateTime?>? updatedAt,
      Value<String?>? logoLocalPath}) {
    return LeaguesCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
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
      logoLocalPath: logoLocalPath ?? this.logoLocalPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
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
    if (logoLocalPath.present) {
      map['logo_local_path'] = Variable<String>(logoLocalPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguesCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
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
          ..write('updatedAt: $updatedAt, ')
          ..write('logoLocalPath: $logoLocalPath')
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
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      [id, leagueSyncId, syncId, description, isMandatory, createdAt];
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
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
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
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
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
  final String leagueSyncId;
  final String syncId;
  final String description;
  final bool isMandatory;
  final DateTime createdAt;
  const LeagueRule(
      {required this.id,
      required this.leagueSyncId,
      required this.syncId,
      required this.description,
      required this.isMandatory,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['sync_id'] = Variable<String>(syncId);
    map['description'] = Variable<String>(description);
    map['is_mandatory'] = Variable<bool>(isMandatory);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LeagueRulesCompanion toCompanion(bool nullToAbsent) {
    return LeagueRulesCompanion(
      id: Value(id),
      leagueSyncId: Value(leagueSyncId),
      syncId: Value(syncId),
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
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      syncId: serializer.fromJson<String>(json['syncId']),
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
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'syncId': serializer.toJson<String>(syncId),
      'description': serializer.toJson<String>(description),
      'isMandatory': serializer.toJson<bool>(isMandatory),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LeagueRule copyWith(
          {int? id,
          String? leagueSyncId,
          String? syncId,
          String? description,
          bool? isMandatory,
          DateTime? createdAt}) =>
      LeagueRule(
        id: id ?? this.id,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        syncId: syncId ?? this.syncId,
        description: description ?? this.description,
        isMandatory: isMandatory ?? this.isMandatory,
        createdAt: createdAt ?? this.createdAt,
      );
  LeagueRule copyWithCompanion(LeagueRulesCompanion data) {
    return LeagueRule(
      id: data.id.present ? data.id.value : this.id,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
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
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('syncId: $syncId, ')
          ..write('description: $description, ')
          ..write('isMandatory: $isMandatory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, leagueSyncId, syncId, description, isMandatory, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueRule &&
          other.id == this.id &&
          other.leagueSyncId == this.leagueSyncId &&
          other.syncId == this.syncId &&
          other.description == this.description &&
          other.isMandatory == this.isMandatory &&
          other.createdAt == this.createdAt);
}

class LeagueRulesCompanion extends UpdateCompanion<LeagueRule> {
  final Value<int> id;
  final Value<String> leagueSyncId;
  final Value<String> syncId;
  final Value<String> description;
  final Value<bool> isMandatory;
  final Value<DateTime> createdAt;
  const LeagueRulesCompanion({
    this.id = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.syncId = const Value.absent(),
    this.description = const Value.absent(),
    this.isMandatory = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LeagueRulesCompanion.insert({
    this.id = const Value.absent(),
    required String leagueSyncId,
    required String syncId,
    required String description,
    this.isMandatory = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : leagueSyncId = Value(leagueSyncId),
        syncId = Value(syncId),
        description = Value(description);
  static Insertable<LeagueRule> custom({
    Expression<int>? id,
    Expression<String>? leagueSyncId,
    Expression<String>? syncId,
    Expression<String>? description,
    Expression<bool>? isMandatory,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (syncId != null) 'sync_id': syncId,
      if (description != null) 'description': description,
      if (isMandatory != null) 'is_mandatory': isMandatory,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LeagueRulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? leagueSyncId,
      Value<String>? syncId,
      Value<String>? description,
      Value<bool>? isMandatory,
      Value<DateTime>? createdAt}) {
    return LeagueRulesCompanion(
      id: id ?? this.id,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      syncId: syncId ?? this.syncId,
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
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
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
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('syncId: $syncId, ')
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
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES leagues(sync_id) ON DELETE CASCADE');
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
        leagueSyncId,
        teamName,
        logoUrl,
        status,
        syncId,
        createdAt,
        updatedAt
      ];
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
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
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
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      teamName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_name'])!,
      logoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_url']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
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

  /// أساس الربط للمزامنة
  final String leagueSyncId;
  final String teamName;
  final String? logoUrl;
  final String status;
  final String syncId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Team(
      {required this.id,
      required this.leagueSyncId,
      required this.teamName,
      this.logoUrl,
      required this.status,
      required this.syncId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['team_name'] = Variable<String>(teamName);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    map['status'] = Variable<String>(status);
    map['sync_id'] = Variable<String>(syncId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      leagueSyncId: Value(leagueSyncId),
      teamName: Value(teamName),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      status: Value(status),
      syncId: Value(syncId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Team.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<int>(json['id']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      teamName: serializer.fromJson<String>(json['teamName']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      status: serializer.fromJson<String>(json['status']),
      syncId: serializer.fromJson<String>(json['syncId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'teamName': serializer.toJson<String>(teamName),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'status': serializer.toJson<String>(status),
      'syncId': serializer.toJson<String>(syncId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Team copyWith(
          {int? id,
          String? leagueSyncId,
          String? teamName,
          Value<String?> logoUrl = const Value.absent(),
          String? status,
          String? syncId,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Team(
        id: id ?? this.id,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        teamName: teamName ?? this.teamName,
        logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
        status: status ?? this.status,
        syncId: syncId ?? this.syncId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      status: data.status.present ? data.status.value : this.status,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('teamName: $teamName, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('syncId: $syncId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, leagueSyncId, teamName, logoUrl, status,
      syncId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.leagueSyncId == this.leagueSyncId &&
          other.teamName == this.teamName &&
          other.logoUrl == this.logoUrl &&
          other.status == this.status &&
          other.syncId == this.syncId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> leagueSyncId;
  final Value<String> teamName;
  final Value<String?> logoUrl;
  final Value<String> status;
  final Value<String> syncId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.teamName = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.syncId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String leagueSyncId,
    required String teamName,
    this.logoUrl = const Value.absent(),
    this.status = const Value.absent(),
    required String syncId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : leagueSyncId = Value(leagueSyncId),
        teamName = Value(teamName),
        syncId = Value(syncId);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? leagueSyncId,
    Expression<String>? teamName,
    Expression<String>? logoUrl,
    Expression<String>? status,
    Expression<String>? syncId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (teamName != null) 'team_name': teamName,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (status != null) 'status': status,
      if (syncId != null) 'sync_id': syncId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TeamsCompanion copyWith(
      {Value<int>? id,
      Value<String>? leagueSyncId,
      Value<String>? teamName,
      Value<String?>? logoUrl,
      Value<String>? status,
      Value<String>? syncId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TeamsCompanion(
      id: id ?? this.id,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      teamName: teamName ?? this.teamName,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      syncId: syncId ?? this.syncId,
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
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
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
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('teamName: $teamName, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('syncId: $syncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerLeagueSyncIdMeta =
      const VerificationMeta('playerLeagueSyncId');
  @override
  late final GeneratedColumn<String> playerLeagueSyncId =
      GeneratedColumn<String>('player_league_sync_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints:
              'NULL REFERENCES leaguePlayers(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _teamSyncIdMeta =
      const VerificationMeta('teamSyncId');
  @override
  late final GeneratedColumn<String> teamSyncId = GeneratedColumn<String>(
      'team_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES teams(sync_id) ON DELETE CASCADE');
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
        syncId,
        playerLeagueSyncId,
        teamSyncId,
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('player_league_sync_id')) {
      context.handle(
          _playerLeagueSyncIdMeta,
          playerLeagueSyncId.isAcceptableOrUnknown(
              data['player_league_sync_id']!, _playerLeagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_playerLeagueSyncIdMeta);
    }
    if (data.containsKey('team_sync_id')) {
      context.handle(
          _teamSyncIdMeta,
          teamSyncId.isAcceptableOrUnknown(
              data['team_sync_id']!, _teamSyncIdMeta));
    } else if (isInserting) {
      context.missing(_teamSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      playerLeagueSyncId: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}player_league_sync_id'])!,
      teamSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_sync_id'])!,
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
  final String syncId;
  final String playerLeagueSyncId;
  final String teamSyncId;
  final String fullName;
  final String? position;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Player(
      {required this.id,
      required this.syncId,
      required this.playerLeagueSyncId,
      required this.teamSyncId,
      required this.fullName,
      this.position,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['player_league_sync_id'] = Variable<String>(playerLeagueSyncId);
    map['team_sync_id'] = Variable<String>(teamSyncId);
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
      syncId: Value(syncId),
      playerLeagueSyncId: Value(playerLeagueSyncId),
      teamSyncId: Value(teamSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      playerLeagueSyncId:
          serializer.fromJson<String>(json['playerLeagueSyncId']),
      teamSyncId: serializer.fromJson<String>(json['teamSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'playerLeagueSyncId': serializer.toJson<String>(playerLeagueSyncId),
      'teamSyncId': serializer.toJson<String>(teamSyncId),
      'fullName': serializer.toJson<String>(fullName),
      'position': serializer.toJson<String?>(position),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Player copyWith(
          {int? id,
          String? syncId,
          String? playerLeagueSyncId,
          String? teamSyncId,
          String? fullName,
          Value<String?> position = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Player(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        playerLeagueSyncId: playerLeagueSyncId ?? this.playerLeagueSyncId,
        teamSyncId: teamSyncId ?? this.teamSyncId,
        fullName: fullName ?? this.fullName,
        position: position.present ? position.value : this.position,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      playerLeagueSyncId: data.playerLeagueSyncId.present
          ? data.playerLeagueSyncId.value
          : this.playerLeagueSyncId,
      teamSyncId:
          data.teamSyncId.present ? data.teamSyncId.value : this.teamSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('playerLeagueSyncId: $playerLeagueSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, playerLeagueSyncId, teamSyncId,
      fullName, position, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.playerLeagueSyncId == this.playerLeagueSyncId &&
          other.teamSyncId == this.teamSyncId &&
          other.fullName == this.fullName &&
          other.position == this.position &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> playerLeagueSyncId;
  final Value<String> teamSyncId;
  final Value<String> fullName;
  final Value<String?> position;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.playerLeagueSyncId = const Value.absent(),
    this.teamSyncId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.position = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String playerLeagueSyncId,
    required String teamSyncId,
    required String fullName,
    this.position = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : syncId = Value(syncId),
        playerLeagueSyncId = Value(playerLeagueSyncId),
        teamSyncId = Value(teamSyncId),
        fullName = Value(fullName);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? playerLeagueSyncId,
    Expression<String>? teamSyncId,
    Expression<String>? fullName,
    Expression<String>? position,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (playerLeagueSyncId != null)
        'player_league_sync_id': playerLeagueSyncId,
      if (teamSyncId != null) 'team_sync_id': teamSyncId,
      if (fullName != null) 'full_name': fullName,
      if (position != null) 'position': position,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? playerLeagueSyncId,
      Value<String>? teamSyncId,
      Value<String>? fullName,
      Value<String?>? position,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PlayersCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      playerLeagueSyncId: playerLeagueSyncId ?? this.playerLeagueSyncId,
      teamSyncId: teamSyncId ?? this.teamSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (playerLeagueSyncId.present) {
      map['player_league_sync_id'] = Variable<String>(playerLeagueSyncId.value);
    }
    if (teamSyncId.present) {
      map['team_sync_id'] = Variable<String>(teamSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('playerLeagueSyncId: $playerLeagueSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
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
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, leagueSyncId, name, syncId];
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
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
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
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
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

  /// أساس الربط للمزامنة
  final String leagueSyncId;
  final String name;
  final String syncId;
  const TeamPlayerCategory(
      {required this.id,
      required this.leagueSyncId,
      required this.name,
      required this.syncId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['name'] = Variable<String>(name);
    map['sync_id'] = Variable<String>(syncId);
    return map;
  }

  TeamPlayerCategoriesCompanion toCompanion(bool nullToAbsent) {
    return TeamPlayerCategoriesCompanion(
      id: Value(id),
      leagueSyncId: Value(leagueSyncId),
      name: Value(name),
      syncId: Value(syncId),
    );
  }

  factory TeamPlayerCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPlayerCategory(
      id: serializer.fromJson<int>(json['id']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      name: serializer.fromJson<String>(json['name']),
      syncId: serializer.fromJson<String>(json['syncId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'name': serializer.toJson<String>(name),
      'syncId': serializer.toJson<String>(syncId),
    };
  }

  TeamPlayerCategory copyWith(
          {int? id, String? leagueSyncId, String? name, String? syncId}) =>
      TeamPlayerCategory(
        id: id ?? this.id,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        name: name ?? this.name,
        syncId: syncId ?? this.syncId,
      );
  TeamPlayerCategory copyWithCompanion(TeamPlayerCategoriesCompanion data) {
    return TeamPlayerCategory(
      id: data.id.present ? data.id.value : this.id,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      name: data.name.present ? data.name.value : this.name,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerCategory(')
          ..write('id: $id, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('syncId: $syncId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, leagueSyncId, name, syncId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPlayerCategory &&
          other.id == this.id &&
          other.leagueSyncId == this.leagueSyncId &&
          other.name == this.name &&
          other.syncId == this.syncId);
}

class TeamPlayerCategoriesCompanion
    extends UpdateCompanion<TeamPlayerCategory> {
  final Value<int> id;
  final Value<String> leagueSyncId;
  final Value<String> name;
  final Value<String> syncId;
  const TeamPlayerCategoriesCompanion({
    this.id = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.name = const Value.absent(),
    this.syncId = const Value.absent(),
  });
  TeamPlayerCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String leagueSyncId,
    required String name,
    required String syncId,
  })  : leagueSyncId = Value(leagueSyncId),
        name = Value(name),
        syncId = Value(syncId);
  static Insertable<TeamPlayerCategory> custom({
    Expression<int>? id,
    Expression<String>? leagueSyncId,
    Expression<String>? name,
    Expression<String>? syncId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (name != null) 'name': name,
      if (syncId != null) 'sync_id': syncId,
    });
  }

  TeamPlayerCategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? leagueSyncId,
      Value<String>? name,
      Value<String>? syncId}) {
    return TeamPlayerCategoriesCompanion(
      id: id ?? this.id,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      name: name ?? this.name,
      syncId: syncId ?? this.syncId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('syncId: $syncId')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES leagues(sync_id) ON DELETE CASCADE');
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
  List<GeneratedColumn> get $columns => [
        id,
        syncId,
        name,
        code,
        leagueSyncId,
        teamPlayerCategoryId,
        createdAt,
        updatedAt
      ];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
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

  /// معرف مزامنة عالمي (UUID) يُستخدم مع الـ backend بدل id المحلي.
  final String syncId;
  final String? name;
  final String? code;

  /// الربط الاحترافي: نحتفظ بـ leagueId (للبيانات القديمة) + leagueSyncId (للمزامنة).
  /// الأساس في الاستعلامات الجديدة يكون leagueSyncId.
  final String leagueSyncId;
  final int? teamPlayerCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LeaguePlayer(
      {required this.id,
      required this.syncId,
      this.name,
      this.code,
      required this.leagueSyncId,
      this.teamPlayerCategoryId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['league_sync_id'] = Variable<String>(leagueSyncId);
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
      syncId: Value(syncId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      leagueSyncId: Value(leagueSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      name: serializer.fromJson<String?>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'name': serializer.toJson<String?>(name),
      'code': serializer.toJson<String?>(code),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'teamPlayerCategoryId': serializer.toJson<int?>(teamPlayerCategoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LeaguePlayer copyWith(
          {int? id,
          String? syncId,
          Value<String?> name = const Value.absent(),
          Value<String?> code = const Value.absent(),
          String? leagueSyncId,
          Value<int?> teamPlayerCategoryId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LeaguePlayer(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        name: name.present ? name.value : this.name,
        code: code.present ? code.value : this.code,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        teamPlayerCategoryId: teamPlayerCategoryId.present
            ? teamPlayerCategoryId.value
            : this.teamPlayerCategoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LeaguePlayer copyWithCompanion(LeaguePlayersCompanion data) {
    return LeaguePlayer(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('teamPlayerCategoryId: $teamPlayerCategoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, name, code, leagueSyncId,
      teamPlayerCategoryId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaguePlayer &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.name == this.name &&
          other.code == this.code &&
          other.leagueSyncId == this.leagueSyncId &&
          other.teamPlayerCategoryId == this.teamPlayerCategoryId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LeaguePlayersCompanion extends UpdateCompanion<LeaguePlayer> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String?> name;
  final Value<String?> code;
  final Value<String> leagueSyncId;
  final Value<int?> teamPlayerCategoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LeaguePlayersCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.teamPlayerCategoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeaguePlayersCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    required String leagueSyncId,
    this.teamPlayerCategoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId);
  static Insertable<LeaguePlayer> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? leagueSyncId,
    Expression<int>? teamPlayerCategoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (teamPlayerCategoryId != null)
        'team_player_category_id': teamPlayerCategoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeaguePlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String?>? name,
      Value<String?>? code,
      Value<String>? leagueSyncId,
      Value<int?>? teamPlayerCategoryId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LeaguePlayersCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      name: name ?? this.name,
      code: code ?? this.code,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('teamPlayerCategoryId: $teamPlayerCategoryId, ')
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(SyncQueueStatus.pending));
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
        entityType,
        entityId,
        operation,
        payload,
        synced,
        status,
        attemptCount,
        lastError,
        lastAttemptAt,
        createdAt
      ];
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
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
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
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
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

  /// للحفاظ على التوافق مع الاستعلامات الحالية.
  final bool synced;

  /// الحالة الأدق للمزامنة.
  final String status;

  /// عدد المحاولات التي تمت لهذا السجل.
  final int attemptCount;

  /// آخر رسالة خطأ (مختصرة) إن وُجدت.
  final String? lastError;

  /// وقت آخر محاولة مزامنة.
  final DateTime? lastAttemptAt;
  final DateTime createdAt;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.synced,
      required this.status,
      required this.attemptCount,
      this.lastError,
      this.lastAttemptAt,
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
    map['status'] = Variable<String>(status);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
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
      status: Value(status),
      attemptCount: Value(attemptCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
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
      status: serializer.fromJson<String>(json['status']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
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
      'status': serializer.toJson<String>(status),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastError': serializer.toJson<String?>(lastError),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
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
          String? status,
          int? attemptCount,
          Value<String?> lastError = const Value.absent(),
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          DateTime? createdAt}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        synced: synced ?? this.synced,
        status: status ?? this.status,
        attemptCount: attemptCount ?? this.attemptCount,
        lastError: lastError.present ? lastError.value : this.lastError,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
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
      status: data.status.present ? data.status.value : this.status,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
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
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId, operation, payload,
      synced, status, attemptCount, lastError, lastAttemptAt, createdAt);
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
          other.status == this.status &&
          other.attemptCount == this.attemptCount &&
          other.lastError == this.lastError &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<bool> synced;
  final Value<String> status;
  final Value<int> attemptCount;
  final Value<String?> lastError;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
    required String operation,
    required String payload,
    this.synced = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
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
    Expression<String>? status,
    Expression<int>? attemptCount,
    Expression<String>? lastError,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (synced != null) 'synced': synced,
      if (status != null) 'status': status,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastError != null) 'last_error': lastError,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
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
      Value<String>? status,
      Value<int>? attemptCount,
      Value<String?>? lastError,
      Value<DateTime?>? lastAttemptAt,
      Value<DateTime>? createdAt}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      synced: synced ?? this.synced,
      status: status ?? this.status,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
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
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
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
      [id, syncId, leagueSyncId, groupName, createdAt, qualifiedTeamNumber];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
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
  final String syncId;
  final String leagueSyncId;
  final String groupName;
  final DateTime createdAt;
  final int qualifiedTeamNumber;
  const GroupData(
      {required this.id,
      required this.syncId,
      required this.leagueSyncId,
      required this.groupName,
      required this.createdAt,
      required this.qualifiedTeamNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['group_name'] = Variable<String>(groupName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['qualified_team_number'] = Variable<int>(qualifiedTeamNumber);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'groupName': serializer.toJson<String>(groupName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'qualifiedTeamNumber': serializer.toJson<int>(qualifiedTeamNumber),
    };
  }

  GroupData copyWith(
          {int? id,
          String? syncId,
          String? leagueSyncId,
          String? groupName,
          DateTime? createdAt,
          int? qualifiedTeamNumber}) =>
      GroupData(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        groupName: groupName ?? this.groupName,
        createdAt: createdAt ?? this.createdAt,
        qualifiedTeamNumber: qualifiedTeamNumber ?? this.qualifiedTeamNumber,
      );
  GroupData copyWithCompanion(GroupCompanion data) {
    return GroupData(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('groupName: $groupName, ')
          ..write('createdAt: $createdAt, ')
          ..write('qualifiedTeamNumber: $qualifiedTeamNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, syncId, leagueSyncId, groupName, createdAt, qualifiedTeamNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.groupName == this.groupName &&
          other.createdAt == this.createdAt &&
          other.qualifiedTeamNumber == this.qualifiedTeamNumber);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> groupName;
  final Value<DateTime> createdAt;
  final Value<int> qualifiedTeamNumber;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.qualifiedTeamNumber = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String leagueSyncId,
    required String groupName,
    this.createdAt = const Value.absent(),
    this.qualifiedTeamNumber = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        groupName = Value(groupName);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? groupName,
    Expression<DateTime>? createdAt,
    Expression<int>? qualifiedTeamNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (groupName != null) 'group_name': groupName,
      if (createdAt != null) 'created_at': createdAt,
      if (qualifiedTeamNumber != null)
        'qualified_team_number': qualifiedTeamNumber,
    });
  }

  GroupCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? groupName,
      Value<DateTime>? createdAt,
      Value<int>? qualifiedTeamNumber}) {
    return GroupCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupSyncIdMeta =
      const VerificationMeta('groupSyncId');
  @override
  late final GeneratedColumn<String> groupSyncId = GeneratedColumn<String>(
      'group_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES "group"(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _teamSyncIdMeta =
      const VerificationMeta('teamSyncId');
  @override
  late final GeneratedColumn<String> teamSyncId = GeneratedColumn<String>(
      'team_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES teams(sync_id) ON DELETE CASCADE');
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
      [id, syncId, groupSyncId, teamSyncId, createdAt, updatedAt];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('group_sync_id')) {
      context.handle(
          _groupSyncIdMeta,
          groupSyncId.isAcceptableOrUnknown(
              data['group_sync_id']!, _groupSyncIdMeta));
    } else if (isInserting) {
      context.missing(_groupSyncIdMeta);
    }
    if (data.containsKey('team_sync_id')) {
      context.handle(
          _teamSyncIdMeta,
          teamSyncId.isAcceptableOrUnknown(
              data['team_sync_id']!, _teamSyncIdMeta));
    } else if (isInserting) {
      context.missing(_teamSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      groupSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_sync_id'])!,
      teamSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_sync_id'])!,
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
  final String syncId;
  final String groupSyncId;
  final String teamSyncId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GroupTeamData(
      {required this.id,
      required this.syncId,
      required this.groupSyncId,
      required this.teamSyncId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['group_sync_id'] = Variable<String>(groupSyncId);
    map['team_sync_id'] = Variable<String>(teamSyncId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GroupTeamCompanion toCompanion(bool nullToAbsent) {
    return GroupTeamCompanion(
      id: Value(id),
      syncId: Value(syncId),
      groupSyncId: Value(groupSyncId),
      teamSyncId: Value(teamSyncId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GroupTeamData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupTeamData(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      groupSyncId: serializer.fromJson<String>(json['groupSyncId']),
      teamSyncId: serializer.fromJson<String>(json['teamSyncId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'groupSyncId': serializer.toJson<String>(groupSyncId),
      'teamSyncId': serializer.toJson<String>(teamSyncId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GroupTeamData copyWith(
          {int? id,
          String? syncId,
          String? groupSyncId,
          String? teamSyncId,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GroupTeamData(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        groupSyncId: groupSyncId ?? this.groupSyncId,
        teamSyncId: teamSyncId ?? this.teamSyncId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GroupTeamData copyWithCompanion(GroupTeamCompanion data) {
    return GroupTeamData(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      groupSyncId:
          data.groupSyncId.present ? data.groupSyncId.value : this.groupSyncId,
      teamSyncId:
          data.teamSyncId.present ? data.teamSyncId.value : this.teamSyncId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupTeamData(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, syncId, groupSyncId, teamSyncId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupTeamData &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.groupSyncId == this.groupSyncId &&
          other.teamSyncId == this.teamSyncId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GroupTeamCompanion extends UpdateCompanion<GroupTeamData> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> groupSyncId;
  final Value<String> teamSyncId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GroupTeamCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.groupSyncId = const Value.absent(),
    this.teamSyncId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GroupTeamCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String groupSyncId,
    required String teamSyncId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : syncId = Value(syncId),
        groupSyncId = Value(groupSyncId),
        teamSyncId = Value(teamSyncId);
  static Insertable<GroupTeamData> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? groupSyncId,
    Expression<String>? teamSyncId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (groupSyncId != null) 'group_sync_id': groupSyncId,
      if (teamSyncId != null) 'team_sync_id': teamSyncId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GroupTeamCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? groupSyncId,
      Value<String>? teamSyncId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return GroupTeamCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      groupSyncId: groupSyncId ?? this.groupSyncId,
      teamSyncId: teamSyncId ?? this.teamSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (groupSyncId.present) {
      map['group_sync_id'] = Variable<String>(groupSyncId.value);
    }
    if (teamSyncId.present) {
      map['team_sync_id'] = Variable<String>(teamSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _roundSyncIdMeta =
      const VerificationMeta('roundSyncId');
  @override
  late final GeneratedColumn<String> roundSyncId = GeneratedColumn<String>(
      'round_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES rounds(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _homeTeamSyncIdMeta =
      const VerificationMeta('homeTeamSyncId');
  @override
  late final GeneratedColumn<String> homeTeamSyncId = GeneratedColumn<String>(
      'home_team_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES teams(sync_id) ON DELETE RESTRICT');
  static const VerificationMeta _awayTeamSyncIdMeta =
      const VerificationMeta('awayTeamSyncId');
  @override
  late final GeneratedColumn<String> awayTeamSyncId = GeneratedColumn<String>(
      'away_team_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES teams(sync_id) ON DELETE RESTRICT');
  static const VerificationMeta _refereeSyncIdMeta =
      const VerificationMeta('refereeSyncId');
  @override
  late final GeneratedColumn<String> refereeSyncId = GeneratedColumn<String>(
      'referee_sync_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES users_has_role(sync_id) ON DELETE SET NULL');
  static const VerificationMeta _mediaSyncIdMeta =
      const VerificationMeta('mediaSyncId');
  @override
  late final GeneratedColumn<String> mediaSyncId = GeneratedColumn<String>(
      'media_sync_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES users_has_role(sync_id) ON DELETE SET NULL');
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
        syncId,
        leagueSyncId,
        roundSyncId,
        homeTeamSyncId,
        awayTeamSyncId,
        refereeSyncId,
        mediaSyncId,
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('round_sync_id')) {
      context.handle(
          _roundSyncIdMeta,
          roundSyncId.isAcceptableOrUnknown(
              data['round_sync_id']!, _roundSyncIdMeta));
    } else if (isInserting) {
      context.missing(_roundSyncIdMeta);
    }
    if (data.containsKey('home_team_sync_id')) {
      context.handle(
          _homeTeamSyncIdMeta,
          homeTeamSyncId.isAcceptableOrUnknown(
              data['home_team_sync_id']!, _homeTeamSyncIdMeta));
    } else if (isInserting) {
      context.missing(_homeTeamSyncIdMeta);
    }
    if (data.containsKey('away_team_sync_id')) {
      context.handle(
          _awayTeamSyncIdMeta,
          awayTeamSyncId.isAcceptableOrUnknown(
              data['away_team_sync_id']!, _awayTeamSyncIdMeta));
    } else if (isInserting) {
      context.missing(_awayTeamSyncIdMeta);
    }
    if (data.containsKey('referee_sync_id')) {
      context.handle(
          _refereeSyncIdMeta,
          refereeSyncId.isAcceptableOrUnknown(
              data['referee_sync_id']!, _refereeSyncIdMeta));
    }
    if (data.containsKey('media_sync_id')) {
      context.handle(
          _mediaSyncIdMeta,
          mediaSyncId.isAcceptableOrUnknown(
              data['media_sync_id']!, _mediaSyncIdMeta));
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      roundSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_sync_id'])!,
      homeTeamSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}home_team_sync_id'])!,
      awayTeamSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}away_team_sync_id'])!,
      refereeSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}referee_sync_id']),
      mediaSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_sync_id']),
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
  final String syncId;
  final String leagueSyncId;

  /// ✅ sync-based FK to rounds(sync_id)
  final String roundSyncId;

  /// ✅ sync-based FK to teams(sync_id)
  final String homeTeamSyncId;

  /// ✅ sync-based FK to teams(sync_id)
  final String awayTeamSyncId;
  final String? refereeSyncId;
  final String? mediaSyncId;
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
      required this.syncId,
      required this.leagueSyncId,
      required this.roundSyncId,
      required this.homeTeamSyncId,
      required this.awayTeamSyncId,
      this.refereeSyncId,
      this.mediaSyncId,
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
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['round_sync_id'] = Variable<String>(roundSyncId);
    map['home_team_sync_id'] = Variable<String>(homeTeamSyncId);
    map['away_team_sync_id'] = Variable<String>(awayTeamSyncId);
    if (!nullToAbsent || refereeSyncId != null) {
      map['referee_sync_id'] = Variable<String>(refereeSyncId);
    }
    if (!nullToAbsent || mediaSyncId != null) {
      map['media_sync_id'] = Variable<String>(mediaSyncId);
    }
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
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      roundSyncId: Value(roundSyncId),
      homeTeamSyncId: Value(homeTeamSyncId),
      awayTeamSyncId: Value(awayTeamSyncId),
      refereeSyncId: refereeSyncId == null && nullToAbsent
          ? const Value.absent()
          : Value(refereeSyncId),
      mediaSyncId: mediaSyncId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      roundSyncId: serializer.fromJson<String>(json['roundSyncId']),
      homeTeamSyncId: serializer.fromJson<String>(json['homeTeamSyncId']),
      awayTeamSyncId: serializer.fromJson<String>(json['awayTeamSyncId']),
      refereeSyncId: serializer.fromJson<String?>(json['refereeSyncId']),
      mediaSyncId: serializer.fromJson<String?>(json['mediaSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'roundSyncId': serializer.toJson<String>(roundSyncId),
      'homeTeamSyncId': serializer.toJson<String>(homeTeamSyncId),
      'awayTeamSyncId': serializer.toJson<String>(awayTeamSyncId),
      'refereeSyncId': serializer.toJson<String?>(refereeSyncId),
      'mediaSyncId': serializer.toJson<String?>(mediaSyncId),
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
          String? syncId,
          String? leagueSyncId,
          String? roundSyncId,
          String? homeTeamSyncId,
          String? awayTeamSyncId,
          Value<String?> refereeSyncId = const Value.absent(),
          Value<String?> mediaSyncId = const Value.absent(),
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
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        roundSyncId: roundSyncId ?? this.roundSyncId,
        homeTeamSyncId: homeTeamSyncId ?? this.homeTeamSyncId,
        awayTeamSyncId: awayTeamSyncId ?? this.awayTeamSyncId,
        refereeSyncId:
            refereeSyncId.present ? refereeSyncId.value : this.refereeSyncId,
        mediaSyncId: mediaSyncId.present ? mediaSyncId.value : this.mediaSyncId,
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
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      roundSyncId:
          data.roundSyncId.present ? data.roundSyncId.value : this.roundSyncId,
      homeTeamSyncId: data.homeTeamSyncId.present
          ? data.homeTeamSyncId.value
          : this.homeTeamSyncId,
      awayTeamSyncId: data.awayTeamSyncId.present
          ? data.awayTeamSyncId.value
          : this.awayTeamSyncId,
      refereeSyncId: data.refereeSyncId.present
          ? data.refereeSyncId.value
          : this.refereeSyncId,
      mediaSyncId:
          data.mediaSyncId.present ? data.mediaSyncId.value : this.mediaSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('roundSyncId: $roundSyncId, ')
          ..write('homeTeamSyncId: $homeTeamSyncId, ')
          ..write('awayTeamSyncId: $awayTeamSyncId, ')
          ..write('refereeSyncId: $refereeSyncId, ')
          ..write('mediaSyncId: $mediaSyncId, ')
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
      syncId,
      leagueSyncId,
      roundSyncId,
      homeTeamSyncId,
      awayTeamSyncId,
      refereeSyncId,
      mediaSyncId,
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
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.roundSyncId == this.roundSyncId &&
          other.homeTeamSyncId == this.homeTeamSyncId &&
          other.awayTeamSyncId == this.awayTeamSyncId &&
          other.refereeSyncId == this.refereeSyncId &&
          other.mediaSyncId == this.mediaSyncId &&
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
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> roundSyncId;
  final Value<String> homeTeamSyncId;
  final Value<String> awayTeamSyncId;
  final Value<String?> refereeSyncId;
  final Value<String?> mediaSyncId;
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
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.roundSyncId = const Value.absent(),
    this.homeTeamSyncId = const Value.absent(),
    this.awayTeamSyncId = const Value.absent(),
    this.refereeSyncId = const Value.absent(),
    this.mediaSyncId = const Value.absent(),
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
    required String syncId,
    required String leagueSyncId,
    required String roundSyncId,
    required String homeTeamSyncId,
    required String awayTeamSyncId,
    this.refereeSyncId = const Value.absent(),
    this.mediaSyncId = const Value.absent(),
    required DateTime matchDate,
    this.scheduledStartTime = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.homeScore = const Value.absent(),
    this.awayScore = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        roundSyncId = Value(roundSyncId),
        homeTeamSyncId = Value(homeTeamSyncId),
        awayTeamSyncId = Value(awayTeamSyncId),
        matchDate = Value(matchDate);
  static Insertable<Matche> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? roundSyncId,
    Expression<String>? homeTeamSyncId,
    Expression<String>? awayTeamSyncId,
    Expression<String>? refereeSyncId,
    Expression<String>? mediaSyncId,
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
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (roundSyncId != null) 'round_sync_id': roundSyncId,
      if (homeTeamSyncId != null) 'home_team_sync_id': homeTeamSyncId,
      if (awayTeamSyncId != null) 'away_team_sync_id': awayTeamSyncId,
      if (refereeSyncId != null) 'referee_sync_id': refereeSyncId,
      if (mediaSyncId != null) 'media_sync_id': mediaSyncId,
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
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? roundSyncId,
      Value<String>? homeTeamSyncId,
      Value<String>? awayTeamSyncId,
      Value<String?>? refereeSyncId,
      Value<String?>? mediaSyncId,
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
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      roundSyncId: roundSyncId ?? this.roundSyncId,
      homeTeamSyncId: homeTeamSyncId ?? this.homeTeamSyncId,
      awayTeamSyncId: awayTeamSyncId ?? this.awayTeamSyncId,
      refereeSyncId: refereeSyncId ?? this.refereeSyncId,
      mediaSyncId: mediaSyncId ?? this.mediaSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (roundSyncId.present) {
      map['round_sync_id'] = Variable<String>(roundSyncId.value);
    }
    if (homeTeamSyncId.present) {
      map['home_team_sync_id'] = Variable<String>(homeTeamSyncId.value);
    }
    if (awayTeamSyncId.present) {
      map['away_team_sync_id'] = Variable<String>(awayTeamSyncId.value);
    }
    if (refereeSyncId.present) {
      map['referee_sync_id'] = Variable<String>(refereeSyncId.value);
    }
    if (mediaSyncId.present) {
      map['media_sync_id'] = Variable<String>(mediaSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('roundSyncId: $roundSyncId, ')
          ..write('homeTeamSyncId: $homeTeamSyncId, ')
          ..write('awayTeamSyncId: $awayTeamSyncId, ')
          ..write('refereeSyncId: $refereeSyncId, ')
          ..write('mediaSyncId: $mediaSyncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'round_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupSyncIdMeta =
      const VerificationMeta('groupSyncId');
  @override
  late final GeneratedColumn<String> groupSyncId = GeneratedColumn<String>(
      'group_sync_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES "group"(sync_id) ON DELETE CASCADE');
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
      [id, syncId, leagueSyncId, name, groupSyncId, roundType, createdAt];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('round_name')) {
      context.handle(_nameMeta,
          name.isAcceptableOrUnknown(data['round_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_sync_id')) {
      context.handle(
          _groupSyncIdMeta,
          groupSyncId.isAcceptableOrUnknown(
              data['group_sync_id']!, _groupSyncIdMeta));
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}round_name'])!,
      groupSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_sync_id']),
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
  final String syncId;
  final String leagueSyncId;
  final String name;
  final String? groupSyncId;
  final String roundType;
  final DateTime createdAt;
  const Round(
      {required this.id,
      required this.syncId,
      required this.leagueSyncId,
      required this.name,
      this.groupSyncId,
      required this.roundType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['round_name'] = Variable<String>(name);
    if (!nullToAbsent || groupSyncId != null) {
      map['group_sync_id'] = Variable<String>(groupSyncId);
    }
    map['round_type'] = Variable<String>(roundType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoundsCompanion toCompanion(bool nullToAbsent) {
    return RoundsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      name: Value(name),
      groupSyncId: groupSyncId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupSyncId),
      roundType: Value(roundType),
      createdAt: Value(createdAt),
    );
  }

  factory Round.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Round(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      name: serializer.fromJson<String>(json['name']),
      groupSyncId: serializer.fromJson<String?>(json['groupSyncId']),
      roundType: serializer.fromJson<String>(json['roundType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'name': serializer.toJson<String>(name),
      'groupSyncId': serializer.toJson<String?>(groupSyncId),
      'roundType': serializer.toJson<String>(roundType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Round copyWith(
          {int? id,
          String? syncId,
          String? leagueSyncId,
          String? name,
          Value<String?> groupSyncId = const Value.absent(),
          String? roundType,
          DateTime? createdAt}) =>
      Round(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        name: name ?? this.name,
        groupSyncId: groupSyncId.present ? groupSyncId.value : this.groupSyncId,
        roundType: roundType ?? this.roundType,
        createdAt: createdAt ?? this.createdAt,
      );
  Round copyWithCompanion(RoundsCompanion data) {
    return Round(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      name: data.name.present ? data.name.value : this.name,
      groupSyncId:
          data.groupSyncId.present ? data.groupSyncId.value : this.groupSyncId,
      roundType: data.roundType.present ? data.roundType.value : this.roundType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Round(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('roundType: $roundType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, syncId, leagueSyncId, name, groupSyncId, roundType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Round &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.name == this.name &&
          other.groupSyncId == this.groupSyncId &&
          other.roundType == this.roundType &&
          other.createdAt == this.createdAt);
}

class RoundsCompanion extends UpdateCompanion<Round> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> name;
  final Value<String?> groupSyncId;
  final Value<String> roundType;
  final Value<DateTime> createdAt;
  const RoundsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.name = const Value.absent(),
    this.groupSyncId = const Value.absent(),
    this.roundType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RoundsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String leagueSyncId,
    required String name,
    this.groupSyncId = const Value.absent(),
    required String roundType,
    this.createdAt = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        name = Value(name),
        roundType = Value(roundType);
  static Insertable<Round> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? name,
    Expression<String>? groupSyncId,
    Expression<String>? roundType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (name != null) 'round_name': name,
      if (groupSyncId != null) 'group_sync_id': groupSyncId,
      if (roundType != null) 'round_type': roundType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RoundsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? name,
      Value<String?>? groupSyncId,
      Value<String>? roundType,
      Value<DateTime>? createdAt}) {
    return RoundsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      name: name ?? this.name,
      groupSyncId: groupSyncId ?? this.groupSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (name.present) {
      map['round_name'] = Variable<String>(name.value);
    }
    if (groupSyncId.present) {
      map['group_sync_id'] = Variable<String>(groupSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('roundType: $roundType, ')
          ..write('createdAt: $createdAt')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _groupSyncIdMeta =
      const VerificationMeta('groupSyncId');
  @override
  late final GeneratedColumn<String> groupSyncId = GeneratedColumn<String>(
      'group_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES "group"(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _teamSyncIdMeta =
      const VerificationMeta('teamSyncId');
  @override
  late final GeneratedColumn<String> teamSyncId = GeneratedColumn<String>(
      'team_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES teams(sync_id) ON DELETE CASCADE');
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
        syncId,
        leagueSyncId,
        groupSyncId,
        teamSyncId,
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('group_sync_id')) {
      context.handle(
          _groupSyncIdMeta,
          groupSyncId.isAcceptableOrUnknown(
              data['group_sync_id']!, _groupSyncIdMeta));
    } else if (isInserting) {
      context.missing(_groupSyncIdMeta);
    }
    if (data.containsKey('team_sync_id')) {
      context.handle(
          _teamSyncIdMeta,
          teamSyncId.isAcceptableOrUnknown(
              data['team_sync_id']!, _teamSyncIdMeta));
    } else if (isInserting) {
      context.missing(_teamSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      groupSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_sync_id'])!,
      teamSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_sync_id'])!,
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
  final String syncId;
  final String leagueSyncId;
  final String groupSyncId;
  final String teamSyncId;
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
      required this.syncId,
      required this.leagueSyncId,
      required this.groupSyncId,
      required this.teamSyncId,
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
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['group_sync_id'] = Variable<String>(groupSyncId);
    map['team_sync_id'] = Variable<String>(teamSyncId);
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
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      groupSyncId: Value(groupSyncId),
      teamSyncId: Value(teamSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      groupSyncId: serializer.fromJson<String>(json['groupSyncId']),
      teamSyncId: serializer.fromJson<String>(json['teamSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'groupSyncId': serializer.toJson<String>(groupSyncId),
      'teamSyncId': serializer.toJson<String>(teamSyncId),
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
          String? syncId,
          String? leagueSyncId,
          String? groupSyncId,
          String? teamSyncId,
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
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        groupSyncId: groupSyncId ?? this.groupSyncId,
        teamSyncId: teamSyncId ?? this.teamSyncId,
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
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      groupSyncId:
          data.groupSyncId.present ? data.groupSyncId.value : this.groupSyncId,
      teamSyncId:
          data.teamSyncId.present ? data.teamSyncId.value : this.teamSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
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
      syncId,
      leagueSyncId,
      groupSyncId,
      teamSyncId,
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
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.groupSyncId == this.groupSyncId &&
          other.teamSyncId == this.teamSyncId &&
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
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> groupSyncId;
  final Value<String> teamSyncId;
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
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.groupSyncId = const Value.absent(),
    this.teamSyncId = const Value.absent(),
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
    required String syncId,
    required String leagueSyncId,
    required String groupSyncId,
    required String teamSyncId,
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
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        groupSyncId = Value(groupSyncId),
        teamSyncId = Value(teamSyncId);
  static Insertable<QualifiedTeamData> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? groupSyncId,
    Expression<String>? teamSyncId,
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
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (groupSyncId != null) 'group_sync_id': groupSyncId,
      if (teamSyncId != null) 'team_sync_id': teamSyncId,
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
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? groupSyncId,
      Value<String>? teamSyncId,
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
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      groupSyncId: groupSyncId ?? this.groupSyncId,
      teamSyncId: teamSyncId ?? this.teamSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (groupSyncId.present) {
      map['group_sync_id'] = Variable<String>(groupSyncId.value);
    }
    if (teamSyncId.present) {
      map['team_sync_id'] = Variable<String>(teamSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('groupSyncId: $groupSyncId, ')
          ..write('teamSyncId: $teamSyncId, ')
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
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
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
        leagueSyncId,
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
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {leagueSyncId};
  @override
  LeagueStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeagueStatusData(
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
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
  /// الأساس الجديد: الربط عبر sync id
  final String leagueSyncId;
  final bool hasGroups;
  final bool hasTeamsInGroups;
  final bool hasMatches;
  final bool hasPlayersAssigned;
  final DateTime? updatedAt;
  const LeagueStatusData(
      {required this.leagueSyncId,
      required this.hasGroups,
      required this.hasTeamsInGroups,
      required this.hasMatches,
      required this.hasPlayersAssigned,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['league_sync_id'] = Variable<String>(leagueSyncId);
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
      leagueSyncId: Value(leagueSyncId),
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
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
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
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'hasGroups': serializer.toJson<bool>(hasGroups),
      'hasTeamsInGroups': serializer.toJson<bool>(hasTeamsInGroups),
      'hasMatches': serializer.toJson<bool>(hasMatches),
      'hasPlayersAssigned': serializer.toJson<bool>(hasPlayersAssigned),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LeagueStatusData copyWith(
          {String? leagueSyncId,
          bool? hasGroups,
          bool? hasTeamsInGroups,
          bool? hasMatches,
          bool? hasPlayersAssigned,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      LeagueStatusData(
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        hasGroups: hasGroups ?? this.hasGroups,
        hasTeamsInGroups: hasTeamsInGroups ?? this.hasTeamsInGroups,
        hasMatches: hasMatches ?? this.hasMatches,
        hasPlayersAssigned: hasPlayersAssigned ?? this.hasPlayersAssigned,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  LeagueStatusData copyWithCompanion(LeagueStatusCompanion data) {
    return LeagueStatusData(
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
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
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('hasGroups: $hasGroups, ')
          ..write('hasTeamsInGroups: $hasTeamsInGroups, ')
          ..write('hasMatches: $hasMatches, ')
          ..write('hasPlayersAssigned: $hasPlayersAssigned, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(leagueSyncId, hasGroups, hasTeamsInGroups,
      hasMatches, hasPlayersAssigned, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueStatusData &&
          other.leagueSyncId == this.leagueSyncId &&
          other.hasGroups == this.hasGroups &&
          other.hasTeamsInGroups == this.hasTeamsInGroups &&
          other.hasMatches == this.hasMatches &&
          other.hasPlayersAssigned == this.hasPlayersAssigned &&
          other.updatedAt == this.updatedAt);
}

class LeagueStatusCompanion extends UpdateCompanion<LeagueStatusData> {
  final Value<String> leagueSyncId;
  final Value<bool> hasGroups;
  final Value<bool> hasTeamsInGroups;
  final Value<bool> hasMatches;
  final Value<bool> hasPlayersAssigned;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LeagueStatusCompanion({
    this.leagueSyncId = const Value.absent(),
    this.hasGroups = const Value.absent(),
    this.hasTeamsInGroups = const Value.absent(),
    this.hasMatches = const Value.absent(),
    this.hasPlayersAssigned = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeagueStatusCompanion.insert({
    required String leagueSyncId,
    this.hasGroups = const Value.absent(),
    this.hasTeamsInGroups = const Value.absent(),
    this.hasMatches = const Value.absent(),
    this.hasPlayersAssigned = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : leagueSyncId = Value(leagueSyncId);
  static Insertable<LeagueStatusData> custom({
    Expression<String>? leagueSyncId,
    Expression<bool>? hasGroups,
    Expression<bool>? hasTeamsInGroups,
    Expression<bool>? hasMatches,
    Expression<bool>? hasPlayersAssigned,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (hasGroups != null) 'has_groups': hasGroups,
      if (hasTeamsInGroups != null) 'has_teams_in_groups': hasTeamsInGroups,
      if (hasMatches != null) 'has_matches': hasMatches,
      if (hasPlayersAssigned != null)
        'has_players_assigned': hasPlayersAssigned,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeagueStatusCompanion copyWith(
      {Value<String>? leagueSyncId,
      Value<bool>? hasGroups,
      Value<bool>? hasTeamsInGroups,
      Value<bool>? hasMatches,
      Value<bool>? hasPlayersAssigned,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return LeagueStatusCompanion(
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      hasGroups: hasGroups ?? this.hasGroups,
      hasTeamsInGroups: hasTeamsInGroups ?? this.hasTeamsInGroups,
      hasMatches: hasMatches ?? this.hasMatches,
      hasPlayersAssigned: hasPlayersAssigned ?? this.hasPlayersAssigned,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeagueStatusCompanion(')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('hasGroups: $hasGroups, ')
          ..write('hasTeamsInGroups: $hasTeamsInGroups, ')
          ..write('hasMatches: $hasMatches, ')
          ..write('hasPlayersAssigned: $hasPlayersAssigned, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaginationMetaTable extends PaginationMeta
    with TableInfo<$PaginationMetaTable, PaginationMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaginationMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resourceMeta =
      const VerificationMeta('resource');
  @override
  late final GeneratedColumn<String> resource = GeneratedColumn<String>(
      'resource', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
      'scope', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('default'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parentKeyMeta =
      const VerificationMeta('parentKey');
  @override
  late final GeneratedColumn<String> parentKey = GeneratedColumn<String>(
      'parent_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastPageMeta =
      const VerificationMeta('lastPage');
  @override
  late final GeneratedColumn<int> lastPage = GeneratedColumn<int>(
      'last_page', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _perPageMeta =
      const VerificationMeta('perPage');
  @override
  late final GeneratedColumn<int> perPage = GeneratedColumn<int>(
      'per_page', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
      'total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
        resource,
        scope,
        key,
        parentKey,
        lastPage,
        perPage,
        total,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagination_meta';
  @override
  VerificationContext validateIntegrity(Insertable<PaginationMetaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resource')) {
      context.handle(_resourceMeta,
          resource.isAcceptableOrUnknown(data['resource']!, _resourceMeta));
    } else if (isInserting) {
      context.missing(_resourceMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
          _scopeMeta, scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('parent_key')) {
      context.handle(_parentKeyMeta,
          parentKey.isAcceptableOrUnknown(data['parent_key']!, _parentKeyMeta));
    }
    if (data.containsKey('last_page')) {
      context.handle(_lastPageMeta,
          lastPage.isAcceptableOrUnknown(data['last_page']!, _lastPageMeta));
    }
    if (data.containsKey('per_page')) {
      context.handle(_perPageMeta,
          perPage.isAcceptableOrUnknown(data['per_page']!, _perPageMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
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
  PaginationMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaginationMetaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource'])!,
      scope: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scope'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key']),
      parentKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_key']),
      lastPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_page'])!,
      perPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}per_page'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PaginationMetaTable createAlias(String alias) {
    return $PaginationMetaTable(attachedDatabase, alias);
  }
}

class PaginationMetaData extends DataClass
    implements Insertable<PaginationMetaData> {
  final int id;

  /// Resource name: e.g. 'leagues', 'teams', 'players', 'matches'.
  final String resource;

  /// Scope for variants of the same resource.
  /// Examples: 'public', 'private', 'all', 'mine', ...
  final String scope;

  /// Optional key for additional filtering/dimensions.
  /// Examples: searchTerm, sortKey, status, etc.
  final String? key;

  /// Optional parent identifier when pagination depends on a parent.
  /// Examples: leagueSyncId for matches list.
  final String? parentKey;
  final int lastPage;
  final int perPage;
  final int total;
  final DateTime updatedAt;
  const PaginationMetaData(
      {required this.id,
      required this.resource,
      required this.scope,
      this.key,
      this.parentKey,
      required this.lastPage,
      required this.perPage,
      required this.total,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resource'] = Variable<String>(resource);
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || parentKey != null) {
      map['parent_key'] = Variable<String>(parentKey);
    }
    map['last_page'] = Variable<int>(lastPage);
    map['per_page'] = Variable<int>(perPage);
    map['total'] = Variable<int>(total);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PaginationMetaCompanion toCompanion(bool nullToAbsent) {
    return PaginationMetaCompanion(
      id: Value(id),
      resource: Value(resource),
      scope: Value(scope),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      parentKey: parentKey == null && nullToAbsent
          ? const Value.absent()
          : Value(parentKey),
      lastPage: Value(lastPage),
      perPage: Value(perPage),
      total: Value(total),
      updatedAt: Value(updatedAt),
    );
  }

  factory PaginationMetaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaginationMetaData(
      id: serializer.fromJson<int>(json['id']),
      resource: serializer.fromJson<String>(json['resource']),
      scope: serializer.fromJson<String>(json['scope']),
      key: serializer.fromJson<String?>(json['key']),
      parentKey: serializer.fromJson<String?>(json['parentKey']),
      lastPage: serializer.fromJson<int>(json['lastPage']),
      perPage: serializer.fromJson<int>(json['perPage']),
      total: serializer.fromJson<int>(json['total']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resource': serializer.toJson<String>(resource),
      'scope': serializer.toJson<String>(scope),
      'key': serializer.toJson<String?>(key),
      'parentKey': serializer.toJson<String?>(parentKey),
      'lastPage': serializer.toJson<int>(lastPage),
      'perPage': serializer.toJson<int>(perPage),
      'total': serializer.toJson<int>(total),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PaginationMetaData copyWith(
          {int? id,
          String? resource,
          String? scope,
          Value<String?> key = const Value.absent(),
          Value<String?> parentKey = const Value.absent(),
          int? lastPage,
          int? perPage,
          int? total,
          DateTime? updatedAt}) =>
      PaginationMetaData(
        id: id ?? this.id,
        resource: resource ?? this.resource,
        scope: scope ?? this.scope,
        key: key.present ? key.value : this.key,
        parentKey: parentKey.present ? parentKey.value : this.parentKey,
        lastPage: lastPage ?? this.lastPage,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PaginationMetaData copyWithCompanion(PaginationMetaCompanion data) {
    return PaginationMetaData(
      id: data.id.present ? data.id.value : this.id,
      resource: data.resource.present ? data.resource.value : this.resource,
      scope: data.scope.present ? data.scope.value : this.scope,
      key: data.key.present ? data.key.value : this.key,
      parentKey: data.parentKey.present ? data.parentKey.value : this.parentKey,
      lastPage: data.lastPage.present ? data.lastPage.value : this.lastPage,
      perPage: data.perPage.present ? data.perPage.value : this.perPage,
      total: data.total.present ? data.total.value : this.total,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaginationMetaData(')
          ..write('id: $id, ')
          ..write('resource: $resource, ')
          ..write('scope: $scope, ')
          ..write('key: $key, ')
          ..write('parentKey: $parentKey, ')
          ..write('lastPage: $lastPage, ')
          ..write('perPage: $perPage, ')
          ..write('total: $total, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, resource, scope, key, parentKey, lastPage, perPage, total, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaginationMetaData &&
          other.id == this.id &&
          other.resource == this.resource &&
          other.scope == this.scope &&
          other.key == this.key &&
          other.parentKey == this.parentKey &&
          other.lastPage == this.lastPage &&
          other.perPage == this.perPage &&
          other.total == this.total &&
          other.updatedAt == this.updatedAt);
}

class PaginationMetaCompanion extends UpdateCompanion<PaginationMetaData> {
  final Value<int> id;
  final Value<String> resource;
  final Value<String> scope;
  final Value<String?> key;
  final Value<String?> parentKey;
  final Value<int> lastPage;
  final Value<int> perPage;
  final Value<int> total;
  final Value<DateTime> updatedAt;
  const PaginationMetaCompanion({
    this.id = const Value.absent(),
    this.resource = const Value.absent(),
    this.scope = const Value.absent(),
    this.key = const Value.absent(),
    this.parentKey = const Value.absent(),
    this.lastPage = const Value.absent(),
    this.perPage = const Value.absent(),
    this.total = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PaginationMetaCompanion.insert({
    this.id = const Value.absent(),
    required String resource,
    this.scope = const Value.absent(),
    this.key = const Value.absent(),
    this.parentKey = const Value.absent(),
    this.lastPage = const Value.absent(),
    this.perPage = const Value.absent(),
    this.total = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : resource = Value(resource);
  static Insertable<PaginationMetaData> custom({
    Expression<int>? id,
    Expression<String>? resource,
    Expression<String>? scope,
    Expression<String>? key,
    Expression<String>? parentKey,
    Expression<int>? lastPage,
    Expression<int>? perPage,
    Expression<int>? total,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resource != null) 'resource': resource,
      if (scope != null) 'scope': scope,
      if (key != null) 'key': key,
      if (parentKey != null) 'parent_key': parentKey,
      if (lastPage != null) 'last_page': lastPage,
      if (perPage != null) 'per_page': perPage,
      if (total != null) 'total': total,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PaginationMetaCompanion copyWith(
      {Value<int>? id,
      Value<String>? resource,
      Value<String>? scope,
      Value<String?>? key,
      Value<String?>? parentKey,
      Value<int>? lastPage,
      Value<int>? perPage,
      Value<int>? total,
      Value<DateTime>? updatedAt}) {
    return PaginationMetaCompanion(
      id: id ?? this.id,
      resource: resource ?? this.resource,
      scope: scope ?? this.scope,
      key: key ?? this.key,
      parentKey: parentKey ?? this.parentKey,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resource.present) {
      map['resource'] = Variable<String>(resource.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (parentKey.present) {
      map['parent_key'] = Variable<String>(parentKey.value);
    }
    if (lastPage.present) {
      map['last_page'] = Variable<int>(lastPage.value);
    }
    if (perPage.present) {
      map['per_page'] = Variable<int>(perPage.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaginationMetaCompanion(')
          ..write('id: $id, ')
          ..write('resource: $resource, ')
          ..write('scope: $scope, ')
          ..write('key: $key, ')
          ..write('parentKey: $parentKey, ')
          ..write('lastPage: $lastPage, ')
          ..write('perPage: $perPage, ')
          ..write('total: $total, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [id, syncId, name, type, order, createdAt];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
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
  final String syncId;
  final String name;

  /// نوع الشوط: عادي regular، إضافي extra، ركلات ترجيح penalty
  final String type;

  /// الترتيب (الشوط الأول = 1، الثاني = 2 ...)
  final int order;

  /// التاريخ في حال احتجنا تحديث الأشواط مستقبلًا
  final DateTime createdAt;
  const Term(
      {required this.id,
      required this.syncId,
      required this.name,
      required this.type,
      required this.order,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['order'] = Variable<int>(order);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TermsCompanion toCompanion(bool nullToAbsent) {
    return TermsCompanion(
      id: Value(id),
      syncId: Value(syncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'order': serializer.toJson<int>(order),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Term copyWith(
          {int? id,
          String? syncId,
          String? name,
          String? type,
          int? order,
          DateTime? createdAt}) =>
      Term(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
      );
  Term copyWithCompanion(TermsCompanion data) {
    return Term(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
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
          ..write('syncId: $syncId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, name, type, order, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Term &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.name == this.name &&
          other.type == this.type &&
          other.order == this.order &&
          other.createdAt == this.createdAt);
}

class TermsCompanion extends UpdateCompanion<Term> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> name;
  final Value<String> type;
  final Value<int> order;
  final Value<DateTime> createdAt;
  const TermsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TermsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String name,
    required String type,
    required int order,
    this.createdAt = const Value.absent(),
  })  : syncId = Value(syncId),
        name = Value(name),
        type = Value(type),
        order = Value(order);
  static Insertable<Term> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? order,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TermsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? name,
      Value<String>? type,
      Value<int>? order,
      Value<DateTime>? createdAt}) {
    return TermsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
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
          ..write('syncId: $syncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _termSyncIdMeta =
      const VerificationMeta('termSyncId');
  @override
  late final GeneratedColumn<String> termSyncId = GeneratedColumn<String>(
      'term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES terms(sync_id) ON DELETE CASCADE');
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
  List<GeneratedColumn> get $columns => [
        id,
        syncId,
        leagueSyncId,
        termSyncId,
        durationMinutes,
        createdAt,
        updatedAt
      ];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('term_sync_id')) {
      context.handle(
          _termSyncIdMeta,
          termSyncId.isAcceptableOrUnknown(
              data['term_sync_id']!, _termSyncIdMeta));
    } else if (isInserting) {
      context.missing(_termSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      termSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term_sync_id'])!,
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
  final String syncId;
  final String leagueSyncId;
  final String termSyncId;
  final int durationMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LeagueTerm(
      {required this.id,
      required this.syncId,
      required this.leagueSyncId,
      required this.termSyncId,
      required this.durationMinutes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['term_sync_id'] = Variable<String>(termSyncId);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LeagueTermsCompanion toCompanion(bool nullToAbsent) {
    return LeagueTermsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      termSyncId: Value(termSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      termSyncId: serializer.fromJson<String>(json['termSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'termSyncId': serializer.toJson<String>(termSyncId),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LeagueTerm copyWith(
          {int? id,
          String? syncId,
          String? leagueSyncId,
          String? termSyncId,
          int? durationMinutes,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LeagueTerm(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        termSyncId: termSyncId ?? this.termSyncId,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LeagueTerm copyWithCompanion(LeagueTermsCompanion data) {
    return LeagueTerm(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      termSyncId:
          data.termSyncId.present ? data.termSyncId.value : this.termSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('termSyncId: $termSyncId, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, leagueSyncId, termSyncId,
      durationMinutes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueTerm &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.termSyncId == this.termSyncId &&
          other.durationMinutes == this.durationMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LeagueTermsCompanion extends UpdateCompanion<LeagueTerm> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> termSyncId;
  final Value<int> durationMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LeagueTermsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.termSyncId = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LeagueTermsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String leagueSyncId,
    required String termSyncId,
    this.durationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        termSyncId = Value(termSyncId);
  static Insertable<LeagueTerm> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? termSyncId,
    Expression<int>? durationMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (termSyncId != null) 'term_sync_id': termSyncId,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LeagueTermsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? termSyncId,
      Value<int>? durationMinutes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LeagueTermsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      termSyncId: termSyncId ?? this.termSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (termSyncId.present) {
      map['term_sync_id'] = Variable<String>(termSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('termSyncId: $termSyncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _matchSyncIdMeta =
      const VerificationMeta('matchSyncId');
  @override
  late final GeneratedColumn<String> matchSyncId = GeneratedColumn<String>(
      'match_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matches(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _leagueTermSyncIdMeta =
      const VerificationMeta('leagueTermSyncId');
  @override
  late final GeneratedColumn<String> leagueTermSyncId = GeneratedColumn<String>(
      'league_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagueTerms(sync_id) ON DELETE CASCADE');
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
        syncId,
        matchSyncId,
        leagueTermSyncId,
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('match_sync_id')) {
      context.handle(
          _matchSyncIdMeta,
          matchSyncId.isAcceptableOrUnknown(
              data['match_sync_id']!, _matchSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchSyncIdMeta);
    }
    if (data.containsKey('league_term_sync_id')) {
      context.handle(
          _leagueTermSyncIdMeta,
          leagueTermSyncId.isAcceptableOrUnknown(
              data['league_term_sync_id']!, _leagueTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueTermSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      matchSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_sync_id'])!,
      leagueTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}league_term_sync_id'])!,
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
  final String syncId;
  final String matchSyncId;
  final String leagueTermSyncId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int additionalMinutes;
  final bool isFinished;
  final DateTime createdAt;
  const MatchTerm(
      {required this.id,
      required this.syncId,
      required this.matchSyncId,
      required this.leagueTermSyncId,
      this.startTime,
      this.endTime,
      required this.additionalMinutes,
      required this.isFinished,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['match_sync_id'] = Variable<String>(matchSyncId);
    map['league_term_sync_id'] = Variable<String>(leagueTermSyncId);
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
      syncId: Value(syncId),
      matchSyncId: Value(matchSyncId),
      leagueTermSyncId: Value(leagueTermSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      matchSyncId: serializer.fromJson<String>(json['matchSyncId']),
      leagueTermSyncId: serializer.fromJson<String>(json['leagueTermSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'matchSyncId': serializer.toJson<String>(matchSyncId),
      'leagueTermSyncId': serializer.toJson<String>(leagueTermSyncId),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'additionalMinutes': serializer.toJson<int>(additionalMinutes),
      'isFinished': serializer.toJson<bool>(isFinished),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MatchTerm copyWith(
          {int? id,
          String? syncId,
          String? matchSyncId,
          String? leagueTermSyncId,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          int? additionalMinutes,
          bool? isFinished,
          DateTime? createdAt}) =>
      MatchTerm(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        matchSyncId: matchSyncId ?? this.matchSyncId,
        leagueTermSyncId: leagueTermSyncId ?? this.leagueTermSyncId,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        additionalMinutes: additionalMinutes ?? this.additionalMinutes,
        isFinished: isFinished ?? this.isFinished,
        createdAt: createdAt ?? this.createdAt,
      );
  MatchTerm copyWithCompanion(MatchTermsCompanion data) {
    return MatchTerm(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      matchSyncId:
          data.matchSyncId.present ? data.matchSyncId.value : this.matchSyncId,
      leagueTermSyncId: data.leagueTermSyncId.present
          ? data.leagueTermSyncId.value
          : this.leagueTermSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('leagueTermSyncId: $leagueTermSyncId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('additionalMinutes: $additionalMinutes, ')
          ..write('isFinished: $isFinished, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, matchSyncId, leagueTermSyncId,
      startTime, endTime, additionalMinutes, isFinished, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchTerm &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.matchSyncId == this.matchSyncId &&
          other.leagueTermSyncId == this.leagueTermSyncId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.additionalMinutes == this.additionalMinutes &&
          other.isFinished == this.isFinished &&
          other.createdAt == this.createdAt);
}

class MatchTermsCompanion extends UpdateCompanion<MatchTerm> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> matchSyncId;
  final Value<String> leagueTermSyncId;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int> additionalMinutes;
  final Value<bool> isFinished;
  final Value<DateTime> createdAt;
  const MatchTermsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.matchSyncId = const Value.absent(),
    this.leagueTermSyncId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.additionalMinutes = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MatchTermsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String matchSyncId,
    required String leagueTermSyncId,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.additionalMinutes = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : syncId = Value(syncId),
        matchSyncId = Value(matchSyncId),
        leagueTermSyncId = Value(leagueTermSyncId);
  static Insertable<MatchTerm> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? matchSyncId,
    Expression<String>? leagueTermSyncId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? additionalMinutes,
    Expression<bool>? isFinished,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (matchSyncId != null) 'match_sync_id': matchSyncId,
      if (leagueTermSyncId != null) 'league_term_sync_id': leagueTermSyncId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (additionalMinutes != null) 'additional_minutes': additionalMinutes,
      if (isFinished != null) 'is_finished': isFinished,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MatchTermsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? matchSyncId,
      Value<String>? leagueTermSyncId,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<int>? additionalMinutes,
      Value<bool>? isFinished,
      Value<DateTime>? createdAt}) {
    return MatchTermsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      leagueTermSyncId: leagueTermSyncId ?? this.leagueTermSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (matchSyncId.present) {
      map['match_sync_id'] = Variable<String>(matchSyncId.value);
    }
    if (leagueTermSyncId.present) {
      map['league_term_sync_id'] = Variable<String>(leagueTermSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('leagueTermSyncId: $leagueTermSyncId, ')
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
  static const VerificationMeta _matchTermSyncIdMeta =
      const VerificationMeta('matchTermSyncId');
  @override
  late final GeneratedColumn<String> matchTermSyncId = GeneratedColumn<String>(
      'match_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matchTerms(sync_id) ON DELETE CASCADE');
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
  List<GeneratedColumn> get $columns =>
      [id, matchTermSyncId, startPause, endPause];
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
    if (data.containsKey('match_term_sync_id')) {
      context.handle(
          _matchTermSyncIdMeta,
          matchTermSyncId.isAcceptableOrUnknown(
              data['match_term_sync_id']!, _matchTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermSyncIdMeta);
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
      matchTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}match_term_sync_id'])!,
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

  /// ✅ sync-based FK to match_terms(sync_id)
  final String matchTermSyncId;
  final DateTime startPause;
  final DateTime? endPause;
  const MatchTermPauseData(
      {required this.id,
      required this.matchTermSyncId,
      required this.startPause,
      this.endPause});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_term_sync_id'] = Variable<String>(matchTermSyncId);
    map['start_pause'] = Variable<DateTime>(startPause);
    if (!nullToAbsent || endPause != null) {
      map['end_pause'] = Variable<DateTime>(endPause);
    }
    return map;
  }

  MatchTermPauseCompanion toCompanion(bool nullToAbsent) {
    return MatchTermPauseCompanion(
      id: Value(id),
      matchTermSyncId: Value(matchTermSyncId),
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
      matchTermSyncId: serializer.fromJson<String>(json['matchTermSyncId']),
      startPause: serializer.fromJson<DateTime>(json['startPause']),
      endPause: serializer.fromJson<DateTime?>(json['endPause']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchTermSyncId': serializer.toJson<String>(matchTermSyncId),
      'startPause': serializer.toJson<DateTime>(startPause),
      'endPause': serializer.toJson<DateTime?>(endPause),
    };
  }

  MatchTermPauseData copyWith(
          {int? id,
          String? matchTermSyncId,
          DateTime? startPause,
          Value<DateTime?> endPause = const Value.absent()}) =>
      MatchTermPauseData(
        id: id ?? this.id,
        matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
        startPause: startPause ?? this.startPause,
        endPause: endPause.present ? endPause.value : this.endPause,
      );
  MatchTermPauseData copyWithCompanion(MatchTermPauseCompanion data) {
    return MatchTermPauseData(
      id: data.id.present ? data.id.value : this.id,
      matchTermSyncId: data.matchTermSyncId.present
          ? data.matchTermSyncId.value
          : this.matchTermSyncId,
      startPause:
          data.startPause.present ? data.startPause.value : this.startPause,
      endPause: data.endPause.present ? data.endPause.value : this.endPause,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchTermPauseData(')
          ..write('id: $id, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('startPause: $startPause, ')
          ..write('endPause: $endPause')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchTermSyncId, startPause, endPause);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchTermPauseData &&
          other.id == this.id &&
          other.matchTermSyncId == this.matchTermSyncId &&
          other.startPause == this.startPause &&
          other.endPause == this.endPause);
}

class MatchTermPauseCompanion extends UpdateCompanion<MatchTermPauseData> {
  final Value<int> id;
  final Value<String> matchTermSyncId;
  final Value<DateTime> startPause;
  final Value<DateTime?> endPause;
  const MatchTermPauseCompanion({
    this.id = const Value.absent(),
    this.matchTermSyncId = const Value.absent(),
    this.startPause = const Value.absent(),
    this.endPause = const Value.absent(),
  });
  MatchTermPauseCompanion.insert({
    this.id = const Value.absent(),
    required String matchTermSyncId,
    required DateTime startPause,
    this.endPause = const Value.absent(),
  })  : matchTermSyncId = Value(matchTermSyncId),
        startPause = Value(startPause);
  static Insertable<MatchTermPauseData> custom({
    Expression<int>? id,
    Expression<String>? matchTermSyncId,
    Expression<DateTime>? startPause,
    Expression<DateTime>? endPause,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchTermSyncId != null) 'match_term_sync_id': matchTermSyncId,
      if (startPause != null) 'start_pause': startPause,
      if (endPause != null) 'end_pause': endPause,
    });
  }

  MatchTermPauseCompanion copyWith(
      {Value<int>? id,
      Value<String>? matchTermSyncId,
      Value<DateTime>? startPause,
      Value<DateTime?>? endPause}) {
    return MatchTermPauseCompanion(
      id: id ?? this.id,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
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
    if (matchTermSyncId.present) {
      map['match_term_sync_id'] = Variable<String>(matchTermSyncId.value);
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
          ..write('matchTermSyncId: $matchTermSyncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _matchSyncIdMeta =
      const VerificationMeta('matchSyncId');
  @override
  late final GeneratedColumn<String> matchSyncId = GeneratedColumn<String>(
      'match_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matches(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _playerSyncIdMeta =
      const VerificationMeta('playerSyncId');
  @override
  late final GeneratedColumn<String> playerSyncId = GeneratedColumn<String>(
      'player_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES players(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _matchTermSyncIdMeta =
      const VerificationMeta('matchTermSyncId');
  @override
  late final GeneratedColumn<String> matchTermSyncId = GeneratedColumn<String>(
      'match_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matchTerms(sync_id) ON DELETE CASCADE');
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
        syncId,
        matchSyncId,
        playerSyncId,
        matchTermSyncId,
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('match_sync_id')) {
      context.handle(
          _matchSyncIdMeta,
          matchSyncId.isAcceptableOrUnknown(
              data['match_sync_id']!, _matchSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchSyncIdMeta);
    }
    if (data.containsKey('player_sync_id')) {
      context.handle(
          _playerSyncIdMeta,
          playerSyncId.isAcceptableOrUnknown(
              data['player_sync_id']!, _playerSyncIdMeta));
    } else if (isInserting) {
      context.missing(_playerSyncIdMeta);
    }
    if (data.containsKey('match_term_sync_id')) {
      context.handle(
          _matchTermSyncIdMeta,
          matchTermSyncId.isAcceptableOrUnknown(
              data['match_term_sync_id']!, _matchTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      matchSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_sync_id'])!,
      playerSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_sync_id'])!,
      matchTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}match_term_sync_id'])!,
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
  final String syncId;
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final int warningTime;
  final String warningType;
  final String? reason;
  final String status;
  const Warning(
      {required this.id,
      required this.syncId,
      required this.matchSyncId,
      required this.playerSyncId,
      required this.matchTermSyncId,
      required this.warningTime,
      required this.warningType,
      this.reason,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['match_sync_id'] = Variable<String>(matchSyncId);
    map['player_sync_id'] = Variable<String>(playerSyncId);
    map['match_term_sync_id'] = Variable<String>(matchTermSyncId);
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
      syncId: Value(syncId),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      matchSyncId: serializer.fromJson<String>(json['matchSyncId']),
      playerSyncId: serializer.fromJson<String>(json['playerSyncId']),
      matchTermSyncId: serializer.fromJson<String>(json['matchTermSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'matchSyncId': serializer.toJson<String>(matchSyncId),
      'playerSyncId': serializer.toJson<String>(playerSyncId),
      'matchTermSyncId': serializer.toJson<String>(matchTermSyncId),
      'warningTime': serializer.toJson<int>(warningTime),
      'warningType': serializer.toJson<String>(warningType),
      'reason': serializer.toJson<String?>(reason),
      'status': serializer.toJson<String>(status),
    };
  }

  Warning copyWith(
          {int? id,
          String? syncId,
          String? matchSyncId,
          String? playerSyncId,
          String? matchTermSyncId,
          int? warningTime,
          String? warningType,
          Value<String?> reason = const Value.absent(),
          String? status}) =>
      Warning(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        matchSyncId: matchSyncId ?? this.matchSyncId,
        playerSyncId: playerSyncId ?? this.playerSyncId,
        matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
        warningTime: warningTime ?? this.warningTime,
        warningType: warningType ?? this.warningType,
        reason: reason.present ? reason.value : this.reason,
        status: status ?? this.status,
      );
  Warning copyWithCompanion(WarningsCompanion data) {
    return Warning(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      matchSyncId:
          data.matchSyncId.present ? data.matchSyncId.value : this.matchSyncId,
      playerSyncId: data.playerSyncId.present
          ? data.playerSyncId.value
          : this.playerSyncId,
      matchTermSyncId: data.matchTermSyncId.present
          ? data.matchTermSyncId.value
          : this.matchTermSyncId,
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
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('warningTime: $warningTime, ')
          ..write('warningType: $warningType, ')
          ..write('reason: $reason, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, matchSyncId, playerSyncId,
      matchTermSyncId, warningTime, warningType, reason, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Warning &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.matchSyncId == this.matchSyncId &&
          other.playerSyncId == this.playerSyncId &&
          other.matchTermSyncId == this.matchTermSyncId &&
          other.warningTime == this.warningTime &&
          other.warningType == this.warningType &&
          other.reason == this.reason &&
          other.status == this.status);
}

class WarningsCompanion extends UpdateCompanion<Warning> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> matchSyncId;
  final Value<String> playerSyncId;
  final Value<String> matchTermSyncId;
  final Value<int> warningTime;
  final Value<String> warningType;
  final Value<String?> reason;
  final Value<String> status;
  const WarningsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.matchSyncId = const Value.absent(),
    this.playerSyncId = const Value.absent(),
    this.matchTermSyncId = const Value.absent(),
    this.warningTime = const Value.absent(),
    this.warningType = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
  });
  WarningsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String matchSyncId,
    required String playerSyncId,
    required String matchTermSyncId,
    required int warningTime,
    required String warningType,
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
  })  : syncId = Value(syncId),
        matchSyncId = Value(matchSyncId),
        playerSyncId = Value(playerSyncId),
        matchTermSyncId = Value(matchTermSyncId),
        warningTime = Value(warningTime),
        warningType = Value(warningType);
  static Insertable<Warning> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? matchSyncId,
    Expression<String>? playerSyncId,
    Expression<String>? matchTermSyncId,
    Expression<int>? warningTime,
    Expression<String>? warningType,
    Expression<String>? reason,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (matchSyncId != null) 'match_sync_id': matchSyncId,
      if (playerSyncId != null) 'player_sync_id': playerSyncId,
      if (matchTermSyncId != null) 'match_term_sync_id': matchTermSyncId,
      if (warningTime != null) 'warning_time': warningTime,
      if (warningType != null) 'warning_type': warningType,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
    });
  }

  WarningsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? matchSyncId,
      Value<String>? playerSyncId,
      Value<String>? matchTermSyncId,
      Value<int>? warningTime,
      Value<String>? warningType,
      Value<String?>? reason,
      Value<String>? status}) {
    return WarningsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (matchSyncId.present) {
      map['match_sync_id'] = Variable<String>(matchSyncId.value);
    }
    if (playerSyncId.present) {
      map['player_sync_id'] = Variable<String>(playerSyncId.value);
    }
    if (matchTermSyncId.present) {
      map['match_term_sync_id'] = Variable<String>(matchTermSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
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
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _matchSyncIdMeta =
      const VerificationMeta('matchSyncId');
  @override
  late final GeneratedColumn<String> matchSyncId = GeneratedColumn<String>(
      'match_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matches(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _playerSyncIdMeta =
      const VerificationMeta('playerSyncId');
  @override
  late final GeneratedColumn<String> playerSyncId = GeneratedColumn<String>(
      'player_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES players(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _matchTermSyncIdMeta =
      const VerificationMeta('matchTermSyncId');
  @override
  late final GeneratedColumn<String> matchTermSyncId = GeneratedColumn<String>(
      'match_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matchTerms(sync_id) ON DELETE CASCADE');
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
  List<GeneratedColumn> get $columns => [
        id,
        syncId,
        matchSyncId,
        playerSyncId,
        matchTermSyncId,
        goalTime,
        goalType,
        status
      ];
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
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('match_sync_id')) {
      context.handle(
          _matchSyncIdMeta,
          matchSyncId.isAcceptableOrUnknown(
              data['match_sync_id']!, _matchSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchSyncIdMeta);
    }
    if (data.containsKey('player_sync_id')) {
      context.handle(
          _playerSyncIdMeta,
          playerSyncId.isAcceptableOrUnknown(
              data['player_sync_id']!, _playerSyncIdMeta));
    } else if (isInserting) {
      context.missing(_playerSyncIdMeta);
    }
    if (data.containsKey('match_term_sync_id')) {
      context.handle(
          _matchTermSyncIdMeta,
          matchTermSyncId.isAcceptableOrUnknown(
              data['match_term_sync_id']!, _matchTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermSyncIdMeta);
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
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      matchSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_sync_id'])!,
      playerSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_sync_id'])!,
      matchTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}match_term_sync_id'])!,
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
  final String syncId;
  final String matchSyncId;
  final String playerSyncId;

  /// ✅ link to match_terms via matchTerms.sync_id
  final String matchTermSyncId;
  final int goalTime;
  final String goalType;
  final String status;
  const Goal(
      {required this.id,
      required this.syncId,
      required this.matchSyncId,
      required this.playerSyncId,
      required this.matchTermSyncId,
      required this.goalTime,
      required this.goalType,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['match_sync_id'] = Variable<String>(matchSyncId);
    map['player_sync_id'] = Variable<String>(playerSyncId);
    map['match_term_sync_id'] = Variable<String>(matchTermSyncId);
    map['goal_time'] = Variable<int>(goalTime);
    map['goal_type'] = Variable<String>(goalType);
    map['status'] = Variable<String>(status);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
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
      syncId: serializer.fromJson<String>(json['syncId']),
      matchSyncId: serializer.fromJson<String>(json['matchSyncId']),
      playerSyncId: serializer.fromJson<String>(json['playerSyncId']),
      matchTermSyncId: serializer.fromJson<String>(json['matchTermSyncId']),
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
      'syncId': serializer.toJson<String>(syncId),
      'matchSyncId': serializer.toJson<String>(matchSyncId),
      'playerSyncId': serializer.toJson<String>(playerSyncId),
      'matchTermSyncId': serializer.toJson<String>(matchTermSyncId),
      'goalTime': serializer.toJson<int>(goalTime),
      'goalType': serializer.toJson<String>(goalType),
      'status': serializer.toJson<String>(status),
    };
  }

  Goal copyWith(
          {int? id,
          String? syncId,
          String? matchSyncId,
          String? playerSyncId,
          String? matchTermSyncId,
          int? goalTime,
          String? goalType,
          String? status}) =>
      Goal(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        matchSyncId: matchSyncId ?? this.matchSyncId,
        playerSyncId: playerSyncId ?? this.playerSyncId,
        matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
        goalTime: goalTime ?? this.goalTime,
        goalType: goalType ?? this.goalType,
        status: status ?? this.status,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      matchSyncId:
          data.matchSyncId.present ? data.matchSyncId.value : this.matchSyncId,
      playerSyncId: data.playerSyncId.present
          ? data.playerSyncId.value
          : this.playerSyncId,
      matchTermSyncId: data.matchTermSyncId.present
          ? data.matchTermSyncId.value
          : this.matchTermSyncId,
      goalTime: data.goalTime.present ? data.goalTime.value : this.goalTime,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('goalTime: $goalTime, ')
          ..write('goalType: $goalType, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncId, matchSyncId, playerSyncId,
      matchTermSyncId, goalTime, goalType, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.matchSyncId == this.matchSyncId &&
          other.playerSyncId == this.playerSyncId &&
          other.matchTermSyncId == this.matchTermSyncId &&
          other.goalTime == this.goalTime &&
          other.goalType == this.goalType &&
          other.status == this.status);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> matchSyncId;
  final Value<String> playerSyncId;
  final Value<String> matchTermSyncId;
  final Value<int> goalTime;
  final Value<String> goalType;
  final Value<String> status;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.matchSyncId = const Value.absent(),
    this.playerSyncId = const Value.absent(),
    this.matchTermSyncId = const Value.absent(),
    this.goalTime = const Value.absent(),
    this.goalType = const Value.absent(),
    this.status = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String matchSyncId,
    required String playerSyncId,
    required String matchTermSyncId,
    required int goalTime,
    required String goalType,
    this.status = const Value.absent(),
  })  : syncId = Value(syncId),
        matchSyncId = Value(matchSyncId),
        playerSyncId = Value(playerSyncId),
        matchTermSyncId = Value(matchTermSyncId),
        goalTime = Value(goalTime),
        goalType = Value(goalType);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? matchSyncId,
    Expression<String>? playerSyncId,
    Expression<String>? matchTermSyncId,
    Expression<int>? goalTime,
    Expression<String>? goalType,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (matchSyncId != null) 'match_sync_id': matchSyncId,
      if (playerSyncId != null) 'player_sync_id': playerSyncId,
      if (matchTermSyncId != null) 'match_term_sync_id': matchTermSyncId,
      if (goalTime != null) 'goal_time': goalTime,
      if (goalType != null) 'goal_type': goalType,
      if (status != null) 'status': status,
    });
  }

  GoalsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? matchSyncId,
      Value<String>? playerSyncId,
      Value<String>? matchTermSyncId,
      Value<int>? goalTime,
      Value<String>? goalType,
      Value<String>? status}) {
    return GoalsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
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
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (matchSyncId.present) {
      map['match_sync_id'] = Variable<String>(matchSyncId.value);
    }
    if (playerSyncId.present) {
      map['player_sync_id'] = Variable<String>(playerSyncId.value);
    }
    if (matchTermSyncId.present) {
      map['match_term_sync_id'] = Variable<String>(matchTermSyncId.value);
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
          ..write('syncId: $syncId, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
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
  static const VerificationMeta _matchSyncIdMeta =
      const VerificationMeta('matchSyncId');
  @override
  late final GeneratedColumn<String> matchSyncId = GeneratedColumn<String>(
      'match_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matches(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _playerSyncIdMeta =
      const VerificationMeta('playerSyncId');
  @override
  late final GeneratedColumn<String> playerSyncId = GeneratedColumn<String>(
      'player_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES players(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _matchTermSyncIdMeta =
      const VerificationMeta('matchTermSyncId');
  @override
  late final GeneratedColumn<String> matchTermSyncId = GeneratedColumn<String>(
      'match_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matchTerms(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _goalSyncIdMeta =
      const VerificationMeta('goalSyncId');
  @override
  late final GeneratedColumn<String> goalSyncId = GeneratedColumn<String>(
      'goal_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES goals(sync_id) ON DELETE CASCADE');
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
  List<GeneratedColumn> get $columns => [
        id,
        matchSyncId,
        playerSyncId,
        matchTermSyncId,
        goalSyncId,
        assistTime,
        status
      ];
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
    if (data.containsKey('match_sync_id')) {
      context.handle(
          _matchSyncIdMeta,
          matchSyncId.isAcceptableOrUnknown(
              data['match_sync_id']!, _matchSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchSyncIdMeta);
    }
    if (data.containsKey('player_sync_id')) {
      context.handle(
          _playerSyncIdMeta,
          playerSyncId.isAcceptableOrUnknown(
              data['player_sync_id']!, _playerSyncIdMeta));
    } else if (isInserting) {
      context.missing(_playerSyncIdMeta);
    }
    if (data.containsKey('match_term_sync_id')) {
      context.handle(
          _matchTermSyncIdMeta,
          matchTermSyncId.isAcceptableOrUnknown(
              data['match_term_sync_id']!, _matchTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermSyncIdMeta);
    }
    if (data.containsKey('goal_sync_id')) {
      context.handle(
          _goalSyncIdMeta,
          goalSyncId.isAcceptableOrUnknown(
              data['goal_sync_id']!, _goalSyncIdMeta));
    } else if (isInserting) {
      context.missing(_goalSyncIdMeta);
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
      matchSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_sync_id'])!,
      playerSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_sync_id'])!,
      matchTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}match_term_sync_id'])!,
      goalSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_sync_id'])!,
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
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final String goalSyncId;
  final int assistTime;
  final String status;
  const Assist(
      {required this.id,
      required this.matchSyncId,
      required this.playerSyncId,
      required this.matchTermSyncId,
      required this.goalSyncId,
      required this.assistTime,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_sync_id'] = Variable<String>(matchSyncId);
    map['player_sync_id'] = Variable<String>(playerSyncId);
    map['match_term_sync_id'] = Variable<String>(matchTermSyncId);
    map['goal_sync_id'] = Variable<String>(goalSyncId);
    map['assist_time'] = Variable<int>(assistTime);
    map['status'] = Variable<String>(status);
    return map;
  }

  AssistsCompanion toCompanion(bool nullToAbsent) {
    return AssistsCompanion(
      id: Value(id),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
      goalSyncId: Value(goalSyncId),
      assistTime: Value(assistTime),
      status: Value(status),
    );
  }

  factory Assist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assist(
      id: serializer.fromJson<int>(json['id']),
      matchSyncId: serializer.fromJson<String>(json['matchSyncId']),
      playerSyncId: serializer.fromJson<String>(json['playerSyncId']),
      matchTermSyncId: serializer.fromJson<String>(json['matchTermSyncId']),
      goalSyncId: serializer.fromJson<String>(json['goalSyncId']),
      assistTime: serializer.fromJson<int>(json['assistTime']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchSyncId': serializer.toJson<String>(matchSyncId),
      'playerSyncId': serializer.toJson<String>(playerSyncId),
      'matchTermSyncId': serializer.toJson<String>(matchTermSyncId),
      'goalSyncId': serializer.toJson<String>(goalSyncId),
      'assistTime': serializer.toJson<int>(assistTime),
      'status': serializer.toJson<String>(status),
    };
  }

  Assist copyWith(
          {int? id,
          String? matchSyncId,
          String? playerSyncId,
          String? matchTermSyncId,
          String? goalSyncId,
          int? assistTime,
          String? status}) =>
      Assist(
        id: id ?? this.id,
        matchSyncId: matchSyncId ?? this.matchSyncId,
        playerSyncId: playerSyncId ?? this.playerSyncId,
        matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
        goalSyncId: goalSyncId ?? this.goalSyncId,
        assistTime: assistTime ?? this.assistTime,
        status: status ?? this.status,
      );
  Assist copyWithCompanion(AssistsCompanion data) {
    return Assist(
      id: data.id.present ? data.id.value : this.id,
      matchSyncId:
          data.matchSyncId.present ? data.matchSyncId.value : this.matchSyncId,
      playerSyncId: data.playerSyncId.present
          ? data.playerSyncId.value
          : this.playerSyncId,
      matchTermSyncId: data.matchTermSyncId.present
          ? data.matchTermSyncId.value
          : this.matchTermSyncId,
      goalSyncId:
          data.goalSyncId.present ? data.goalSyncId.value : this.goalSyncId,
      assistTime:
          data.assistTime.present ? data.assistTime.value : this.assistTime,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assist(')
          ..write('id: $id, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('goalSyncId: $goalSyncId, ')
          ..write('assistTime: $assistTime, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchSyncId, playerSyncId,
      matchTermSyncId, goalSyncId, assistTime, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assist &&
          other.id == this.id &&
          other.matchSyncId == this.matchSyncId &&
          other.playerSyncId == this.playerSyncId &&
          other.matchTermSyncId == this.matchTermSyncId &&
          other.goalSyncId == this.goalSyncId &&
          other.assistTime == this.assistTime &&
          other.status == this.status);
}

class AssistsCompanion extends UpdateCompanion<Assist> {
  final Value<int> id;
  final Value<String> matchSyncId;
  final Value<String> playerSyncId;
  final Value<String> matchTermSyncId;
  final Value<String> goalSyncId;
  final Value<int> assistTime;
  final Value<String> status;
  const AssistsCompanion({
    this.id = const Value.absent(),
    this.matchSyncId = const Value.absent(),
    this.playerSyncId = const Value.absent(),
    this.matchTermSyncId = const Value.absent(),
    this.goalSyncId = const Value.absent(),
    this.assistTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  AssistsCompanion.insert({
    this.id = const Value.absent(),
    required String matchSyncId,
    required String playerSyncId,
    required String matchTermSyncId,
    required String goalSyncId,
    required int assistTime,
    this.status = const Value.absent(),
  })  : matchSyncId = Value(matchSyncId),
        playerSyncId = Value(playerSyncId),
        matchTermSyncId = Value(matchTermSyncId),
        goalSyncId = Value(goalSyncId),
        assistTime = Value(assistTime);
  static Insertable<Assist> custom({
    Expression<int>? id,
    Expression<String>? matchSyncId,
    Expression<String>? playerSyncId,
    Expression<String>? matchTermSyncId,
    Expression<String>? goalSyncId,
    Expression<int>? assistTime,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchSyncId != null) 'match_sync_id': matchSyncId,
      if (playerSyncId != null) 'player_sync_id': playerSyncId,
      if (matchTermSyncId != null) 'match_term_sync_id': matchTermSyncId,
      if (goalSyncId != null) 'goal_sync_id': goalSyncId,
      if (assistTime != null) 'assist_time': assistTime,
      if (status != null) 'status': status,
    });
  }

  AssistsCompanion copyWith(
      {Value<int>? id,
      Value<String>? matchSyncId,
      Value<String>? playerSyncId,
      Value<String>? matchTermSyncId,
      Value<String>? goalSyncId,
      Value<int>? assistTime,
      Value<String>? status}) {
    return AssistsCompanion(
      id: id ?? this.id,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      goalSyncId: goalSyncId ?? this.goalSyncId,
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
    if (matchSyncId.present) {
      map['match_sync_id'] = Variable<String>(matchSyncId.value);
    }
    if (playerSyncId.present) {
      map['player_sync_id'] = Variable<String>(playerSyncId.value);
    }
    if (matchTermSyncId.present) {
      map['match_term_sync_id'] = Variable<String>(matchTermSyncId.value);
    }
    if (goalSyncId.present) {
      map['goal_sync_id'] = Variable<String>(goalSyncId.value);
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
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('goalSyncId: $goalSyncId, ')
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
  static const VerificationMeta _matchSyncIdMeta =
      const VerificationMeta('matchSyncId');
  @override
  late final GeneratedColumn<String> matchSyncId = GeneratedColumn<String>(
      'match_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matches(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _playerSyncIdMeta =
      const VerificationMeta('playerSyncId');
  @override
  late final GeneratedColumn<String> playerSyncId = GeneratedColumn<String>(
      'player_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES players(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _matchTermSyncIdMeta =
      const VerificationMeta('matchTermSyncId');
  @override
  late final GeneratedColumn<String> matchTermSyncId = GeneratedColumn<String>(
      'match_term_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES matchTerms(sync_id) ON DELETE CASCADE');
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
  static const VerificationMeta _substitutedPlayerSyncIdMeta =
      const VerificationMeta('substitutedPlayerSyncId');
  @override
  late final GeneratedColumn<String> substitutedPlayerSyncId =
      GeneratedColumn<String>('substituted_player_sync_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: 'REFERENCES players(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _participationTypeMeta =
      const VerificationMeta('participationType');
  @override
  late final GeneratedColumn<String> participationType =
      GeneratedColumn<String>('participation_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        matchSyncId,
        playerSyncId,
        matchTermSyncId,
        startTime,
        endTime,
        substitutedPlayerSyncId,
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
    if (data.containsKey('match_sync_id')) {
      context.handle(
          _matchSyncIdMeta,
          matchSyncId.isAcceptableOrUnknown(
              data['match_sync_id']!, _matchSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchSyncIdMeta);
    }
    if (data.containsKey('player_sync_id')) {
      context.handle(
          _playerSyncIdMeta,
          playerSyncId.isAcceptableOrUnknown(
              data['player_sync_id']!, _playerSyncIdMeta));
    } else if (isInserting) {
      context.missing(_playerSyncIdMeta);
    }
    if (data.containsKey('match_term_sync_id')) {
      context.handle(
          _matchTermSyncIdMeta,
          matchTermSyncId.isAcceptableOrUnknown(
              data['match_term_sync_id']!, _matchTermSyncIdMeta));
    } else if (isInserting) {
      context.missing(_matchTermSyncIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('substituted_player_sync_id')) {
      context.handle(
          _substitutedPlayerSyncIdMeta,
          substitutedPlayerSyncId.isAcceptableOrUnknown(
              data['substituted_player_sync_id']!,
              _substitutedPlayerSyncIdMeta));
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
      matchSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_sync_id'])!,
      playerSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_sync_id'])!,
      matchTermSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}match_term_sync_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time']),
      substitutedPlayerSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}substituted_player_sync_id']),
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
  final String matchSyncId;
  final String playerSyncId;
  final String matchTermSyncId;
  final int? startTime;
  final int? endTime;
  final String? substitutedPlayerSyncId;
  final String participationType;
  const PlayerMatchParticipationData(
      {required this.id,
      required this.matchSyncId,
      required this.playerSyncId,
      required this.matchTermSyncId,
      this.startTime,
      this.endTime,
      this.substitutedPlayerSyncId,
      required this.participationType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_sync_id'] = Variable<String>(matchSyncId);
    map['player_sync_id'] = Variable<String>(playerSyncId);
    map['match_term_sync_id'] = Variable<String>(matchTermSyncId);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<int>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<int>(endTime);
    }
    if (!nullToAbsent || substitutedPlayerSyncId != null) {
      map['substituted_player_sync_id'] =
          Variable<String>(substitutedPlayerSyncId);
    }
    map['participation_type'] = Variable<String>(participationType);
    return map;
  }

  PlayerMatchParticipationCompanion toCompanion(bool nullToAbsent) {
    return PlayerMatchParticipationCompanion(
      id: Value(id),
      matchSyncId: Value(matchSyncId),
      playerSyncId: Value(playerSyncId),
      matchTermSyncId: Value(matchTermSyncId),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      substitutedPlayerSyncId: substitutedPlayerSyncId == null && nullToAbsent
          ? const Value.absent()
          : Value(substitutedPlayerSyncId),
      participationType: Value(participationType),
    );
  }

  factory PlayerMatchParticipationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerMatchParticipationData(
      id: serializer.fromJson<int>(json['id']),
      matchSyncId: serializer.fromJson<String>(json['matchSyncId']),
      playerSyncId: serializer.fromJson<String>(json['playerSyncId']),
      matchTermSyncId: serializer.fromJson<String>(json['matchTermSyncId']),
      startTime: serializer.fromJson<int?>(json['startTime']),
      endTime: serializer.fromJson<int?>(json['endTime']),
      substitutedPlayerSyncId:
          serializer.fromJson<String?>(json['substitutedPlayerSyncId']),
      participationType: serializer.fromJson<String>(json['participationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchSyncId': serializer.toJson<String>(matchSyncId),
      'playerSyncId': serializer.toJson<String>(playerSyncId),
      'matchTermSyncId': serializer.toJson<String>(matchTermSyncId),
      'startTime': serializer.toJson<int?>(startTime),
      'endTime': serializer.toJson<int?>(endTime),
      'substitutedPlayerSyncId':
          serializer.toJson<String?>(substitutedPlayerSyncId),
      'participationType': serializer.toJson<String>(participationType),
    };
  }

  PlayerMatchParticipationData copyWith(
          {int? id,
          String? matchSyncId,
          String? playerSyncId,
          String? matchTermSyncId,
          Value<int?> startTime = const Value.absent(),
          Value<int?> endTime = const Value.absent(),
          Value<String?> substitutedPlayerSyncId = const Value.absent(),
          String? participationType}) =>
      PlayerMatchParticipationData(
        id: id ?? this.id,
        matchSyncId: matchSyncId ?? this.matchSyncId,
        playerSyncId: playerSyncId ?? this.playerSyncId,
        matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        substitutedPlayerSyncId: substitutedPlayerSyncId.present
            ? substitutedPlayerSyncId.value
            : this.substitutedPlayerSyncId,
        participationType: participationType ?? this.participationType,
      );
  PlayerMatchParticipationData copyWithCompanion(
      PlayerMatchParticipationCompanion data) {
    return PlayerMatchParticipationData(
      id: data.id.present ? data.id.value : this.id,
      matchSyncId:
          data.matchSyncId.present ? data.matchSyncId.value : this.matchSyncId,
      playerSyncId: data.playerSyncId.present
          ? data.playerSyncId.value
          : this.playerSyncId,
      matchTermSyncId: data.matchTermSyncId.present
          ? data.matchTermSyncId.value
          : this.matchTermSyncId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      substitutedPlayerSyncId: data.substitutedPlayerSyncId.present
          ? data.substitutedPlayerSyncId.value
          : this.substitutedPlayerSyncId,
      participationType: data.participationType.present
          ? data.participationType.value
          : this.participationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerMatchParticipationData(')
          ..write('id: $id, ')
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('substitutedPlayerSyncId: $substitutedPlayerSyncId, ')
          ..write('participationType: $participationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      matchSyncId,
      playerSyncId,
      matchTermSyncId,
      startTime,
      endTime,
      substitutedPlayerSyncId,
      participationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerMatchParticipationData &&
          other.id == this.id &&
          other.matchSyncId == this.matchSyncId &&
          other.playerSyncId == this.playerSyncId &&
          other.matchTermSyncId == this.matchTermSyncId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.substitutedPlayerSyncId == this.substitutedPlayerSyncId &&
          other.participationType == this.participationType);
}

class PlayerMatchParticipationCompanion
    extends UpdateCompanion<PlayerMatchParticipationData> {
  final Value<int> id;
  final Value<String> matchSyncId;
  final Value<String> playerSyncId;
  final Value<String> matchTermSyncId;
  final Value<int?> startTime;
  final Value<int?> endTime;
  final Value<String?> substitutedPlayerSyncId;
  final Value<String> participationType;
  const PlayerMatchParticipationCompanion({
    this.id = const Value.absent(),
    this.matchSyncId = const Value.absent(),
    this.playerSyncId = const Value.absent(),
    this.matchTermSyncId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.substitutedPlayerSyncId = const Value.absent(),
    this.participationType = const Value.absent(),
  });
  PlayerMatchParticipationCompanion.insert({
    this.id = const Value.absent(),
    required String matchSyncId,
    required String playerSyncId,
    required String matchTermSyncId,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.substitutedPlayerSyncId = const Value.absent(),
    required String participationType,
  })  : matchSyncId = Value(matchSyncId),
        playerSyncId = Value(playerSyncId),
        matchTermSyncId = Value(matchTermSyncId),
        participationType = Value(participationType);
  static Insertable<PlayerMatchParticipationData> custom({
    Expression<int>? id,
    Expression<String>? matchSyncId,
    Expression<String>? playerSyncId,
    Expression<String>? matchTermSyncId,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<String>? substitutedPlayerSyncId,
    Expression<String>? participationType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchSyncId != null) 'match_sync_id': matchSyncId,
      if (playerSyncId != null) 'player_sync_id': playerSyncId,
      if (matchTermSyncId != null) 'match_term_sync_id': matchTermSyncId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (substitutedPlayerSyncId != null)
        'substituted_player_sync_id': substitutedPlayerSyncId,
      if (participationType != null) 'participation_type': participationType,
    });
  }

  PlayerMatchParticipationCompanion copyWith(
      {Value<int>? id,
      Value<String>? matchSyncId,
      Value<String>? playerSyncId,
      Value<String>? matchTermSyncId,
      Value<int?>? startTime,
      Value<int?>? endTime,
      Value<String?>? substitutedPlayerSyncId,
      Value<String>? participationType}) {
    return PlayerMatchParticipationCompanion(
      id: id ?? this.id,
      matchSyncId: matchSyncId ?? this.matchSyncId,
      playerSyncId: playerSyncId ?? this.playerSyncId,
      matchTermSyncId: matchTermSyncId ?? this.matchTermSyncId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      substitutedPlayerSyncId:
          substitutedPlayerSyncId ?? this.substitutedPlayerSyncId,
      participationType: participationType ?? this.participationType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchSyncId.present) {
      map['match_sync_id'] = Variable<String>(matchSyncId.value);
    }
    if (playerSyncId.present) {
      map['player_sync_id'] = Variable<String>(playerSyncId.value);
    }
    if (matchTermSyncId.present) {
      map['match_term_sync_id'] = Variable<String>(matchTermSyncId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (substitutedPlayerSyncId.present) {
      map['substituted_player_sync_id'] =
          Variable<String>(substitutedPlayerSyncId.value);
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
          ..write('matchSyncId: $matchSyncId, ')
          ..write('playerSyncId: $playerSyncId, ')
          ..write('matchTermSyncId: $matchTermSyncId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('substitutedPlayerSyncId: $substitutedPlayerSyncId, ')
          ..write('participationType: $participationType')
          ..write(')'))
        .toString();
  }
}

class $UsersHasRoleTable extends UsersHasRole
    with TableInfo<$UsersHasRoleTable, UsersHasRoleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersHasRoleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleOrderMeta =
      const VerificationMeta('roleOrder');
  @override
  late final GeneratedColumn<int> roleOrder = GeneratedColumn<int>(
      'role_order', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [syncId, leagueSyncId, name, role, roleOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_has_role';
  @override
  VerificationContext validateIntegrity(Insertable<UsersHasRoleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('role_order')) {
      context.handle(_roleOrderMeta,
          roleOrder.isAcceptableOrUnknown(data['role_order']!, _roleOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UsersHasRoleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersHasRoleData(
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      roleOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_order']),
    );
  }

  @override
  $UsersHasRoleTable createAlias(String alias) {
    return $UsersHasRoleTable(attachedDatabase, alias);
  }
}

class UsersHasRoleData extends DataClass
    implements Insertable<UsersHasRoleData> {
  final String syncId;
  final String leagueSyncId;
  final String name;
  final String role;
  final int? roleOrder;
  const UsersHasRoleData(
      {required this.syncId,
      required this.leagueSyncId,
      required this.name,
      required this.role,
      this.roleOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || roleOrder != null) {
      map['role_order'] = Variable<int>(roleOrder);
    }
    return map;
  }

  UsersHasRoleCompanion toCompanion(bool nullToAbsent) {
    return UsersHasRoleCompanion(
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      name: Value(name),
      role: Value(role),
      roleOrder: roleOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(roleOrder),
    );
  }

  factory UsersHasRoleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersHasRoleData(
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      roleOrder: serializer.fromJson<int?>(json['roleOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'roleOrder': serializer.toJson<int?>(roleOrder),
    };
  }

  UsersHasRoleData copyWith(
          {String? syncId,
          String? leagueSyncId,
          String? name,
          String? role,
          Value<int?> roleOrder = const Value.absent()}) =>
      UsersHasRoleData(
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        name: name ?? this.name,
        role: role ?? this.role,
        roleOrder: roleOrder.present ? roleOrder.value : this.roleOrder,
      );
  UsersHasRoleData copyWithCompanion(UsersHasRoleCompanion data) {
    return UsersHasRoleData(
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      roleOrder: data.roleOrder.present ? data.roleOrder.value : this.roleOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersHasRoleData(')
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('roleOrder: $roleOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(syncId, leagueSyncId, name, role, roleOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersHasRoleData &&
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.name == this.name &&
          other.role == this.role &&
          other.roleOrder == this.roleOrder);
}

class UsersHasRoleCompanion extends UpdateCompanion<UsersHasRoleData> {
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> name;
  final Value<String> role;
  final Value<int?> roleOrder;
  final Value<int> rowid;
  const UsersHasRoleCompanion({
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.roleOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersHasRoleCompanion.insert({
    required String syncId,
    required String leagueSyncId,
    required String name,
    required String role,
    this.roleOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        name = Value(name),
        role = Value(role);
  static Insertable<UsersHasRoleData> custom({
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? name,
    Expression<String>? role,
    Expression<int>? roleOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (roleOrder != null) 'role_order': roleOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersHasRoleCompanion copyWith(
      {Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? name,
      Value<String>? role,
      Value<int?>? roleOrder,
      Value<int>? rowid}) {
    return UsersHasRoleCompanion(
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      name: name ?? this.name,
      role: role ?? this.role,
      roleOrder: roleOrder ?? this.roleOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (roleOrder.present) {
      map['role_order'] = Variable<int>(roleOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersHasRoleCompanion(')
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('roleOrder: $roleOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeagueKnockoutFlagsTable extends LeagueKnockoutFlags
    with TableInfo<$LeagueKnockoutFlagsTable, LeagueKnockoutFlag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeagueKnockoutFlagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstKnockoutCreatedMeta =
      const VerificationMeta('firstKnockoutCreated');
  @override
  late final GeneratedColumn<bool> firstKnockoutCreated = GeneratedColumn<bool>(
      'first_knockout_created', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("first_knockout_created" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [leagueSyncId, firstKnockoutCreated, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_knockout_flags';
  @override
  VerificationContext validateIntegrity(Insertable<LeagueKnockoutFlag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('first_knockout_created')) {
      context.handle(
          _firstKnockoutCreatedMeta,
          firstKnockoutCreated.isAcceptableOrUnknown(
              data['first_knockout_created']!, _firstKnockoutCreatedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {leagueSyncId};
  @override
  LeagueKnockoutFlag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeagueKnockoutFlag(
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      firstKnockoutCreated: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}first_knockout_created'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $LeagueKnockoutFlagsTable createAlias(String alias) {
    return $LeagueKnockoutFlagsTable(attachedDatabase, alias);
  }
}

class LeagueKnockoutFlag extends DataClass
    implements Insertable<LeagueKnockoutFlag> {
  final String leagueSyncId;
  final bool firstKnockoutCreated;
  final DateTime? updatedAt;
  const LeagueKnockoutFlag(
      {required this.leagueSyncId,
      required this.firstKnockoutCreated,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['first_knockout_created'] = Variable<bool>(firstKnockoutCreated);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LeagueKnockoutFlagsCompanion toCompanion(bool nullToAbsent) {
    return LeagueKnockoutFlagsCompanion(
      leagueSyncId: Value(leagueSyncId),
      firstKnockoutCreated: Value(firstKnockoutCreated),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LeagueKnockoutFlag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeagueKnockoutFlag(
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      firstKnockoutCreated:
          serializer.fromJson<bool>(json['firstKnockoutCreated']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'firstKnockoutCreated': serializer.toJson<bool>(firstKnockoutCreated),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LeagueKnockoutFlag copyWith(
          {String? leagueSyncId,
          bool? firstKnockoutCreated,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      LeagueKnockoutFlag(
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        firstKnockoutCreated: firstKnockoutCreated ?? this.firstKnockoutCreated,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  LeagueKnockoutFlag copyWithCompanion(LeagueKnockoutFlagsCompanion data) {
    return LeagueKnockoutFlag(
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      firstKnockoutCreated: data.firstKnockoutCreated.present
          ? data.firstKnockoutCreated.value
          : this.firstKnockoutCreated,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeagueKnockoutFlag(')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('firstKnockoutCreated: $firstKnockoutCreated, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(leagueSyncId, firstKnockoutCreated, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeagueKnockoutFlag &&
          other.leagueSyncId == this.leagueSyncId &&
          other.firstKnockoutCreated == this.firstKnockoutCreated &&
          other.updatedAt == this.updatedAt);
}

class LeagueKnockoutFlagsCompanion extends UpdateCompanion<LeagueKnockoutFlag> {
  final Value<String> leagueSyncId;
  final Value<bool> firstKnockoutCreated;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LeagueKnockoutFlagsCompanion({
    this.leagueSyncId = const Value.absent(),
    this.firstKnockoutCreated = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeagueKnockoutFlagsCompanion.insert({
    required String leagueSyncId,
    this.firstKnockoutCreated = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : leagueSyncId = Value(leagueSyncId);
  static Insertable<LeagueKnockoutFlag> custom({
    Expression<String>? leagueSyncId,
    Expression<bool>? firstKnockoutCreated,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (firstKnockoutCreated != null)
        'first_knockout_created': firstKnockoutCreated,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeagueKnockoutFlagsCompanion copyWith(
      {Value<String>? leagueSyncId,
      Value<bool>? firstKnockoutCreated,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return LeagueKnockoutFlagsCompanion(
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      firstKnockoutCreated: firstKnockoutCreated ?? this.firstKnockoutCreated,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (firstKnockoutCreated.present) {
      map['first_knockout_created'] =
          Variable<bool>(firstKnockoutCreated.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeagueKnockoutFlagsCompanion(')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('firstKnockoutCreated: $firstKnockoutCreated, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnockoutProgressLocksTable extends KnockoutProgressLocks
    with TableInfo<$KnockoutProgressLocksTable, KnockoutProgressLock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnockoutProgressLocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finishedRoundSyncIdMeta =
      const VerificationMeta('finishedRoundSyncId');
  @override
  late final GeneratedColumn<String> finishedRoundSyncId =
      GeneratedColumn<String>('finished_round_sync_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
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
      [leagueSyncId, finishedRoundSyncId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knockout_progress_locks';
  @override
  VerificationContext validateIntegrity(
      Insertable<KnockoutProgressLock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('finished_round_sync_id')) {
      context.handle(
          _finishedRoundSyncIdMeta,
          finishedRoundSyncId.isAcceptableOrUnknown(
              data['finished_round_sync_id']!, _finishedRoundSyncIdMeta));
    } else if (isInserting) {
      context.missing(_finishedRoundSyncIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {leagueSyncId, finishedRoundSyncId};
  @override
  KnockoutProgressLock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnockoutProgressLock(
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      finishedRoundSyncId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}finished_round_sync_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KnockoutProgressLocksTable createAlias(String alias) {
    return $KnockoutProgressLocksTable(attachedDatabase, alias);
  }
}

class KnockoutProgressLock extends DataClass
    implements Insertable<KnockoutProgressLock> {
  final String leagueSyncId;
  final String finishedRoundSyncId;
  final DateTime createdAt;
  const KnockoutProgressLock(
      {required this.leagueSyncId,
      required this.finishedRoundSyncId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['finished_round_sync_id'] = Variable<String>(finishedRoundSyncId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnockoutProgressLocksCompanion toCompanion(bool nullToAbsent) {
    return KnockoutProgressLocksCompanion(
      leagueSyncId: Value(leagueSyncId),
      finishedRoundSyncId: Value(finishedRoundSyncId),
      createdAt: Value(createdAt),
    );
  }

  factory KnockoutProgressLock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnockoutProgressLock(
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      finishedRoundSyncId:
          serializer.fromJson<String>(json['finishedRoundSyncId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'finishedRoundSyncId': serializer.toJson<String>(finishedRoundSyncId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnockoutProgressLock copyWith(
          {String? leagueSyncId,
          String? finishedRoundSyncId,
          DateTime? createdAt}) =>
      KnockoutProgressLock(
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        finishedRoundSyncId: finishedRoundSyncId ?? this.finishedRoundSyncId,
        createdAt: createdAt ?? this.createdAt,
      );
  KnockoutProgressLock copyWithCompanion(KnockoutProgressLocksCompanion data) {
    return KnockoutProgressLock(
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      finishedRoundSyncId: data.finishedRoundSyncId.present
          ? data.finishedRoundSyncId.value
          : this.finishedRoundSyncId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnockoutProgressLock(')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('finishedRoundSyncId: $finishedRoundSyncId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(leagueSyncId, finishedRoundSyncId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnockoutProgressLock &&
          other.leagueSyncId == this.leagueSyncId &&
          other.finishedRoundSyncId == this.finishedRoundSyncId &&
          other.createdAt == this.createdAt);
}

class KnockoutProgressLocksCompanion
    extends UpdateCompanion<KnockoutProgressLock> {
  final Value<String> leagueSyncId;
  final Value<String> finishedRoundSyncId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const KnockoutProgressLocksCompanion({
    this.leagueSyncId = const Value.absent(),
    this.finishedRoundSyncId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnockoutProgressLocksCompanion.insert({
    required String leagueSyncId,
    required String finishedRoundSyncId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : leagueSyncId = Value(leagueSyncId),
        finishedRoundSyncId = Value(finishedRoundSyncId);
  static Insertable<KnockoutProgressLock> custom({
    Expression<String>? leagueSyncId,
    Expression<String>? finishedRoundSyncId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (finishedRoundSyncId != null)
        'finished_round_sync_id': finishedRoundSyncId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnockoutProgressLocksCompanion copyWith(
      {Value<String>? leagueSyncId,
      Value<String>? finishedRoundSyncId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return KnockoutProgressLocksCompanion(
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      finishedRoundSyncId: finishedRoundSyncId ?? this.finishedRoundSyncId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (finishedRoundSyncId.present) {
      map['finished_round_sync_id'] =
          Variable<String>(finishedRoundSyncId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnockoutProgressLocksCompanion(')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('finishedRoundSyncId: $finishedRoundSyncId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserLeaguePermissionsTable extends UserLeaguePermissions
    with TableInfo<$UserLeaguePermissionsTable, UserLeaguePermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLeaguePermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _leagueSyncIdMeta =
      const VerificationMeta('leagueSyncId');
  @override
  late final GeneratedColumn<String> leagueSyncId = GeneratedColumn<String>(
      'league_sync_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES leagues(sync_id) ON DELETE CASCADE');
  static const VerificationMeta _permissionKeyMeta =
      const VerificationMeta('permissionKey');
  @override
  late final GeneratedColumn<String> permissionKey = GeneratedColumn<String>(
      'permission_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      [id, syncId, leagueSyncId, permissionKey, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_league_permissions';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserLeaguePermission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('league_sync_id')) {
      context.handle(
          _leagueSyncIdMeta,
          leagueSyncId.isAcceptableOrUnknown(
              data['league_sync_id']!, _leagueSyncIdMeta));
    } else if (isInserting) {
      context.missing(_leagueSyncIdMeta);
    }
    if (data.containsKey('permission_key')) {
      context.handle(
          _permissionKeyMeta,
          permissionKey.isAcceptableOrUnknown(
              data['permission_key']!, _permissionKeyMeta));
    } else if (isInserting) {
      context.missing(_permissionKeyMeta);
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
  UserLeaguePermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLeaguePermission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      leagueSyncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}league_sync_id'])!,
      permissionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}permission_key'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserLeaguePermissionsTable createAlias(String alias) {
    return $UserLeaguePermissionsTable(attachedDatabase, alias);
  }
}

class UserLeaguePermission extends DataClass
    implements Insertable<UserLeaguePermission> {
  final int id;

  /// معرف عالمي للمزامنة (UUID)
  final String syncId;

  /// ربط بالدوري عبر sync_id (بدل id)
  final String leagueSyncId;

  /// مفتاح الصلاحية (league.view, match.manage, ...)
  final String permissionKey;
  final DateTime createdAt;
  const UserLeaguePermission(
      {required this.id,
      required this.syncId,
      required this.leagueSyncId,
      required this.permissionKey,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['league_sync_id'] = Variable<String>(leagueSyncId);
    map['permission_key'] = Variable<String>(permissionKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserLeaguePermissionsCompanion toCompanion(bool nullToAbsent) {
    return UserLeaguePermissionsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      leagueSyncId: Value(leagueSyncId),
      permissionKey: Value(permissionKey),
      createdAt: Value(createdAt),
    );
  }

  factory UserLeaguePermission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLeaguePermission(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      leagueSyncId: serializer.fromJson<String>(json['leagueSyncId']),
      permissionKey: serializer.fromJson<String>(json['permissionKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'leagueSyncId': serializer.toJson<String>(leagueSyncId),
      'permissionKey': serializer.toJson<String>(permissionKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserLeaguePermission copyWith(
          {int? id,
          String? syncId,
          String? leagueSyncId,
          String? permissionKey,
          DateTime? createdAt}) =>
      UserLeaguePermission(
        id: id ?? this.id,
        syncId: syncId ?? this.syncId,
        leagueSyncId: leagueSyncId ?? this.leagueSyncId,
        permissionKey: permissionKey ?? this.permissionKey,
        createdAt: createdAt ?? this.createdAt,
      );
  UserLeaguePermission copyWithCompanion(UserLeaguePermissionsCompanion data) {
    return UserLeaguePermission(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      leagueSyncId: data.leagueSyncId.present
          ? data.leagueSyncId.value
          : this.leagueSyncId,
      permissionKey: data.permissionKey.present
          ? data.permissionKey.value
          : this.permissionKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserLeaguePermission(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('permissionKey: $permissionKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, syncId, leagueSyncId, permissionKey, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLeaguePermission &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.leagueSyncId == this.leagueSyncId &&
          other.permissionKey == this.permissionKey &&
          other.createdAt == this.createdAt);
}

class UserLeaguePermissionsCompanion
    extends UpdateCompanion<UserLeaguePermission> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> leagueSyncId;
  final Value<String> permissionKey;
  final Value<DateTime> createdAt;
  const UserLeaguePermissionsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.leagueSyncId = const Value.absent(),
    this.permissionKey = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserLeaguePermissionsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String leagueSyncId,
    required String permissionKey,
    this.createdAt = const Value.absent(),
  })  : syncId = Value(syncId),
        leagueSyncId = Value(leagueSyncId),
        permissionKey = Value(permissionKey);
  static Insertable<UserLeaguePermission> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? leagueSyncId,
    Expression<String>? permissionKey,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (leagueSyncId != null) 'league_sync_id': leagueSyncId,
      if (permissionKey != null) 'permission_key': permissionKey,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserLeaguePermissionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncId,
      Value<String>? leagueSyncId,
      Value<String>? permissionKey,
      Value<DateTime>? createdAt}) {
    return UserLeaguePermissionsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      leagueSyncId: leagueSyncId ?? this.leagueSyncId,
      permissionKey: permissionKey ?? this.permissionKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (leagueSyncId.present) {
      map['league_sync_id'] = Variable<String>(leagueSyncId.value);
    }
    if (permissionKey.present) {
      map['permission_key'] = Variable<String>(permissionKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLeaguePermissionsCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('leagueSyncId: $leagueSyncId, ')
          ..write('permissionKey: $permissionKey, ')
          ..write('createdAt: $createdAt')
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
  late final $PlayersTable players = $PlayersTable(this);
  late final $TeamPlayerCategoriesTable teamPlayerCategories =
      $TeamPlayerCategoriesTable(this);
  late final $LeaguePlayersTable leaguePlayers = $LeaguePlayersTable(this);
  late final $DraftProgressTable draftProgress = $DraftProgressTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $GroupTable group = $GroupTable(this);
  late final $GroupTeamTable groupTeam = $GroupTeamTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $RoundsTable rounds = $RoundsTable(this);
  late final $QualifiedTeamTable qualifiedTeam = $QualifiedTeamTable(this);
  late final $LeagueStatusTable leagueStatus = $LeagueStatusTable(this);
  late final $PaginationMetaTable paginationMeta = $PaginationMetaTable(this);
  late final $TermsTable terms = $TermsTable(this);
  late final $LeagueTermsTable leagueTerms = $LeagueTermsTable(this);
  late final $MatchTermsTable matchTerms = $MatchTermsTable(this);
  late final $MatchTermPauseTable matchTermPause = $MatchTermPauseTable(this);
  late final $WarningsTable warnings = $WarningsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $AssistsTable assists = $AssistsTable(this);
  late final $PlayerMatchParticipationTable playerMatchParticipation =
      $PlayerMatchParticipationTable(this);
  late final $UsersHasRoleTable usersHasRole = $UsersHasRoleTable(this);
  late final $LeagueKnockoutFlagsTable leagueKnockoutFlags =
      $LeagueKnockoutFlagsTable(this);
  late final $KnockoutProgressLocksTable knockoutProgressLocks =
      $KnockoutProgressLocksTable(this);
  late final $UserLeaguePermissionsTable userLeaguePermissions =
      $UserLeaguePermissionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        leagues,
        leagueRules,
        teams,
        players,
        teamPlayerCategories,
        leaguePlayers,
        draftProgress,
        syncQueue,
        group,
        groupTeam,
        matches,
        rounds,
        qualifiedTeam,
        leagueStatus,
        paginationMeta,
        terms,
        leagueTerms,
        matchTerms,
        matchTermPause,
        warnings,
        goals,
        assists,
        playerMatchParticipation,
        usersHasRole,
        leagueKnockoutFlags,
        knockoutProgressLocks,
        userLeaguePermissions
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('leagues',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('league_rules', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('team_player_categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('league_players', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$LeaguesTableCreateCompanionBuilder = LeaguesCompanion Function({
  Value<int> id,
  required String syncId,
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
  Value<String?> logoLocalPath,
});
typedef $$LeaguesTableUpdateCompanionBuilder = LeaguesCompanion Function({
  Value<int> id,
  Value<String> syncId,
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
  Value<String?> logoLocalPath,
});

final class $$LeaguesTableReferences
    extends BaseReferences<_$Safirah, $LeaguesTable, League> {
  $$LeaguesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LeagueRulesTable, List<LeagueRule>>
      _leagueRulesRefsTable(_$Safirah db) =>
          MultiTypedResultKey.fromTable(db.leagueRules,
              aliasName: $_aliasNameGenerator(
                  db.leagues.syncId, db.leagueRules.leagueSyncId));

  $$LeagueRulesTableProcessedTableManager get leagueRulesRefs {
    final manager = $$LeagueRulesTableTableManager($_db, $_db.leagueRules)
        .filter((f) => f.leagueSyncId.syncId($_item.syncId));

    final cache = $_typedResult.readTableOrNull(_leagueRulesRefsTable($_db));
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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath, builder: (column) => ColumnFilters(column));

  Expression<bool> leagueRulesRefs(
      Expression<bool> Function($$LeagueRulesTableFilterComposer f) f) {
    final $$LeagueRulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.syncId,
        referencedTable: $db.leagueRules,
        getReferencedColumn: (t) => t.leagueSyncId,
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

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

  GeneratedColumn<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath, builder: (column) => column);

  Expression<T> leagueRulesRefs<T extends Object>(
      Expression<T> Function($$LeagueRulesTableAnnotationComposer a) f) {
    final $$LeagueRulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.syncId,
        referencedTable: $db.leagueRules,
        getReferencedColumn: (t) => t.leagueSyncId,
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
    PrefetchHooks Function({bool leagueRulesRefs})> {
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
            Value<String> syncId = const Value.absent(),
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
            Value<String?> logoLocalPath = const Value.absent(),
          }) =>
              LeaguesCompanion(
            id: id,
            syncId: syncId,
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
            logoLocalPath: logoLocalPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
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
            Value<String?> logoLocalPath = const Value.absent(),
          }) =>
              LeaguesCompanion.insert(
            id: id,
            syncId: syncId,
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
            logoLocalPath: logoLocalPath,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LeaguesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({leagueRulesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (leagueRulesRefs) db.leagueRules],
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
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.leagueSyncId == item.syncId),
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
    PrefetchHooks Function({bool leagueRulesRefs})>;
typedef $$LeagueRulesTableCreateCompanionBuilder = LeagueRulesCompanion
    Function({
  Value<int> id,
  required String leagueSyncId,
  required String syncId,
  required String description,
  Value<bool> isMandatory,
  Value<DateTime> createdAt,
});
typedef $$LeagueRulesTableUpdateCompanionBuilder = LeagueRulesCompanion
    Function({
  Value<int> id,
  Value<String> leagueSyncId,
  Value<String> syncId,
  Value<String> description,
  Value<bool> isMandatory,
  Value<DateTime> createdAt,
});

final class $$LeagueRulesTableReferences
    extends BaseReferences<_$Safirah, $LeagueRulesTable, LeagueRule> {
  $$LeagueRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueSyncIdTable(_$Safirah db) =>
      db.leagues.createAlias(
          $_aliasNameGenerator(db.leagueRules.leagueSyncId, db.leagues.syncId));

  $$LeaguesTableProcessedTableManager? get leagueSyncId {
    if ($_item.leagueSyncId == null) return null;
    final manager = $$LeaguesTableTableManager($_db, $_db.leagues)
        .filter((f) => f.syncId($_item.leagueSyncId!));
    final item = $_typedResult.readTableOrNull(_leagueSyncIdTable($_db));
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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LeaguesTableFilterComposer get leagueSyncId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueSyncId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.syncId,
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LeaguesTableOrderingComposer get leagueSyncId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueSyncId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.syncId,
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isMandatory => $composableBuilder(
      column: $table.isMandatory, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LeaguesTableAnnotationComposer get leagueSyncId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.leagueSyncId,
        referencedTable: $db.leagues,
        getReferencedColumn: (t) => t.syncId,
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
    PrefetchHooks Function({bool leagueSyncId})> {
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
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> syncId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isMandatory = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LeagueRulesCompanion(
            id: id,
            leagueSyncId: leagueSyncId,
            syncId: syncId,
            description: description,
            isMandatory: isMandatory,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String leagueSyncId,
            required String syncId,
            required String description,
            Value<bool> isMandatory = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LeagueRulesCompanion.insert(
            id: id,
            leagueSyncId: leagueSyncId,
            syncId: syncId,
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
          prefetchHooksCallback: ({leagueSyncId = false}) {
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
                if (leagueSyncId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.leagueSyncId,
                    referencedTable:
                        $$LeagueRulesTableReferences._leagueSyncIdTable(db),
                    referencedColumn: $$LeagueRulesTableReferences
                        ._leagueSyncIdTable(db)
                        .syncId,
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
    PrefetchHooks Function({bool leagueSyncId})>;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  required String leagueSyncId,
  required String teamName,
  Value<String?> logoUrl,
  Value<String> status,
  required String syncId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  Value<String> leagueSyncId,
  Value<String> teamName,
  Value<String?> logoUrl,
  Value<String> status,
  Value<String> syncId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

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

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamName => $composableBuilder(
      column: $table.teamName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamName => $composableBuilder(
      column: $table.teamName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
    (Team, BaseReferences<_$Safirah, $TeamsTable, Team>),
    Team,
    PrefetchHooks Function()> {
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
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> teamName = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> syncId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TeamsCompanion(
            id: id,
            leagueSyncId: leagueSyncId,
            teamName: teamName,
            logoUrl: logoUrl,
            status: status,
            syncId: syncId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String leagueSyncId,
            required String teamName,
            Value<String?> logoUrl = const Value.absent(),
            Value<String> status = const Value.absent(),
            required String syncId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TeamsCompanion.insert(
            id: id,
            leagueSyncId: leagueSyncId,
            teamName: teamName,
            logoUrl: logoUrl,
            status: status,
            syncId: syncId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Team, BaseReferences<_$Safirah, $TeamsTable, Team>),
    Team,
    PrefetchHooks Function()>;
typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  required String syncId,
  required String playerLeagueSyncId,
  required String teamSyncId,
  required String fullName,
  Value<String?> position,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> playerLeagueSyncId,
  Value<String> teamSyncId,
  Value<String> fullName,
  Value<String?> position,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerLeagueSyncId => $composableBuilder(
      column: $table.playerLeagueSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerLeagueSyncId => $composableBuilder(
      column: $table.playerLeagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get playerLeagueSyncId => $composableBuilder(
      column: $table.playerLeagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => column);

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
    (Player, BaseReferences<_$Safirah, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> playerLeagueSyncId = const Value.absent(),
            Value<String> teamSyncId = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> position = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            syncId: syncId,
            playerLeagueSyncId: playerLeagueSyncId,
            teamSyncId: teamSyncId,
            fullName: fullName,
            position: position,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String playerLeagueSyncId,
            required String teamSyncId,
            required String fullName,
            Value<String?> position = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            syncId: syncId,
            playerLeagueSyncId: playerLeagueSyncId,
            teamSyncId: teamSyncId,
            fullName: fullName,
            position: position,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Player, BaseReferences<_$Safirah, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()>;
typedef $$TeamPlayerCategoriesTableCreateCompanionBuilder
    = TeamPlayerCategoriesCompanion Function({
  Value<int> id,
  required String leagueSyncId,
  required String name,
  required String syncId,
});
typedef $$TeamPlayerCategoriesTableUpdateCompanionBuilder
    = TeamPlayerCategoriesCompanion Function({
  Value<int> id,
  Value<String> leagueSyncId,
  Value<String> name,
  Value<String> syncId,
});

final class $$TeamPlayerCategoriesTableReferences extends BaseReferences<
    _$Safirah, $TeamPlayerCategoriesTable, TeamPlayerCategory> {
  $$TeamPlayerCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

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

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

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
    PrefetchHooks Function({bool leaguePlayersRefs})> {
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
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> syncId = const Value.absent(),
          }) =>
              TeamPlayerCategoriesCompanion(
            id: id,
            leagueSyncId: leagueSyncId,
            name: name,
            syncId: syncId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String leagueSyncId,
            required String name,
            required String syncId,
          }) =>
              TeamPlayerCategoriesCompanion.insert(
            id: id,
            leagueSyncId: leagueSyncId,
            name: name,
            syncId: syncId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TeamPlayerCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({leaguePlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (leaguePlayersRefs) db.leaguePlayers
              ],
              addJoins: null,
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
        PrefetchHooks Function({bool leaguePlayersRefs})>;
typedef $$LeaguePlayersTableCreateCompanionBuilder = LeaguePlayersCompanion
    Function({
  Value<int> id,
  required String syncId,
  Value<String?> name,
  Value<String?> code,
  required String leagueSyncId,
  Value<int?> teamPlayerCategoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$LeaguePlayersTableUpdateCompanionBuilder = LeaguePlayersCompanion
    Function({
  Value<int> id,
  Value<String> syncId,
  Value<String?> name,
  Value<String?> code,
  Value<String> leagueSyncId,
  Value<int?> teamPlayerCategoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$LeaguePlayersTableReferences
    extends BaseReferences<_$Safirah, $LeaguePlayersTable, LeaguePlayer> {
  $$LeaguePlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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
    PrefetchHooks Function({bool teamPlayerCategoryId})> {
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
            Value<String> syncId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<int?> teamPlayerCategoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeaguePlayersCompanion(
            id: id,
            syncId: syncId,
            name: name,
            code: code,
            leagueSyncId: leagueSyncId,
            teamPlayerCategoryId: teamPlayerCategoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            Value<String?> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            required String leagueSyncId,
            Value<int?> teamPlayerCategoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeaguePlayersCompanion.insert(
            id: id,
            syncId: syncId,
            name: name,
            code: code,
            leagueSyncId: leagueSyncId,
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
          prefetchHooksCallback: ({teamPlayerCategoryId = false}) {
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
                return [];
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
    PrefetchHooks Function({bool teamPlayerCategoryId})>;
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
  Value<String> status,
  Value<int> attemptCount,
  Value<String?> lastError,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime> createdAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<int> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<bool> synced,
  Value<String> status,
  Value<int> attemptCount,
  Value<String?> lastError,
  Value<DateTime?> lastAttemptAt,
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

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

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
            Value<String> status = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            synced: synced,
            status: status,
            attemptCount: attemptCount,
            lastError: lastError,
            lastAttemptAt: lastAttemptAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required int entityId,
            required String operation,
            required String payload,
            Value<bool> synced = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            synced: synced,
            status: status,
            attemptCount: attemptCount,
            lastError: lastError,
            lastAttemptAt: lastAttemptAt,
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
  required String syncId,
  required String leagueSyncId,
  required String groupName,
  Value<DateTime> createdAt,
  Value<int> qualifiedTeamNumber,
});
typedef $$GroupTableUpdateCompanionBuilder = GroupCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> groupName,
  Value<DateTime> createdAt,
  Value<int> qualifiedTeamNumber,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber,
      builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get qualifiedTeamNumber => $composableBuilder(
      column: $table.qualifiedTeamNumber, builder: (column) => column);
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
    (GroupData, BaseReferences<_$Safirah, $GroupTable, GroupData>),
    GroupData,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> qualifiedTeamNumber = const Value.absent(),
          }) =>
              GroupCompanion(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            groupName: groupName,
            createdAt: createdAt,
            qualifiedTeamNumber: qualifiedTeamNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String leagueSyncId,
            required String groupName,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> qualifiedTeamNumber = const Value.absent(),
          }) =>
              GroupCompanion.insert(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            groupName: groupName,
            createdAt: createdAt,
            qualifiedTeamNumber: qualifiedTeamNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (GroupData, BaseReferences<_$Safirah, $GroupTable, GroupData>),
    GroupData,
    PrefetchHooks Function()>;
typedef $$GroupTeamTableCreateCompanionBuilder = GroupTeamCompanion Function({
  Value<int> id,
  required String syncId,
  required String groupSyncId,
  required String teamSyncId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$GroupTeamTableUpdateCompanionBuilder = GroupTeamCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> groupSyncId,
  Value<String> teamSyncId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => column);

  GeneratedColumn<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
    (GroupTeamData, BaseReferences<_$Safirah, $GroupTeamTable, GroupTeamData>),
    GroupTeamData,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> groupSyncId = const Value.absent(),
            Value<String> teamSyncId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              GroupTeamCompanion(
            id: id,
            syncId: syncId,
            groupSyncId: groupSyncId,
            teamSyncId: teamSyncId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String groupSyncId,
            required String teamSyncId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              GroupTeamCompanion.insert(
            id: id,
            syncId: syncId,
            groupSyncId: groupSyncId,
            teamSyncId: teamSyncId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (GroupTeamData, BaseReferences<_$Safirah, $GroupTeamTable, GroupTeamData>),
    GroupTeamData,
    PrefetchHooks Function()>;
typedef $$MatchesTableCreateCompanionBuilder = MatchesCompanion Function({
  Value<int> id,
  required String syncId,
  required String leagueSyncId,
  required String roundSyncId,
  required String homeTeamSyncId,
  required String awayTeamSyncId,
  Value<String?> refereeSyncId,
  Value<String?> mediaSyncId,
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
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> roundSyncId,
  Value<String> homeTeamSyncId,
  Value<String> awayTeamSyncId,
  Value<String?> refereeSyncId,
  Value<String?> mediaSyncId,
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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roundSyncId => $composableBuilder(
      column: $table.roundSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homeTeamSyncId => $composableBuilder(
      column: $table.homeTeamSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get awayTeamSyncId => $composableBuilder(
      column: $table.awayTeamSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refereeSyncId => $composableBuilder(
      column: $table.refereeSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaSyncId => $composableBuilder(
      column: $table.mediaSyncId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roundSyncId => $composableBuilder(
      column: $table.roundSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homeTeamSyncId => $composableBuilder(
      column: $table.homeTeamSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get awayTeamSyncId => $composableBuilder(
      column: $table.awayTeamSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refereeSyncId => $composableBuilder(
      column: $table.refereeSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaSyncId => $composableBuilder(
      column: $table.mediaSyncId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get roundSyncId => $composableBuilder(
      column: $table.roundSyncId, builder: (column) => column);

  GeneratedColumn<String> get homeTeamSyncId => $composableBuilder(
      column: $table.homeTeamSyncId, builder: (column) => column);

  GeneratedColumn<String> get awayTeamSyncId => $composableBuilder(
      column: $table.awayTeamSyncId, builder: (column) => column);

  GeneratedColumn<String> get refereeSyncId => $composableBuilder(
      column: $table.refereeSyncId, builder: (column) => column);

  GeneratedColumn<String> get mediaSyncId => $composableBuilder(
      column: $table.mediaSyncId, builder: (column) => column);

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
    (Matche, BaseReferences<_$Safirah, $MatchesTable, Matche>),
    Matche,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> roundSyncId = const Value.absent(),
            Value<String> homeTeamSyncId = const Value.absent(),
            Value<String> awayTeamSyncId = const Value.absent(),
            Value<String?> refereeSyncId = const Value.absent(),
            Value<String?> mediaSyncId = const Value.absent(),
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
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            roundSyncId: roundSyncId,
            homeTeamSyncId: homeTeamSyncId,
            awayTeamSyncId: awayTeamSyncId,
            refereeSyncId: refereeSyncId,
            mediaSyncId: mediaSyncId,
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
            required String syncId,
            required String leagueSyncId,
            required String roundSyncId,
            required String homeTeamSyncId,
            required String awayTeamSyncId,
            Value<String?> refereeSyncId = const Value.absent(),
            Value<String?> mediaSyncId = const Value.absent(),
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
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            roundSyncId: roundSyncId,
            homeTeamSyncId: homeTeamSyncId,
            awayTeamSyncId: awayTeamSyncId,
            refereeSyncId: refereeSyncId,
            mediaSyncId: mediaSyncId,
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Matche, BaseReferences<_$Safirah, $MatchesTable, Matche>),
    Matche,
    PrefetchHooks Function()>;
typedef $$RoundsTableCreateCompanionBuilder = RoundsCompanion Function({
  Value<int> id,
  required String syncId,
  required String leagueSyncId,
  required String name,
  Value<String?> groupSyncId,
  required String roundType,
  Value<DateTime> createdAt,
});
typedef $$RoundsTableUpdateCompanionBuilder = RoundsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> name,
  Value<String?> groupSyncId,
  Value<String> roundType,
  Value<DateTime> createdAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roundType => $composableBuilder(
      column: $table.roundType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roundType => $composableBuilder(
      column: $table.roundType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => column);

  GeneratedColumn<String> get roundType =>
      $composableBuilder(column: $table.roundType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
    (Round, BaseReferences<_$Safirah, $RoundsTable, Round>),
    Round,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> groupSyncId = const Value.absent(),
            Value<String> roundType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RoundsCompanion(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            name: name,
            groupSyncId: groupSyncId,
            roundType: roundType,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String leagueSyncId,
            required String name,
            Value<String?> groupSyncId = const Value.absent(),
            required String roundType,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RoundsCompanion.insert(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            name: name,
            groupSyncId: groupSyncId,
            roundType: roundType,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Round, BaseReferences<_$Safirah, $RoundsTable, Round>),
    Round,
    PrefetchHooks Function()>;
typedef $$QualifiedTeamTableCreateCompanionBuilder = QualifiedTeamCompanion
    Function({
  Value<int> id,
  required String syncId,
  required String leagueSyncId,
  required String groupSyncId,
  required String teamSyncId,
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
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> groupSyncId,
  Value<String> teamSyncId,
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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get groupSyncId => $composableBuilder(
      column: $table.groupSyncId, builder: (column) => column);

  GeneratedColumn<String> get teamSyncId => $composableBuilder(
      column: $table.teamSyncId, builder: (column) => column);

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
    (
      QualifiedTeamData,
      BaseReferences<_$Safirah, $QualifiedTeamTable, QualifiedTeamData>
    ),
    QualifiedTeamData,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> groupSyncId = const Value.absent(),
            Value<String> teamSyncId = const Value.absent(),
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
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            groupSyncId: groupSyncId,
            teamSyncId: teamSyncId,
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
            required String syncId,
            required String leagueSyncId,
            required String groupSyncId,
            required String teamSyncId,
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
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            groupSyncId: groupSyncId,
            teamSyncId: teamSyncId,
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      QualifiedTeamData,
      BaseReferences<_$Safirah, $QualifiedTeamTable, QualifiedTeamData>
    ),
    QualifiedTeamData,
    PrefetchHooks Function()>;
typedef $$LeagueStatusTableCreateCompanionBuilder = LeagueStatusCompanion
    Function({
  required String leagueSyncId,
  Value<bool> hasGroups,
  Value<bool> hasTeamsInGroups,
  Value<bool> hasMatches,
  Value<bool> hasPlayersAssigned,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$LeagueStatusTableUpdateCompanionBuilder = LeagueStatusCompanion
    Function({
  Value<String> leagueSyncId,
  Value<bool> hasGroups,
  Value<bool> hasTeamsInGroups,
  Value<bool> hasMatches,
  Value<bool> hasPlayersAssigned,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$LeagueStatusTableFilterComposer
    extends Composer<_$Safirah, $LeagueStatusTable> {
  $$LeagueStatusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

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
  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

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
  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

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
    (
      LeagueStatusData,
      BaseReferences<_$Safirah, $LeagueStatusTable, LeagueStatusData>
    ),
    LeagueStatusData,
    PrefetchHooks Function()> {
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
            Value<String> leagueSyncId = const Value.absent(),
            Value<bool> hasGroups = const Value.absent(),
            Value<bool> hasTeamsInGroups = const Value.absent(),
            Value<bool> hasMatches = const Value.absent(),
            Value<bool> hasPlayersAssigned = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LeagueStatusCompanion(
            leagueSyncId: leagueSyncId,
            hasGroups: hasGroups,
            hasTeamsInGroups: hasTeamsInGroups,
            hasMatches: hasMatches,
            hasPlayersAssigned: hasPlayersAssigned,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String leagueSyncId,
            Value<bool> hasGroups = const Value.absent(),
            Value<bool> hasTeamsInGroups = const Value.absent(),
            Value<bool> hasMatches = const Value.absent(),
            Value<bool> hasPlayersAssigned = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LeagueStatusCompanion.insert(
            leagueSyncId: leagueSyncId,
            hasGroups: hasGroups,
            hasTeamsInGroups: hasTeamsInGroups,
            hasMatches: hasMatches,
            hasPlayersAssigned: hasPlayersAssigned,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      LeagueStatusData,
      BaseReferences<_$Safirah, $LeagueStatusTable, LeagueStatusData>
    ),
    LeagueStatusData,
    PrefetchHooks Function()>;
typedef $$PaginationMetaTableCreateCompanionBuilder = PaginationMetaCompanion
    Function({
  Value<int> id,
  required String resource,
  Value<String> scope,
  Value<String?> key,
  Value<String?> parentKey,
  Value<int> lastPage,
  Value<int> perPage,
  Value<int> total,
  Value<DateTime> updatedAt,
});
typedef $$PaginationMetaTableUpdateCompanionBuilder = PaginationMetaCompanion
    Function({
  Value<int> id,
  Value<String> resource,
  Value<String> scope,
  Value<String?> key,
  Value<String?> parentKey,
  Value<int> lastPage,
  Value<int> perPage,
  Value<int> total,
  Value<DateTime> updatedAt,
});

class $$PaginationMetaTableFilterComposer
    extends Composer<_$Safirah, $PaginationMetaTable> {
  $$PaginationMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resource => $composableBuilder(
      column: $table.resource, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentKey => $composableBuilder(
      column: $table.parentKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastPage => $composableBuilder(
      column: $table.lastPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get perPage => $composableBuilder(
      column: $table.perPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PaginationMetaTableOrderingComposer
    extends Composer<_$Safirah, $PaginationMetaTable> {
  $$PaginationMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resource => $composableBuilder(
      column: $table.resource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentKey => $composableBuilder(
      column: $table.parentKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastPage => $composableBuilder(
      column: $table.lastPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get perPage => $composableBuilder(
      column: $table.perPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PaginationMetaTableAnnotationComposer
    extends Composer<_$Safirah, $PaginationMetaTable> {
  $$PaginationMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get resource =>
      $composableBuilder(column: $table.resource, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get parentKey =>
      $composableBuilder(column: $table.parentKey, builder: (column) => column);

  GeneratedColumn<int> get lastPage =>
      $composableBuilder(column: $table.lastPage, builder: (column) => column);

  GeneratedColumn<int> get perPage =>
      $composableBuilder(column: $table.perPage, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PaginationMetaTableTableManager extends RootTableManager<
    _$Safirah,
    $PaginationMetaTable,
    PaginationMetaData,
    $$PaginationMetaTableFilterComposer,
    $$PaginationMetaTableOrderingComposer,
    $$PaginationMetaTableAnnotationComposer,
    $$PaginationMetaTableCreateCompanionBuilder,
    $$PaginationMetaTableUpdateCompanionBuilder,
    (
      PaginationMetaData,
      BaseReferences<_$Safirah, $PaginationMetaTable, PaginationMetaData>
    ),
    PaginationMetaData,
    PrefetchHooks Function()> {
  $$PaginationMetaTableTableManager(_$Safirah db, $PaginationMetaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaginationMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaginationMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaginationMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> resource = const Value.absent(),
            Value<String> scope = const Value.absent(),
            Value<String?> key = const Value.absent(),
            Value<String?> parentKey = const Value.absent(),
            Value<int> lastPage = const Value.absent(),
            Value<int> perPage = const Value.absent(),
            Value<int> total = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PaginationMetaCompanion(
            id: id,
            resource: resource,
            scope: scope,
            key: key,
            parentKey: parentKey,
            lastPage: lastPage,
            perPage: perPage,
            total: total,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String resource,
            Value<String> scope = const Value.absent(),
            Value<String?> key = const Value.absent(),
            Value<String?> parentKey = const Value.absent(),
            Value<int> lastPage = const Value.absent(),
            Value<int> perPage = const Value.absent(),
            Value<int> total = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PaginationMetaCompanion.insert(
            id: id,
            resource: resource,
            scope: scope,
            key: key,
            parentKey: parentKey,
            lastPage: lastPage,
            perPage: perPage,
            total: total,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaginationMetaTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $PaginationMetaTable,
    PaginationMetaData,
    $$PaginationMetaTableFilterComposer,
    $$PaginationMetaTableOrderingComposer,
    $$PaginationMetaTableAnnotationComposer,
    $$PaginationMetaTableCreateCompanionBuilder,
    $$PaginationMetaTableUpdateCompanionBuilder,
    (
      PaginationMetaData,
      BaseReferences<_$Safirah, $PaginationMetaTable, PaginationMetaData>
    ),
    PaginationMetaData,
    PrefetchHooks Function()>;
typedef $$TermsTableCreateCompanionBuilder = TermsCompanion Function({
  Value<int> id,
  required String syncId,
  required String name,
  required String type,
  required int order,
  Value<DateTime> createdAt,
});
typedef $$TermsTableUpdateCompanionBuilder = TermsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> name,
  Value<String> type,
  Value<int> order,
  Value<DateTime> createdAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
    (Term, BaseReferences<_$Safirah, $TermsTable, Term>),
    Term,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TermsCompanion(
            id: id,
            syncId: syncId,
            name: name,
            type: type,
            order: order,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String name,
            required String type,
            required int order,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TermsCompanion.insert(
            id: id,
            syncId: syncId,
            name: name,
            type: type,
            order: order,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Term, BaseReferences<_$Safirah, $TermsTable, Term>),
    Term,
    PrefetchHooks Function()>;
typedef $$LeagueTermsTableCreateCompanionBuilder = LeagueTermsCompanion
    Function({
  Value<int> id,
  required String syncId,
  required String leagueSyncId,
  required String termSyncId,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$LeagueTermsTableUpdateCompanionBuilder = LeagueTermsCompanion
    Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> termSyncId,
  Value<int> durationMinutes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get termSyncId => $composableBuilder(
      column: $table.termSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get termSyncId => $composableBuilder(
      column: $table.termSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get termSyncId => $composableBuilder(
      column: $table.termSyncId, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
    (LeagueTerm, BaseReferences<_$Safirah, $LeagueTermsTable, LeagueTerm>),
    LeagueTerm,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> termSyncId = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeagueTermsCompanion(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            termSyncId: termSyncId,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String leagueSyncId,
            required String termSyncId,
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LeagueTermsCompanion.insert(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            termSyncId: termSyncId,
            durationMinutes: durationMinutes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (LeagueTerm, BaseReferences<_$Safirah, $LeagueTermsTable, LeagueTerm>),
    LeagueTerm,
    PrefetchHooks Function()>;
typedef $$MatchTermsTableCreateCompanionBuilder = MatchTermsCompanion Function({
  Value<int> id,
  required String syncId,
  required String matchSyncId,
  required String leagueTermSyncId,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> additionalMinutes,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
});
typedef $$MatchTermsTableUpdateCompanionBuilder = MatchTermsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> matchSyncId,
  Value<String> leagueTermSyncId,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int> additionalMinutes,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueTermSyncId => $composableBuilder(
      column: $table.leagueTermSyncId,
      builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueTermSyncId => $composableBuilder(
      column: $table.leagueTermSyncId,
      builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => column);

  GeneratedColumn<String> get leagueTermSyncId => $composableBuilder(
      column: $table.leagueTermSyncId, builder: (column) => column);

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
    (MatchTerm, BaseReferences<_$Safirah, $MatchTermsTable, MatchTerm>),
    MatchTerm,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> matchSyncId = const Value.absent(),
            Value<String> leagueTermSyncId = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> additionalMinutes = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MatchTermsCompanion(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            leagueTermSyncId: leagueTermSyncId,
            startTime: startTime,
            endTime: endTime,
            additionalMinutes: additionalMinutes,
            isFinished: isFinished,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String matchSyncId,
            required String leagueTermSyncId,
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int> additionalMinutes = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MatchTermsCompanion.insert(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            leagueTermSyncId: leagueTermSyncId,
            startTime: startTime,
            endTime: endTime,
            additionalMinutes: additionalMinutes,
            isFinished: isFinished,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (MatchTerm, BaseReferences<_$Safirah, $MatchTermsTable, MatchTerm>),
    MatchTerm,
    PrefetchHooks Function()>;
typedef $$MatchTermPauseTableCreateCompanionBuilder = MatchTermPauseCompanion
    Function({
  Value<int> id,
  required String matchTermSyncId,
  required DateTime startPause,
  Value<DateTime?> endPause,
});
typedef $$MatchTermPauseTableUpdateCompanionBuilder = MatchTermPauseCompanion
    Function({
  Value<int> id,
  Value<String> matchTermSyncId,
  Value<DateTime> startPause,
  Value<DateTime?> endPause,
});

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

  ColumnFilters<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endPause => $composableBuilder(
      column: $table.endPause, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endPause => $composableBuilder(
      column: $table.endPause, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId, builder: (column) => column);

  GeneratedColumn<DateTime> get startPause => $composableBuilder(
      column: $table.startPause, builder: (column) => column);

  GeneratedColumn<DateTime> get endPause =>
      $composableBuilder(column: $table.endPause, builder: (column) => column);
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
    (
      MatchTermPauseData,
      BaseReferences<_$Safirah, $MatchTermPauseTable, MatchTermPauseData>
    ),
    MatchTermPauseData,
    PrefetchHooks Function()> {
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
            Value<String> matchTermSyncId = const Value.absent(),
            Value<DateTime> startPause = const Value.absent(),
            Value<DateTime?> endPause = const Value.absent(),
          }) =>
              MatchTermPauseCompanion(
            id: id,
            matchTermSyncId: matchTermSyncId,
            startPause: startPause,
            endPause: endPause,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String matchTermSyncId,
            required DateTime startPause,
            Value<DateTime?> endPause = const Value.absent(),
          }) =>
              MatchTermPauseCompanion.insert(
            id: id,
            matchTermSyncId: matchTermSyncId,
            startPause: startPause,
            endPause: endPause,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      MatchTermPauseData,
      BaseReferences<_$Safirah, $MatchTermPauseTable, MatchTermPauseData>
    ),
    MatchTermPauseData,
    PrefetchHooks Function()>;
typedef $$WarningsTableCreateCompanionBuilder = WarningsCompanion Function({
  Value<int> id,
  required String syncId,
  required String matchSyncId,
  required String playerSyncId,
  required String matchTermSyncId,
  required int warningTime,
  required String warningType,
  Value<String?> reason,
  Value<String> status,
});
typedef $$WarningsTableUpdateCompanionBuilder = WarningsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> matchSyncId,
  Value<String> playerSyncId,
  Value<String> matchTermSyncId,
  Value<int> warningTime,
  Value<String> warningType,
  Value<String?> reason,
  Value<String> status,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => column);

  GeneratedColumn<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => column);

  GeneratedColumn<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId, builder: (column) => column);

  GeneratedColumn<int> get warningTime => $composableBuilder(
      column: $table.warningTime, builder: (column) => column);

  GeneratedColumn<String> get warningType => $composableBuilder(
      column: $table.warningType, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
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
    (Warning, BaseReferences<_$Safirah, $WarningsTable, Warning>),
    Warning,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> matchSyncId = const Value.absent(),
            Value<String> playerSyncId = const Value.absent(),
            Value<String> matchTermSyncId = const Value.absent(),
            Value<int> warningTime = const Value.absent(),
            Value<String> warningType = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WarningsCompanion(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            warningTime: warningTime,
            warningType: warningType,
            reason: reason,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String matchSyncId,
            required String playerSyncId,
            required String matchTermSyncId,
            required int warningTime,
            required String warningType,
            Value<String?> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WarningsCompanion.insert(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            warningTime: warningTime,
            warningType: warningType,
            reason: reason,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Warning, BaseReferences<_$Safirah, $WarningsTable, Warning>),
    Warning,
    PrefetchHooks Function()>;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required String syncId,
  required String matchSyncId,
  required String playerSyncId,
  required String matchTermSyncId,
  required int goalTime,
  required String goalType,
  Value<String> status,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> matchSyncId,
  Value<String> playerSyncId,
  Value<String> matchTermSyncId,
  Value<int> goalTime,
  Value<String> goalType,
  Value<String> status,
});

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

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalTime => $composableBuilder(
      column: $table.goalTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalType => $composableBuilder(
      column: $table.goalType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalTime => $composableBuilder(
      column: $table.goalTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalType => $composableBuilder(
      column: $table.goalType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => column);

  GeneratedColumn<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => column);

  GeneratedColumn<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId, builder: (column) => column);

  GeneratedColumn<int> get goalTime =>
      $composableBuilder(column: $table.goalTime, builder: (column) => column);

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
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
    (Goal, BaseReferences<_$Safirah, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()> {
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
            Value<String> syncId = const Value.absent(),
            Value<String> matchSyncId = const Value.absent(),
            Value<String> playerSyncId = const Value.absent(),
            Value<String> matchTermSyncId = const Value.absent(),
            Value<int> goalTime = const Value.absent(),
            Value<String> goalType = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            goalTime: goalTime,
            goalType: goalType,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String matchSyncId,
            required String playerSyncId,
            required String matchTermSyncId,
            required int goalTime,
            required String goalType,
            Value<String> status = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            syncId: syncId,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            goalTime: goalTime,
            goalType: goalType,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Goal, BaseReferences<_$Safirah, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()>;
typedef $$AssistsTableCreateCompanionBuilder = AssistsCompanion Function({
  Value<int> id,
  required String matchSyncId,
  required String playerSyncId,
  required String matchTermSyncId,
  required String goalSyncId,
  required int assistTime,
  Value<String> status,
});
typedef $$AssistsTableUpdateCompanionBuilder = AssistsCompanion Function({
  Value<int> id,
  Value<String> matchSyncId,
  Value<String> playerSyncId,
  Value<String> matchTermSyncId,
  Value<String> goalSyncId,
  Value<int> assistTime,
  Value<String> status,
});

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

  ColumnFilters<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalSyncId => $composableBuilder(
      column: $table.goalSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalSyncId => $composableBuilder(
      column: $table.goalSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => column);

  GeneratedColumn<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => column);

  GeneratedColumn<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId, builder: (column) => column);

  GeneratedColumn<String> get goalSyncId => $composableBuilder(
      column: $table.goalSyncId, builder: (column) => column);

  GeneratedColumn<int> get assistTime => $composableBuilder(
      column: $table.assistTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
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
    (Assist, BaseReferences<_$Safirah, $AssistsTable, Assist>),
    Assist,
    PrefetchHooks Function()> {
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
            Value<String> matchSyncId = const Value.absent(),
            Value<String> playerSyncId = const Value.absent(),
            Value<String> matchTermSyncId = const Value.absent(),
            Value<String> goalSyncId = const Value.absent(),
            Value<int> assistTime = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              AssistsCompanion(
            id: id,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            goalSyncId: goalSyncId,
            assistTime: assistTime,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String matchSyncId,
            required String playerSyncId,
            required String matchTermSyncId,
            required String goalSyncId,
            required int assistTime,
            Value<String> status = const Value.absent(),
          }) =>
              AssistsCompanion.insert(
            id: id,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            goalSyncId: goalSyncId,
            assistTime: assistTime,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (Assist, BaseReferences<_$Safirah, $AssistsTable, Assist>),
    Assist,
    PrefetchHooks Function()>;
typedef $$PlayerMatchParticipationTableCreateCompanionBuilder
    = PlayerMatchParticipationCompanion Function({
  Value<int> id,
  required String matchSyncId,
  required String playerSyncId,
  required String matchTermSyncId,
  Value<int?> startTime,
  Value<int?> endTime,
  Value<String?> substitutedPlayerSyncId,
  required String participationType,
});
typedef $$PlayerMatchParticipationTableUpdateCompanionBuilder
    = PlayerMatchParticipationCompanion Function({
  Value<int> id,
  Value<String> matchSyncId,
  Value<String> playerSyncId,
  Value<String> matchTermSyncId,
  Value<int?> startTime,
  Value<int?> endTime,
  Value<String?> substitutedPlayerSyncId,
  Value<String> participationType,
});

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

  ColumnFilters<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get substitutedPlayerSyncId => $composableBuilder(
      column: $table.substitutedPlayerSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get participationType => $composableBuilder(
      column: $table.participationType,
      builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get substitutedPlayerSyncId => $composableBuilder(
      column: $table.substitutedPlayerSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get participationType => $composableBuilder(
      column: $table.participationType,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get matchSyncId => $composableBuilder(
      column: $table.matchSyncId, builder: (column) => column);

  GeneratedColumn<String> get playerSyncId => $composableBuilder(
      column: $table.playerSyncId, builder: (column) => column);

  GeneratedColumn<String> get matchTermSyncId => $composableBuilder(
      column: $table.matchTermSyncId, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get substitutedPlayerSyncId => $composableBuilder(
      column: $table.substitutedPlayerSyncId, builder: (column) => column);

  GeneratedColumn<String> get participationType => $composableBuilder(
      column: $table.participationType, builder: (column) => column);
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
    (
      PlayerMatchParticipationData,
      BaseReferences<_$Safirah, $PlayerMatchParticipationTable,
          PlayerMatchParticipationData>
    ),
    PlayerMatchParticipationData,
    PrefetchHooks Function()> {
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
            Value<String> matchSyncId = const Value.absent(),
            Value<String> playerSyncId = const Value.absent(),
            Value<String> matchTermSyncId = const Value.absent(),
            Value<int?> startTime = const Value.absent(),
            Value<int?> endTime = const Value.absent(),
            Value<String?> substitutedPlayerSyncId = const Value.absent(),
            Value<String> participationType = const Value.absent(),
          }) =>
              PlayerMatchParticipationCompanion(
            id: id,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            startTime: startTime,
            endTime: endTime,
            substitutedPlayerSyncId: substitutedPlayerSyncId,
            participationType: participationType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String matchSyncId,
            required String playerSyncId,
            required String matchTermSyncId,
            Value<int?> startTime = const Value.absent(),
            Value<int?> endTime = const Value.absent(),
            Value<String?> substitutedPlayerSyncId = const Value.absent(),
            required String participationType,
          }) =>
              PlayerMatchParticipationCompanion.insert(
            id: id,
            matchSyncId: matchSyncId,
            playerSyncId: playerSyncId,
            matchTermSyncId: matchTermSyncId,
            startTime: startTime,
            endTime: endTime,
            substitutedPlayerSyncId: substitutedPlayerSyncId,
            participationType: participationType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
          BaseReferences<_$Safirah, $PlayerMatchParticipationTable,
              PlayerMatchParticipationData>
        ),
        PlayerMatchParticipationData,
        PrefetchHooks Function()>;
typedef $$UsersHasRoleTableCreateCompanionBuilder = UsersHasRoleCompanion
    Function({
  required String syncId,
  required String leagueSyncId,
  required String name,
  required String role,
  Value<int?> roleOrder,
  Value<int> rowid,
});
typedef $$UsersHasRoleTableUpdateCompanionBuilder = UsersHasRoleCompanion
    Function({
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> name,
  Value<String> role,
  Value<int?> roleOrder,
  Value<int> rowid,
});

class $$UsersHasRoleTableFilterComposer
    extends Composer<_$Safirah, $UsersHasRoleTable> {
  $$UsersHasRoleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get roleOrder => $composableBuilder(
      column: $table.roleOrder, builder: (column) => ColumnFilters(column));
}

class $$UsersHasRoleTableOrderingComposer
    extends Composer<_$Safirah, $UsersHasRoleTable> {
  $$UsersHasRoleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roleOrder => $composableBuilder(
      column: $table.roleOrder, builder: (column) => ColumnOrderings(column));
}

class $$UsersHasRoleTableAnnotationComposer
    extends Composer<_$Safirah, $UsersHasRoleTable> {
  $$UsersHasRoleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get roleOrder =>
      $composableBuilder(column: $table.roleOrder, builder: (column) => column);
}

class $$UsersHasRoleTableTableManager extends RootTableManager<
    _$Safirah,
    $UsersHasRoleTable,
    UsersHasRoleData,
    $$UsersHasRoleTableFilterComposer,
    $$UsersHasRoleTableOrderingComposer,
    $$UsersHasRoleTableAnnotationComposer,
    $$UsersHasRoleTableCreateCompanionBuilder,
    $$UsersHasRoleTableUpdateCompanionBuilder,
    (
      UsersHasRoleData,
      BaseReferences<_$Safirah, $UsersHasRoleTable, UsersHasRoleData>
    ),
    UsersHasRoleData,
    PrefetchHooks Function()> {
  $$UsersHasRoleTableTableManager(_$Safirah db, $UsersHasRoleTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersHasRoleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersHasRoleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersHasRoleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<int?> roleOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersHasRoleCompanion(
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            name: name,
            role: role,
            roleOrder: roleOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String syncId,
            required String leagueSyncId,
            required String name,
            required String role,
            Value<int?> roleOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersHasRoleCompanion.insert(
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            name: name,
            role: role,
            roleOrder: roleOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersHasRoleTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $UsersHasRoleTable,
    UsersHasRoleData,
    $$UsersHasRoleTableFilterComposer,
    $$UsersHasRoleTableOrderingComposer,
    $$UsersHasRoleTableAnnotationComposer,
    $$UsersHasRoleTableCreateCompanionBuilder,
    $$UsersHasRoleTableUpdateCompanionBuilder,
    (
      UsersHasRoleData,
      BaseReferences<_$Safirah, $UsersHasRoleTable, UsersHasRoleData>
    ),
    UsersHasRoleData,
    PrefetchHooks Function()>;
typedef $$LeagueKnockoutFlagsTableCreateCompanionBuilder
    = LeagueKnockoutFlagsCompanion Function({
  required String leagueSyncId,
  Value<bool> firstKnockoutCreated,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$LeagueKnockoutFlagsTableUpdateCompanionBuilder
    = LeagueKnockoutFlagsCompanion Function({
  Value<String> leagueSyncId,
  Value<bool> firstKnockoutCreated,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$LeagueKnockoutFlagsTableFilterComposer
    extends Composer<_$Safirah, $LeagueKnockoutFlagsTable> {
  $$LeagueKnockoutFlagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get firstKnockoutCreated => $composableBuilder(
      column: $table.firstKnockoutCreated,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LeagueKnockoutFlagsTableOrderingComposer
    extends Composer<_$Safirah, $LeagueKnockoutFlagsTable> {
  $$LeagueKnockoutFlagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get firstKnockoutCreated => $composableBuilder(
      column: $table.firstKnockoutCreated,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LeagueKnockoutFlagsTableAnnotationComposer
    extends Composer<_$Safirah, $LeagueKnockoutFlagsTable> {
  $$LeagueKnockoutFlagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<bool> get firstKnockoutCreated => $composableBuilder(
      column: $table.firstKnockoutCreated, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LeagueKnockoutFlagsTableTableManager extends RootTableManager<
    _$Safirah,
    $LeagueKnockoutFlagsTable,
    LeagueKnockoutFlag,
    $$LeagueKnockoutFlagsTableFilterComposer,
    $$LeagueKnockoutFlagsTableOrderingComposer,
    $$LeagueKnockoutFlagsTableAnnotationComposer,
    $$LeagueKnockoutFlagsTableCreateCompanionBuilder,
    $$LeagueKnockoutFlagsTableUpdateCompanionBuilder,
    (
      LeagueKnockoutFlag,
      BaseReferences<_$Safirah, $LeagueKnockoutFlagsTable, LeagueKnockoutFlag>
    ),
    LeagueKnockoutFlag,
    PrefetchHooks Function()> {
  $$LeagueKnockoutFlagsTableTableManager(
      _$Safirah db, $LeagueKnockoutFlagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeagueKnockoutFlagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeagueKnockoutFlagsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeagueKnockoutFlagsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> leagueSyncId = const Value.absent(),
            Value<bool> firstKnockoutCreated = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LeagueKnockoutFlagsCompanion(
            leagueSyncId: leagueSyncId,
            firstKnockoutCreated: firstKnockoutCreated,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String leagueSyncId,
            Value<bool> firstKnockoutCreated = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LeagueKnockoutFlagsCompanion.insert(
            leagueSyncId: leagueSyncId,
            firstKnockoutCreated: firstKnockoutCreated,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LeagueKnockoutFlagsTableProcessedTableManager = ProcessedTableManager<
    _$Safirah,
    $LeagueKnockoutFlagsTable,
    LeagueKnockoutFlag,
    $$LeagueKnockoutFlagsTableFilterComposer,
    $$LeagueKnockoutFlagsTableOrderingComposer,
    $$LeagueKnockoutFlagsTableAnnotationComposer,
    $$LeagueKnockoutFlagsTableCreateCompanionBuilder,
    $$LeagueKnockoutFlagsTableUpdateCompanionBuilder,
    (
      LeagueKnockoutFlag,
      BaseReferences<_$Safirah, $LeagueKnockoutFlagsTable, LeagueKnockoutFlag>
    ),
    LeagueKnockoutFlag,
    PrefetchHooks Function()>;
typedef $$KnockoutProgressLocksTableCreateCompanionBuilder
    = KnockoutProgressLocksCompanion Function({
  required String leagueSyncId,
  required String finishedRoundSyncId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$KnockoutProgressLocksTableUpdateCompanionBuilder
    = KnockoutProgressLocksCompanion Function({
  Value<String> leagueSyncId,
  Value<String> finishedRoundSyncId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$KnockoutProgressLocksTableFilterComposer
    extends Composer<_$Safirah, $KnockoutProgressLocksTable> {
  $$KnockoutProgressLocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finishedRoundSyncId => $composableBuilder(
      column: $table.finishedRoundSyncId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$KnockoutProgressLocksTableOrderingComposer
    extends Composer<_$Safirah, $KnockoutProgressLocksTable> {
  $$KnockoutProgressLocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finishedRoundSyncId => $composableBuilder(
      column: $table.finishedRoundSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$KnockoutProgressLocksTableAnnotationComposer
    extends Composer<_$Safirah, $KnockoutProgressLocksTable> {
  $$KnockoutProgressLocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get finishedRoundSyncId => $composableBuilder(
      column: $table.finishedRoundSyncId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KnockoutProgressLocksTableTableManager extends RootTableManager<
    _$Safirah,
    $KnockoutProgressLocksTable,
    KnockoutProgressLock,
    $$KnockoutProgressLocksTableFilterComposer,
    $$KnockoutProgressLocksTableOrderingComposer,
    $$KnockoutProgressLocksTableAnnotationComposer,
    $$KnockoutProgressLocksTableCreateCompanionBuilder,
    $$KnockoutProgressLocksTableUpdateCompanionBuilder,
    (
      KnockoutProgressLock,
      BaseReferences<_$Safirah, $KnockoutProgressLocksTable,
          KnockoutProgressLock>
    ),
    KnockoutProgressLock,
    PrefetchHooks Function()> {
  $$KnockoutProgressLocksTableTableManager(
      _$Safirah db, $KnockoutProgressLocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnockoutProgressLocksTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KnockoutProgressLocksTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnockoutProgressLocksTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> finishedRoundSyncId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnockoutProgressLocksCompanion(
            leagueSyncId: leagueSyncId,
            finishedRoundSyncId: finishedRoundSyncId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String leagueSyncId,
            required String finishedRoundSyncId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnockoutProgressLocksCompanion.insert(
            leagueSyncId: leagueSyncId,
            finishedRoundSyncId: finishedRoundSyncId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KnockoutProgressLocksTableProcessedTableManager
    = ProcessedTableManager<
        _$Safirah,
        $KnockoutProgressLocksTable,
        KnockoutProgressLock,
        $$KnockoutProgressLocksTableFilterComposer,
        $$KnockoutProgressLocksTableOrderingComposer,
        $$KnockoutProgressLocksTableAnnotationComposer,
        $$KnockoutProgressLocksTableCreateCompanionBuilder,
        $$KnockoutProgressLocksTableUpdateCompanionBuilder,
        (
          KnockoutProgressLock,
          BaseReferences<_$Safirah, $KnockoutProgressLocksTable,
              KnockoutProgressLock>
        ),
        KnockoutProgressLock,
        PrefetchHooks Function()>;
typedef $$UserLeaguePermissionsTableCreateCompanionBuilder
    = UserLeaguePermissionsCompanion Function({
  Value<int> id,
  required String syncId,
  required String leagueSyncId,
  required String permissionKey,
  Value<DateTime> createdAt,
});
typedef $$UserLeaguePermissionsTableUpdateCompanionBuilder
    = UserLeaguePermissionsCompanion Function({
  Value<int> id,
  Value<String> syncId,
  Value<String> leagueSyncId,
  Value<String> permissionKey,
  Value<DateTime> createdAt,
});

class $$UserLeaguePermissionsTableFilterComposer
    extends Composer<_$Safirah, $UserLeaguePermissionsTable> {
  $$UserLeaguePermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissionKey => $composableBuilder(
      column: $table.permissionKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UserLeaguePermissionsTableOrderingComposer
    extends Composer<_$Safirah, $UserLeaguePermissionsTable> {
  $$UserLeaguePermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissionKey => $composableBuilder(
      column: $table.permissionKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UserLeaguePermissionsTableAnnotationComposer
    extends Composer<_$Safirah, $UserLeaguePermissionsTable> {
  $$UserLeaguePermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get leagueSyncId => $composableBuilder(
      column: $table.leagueSyncId, builder: (column) => column);

  GeneratedColumn<String> get permissionKey => $composableBuilder(
      column: $table.permissionKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserLeaguePermissionsTableTableManager extends RootTableManager<
    _$Safirah,
    $UserLeaguePermissionsTable,
    UserLeaguePermission,
    $$UserLeaguePermissionsTableFilterComposer,
    $$UserLeaguePermissionsTableOrderingComposer,
    $$UserLeaguePermissionsTableAnnotationComposer,
    $$UserLeaguePermissionsTableCreateCompanionBuilder,
    $$UserLeaguePermissionsTableUpdateCompanionBuilder,
    (
      UserLeaguePermission,
      BaseReferences<_$Safirah, $UserLeaguePermissionsTable,
          UserLeaguePermission>
    ),
    UserLeaguePermission,
    PrefetchHooks Function()> {
  $$UserLeaguePermissionsTableTableManager(
      _$Safirah db, $UserLeaguePermissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserLeaguePermissionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$UserLeaguePermissionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserLeaguePermissionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> syncId = const Value.absent(),
            Value<String> leagueSyncId = const Value.absent(),
            Value<String> permissionKey = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UserLeaguePermissionsCompanion(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            permissionKey: permissionKey,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncId,
            required String leagueSyncId,
            required String permissionKey,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UserLeaguePermissionsCompanion.insert(
            id: id,
            syncId: syncId,
            leagueSyncId: leagueSyncId,
            permissionKey: permissionKey,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserLeaguePermissionsTableProcessedTableManager
    = ProcessedTableManager<
        _$Safirah,
        $UserLeaguePermissionsTable,
        UserLeaguePermission,
        $$UserLeaguePermissionsTableFilterComposer,
        $$UserLeaguePermissionsTableOrderingComposer,
        $$UserLeaguePermissionsTableAnnotationComposer,
        $$UserLeaguePermissionsTableCreateCompanionBuilder,
        $$UserLeaguePermissionsTableUpdateCompanionBuilder,
        (
          UserLeaguePermission,
          BaseReferences<_$Safirah, $UserLeaguePermissionsTable,
              UserLeaguePermission>
        ),
        UserLeaguePermission,
        PrefetchHooks Function()>;

class $SafirahManager {
  final _$Safirah _db;
  $SafirahManager(this._db);
  $$LeaguesTableTableManager get leagues =>
      $$LeaguesTableTableManager(_db, _db.leagues);
  $$LeagueRulesTableTableManager get leagueRules =>
      $$LeagueRulesTableTableManager(_db, _db.leagueRules);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$TeamPlayerCategoriesTableTableManager get teamPlayerCategories =>
      $$TeamPlayerCategoriesTableTableManager(_db, _db.teamPlayerCategories);
  $$LeaguePlayersTableTableManager get leaguePlayers =>
      $$LeaguePlayersTableTableManager(_db, _db.leaguePlayers);
  $$DraftProgressTableTableManager get draftProgress =>
      $$DraftProgressTableTableManager(_db, _db.draftProgress);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$GroupTableTableManager get group =>
      $$GroupTableTableManager(_db, _db.group);
  $$GroupTeamTableTableManager get groupTeam =>
      $$GroupTeamTableTableManager(_db, _db.groupTeam);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$RoundsTableTableManager get rounds =>
      $$RoundsTableTableManager(_db, _db.rounds);
  $$QualifiedTeamTableTableManager get qualifiedTeam =>
      $$QualifiedTeamTableTableManager(_db, _db.qualifiedTeam);
  $$LeagueStatusTableTableManager get leagueStatus =>
      $$LeagueStatusTableTableManager(_db, _db.leagueStatus);
  $$PaginationMetaTableTableManager get paginationMeta =>
      $$PaginationMetaTableTableManager(_db, _db.paginationMeta);
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
  $$UsersHasRoleTableTableManager get usersHasRole =>
      $$UsersHasRoleTableTableManager(_db, _db.usersHasRole);
  $$LeagueKnockoutFlagsTableTableManager get leagueKnockoutFlags =>
      $$LeagueKnockoutFlagsTableTableManager(_db, _db.leagueKnockoutFlags);
  $$KnockoutProgressLocksTableTableManager get knockoutProgressLocks =>
      $$KnockoutProgressLocksTableTableManager(_db, _db.knockoutProgressLocks);
  $$UserLeaguePermissionsTableTableManager get userLeaguePermissions =>
      $$UserLeaguePermissionsTableTableManager(_db, _db.userLeaguePermissions);
}
