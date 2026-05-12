class AwardsData {
  final String scope;
  final String requestedScope;
  final List<AwardsActivePeriod> activePeriods;
  final List<AwardsScopeData> scopes;

  AwardsData({
    required this.scope,
    required this.requestedScope,
    required this.activePeriods,
    required this.scopes,
  });

  factory AwardsData.fromJson(
    Map<String, dynamic> json, {
    String? preferredScope,
  }) {
    final root = _map(json['data']) ?? json;
    final hasScopedResponse = root['active_periods'] is List || root['scopes'] is List;

    if (hasScopedResponse) {
      final activePeriods = AwardsActivePeriod.fromJsonList(root['active_periods'] ?? []);
      final scopes = AwardsScopeData.fromJsonList(root['scopes'] ?? []);
      final requestedScope = _string(root['requested_scope']);
      final resolvedScope = _resolveScope(
        scopes: scopes,
        preferredScope: preferredScope,
        requestedScope: requestedScope,
        activePeriods: activePeriods,
      );

      return AwardsData(
        scope: resolvedScope?.scope ??
            _firstString([
              preferredScope,
              requestedScope,
              activePeriods.isNotEmpty ? activePeriods.first.name : '',
              scopes.isNotEmpty ? scopes.first.scope : '',
              'month',
            ]),
        requestedScope: requestedScope,
        activePeriods: activePeriods,
        scopes: scopes,
      );
    }

    final legacyScope = AwardsScopeData.fromLegacyJson(
      root,
      preferredScope: preferredScope,
    );

    return AwardsData(
      scope: legacyScope.scope,
      requestedScope: '',
      activePeriods: const [],
      scopes: [legacyScope],
    );
  }

  factory AwardsData.empty() {
    return AwardsData(
      scope: '',
      requestedScope: '',
      activePeriods: const [],
      scopes: const [],
    );
  }

  factory AwardsData.placeholder(String scope) {
    final fallbackScopes = [
      AwardsScopeData(
        scope: 'month',
        period: AwardsPeriod(
          id: 17,
          type: 'month',
          label: 'الشهر 5',
          monthNumber: 5,
          year: 0,
          startDate: '',
          endDate: '',
          isClosed: false,
        ),
        season: AwardsSeason(
          id: 2,
          name: '',
          year: 2026,
        ),
        itemsCount: 3,
        items: [
          AwardPrizeData.placeholder(1),
          AwardPrizeData.placeholder(2),
          AwardPrizeData.placeholder(3),
        ],
      ),
      AwardsScopeData(
        scope: 'season',
        period: AwardsPeriod(
          id: 2,
          type: 'season',
          label: 'موسم 2026',
          monthNumber: 0,
          year: 2026,
          startDate: '',
          endDate: '',
          isClosed: false,
        ),
        season: AwardsSeason(
          id: 2,
          name: '',
          year: 2026,
        ),
        itemsCount: 3,
        items: [
          AwardPrizeData.placeholder(1),
          AwardPrizeData.placeholder(2),
          AwardPrizeData.placeholder(3),
        ],
      ),
    ];

    final selectedScope = fallbackScopes.firstWhere(
      (item) => item.scope == scope,
      orElse: () => fallbackScopes.first,
    );

    return AwardsData(
      scope: selectedScope.scope,
      requestedScope: selectedScope.scope,
      activePeriods: [
        AwardsActivePeriod(id: 2, name: 'month', label: 'شهري', labelEn: 'Monthly'),
        AwardsActivePeriod(id: 3, name: 'season', label: 'موسمي', labelEn: 'Seasonal'),
      ],
      scopes: fallbackScopes,
    );
  }

  AwardsScopeData? get selectedScopeData => scopeDataFor(scope);

  bool get hasRemoteStructure => activePeriods.isNotEmpty || scopes.isNotEmpty;

  bool hasScope(String value) => scopeDataFor(value) != null;

  List<AwardsActivePeriod> get availablePeriods {
    if (activePeriods.isNotEmpty) return activePeriods;

    return [
      AwardsActivePeriod(id: 2, name: 'month', label: 'شهري', labelEn: 'Monthly'),
      AwardsActivePeriod(id: 3, name: 'season', label: 'موسمي', labelEn: 'Seasonal'),
    ];
  }

  AwardsScopeData? scopeDataFor(String? value) {
    if (_string(value).isEmpty) return null;

    for (final item in scopes) {
      if (item.scope == value) return item;
    }

    return null;
  }

  AwardsData mergeWith(AwardsData other) {
    final mergedPeriods = <AwardsActivePeriod>[...activePeriods];
    for (final item in other.activePeriods) {
      if (!mergedPeriods.any((current) => current.name == item.name)) {
        mergedPeriods.add(item);
      }
    }

    final mergedScopes = <AwardsScopeData>[...scopes];
    for (final item in other.scopes) {
      final index = mergedScopes.indexWhere((current) => current.scope == item.scope);
      if (index == -1) {
        mergedScopes.add(item);
      } else {
        mergedScopes[index] = item;
      }
    }

    return AwardsData(
      scope: scope.isNotEmpty ? scope : other.scope,
      requestedScope: requestedScope.isNotEmpty ? requestedScope : other.requestedScope,
      activePeriods: mergedPeriods,
      scopes: mergedScopes,
    );
  }

  List<AwardPrizeData> get items {
    return selectedScopeData?.items ?? AwardPrizeData.ensureTopThree(const []);
  }

  num get itemsCount {
    return selectedScopeData?.itemsCount ?? 0;
  }

  AwardsPeriod get period {
    return selectedScopeData?.period ?? AwardsPeriod.empty();
  }

  AwardsSeason get season {
    return selectedScopeData?.season ?? AwardsSeason.empty();
  }

  String scopeLabel(String scopeName) {
    for (final item in availablePeriods) {
      if (item.name == scopeName) return item.label;
    }

    if (scopeName == 'month') return 'شهري';
    if (scopeName == 'season') return 'موسمي';
    return scopeName;
  }

  static AwardsScopeData? _resolveScope({
    required List<AwardsScopeData> scopes,
    required String? preferredScope,
    required String requestedScope,
    required List<AwardsActivePeriod> activePeriods,
  }) {
    final candidates = [
      preferredScope ?? '',
      requestedScope,
      activePeriods.isNotEmpty ? activePeriods.first.name : '',
    ];

    for (final candidate in candidates) {
      if (_string(candidate).isEmpty) continue;

      for (final item in scopes) {
        if (item.scope == candidate) return item;
      }
    }

    if (scopes.isNotEmpty) return scopes.first;
    return null;
  }
}

