import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/league_model.dart';
import '../../data/model/league_status_model.dart';
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
    DetailsLeaguesNotifier,
    DataState<LeagueModel>,
    int>(
  (ref,idLeague) => DetailsLeaguesNotifier(idLeague),
);

class DetailsLeaguesNotifier extends StateNotifier<DataState<LeagueModel>> {
  DetailsLeaguesNotifier(this.idLeague) : super(DataState<LeagueModel>.initial(LeagueModel())) {
    getLeague();
  }

  final int idLeague;
  final _repo = LeagueRepository(local: di.sl());

  Future<void> getLeague() async {
    state = state.copyWith(state: States.loading);

    final result = await _repo.getLeague(idLeague: idLeague);

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
    StateNotifierProvider.autoDispose<AddLeagueNotifier, DataState<int>>(
  (ref) => AddLeagueNotifier(),
);

class AddLeagueNotifier extends StateNotifier<DataState<int>> {
  AddLeagueNotifier() : super(DataState<int>.initial(0));

  final _repo = LeagueRepository(local: di.sl());

  Future<void> addLeague(LeagueModel model) async {
    state = state.copyWith(state: States.loading);

    final result = await _repo.createLeague(model);

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

  static final _defaultRules = [
    RuleUIModel(
      rule:
          "يتكون كل فريق من 11 لاعبًا بما في ذلك حارس المرمى. يجب أن يكون لدى الفريق عدد كافٍ من اللاعبين للعب المباراة (عادة ما بين 7 و 11 لاعبًا).",
      isDefault: true,
    ),
    RuleUIModel(
      rule:
          "تتكون المباراة من شوطين مدة كل شوط 45 دقيقة. في حال التعادل يتم إضافة وقت إضافي (2 × 15 دقيقة) ثم ركلات ترجيح إذا استمر التعادل.",
      isDefault: true,
    ),
    RuleUIModel(
      rule:
          "يجب أن يكون اللعب مستطيلاً بطول يتراوح بين 90 مترًا و120 مترًا، وعرض بين 45 مترًا و90 مترًا. وسط الملعب خط الوسط وهناك منطقة جزاء أمام كل مرمى.",
      isDefault: true,
    ),
    RuleUIModel(
      rule:
          "يجب أن تكون الكرة كروية الشكل ومحيطها يتراوح بين 68 و70 سم ووزنها بين 410 و450 جم.",
      isDefault: true,
    ),
  ];

  void toggleSelection(int index) {
    final updated = [...state];
    updated[index] = updated[index].copyWith(
      selected: !updated[index].selected,
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

  Future<void> addRuleList(int leagueId, List<LeagueRuleModel> rules) async {
    state = state.copyWith(state: States.loading);

    final result = await repo.replaceRulesForLeague(leagueId, rules);

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
    DataState<List<LeagueModel>>,
    bool>((ref, isPrivate) {
  return LeaguesByPrivacyNotifier(isPrivate);
});

class LeaguesByPrivacyNotifier
    extends StateNotifier<DataState<List<LeagueModel>>> {
  LeaguesByPrivacyNotifier(this.isPrivate)
      : super(DataState.initial(const [])) {
    load();
  }

  final bool isPrivate; // false = عامة، true = خاصة
  final _repo = LeagueRepository(local: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getLeaguesByPrivacy(isPrivate: isPrivate);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (list) => state = state.copyWith(state: States.loaded, data: list),
    );
  }
}
final leagueStatusProvider = StateNotifierProvider.family<
    LeagueStatusLoaderNotifier,
    DataState<LeagueStatusModel?>,
    int>((ref, leagueId) {
  return LeagueStatusLoaderNotifier(leagueId, ref);
});

class LeagueStatusLoaderNotifier
    extends StateNotifier<DataState<LeagueStatusModel?>> {
  final int leagueId;
  final LeagueRepository _repo;

  LeagueStatusLoaderNotifier(this.leagueId, Ref ref)
      : _repo = LeagueRepository(local: di.sl()),
        super(DataState.initial(null)) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.getStatus(leagueId);
    res.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (model) => state = state.copyWith(state: States.loaded, data: model),
    );
  }
}
final leagueStatusUpdateProvider =
StateNotifierProvider<LeagueStatusUpdaterNotifier, DataState<Unit>>((ref) {
  return LeagueStatusUpdaterNotifier(ref);
});

class LeagueStatusUpdaterNotifier extends StateNotifier<DataState<Unit>> {
  final LeagueRepository _repo;

  LeagueStatusUpdaterNotifier(Ref ref)
      : _repo = LeagueRepository(local: di.sl()),
        super(DataState.initial(unit));

  Future<void> update({
    required int leagueId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasPlayersAssigned,
  }) async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.updateLeagueStatus(
      leagueId: leagueId,
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
