import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../home/data/models/banners_model.dart';
import '../../../home/data/models/news_item_model.dart';
import '../../data/model/league_model.dart';
import '../../data/model/league_status_model.dart';
import '../../data/model/report_model.dart';
import '../../data/model/rule_league_model.dart';
import '../../data/reposaitory/league_reposaitory.dart';
import 'package:safirah/injection.dart' as di;

final leagueFormProvider =
    StateNotifierProvider.autoDispose<LeagueFormNotifier, LeagueModel>(
  (ref) => LeagueFormNotifier(),
);

class LeagueFormNotifier extends StateNotifier<LeagueModel> {
  LeagueFormNotifier() : super(LeagueModel());

  void updateName(String value) => state = state.copyWith(name: value);

  void updateType(String value) => state = state.copyWith(type: value);

  void updateOrganizerId(int value) =>
      state = state.copyWith(organizerId: value);

  void updateScope(String value) => state = state.copyWith(scope: value);

  void updateStartDate(DateTime value) =>
      state = state.copyWith(startDate: value);

  void updateEndDate(DateTime value) => state = state.copyWith(endDate: value);

  void updateMaxTeams(int value) => state = state.copyWith(maxTeams: value);

  void updateMaxMainPlayers(int value) =>
      state = state.copyWith(maxMainPlayers: value);

  void updateMaxSubPlayers(int value) =>
      state = state.copyWith(maxSubPlayers: value);

  void updatePrivacy(bool value) => state = state.copyWith(isPrivate: value);

  void updateStatus(String value) => state = state.copyWith(status: value);
}

final detailsLeagueProvider = StateNotifierProvider.family<
    DetailsLeaguesNotifier, DataState<LeagueModel>, String>(
  (ref, leagueSyncId) => DetailsLeaguesNotifier(leagueSyncId),
);

class DetailsLeaguesNotifier extends StateNotifier<DataState<LeagueModel>> {
  DetailsLeaguesNotifier(this.leagueSyncId)
      : super(DataState<LeagueModel>.initial(LeagueModel())) {
    getLeague();
  }

  final String leagueSyncId;
  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());

  Future<void> getLeague() async {
    state = state.copyWith(state: States.loading);

    final result = await _repo.getLeague(leagueSyncId: leagueSyncId);

    result.fold(
      (f) {
        state = state.copyWith(state: States.error, exception: f);
      },
      (data) {
        state = state.copyWith(state: States.loaded, data: data);
      },
    );
  }
}

final addLeagueProvider =
    StateNotifierProvider.autoDispose<AddLeagueNotifier, DataState<String>>(
  (ref) => AddLeagueNotifier(),
);

class AddLeagueNotifier extends StateNotifier<DataState<String>> {
  AddLeagueNotifier() : super(DataState<String>.initial(''));

  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());

  Future<void> addLeague(LeagueModel model,List<LeagueRuleModel> leagueRule) async {
    state = state.copyWith(state: States.loading);

    final result = await _repo.createLeague(model, leagueRule);

    result.fold(
      (f) {
        state = state.copyWith(state: States.error, exception: f);
      },
      (data) {
        state = state.copyWith(state: States.loaded, data: data);
      },
    );
  }
}

final rulesProvider =
    StateNotifierProvider<RulesNotifier, List<RuleUIModel>>((ref) {
  return RulesNotifier();
});

class RulesNotifier extends StateNotifier<List<RuleUIModel>> {
  RulesNotifier() : super(_defaultRules);

  /// نصوص القواعد الأساسية الافتراضية (لاستخدامها في التصنيف/العرض بدون رقم ثابت)
  static List<String> get defaultRulesText =>
      _defaultRules.map((e) => e.rule.trim()).toList(growable: false);