class AwardsActivePeriod {
  final int id;
  final String name;
  final String label;
  final String labelEn;

  AwardsActivePeriod({
    required this.id,
    required this.name,
    required this.label,
    required this.labelEn,
  });

  factory AwardsActivePeriod.fromJson(Map<String, dynamic> json) {
    return AwardsActivePeriod(
      id: (_num(json['id']) ?? 0).toInt(),
      name: _firstString([
        json['name'],
        json['scope'],
        json['type'],
      ]),
      label: _firstString([
        json['label'],
        json['name'],
      ]),
      labelEn: _firstString([
        json['label_en'],
        json['labelEn'],
      ]),
    );
  }

  static List<AwardsActivePeriod> fromJsonList(List json) {
    return json.map((e) => AwardsActivePeriod.fromJson(_map(e) ?? {})).toList();
  }
}

class AwardsScopeData {
  final String scope;
  final AwardsPeriod period;
  final AwardsSeason season;
  final num itemsCount;
  final List<AwardPrizeData> items;

  AwardsScopeData({
    required this.scope,
    required this.period,
    required this.season,
    required this.itemsCount,
    required this.items,
  });

  factory AwardsScopeData.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] ?? [];
    final items = AwardPrizeData.fromJsonList(rawItems)
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return AwardsScopeData(
      scope: _firstString([
        json['scope'],
        _map(json['period'])?['type'],
      ]),
      period: AwardsPeriod.fromJson(_map(json['period']) ?? {}),
      season: AwardsSeason.fromJson(_map(json['season']) ?? {}),
      itemsCount: _num(json['items_count']) ?? rawItems.length,
      items: AwardPrizeData.ensureTopThree(items),
    );
  }

  factory AwardsScopeData.fromLegacyJson(
    Map<String, dynamic> json, {
    String? preferredScope,
  }) {
    final rawItems = _extractLegacyItems(json);
    final items = AwardPrizeData.fromJsonList(rawItems)
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return AwardsScopeData(
      scope: _firstString([
        preferredScope,
        json['scope'],
        json['period'],
        json['type'],
      ]),
      period: AwardsPeriod(
        id: 0,
        type: _firstString([
          json['period'],
          json['type'],
          preferredScope,
        ]),
        label: _firstString([
          json['period_label'],
          json['period_name'],
        ]),
        monthNumber: 0,
        year: 0,
        startDate: '',
        endDate: '',
        isClosed: false,
      ),
      season: AwardsSeason.fromJson(_map(json['season']) ?? {
        'name': _firstString([
          json['season_name'],
          json['season_label'],
          json['season'],
        ]),
      }),
      itemsCount: _num(json['items_count']) ?? items.length,
      items: AwardPrizeData.ensureTopThree(items),
    );
  }

  static List<AwardsScopeData> fromJsonList(List json) {
    return json.map((e) => AwardsScopeData.fromJson(_map(e) ?? {})).toList();
  }

  bool get hasMeaningfulAwards {
    return items.any((item) => item.hasPrize);
  }
}

class AwardsPeriod {
  final int id;
  final String type;
  final String label;
  final int monthNumber;
  final int year;
  final String startDate;
  final String endDate;
  final bool isClosed;

  AwardsPeriod({
    required this.id,
    required this.type,
    required this.label,
    required this.monthNumber,
    required this.year,
    required this.startDate,
    required this.endDate,
    required this.isClosed,
  });

  factory AwardsPeriod.fromJson(Map<String, dynamic> json) {
    return AwardsPeriod(
      id: (_num(json['id']) ?? 0).toInt(),
      type: _string(json['type']),
      label: _string(json['label']),
      monthNumber: (_num(json['month_number']) ?? 0).toInt(),
      year: (_num(json['year']) ?? 0).toInt(),
      startDate: _string(json['start_date']),
      endDate: _string(json['end_date']),
      isClosed: json['is_closed'] == true,
    );
  }

  factory AwardsPeriod.empty() {
    return AwardsPeriod(
      id: 0,
      type: '',
      label: '',
      monthNumber: 0,
      year: 0,
      startDate: '',
      endDate: '',
      isClosed: false,
    );
  }
}

class AwardsSeason {
  final int id;
  final String name;
  final int year;

  AwardsSeason({
    required this.id,
    required this.name,
    required this.year,
  });

  factory AwardsSeason.fromJson(Map<String, dynamic> json) {
    return AwardsSeason(
      id: (_num(json['id']) ?? 0).toInt(),
      name: _firstString([
        json['name'],
        json['label'],
      ]),
      year: (_num(json['year']) ?? 0).toInt(),
    );
  }

  factory AwardsSeason.empty() {
    return AwardsSeason(id: 0, name: '', year: 0);
  }
}

class AwardPrizeData {
  final int assignmentId;
  final AwardsRankingType rankingType;
  final AwardsPrize prize;
  final String executedAt;
  final String userName;
  final num points;