  static final _defaultRules = [
    RuleUIModel(
      rule: "الالتزام باللبس الرياضي المناسب.",
      isDefault: true,
      selected: true,
    ),
    RuleUIModel(
      rule: "ممنوع اللعب الخشن أو العنيف.",
      isDefault: true,
      selected: true,
    ),
    RuleUIModel(
      rule: "احترام جميع اللاعبين والمنظمين.",
      isDefault: true,
      selected: true,
    ),
    RuleUIModel(
      rule: "الالتزام بقواعد المباراة المتفق عليها قبل البداية.",
      isDefault: true,
      selected: true,
    ),
    RuleUIModel(
      rule: "اللعب بروح رياضية والمحافظة على سلامة الجميع.",
      isDefault: true,
      selected: true,
    ),
  ];

  void toggleSelection(int index) {
    final current = state[index];
    if (current.isDefault) return; // default rules must stay selected

    final updated = [...state];
    updated[index] = current.copyWith(
      selected: !current.selected,
    );
    state = updated;
  }

  void addCustomRule(String rule) {
    final updated = [...state];
    updated.add(
      RuleUIModel(
        rule: rule,
        selected: true,
        isDefault: false,
      ),
    );
    state = updated;
  }
}

final addRuleProvider = StateNotifierProvider<AddRuleNotifier, DataState<Unit>>(
  (ref) => AddRuleNotifier(di.sl()),
);

class AddRuleNotifier extends StateNotifier<DataState<Unit>> {
  final LeagueRepository repo;

  AddRuleNotifier(this.repo) : super(DataState.initial(unit));

  Future<void> addRuleList(
      String leagueSyncId, List<LeagueRuleModel> rules) async {
    state = state.copyWith(state: States.loading);

    final result = await repo.replaceRulesForLeague(leagueSyncId: leagueSyncId, rules: rules);

    result.fold(
      (failure) {
        state = state.copyWith(
          state: States.error,
        );
      },
      (_) {
        state = state.copyWith(state: States.loaded);
      },
    );
  }
}

final leaguesByPrivacyProvider = StateNotifierProvider.family<
    LeaguesByPrivacyNotifier,
    DataState<PaginationModel<LeagueModel>>,
    bool>((ref, isPrivate) {
  return LeaguesByPrivacyNotifier(isPrivate);
});