  AwardPrizeData({
    required this.assignmentId,
    required this.rankingType,
    required this.prize,
    required this.executedAt,
    required this.userName,
    required this.points,
  });

  factory AwardPrizeData.fromJson(Map<String, dynamic> json) {
    final user = _map(json['user']);
    final rankingType = AwardsRankingType.fromJson(_map(json['ranking_type']) ?? {
      'id': 0,
      'code': _legacyRankCode(json),
      'name': _legacyRankName(json),
    });

    return AwardPrizeData(
      assignmentId: (_num(json['assignment_id']) ?? 0).toInt(),
      rankingType: rankingType,
      prize: AwardsPrize.fromJson(_legacyPrizeJson(json)),
      executedAt: _string(json['executed_at']),
      userName: _firstString([
        user?['name'],
        user?['username'],
        json['user_name'],
        json['name'],
        json['username'],
      ]),
      points: _num(json['points']) ?? _num(json['score']) ?? _num(json['total_points']) ?? 0,
    );
  }

  factory AwardPrizeData.placeholder(int rank) {
    return AwardPrizeData(
      assignmentId: 0,
      rankingType: AwardsRankingType(
        id: rank,
        code: 'rank$rank',
        name: 'المركز $rank',
      ),
      prize: AwardsPrize(
        id: 0,
        name: '',
        description: '',
        rewardType: '',
        rewardTypeLabel: '',
        rewardValue: '',
        imageUrl: '',
      ),
      executedAt: '',
      userName: '',
      points: 0,
    );
  }

  static List<AwardPrizeData> fromJsonList(List json) {
    return json.map((e) => AwardPrizeData.fromJson(_map(e) ?? {})).toList();
  }

  int get rank => rankingType.rank;

  bool get hasPrize => prize.hasPrize;

  bool get hasImage => prize.imageUrl.trim().isNotEmpty;

  String get imageUrl => prize.imageUrl;

  String get prizeHeadline => prize.headline;

  String get prizeDetails => prize.details;

  String get displayPrize {
    if (!hasPrize) return 'سيتم الإعلان عنها لاحقًا';
    if (prizeDetails.isEmpty) return prizeHeadline;
    return '$prizeHeadline\n$prizeDetails';
  }

  static List<AwardPrizeData> ensureTopThree(List<AwardPrizeData> items) {
    final byRank = <int, AwardPrizeData>{};

    for (final item in items) {
      if (item.rank >= 1 && item.rank <= 3 && !byRank.containsKey(item.rank)) {
        byRank[item.rank] = item;
      }
    }

    return List.generate(
      3,
      (index) => byRank[index + 1] ?? AwardPrizeData.placeholder(index + 1),
    );
  }
}

class AwardsRankingType {
  final int id;
  final String code;
  final String name;

  AwardsRankingType({
    required this.id,
    required this.code,
    required this.name,
  });

  factory AwardsRankingType.fromJson(Map<String, dynamic> json) {
    return AwardsRankingType(
      id: (_num(json['id']) ?? 0).toInt(),
      code: _string(json['code']),
      name: _string(json['name']),
    );
  }

  int get rank => _extractRank(code) ?? _extractRank(name) ?? 0;
}

class AwardsPrize {
  final int id;
  final String name;
  final String description;
  final String rewardType;
  final String rewardTypeLabel;
  final String rewardValue;
  final String imageUrl;

  AwardsPrize({
    required this.id,
    required this.name,
    required this.description,
    required this.rewardType,
    required this.rewardTypeLabel,
    required this.rewardValue,
    required this.imageUrl,
  });

  factory AwardsPrize.fromJson(Map<String, dynamic> json) {
    return AwardsPrize(
      id: (_num(json['id']) ?? 0).toInt(),
      name: _firstString([
        json['name'],
        json['title'],
        json['label'],
      ]),
      description: _firstString([
        json['description'],
        json['subtitle'],
        json['sub_title'],
        json['details'],
        json['note'],
      ]),
      rewardType: _string(json['reward_type']),
      rewardTypeLabel: _string(json['reward_type_label']),
      rewardValue: _firstString([
        json['reward_value'],
        json['value'],
        json['amount'],
      ]),
      imageUrl: _firstString([
        json['image'],
        json['image_url'],
        json['imageUrl'],
        json['photo'],
        json['photo_url'],
        json['photoUrl'],
        json['thumbnail'],
      ]),
    );
  }

  bool get hasPrize => name.trim().isNotEmpty || details.isNotEmpty;

  String get headline {
    if (name.trim().isNotEmpty) return name;
    if (details.isNotEmpty) return details;
    return 'سيتم الإعلان عنها لاحقًا';
  }

  String get details {
    return _composePrizeSubtitle(
      base: description,
      rewardValue: rewardValue,
    );
  }
}

Map<String, dynamic>? _map(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

String _string(dynamic value) {
  if (value == null) return '';
  final text = value.toString().trim();
  if (text.isEmpty || text.toLowerCase() == 'null') return '';
  return text;
}

String _firstString(List<dynamic> values) {
  for (final value in values) {
    final text = _string(value);
    if (text.isNotEmpty) return text;
  }
  return '';
}

num? _num(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(value.toString());
}

String _composePrizeSubtitle({
  required String base,
  required String rewardValue,
}) {
  if (base.isEmpty) return rewardValue;
  if (rewardValue.isEmpty) return base;
  if (base.contains(rewardValue)) return base;
  return '$base $rewardValue'.trim();
}

int? _extractRank(dynamic value) {
  final text = _string(value);
  if (text.isEmpty) return null;

  final match = RegExp(r'\d+').firstMatch(text);
  if (match == null) return null;

  return int.tryParse(match.group(0) ?? '');
}

List<dynamic> _extractLegacyItems(Map<String, dynamic> json) {
  final directItems = json['items'] ??
      json['winners'] ??
      json['top_three'] ??
      json['topThree'] ??
      json['top_winners'] ??
      json['positions'];

  if (directItems is List) return directItems;

  final candidates = [
    _map(json['awards']),
    _map(json['prizes']),
    _map(json['ranking']),
    _map(json['winners_data']),
  ];

  for (final item in candidates) {
    final nestedItems = item?['items'] ?? item?['winners'] ?? item?['top_three'];
    if (nestedItems is List) return nestedItems;
  }

  return const [];
}

Map<String, dynamic> _legacyPrizeJson(Map<String, dynamic> json) {
  final prize = _map(json['prize']);
  final award = _map(json['award']);
  final reward = _map(json['reward']);
  final source = prize ?? award ?? reward;

  if (source != null) return source;

  return {
    'name': _firstString([
      json['prize_title'],
      json['award_title'],
      json['prize'],
      json['award'],
      json['reward'],
    ]),
    'description': _firstString([
      json['prize_description'],
      json['award_description'],
      json['description'],
    ]),
    'reward_value': _string(json['reward_value']),
    'image_url': _firstString([
      json['image'],
      json['image_url'],
      json['imageUrl'],
      json['photo'],
      json['photo_url'],
      json['photoUrl'],
      json['prize_image'],
      json['prize_image_url'],
      json['award_image'],
      json['award_image_url'],
    ]),
  };
}

String _legacyRankCode(Map<String, dynamic> json) {
  final rank = (_num(json['rank']) ??
          _num(json['position']) ??
          _num(json['place']) ??
          _num(json['order']) ??
          0)
      .toInt();
  return rank > 0 ? 'rank$rank' : '';
}

String _legacyRankName(Map<String, dynamic> json) {
  final rank = (_num(json['rank']) ??
          _num(json['position']) ??
          _num(json['place']) ??
          _num(json['order']) ??
          0)
      .toInt();
  return rank > 0 ? 'المركز $rank' : '';
}