class LeaguesByPrivacyNotifier
    extends StateNotifier<DataState<PaginationModel<LeagueModel>>> {
  LeaguesByPrivacyNotifier(this.isPrivate)
      : super(DataState<PaginationModel<LeagueModel>>.initial(
          PaginationModel.empty(),
        )) {
    _listenToLocal();
    getDataBookingType();
  }

  final bool isPrivate;

  final _controller = LeagueRepository(
    remote: di.sl(),
    local: di.sl(),
    syncService: di.sl(),
    connectivity: di.sl(),
  );

  final int _pageSize = 15;
  bool _requestInFlight = false;

  int _currentPage = 1;
  StreamSubscription<PaginationModel<LeagueModel>>? _sub;

  int _listenToken = 0;

  void _listenToLocal() {
    final token = ++_listenToken;

    _sub = _controller
        .getLeagues(
      isPrivate: isPrivate,
      page: _currentPage,
      perPage: _pageSize,
    )
        .listen((pageModel) {
      if (token != _listenToken) return;

      if (pageModel.data.isEmpty && state.data.data.isNotEmpty) return;

      state = state.copyWith(
        state: state.stateData,
        data: pageModel,
      );
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> getDataBookingType({bool moreData = false}) async {
    if (_requestInFlight) return;

    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }

    _requestInFlight = true;

    final hasData = state.data.data.isNotEmpty;
    state = state.copyWith(
      state: moreData
          ? States.loadingMore
          : (hasData ? States.loaded : States.loading),
    );

    _currentPage = moreData ? _currentPage + 1 : 1;

    await _sub?.cancel();
    _listenToLocal();

    state = state.copyWith(state: States.loaded);

    _requestInFlight = false;
  }
}

final leagueStatusRepoProvider = Provider<LeagueRepository>((ref) {
  return LeagueRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
    syncService: di.sl(),
  );
});
final leagueStatusStreamProvider =
    StreamProvider.family<LeagueStatusModel?, String>((ref, param) {
  final repo = ref.read(leagueStatusRepoProvider);
  return repo.watchLeagueStatus(
    leagueSyncId: param,
  );
});
final leagueStatusProvider = StateNotifierProvider.family<
    LeagueStatusLoaderNotifier, RefreshState, String>((ref, param) {
  final repo = ref.read(leagueStatusRepoProvider);
  return LeagueStatusLoaderNotifier(repo, param);
});

class LeagueStatusLoaderNotifier extends StateNotifier<RefreshState> {
  final LeagueRepository _repo;
  final String leagueSyncId;

  LeagueStatusLoaderNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle()) {
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeagueStatus(
      leagueSyncId: leagueSyncId,
    );

    res.fold(
      (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
      (_) =>
          state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final leagueStatusUpdateProvider =
    StateNotifierProvider<LeagueStatusUpdaterNotifier, DataState<Unit>>((ref) {
  final repo = ref.read(leagueStatusRepoProvider);

  return LeagueStatusUpdaterNotifier(ref, repo);
});

class LeagueStatusUpdaterNotifier extends StateNotifier<DataState<Unit>> {
  final LeagueRepository _repo;

  LeagueStatusUpdaterNotifier(Ref ref, this._repo)
      : super(DataState.initial(unit));

  Future<void> update({
    required String leagueSyncId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasPlayersAssigned,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.updateLeagueStatus(
      leagueSyncId: leagueSyncId,
      hasGroups: hasGroups,
      hasTeamsInGroups: hasTeamsInGroups,
      hasMatches: hasMatches,
      hasPlayersAssigned: hasPlayersAssigned,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final leagueBundleRefreshProvider = StateNotifierProvider.family<
    LeagueBundleRefreshNotifier, RefreshState, String>((ref, leagueSyncId) {
  final repo = ref.read(leagueStatusRepoProvider);
  return LeagueBundleRefreshNotifier(repo, leagueSyncId);
});

class LeagueBundleRefreshNotifier extends StateNotifier<RefreshState> {
  final LeagueRepository _repo;
  final String leagueSyncId;

  LeagueBundleRefreshNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle());

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeagueBundle(leagueSyncId: leagueSyncId);

    res.fold(
      (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
      (_) =>
          state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final leagueStreamProvider =
    StreamProvider.family<LeagueModel?, String>((ref, leagueSyncId) {
  final repo = ref.read(leagueStatusRepoProvider);
  return repo.watchLeague(leagueSyncId: leagueSyncId);
});


final getAllLatestNewsLeagueProvider = StateNotifierProvider.family.autoDispose<
    GetAllLatestNewsLeagueNotifier,
    DataState<PaginationModel<NewsItemModel>>,
    String>(
  (ref, leagueSyncId) {
    return GetAllLatestNewsLeagueNotifier(leagueSyncId);
  },
);

class GetAllLatestNewsLeagueNotifier
    extends StateNotifier<DataState<PaginationModel<NewsItemModel>>> {
  GetAllLatestNewsLeagueNotifier(this.leagueSyncId)
      : super(DataState<PaginationModel<NewsItemModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  final String leagueSyncId;
  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());

  Future<void> getData({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _repo.getAllLatestLeagueNews(leagueSyncId, nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.success(newData, moreData);
      },
    );
  }
}

final addReportProvider =
    StateNotifierProvider.autoDispose<AddReportNotifier, DataState<String>>(
  (ref) => AddReportNotifier(),
);

class AddReportNotifier extends StateNotifier<DataState<String>> {
  AddReportNotifier() : super(DataState<String>.initial(''));
  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());

  Future<void> addReport(ReportModel model) async {
    state = state.copyWith(state: States.loading);

    final result = await _repo.addReport(model);

    result.fold(
      (f) {
        state = state.copyWith(state: States.error, exception: f);
      },
      (_) {
        state = state.copyWith(
          state: States.loaded,
        );
      },
    );
  }
}

final reporterDetailsProvider = StateNotifierProvider.family<
    ReporterDetailsController, DataState<NewsItemModel>, int>(
  (ref, int id) {
    return ReporterDetailsController(id);
  },
);

class ReporterDetailsController
    extends StateNotifier<DataState<NewsItemModel>> {
  final int id;

  ReporterDetailsController(this.id)
      : super(DataState<NewsItemModel>.initial(NewsItemModel.empty())) {
    getData();
  }

  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _repo.reportDetails(id: id);
    data.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (orderDetailsData) {
        state = state.copyWith(
          state: States.loaded,
          data: orderDetailsData,
        );
      },
    );
  }
}

final orderLeagueInvitationsPlayerProvider = StateNotifierProvider.family<
    OrderLeagueInvitationsPlayerNotifier,
    DataState<Unit>,
    String>((ref, syncLeagueId) {
  return OrderLeagueInvitationsPlayerNotifier(syncLeagueId);
});

class OrderLeagueInvitationsPlayerNotifier
    extends StateNotifier<DataState<Unit>> {
  OrderLeagueInvitationsPlayerNotifier(this.syncLeagueId)
      : super(DataState.initial(unit)) ;

  final String syncLeagueId;
  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());


  Future<void> add() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.orderLeagueInvitationsPlayer(syncLeagueId);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (_) => state = state.copyWith(state: States.loaded),
    );
  }
}

final getLeagueBannersProvider = StateNotifierProvider.family<
    GetLeagueBannersNotifier,
    DataState<List<BannerModel>>,
    String>((ref, syncLeagueId) {
  return GetLeagueBannersNotifier(syncLeagueId);
});

class GetLeagueBannersNotifier
    extends StateNotifier<DataState<List<BannerModel>>> {
  GetLeagueBannersNotifier(this.syncLeagueId)
      : super(DataState.initial([])){
    load();
  }

  final String syncLeagueId;
  final _repo = LeagueRepository(
      local: di.sl(),
      syncService: di.sl(),
      connectivity: di.sl(),
      remote: di.sl());


  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeagueBanners(syncLeagueId);
    r.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (data) => state = state.copyWith(state: States.loaded,data: data),
    );
  }
}



/// يراقب قواعد دوري محدد (من اللوكال) ويحدث الواجهة تلقائيًا.
final leagueRulesStreamProvider = StreamProvider.family
    <List<LeagueRuleModel>, String>((ref, leagueSyncId) {
  final repo = ref.read(leagueStatusRepoProvider);
  return repo.watchLeagueRules(leagueSyncId: leagueSyncId);
});

/// حالة refresh لقواعد الدوري (تحميل/نجاح/خطأ)
final leagueRulesRefreshProvider = StateNotifierProvider.family
    <LeagueRulesRefreshNotifier, RefreshState, String>((ref, leagueSyncId) {
  final repo = ref.read(leagueStatusRepoProvider);
  return LeagueRulesRefreshNotifier(repo, leagueSyncId);
});

class LeagueRulesRefreshNotifier extends StateNotifier<RefreshState> {
  LeagueRulesRefreshNotifier(this._repo, this.leagueSyncId)
      : super(RefreshState.idle());

  final LeagueRepository _repo;
  final String leagueSyncId;

  Future<void> refresh({bool deleteMissing = true}) async {
    if (state.status == RefreshStatus.loading) return;

    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await _repo.refreshLeagueRules(
      leagueSyncId: leagueSyncId,
      deleteMissing: deleteMissing,
    );

    res.fold(
      (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
      (_) => state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}
