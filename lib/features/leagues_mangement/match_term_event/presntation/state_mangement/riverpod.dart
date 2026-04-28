import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/database/safirah_database.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di show sl;
import '../../../group/presntaion/state_managment/riverpod.dart';
import '../../../match/data/model/match_model.dart';
import '../../../match/data/model/round_model.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
import '../../data/data_source/local_data_source/local_knockout_data_source.dart';
import '../../data/model/assist_model.dart';
import '../../data/model/counter_data.dart';
import '../../data/model/goal_model.dart';
import '../../data/model/match_term_model.dart';
import '../../data/model/player_stats.dart';
import '../../data/model/terms_model.dart';
import '../../data/model/warring_model.dart';
import '../../data/reposaitory/knockout_reposaitory.dart';
import '../../data/reposaitory/reposaitory.dart';
import '../page/var_page.dart';
import '../widget/player_tile_with_event_widget.dart';

final termsProvider =
    StateNotifierProvider<TermsNotifier, DataState<List<TermModel>>>((ref) {
  return TermsNotifier();
});

class TermsNotifier extends StateNotifier<DataState<List<TermModel>>> {
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  TermsNotifier() : super(DataState.initial(const [])) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getAllTerms();
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (terms) => state = state.copyWith(state: States.loaded, data: terms),
    );
  }
}

final leagueTermProvider = StateNotifierProvider.family<LeagueTermNotifier,
    DataState<List<LeagueTermModel>>, String>((ref, leagueSyncId) {
  return LeagueTermNotifier(leagueSyncId);
});

class LeagueTermNotifier
    extends StateNotifier<DataState<List<LeagueTermModel>>> {
  LeagueTermNotifier(this.leagueSyncId)
      : _repo = MatchTermsEventRepository(
            local: di.sl(), syncService: di.sl(), connectivity: di.sl()),
        super(DataState.initial(const []));

  final String leagueSyncId;
  final MatchTermsEventRepository _repo;

  Future<void> initTermsUiLogic(
    List<TermModel> allTerms,
    int? selectedTermsCount,
    bool includeExtraAndPenalties,
    int matchDuration,
  ) async {
    if (selectedTermsCount == null) {
      state = state.copyWith(
        state: States.error,
      );
      return;
    }

    List<String> selectedTermIds = [];

    if (selectedTermsCount == 1) {
      final first =
          allTerms.firstWhere((t) => t.type == 'regular' && t.order == 1);
      selectedTermIds.add(first.syncId);
    } else if (selectedTermsCount == 2) {

      selectedTermIds.addAll(
        allTerms.where((t) => t.type == 'regular').take(2).map((t) => t.syncId),
      );

    }

    if (includeExtraAndPenalties) {
      selectedTermIds.addAll(
        allTerms
            .where((t) => t.type == 'extra' || t.type == 'penalty')
            .map((t) => t.syncId),
      );
    } else {
      final penalty = allTerms.firstWhere((t) => t.type == 'penalty');
      selectedTermIds.add(penalty.syncId);
    }
    for(var id in allTerms){
      print(id.name);
    }
    print(allTerms);
    await initTerms(
      selectedTermIds: selectedTermIds,
      durationMinutes: matchDuration,
    );
  }

  Future<void> initTerms({
    required List<String> selectedTermIds,
    required int durationMinutes,
  }) async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.initLeagueTerms(
      leagueSyncId: leagueSyncId,
      selectedTermIds: selectedTermIds,
      durationMinutes: durationMinutes,
    );

    result.fold(
      (f) => state = state.copyWith(state: States.error, exception: f),
      (_) => state = state.copyWith(
        state: States.loaded,
      ),
    );
  }
}

final termDurationProvider =
    StateNotifierProvider.family<TermDurationNotifier, DataState<int?>, String>(
  (ref, matchTermSyncId) => TermDurationNotifier(matchTermSyncId),
);

class TermDurationNotifier extends StateNotifier<DataState<int?>> {
  final String matchTermSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  TermDurationNotifier(this.matchTermSyncId) : super(DataState.initial(null)) {
    loadTermDuration();
  }

  Future<void> loadTermDuration() async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.getTermDuration(matchTermSyncId);

    result.fold(
      (e) {
        print(e.error.toString());

        return state = state.copyWith(state: States.error, exception: e);
      },
      (duration) {

        return state = state.copyWith(state: States.loaded, data: duration);
      },
    );
  }
}

final updateAdditionalMinutesNotifierProvider = StateNotifierProvider.family<
    UpdateAdditionalMinutesNotifier,
    DataState<bool>,
    (
      String,
      int
    )>((ref, params) => UpdateAdditionalMinutesNotifier(params.$1, params.$2));

class UpdateAdditionalMinutesNotifier extends StateNotifier<DataState<bool>> {
  final String termSyncId;
  final int minutes;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  UpdateAdditionalMinutesNotifier(this.termSyncId, this.minutes)
      : super(DataState.initial(false)) {
    update();
  }

  Future<void> update() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.updateAdditionalMinutes(termSyncId, minutes);
    res.fold(
      (l) => state = state.copyWith(state: States.error, exception: l),
      (r) => state = state.copyWith(state: States.loaded, data: true),
    );
  }
}

// Change StartTermNotifier/FinishTermNotifier to be sync-based
final startTermNotifierProvider = StateNotifierProvider.family<
        StartTermNotifier, DataState<bool>, Map<String, String>>(
    (ref, params) => StartTermNotifier(
          ref,
          params['matchSyncId']!,
          params['idMatchTerm']!,
        ));

class StartTermNotifier extends StateNotifier<DataState<bool>> {
  final Ref ref;
  final String matchSyncId;
  final String idSyncMatchTerm;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  StartTermNotifier(this.ref, this.matchSyncId, this.idSyncMatchTerm)
      : super(DataState.initial(false)) {
    startTerm();
  }

  /// ✅ بدء الشوط مع التحقق من وقت المباراة
  Future<void> startTerm() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.startTermSafe(matchSyncId, idSyncMatchTerm);

    res.fold(
      (error) => state = state.copyWith(state: States.error, exception: error),
      (_) => state = state.copyWith(state: States.loaded, data: true),
    );
  }
}

final finishTermNotifierProvider = StateNotifierProvider.family<
    FinishTermNotifier, DataState<bool>,(String,String)>((ref, ids) {
  return FinishTermNotifier(
    matchSyncId:ids.$1,
    matchTermSyncId:ids.$2,
  );
});

class FinishTermNotifier extends StateNotifier<DataState<bool>> {
  final String matchSyncId;
  final String matchTermSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  bool _isRunning = false; // لمنع الاستدعاء المتكرر

  FinishTermNotifier({required this.matchSyncId, required this.matchTermSyncId})
      : super(DataState.initial(false));

  Future<void> finish() async {
    if (_isRunning) return; // إذا كانت العملية جارية بالفعل، تجاهل الاستدعاء
    _isRunning = true;

    try {
      state = state.copyWith(state: States.loading);

      final res = await _repo.finishCurrentTerm(
          matchSyncId: matchSyncId, matchTermSyncId: matchTermSyncId);

      res.fold(
        (l) => state = state.copyWith(state: States.error, exception: l),
        (r) => state = state.copyWith(state: States.loaded, data: true),
      );
    } finally {
      _isRunning = false;
    }
  }
}

final matchTimerProvider = StateProvider<int>((ref) => 0);

class MatchTermCounterNotifier extends StateNotifier<DataState<CounterData>> {
  final Ref ref;
  final int durationMinutesDummy;
  Timer? _timer;

  DateTime? _pauseStartTime;
  bool _isPaused = false;
  bool _waitingExtraTime = false;
  bool _isFinishing = false;

  MatchTermCounterNotifier(this.ref, this.durationMinutesDummy)
      : super(DataState.initial(CounterData()));

  Future<void> start(
      {required Future<int?> Function(String title, int wastedMinutes)
          onAskExtraTime,
      required MatchTermModel currentTerm,
      required String roundSyncId,
      required String leagueSyncId}) async {
    if (_timer != null) return;

    final termId = currentTerm.syncId;
    final matchSyncId = currentTerm.matchSyncId;
    final matchTermSyncId = currentTerm.syncId;

    final startTermProviderRef = startTermNotifierProvider({
      'matchSyncId': matchSyncId,
      'idMatchTerm': termId,
    });

    await ref.read(startTermProviderRef.notifier).startTerm();

    final termSyncId = matchTermSyncId;
    if(currentTerm.termName=='الشوط الاول'&&currentTerm.termType=='regular'){

      if (termSyncId.isNotEmpty) {
        await ref
            .read(initStartersNotifierProvider(
            (matchSyncId: matchSyncId, matchTermSyncId: termSyncId))
            .notifier)
            .run();
      }
    } else {
      await ref
          .read(initStartersTermNotifierProvider(
          (matchSyncId: matchSyncId, matchTermSyncId: termSyncId))
          .notifier)
          .run();
    }

    final startState = ref.read(startTermProviderRef);
    if (startState.stateData == States.error) {
      print('startTermProviderRef');
      return;
    }

    int baseDuration;
    final durationState = ref.read(termDurationProvider(termId));
    if (durationState.stateData == States.loaded) {
      print(durationState.data);
      baseDuration = durationState.data!;
    } else {
      try {
        await ref
            .read(termDurationProvider(termId).notifier)
            .loadTermDuration();
        baseDuration = ref.read(termDurationProvider(termId)).data!;
        print(baseDuration);
      } catch (e) {
        print(e);
        return;
      }
    }

    int additional = currentTerm.additionalMinutes;
    int totalMinutes = baseDuration + additional;
    if (totalMinutes <= 0) totalMinutes = 1;

    state = state.copyWith(
      state: States.loaded,
      data: state.data.copyWith(isRunning: true, alertShown: false),
    );
    _isPaused = false;
    _pauseStartTime = null;
    _waitingExtraTime = false;
    ref.read(matchTermStateProvider(matchTermSyncId).notifier).state = true;
    await ref.read(getCurrentMatchTermProvider(matchSyncId).notifier).run();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (_waitingExtraTime || _isFinishing) return;

      final newElapsed = state.data.elapsedSeconds + 1;
      ref.read(matchTimerProvider.notifier).state = newElapsed;
      state = state.copyWith(
        state: States.loaded,
        data: state.data.copyWith(elapsedSeconds: newElapsed),
      );
     // referee
      // if (_isPaused) return;
      if (!state.data.alertShown && newElapsed >= (baseDuration - 1) * 60) {
      //  if (!state.data.alertShown && newElapsed >= (baseDuration - 1)) {
        state = state.copyWith(
          state: States.loaded,
          data: state.data.copyWith(alertShown: true),
        );
      }

      if (newElapsed >= baseDuration * 60 &&
          additional == 0 &&
          !_waitingExtraTime) {
        _waitingExtraTime = true;

        final wastedMinutes = (state.data.totalWastedSeconds ~/ 60);

        final extra = await onAskExtraTime(
          '⏱️ الوقت الضائع حتى الآن: $wastedMinutes دقيقة.\nكم دقيقة إضافية تريد إضافتها؟',
          wastedMinutes,
        );

        if (extra != null && extra > 0) {
          await ref
              .read(updateAdditionalMinutesNotifierProvider(
                (termId, extra),
              ).notifier)
              .update();

          additional = extra;
          _waitingExtraTime = false;
        } else {
          await _finishCurrentTerm(roundSyncId, leagueSyncId, currentTerm);
        }
      }

      // 🎯 تحقق من نهاية الوقت الكلي (الرسمي + الإضافي)
  //   if (newElapsed >= (baseDuration + additional)) {
      if (newElapsed >= (baseDuration + additional) * 60) {
        await _finishCurrentTerm(roundSyncId, leagueSyncId, currentTerm);
      }
    });
  }

  void stop(String matchTermSyncId) {
    if (_isPaused) return;
    ref.read(stopTermStateProvider(matchTermSyncId).notifier).state = true;

    _isPaused = true;
    _pauseStartTime = DateTime.now();

    state = state.copyWith(
      state: States.loaded,
      data: state.data.copyWith(isPaused: true),
    );
  }

  void resume(String matchTermSyncId) {
    if (!_isPaused || _pauseStartTime == null) return;
    final pausedSeconds = DateTime.now().difference(_pauseStartTime!).inSeconds;
    state = state.copyWith(
      state: States.loaded,
      data: state.data.copyWith(
        totalWastedSeconds: state.data.totalWastedSeconds + pausedSeconds,
        isPaused: false,
      ),
    );
    ref.read(stopTermStateProvider(matchTermSyncId).notifier).state = false;

    _pauseStartTime = null;
    _isPaused = false;
  }

  Future<void> _finishCurrentTerm(
    String finishedRoundId,
    String leagueSyncId,
    MatchTermModel currentTerm,
  ) async {
    if (_isFinishing) return;
    _isFinishing = true;

    final termId = currentTerm.syncId;
    final matchSyncId = currentTerm.matchSyncId;
    final matchTermSyncId = currentTerm.syncId;

    try {
      _timer?.cancel();
      _timer = null;

      final notifier = ref.read(finishTermNotifierProvider(
          (matchSyncId,matchTermSyncId)

      ).notifier);

      await notifier.finish();
      final finishState = ref.read(finishTermNotifierProvider(
          (matchSyncId,matchTermSyncId)));

      if (finishState.stateData == States.error) {
        return;
      }

      ref.read(matchTermStateProvider(matchTermSyncId).notifier).state = false;
      await ref.read(getCurrentMatchTermProvider(matchSyncId).notifier).run();
      await ref.read(getCurrentMatchTermProvider(matchSyncId).notifier).run();
      // try {
      //   await ref
      //       .read(getCurrentLeagueRoundProvider(leagueSyncId).notifier)
      //       .run();
      //   final roundType = ref.read(getCurrentLeagueRoundProvider(leagueSyncId));
      //   if (roundType.data.roundType == 'group') {
      //     await ref
      //         .read(checkGroupMatchesFinishedProvider(leagueSyncId).notifier)
      //         .run();
      //     final isFinishedAllGroupMatch =
      //         ref.read(checkGroupMatchesFinishedProvider(leagueSyncId));
      //     if (isFinishedAllGroupMatch.data) {
      //       await ref
      //           .read(generateFirstKnockoutProvider((leagueSyncId, 4)).notifier)
      //           .run();
      //
      //       final knockoutState =
      //           ref.read(generateFirstKnockoutProvider((leagueSyncId, 4)));
      //       ref
      //           .read(roundsRefreshKnockoutProvider(
      //                   Tuple3(leagueSyncId, 'unscheduled', ''))
      //               .notifier)
      //           .refresh();
      //       if (knockoutState.stateData == States.error) {
      //         print(
      //             "⚠️ خطأ أثناء تفعيل الأدوار الإقصائية: ${knockoutState.exception}");
      //       } else if (knockoutState.stateData == States.loaded) {
      //         print(
      //             "🎯 تم إنشاء الجولة الإقصائية الأولى: ${knockoutState.data.roundName}");
      //       }
      //     }

      //     await ref
      //         .read(getCurrentMatchTermProvider(matchSyncId).notifier)
      //         .run();
      //     ref.read(groupRefreshProvider(leagueSyncId).notifier).refresh();
      //     ref
      //         .read(roundsRefreshProvider(Tuple3(
      //                 leagueSyncId, 'scheduled,live,finished', 'organizer'))
      //             .notifier)
      //         .refresh();
      //     ref
      //         .read(roundsRefreshProvider(
      //                 Tuple3(leagueSyncId, 'scheduled,live', 'organizer'))
      //             .notifier)
      //         .refresh();
      //   } else {
      //     await ref
      //         .read(getCurrentMatchTermProvider(matchSyncId).notifier)
      //         .run();
      //
      //     await ref
      //         .read(checkGroupMatchesFinishedProvider(leagueSyncId).notifier)
      //         .run();
      //
      //     await ref
      //         .read(
      //             generateNextKnockoutProvider((leagueSyncId, finishedRoundId))
      //                 .notifier)
      //         .run();
      //     ref
      //         .read(roundsRefreshKnockoutProvider(
      //                 Tuple3(leagueSyncId, 'scheduled,live,finished', 'organizer'))
      //             .notifier)
      //         .refresh();
      //     ref
      //         .read(roundsRefreshKnockoutProvider(
      //                 Tuple3(leagueSyncId, 'unscheduled', 'organizer'))
      //             .notifier)
      //         .refresh();
      //     ref
      //         .read(roundsRefreshKnockoutProvider(
      //                 Tuple3(leagueSyncId, 'scheduled,live', 'organizer'))
      //             .notifier)
      //         .refresh();
      //   }
      // } catch (e, st) {
      //   print("❌ خطأ أثناء إدارة الأدوار الإقصائية: $e\n$st");
      // }

      ref.read(activeVarPlayerProvider.notifier).state = null;
      ref.read(currentVarEventProvider.notifier).state = null;

      _isPaused = false;
      _waitingExtraTime = false;
      _pauseStartTime = null;
      _isFinishing = false;

      if (!mounted) return;
      state = state.copyWith(
        state: States.loaded,
        data: CounterData(),
      );
    } catch (e, st) {
      print("⚠️ خطأ غير متوقع عند إنهاء الشوط: $e\n$st");
    } finally {
      _isFinishing = false;
    }
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _pauseStartTime = null;
    _isPaused = false;
    _waitingExtraTime = false;

    _isFinishing = false;
    state = state.copyWith(state: States.loaded, data: CounterData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Initializes participation rows for starters when the first term starts.
final initStartersNotifierProvider = StateNotifierProvider.family<
    InitStartersNotifier,
    DataState<Unit>,
    ({String matchSyncId, String matchTermSyncId})>((ref, args) {
  return InitStartersNotifier(args.matchSyncId, args.matchTermSyncId);
});

class InitStartersNotifier extends StateNotifier<DataState<Unit>> {
  InitStartersNotifier(this.matchSyncId, this.matchTermSyncId)
      : super(DataState.initial(unit));

  final String matchSyncId;
  final String matchTermSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.initStartersForMatch(
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

/// Initializes participation rows for starters when the first term starts.
final initStartersTermNotifierProvider = StateNotifierProvider.family<
    InitStartersTermNotifier,
    DataState<Unit>,
    ({String matchSyncId, String matchTermSyncId})>((ref, args) {
  return InitStartersTermNotifier(args.matchSyncId, args.matchTermSyncId);
});

class InitStartersTermNotifier extends StateNotifier<DataState<Unit>> {
  InitStartersTermNotifier(this.matchSyncId, this.matchTermSyncId)
      : super(DataState.initial(unit));

  final String matchSyncId;
  final String matchTermSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.initStartersForMatchTerm(
      matchSyncId: matchSyncId,
      matchTermSyncId: matchTermSyncId,
    );

    res.fold(
          (e) => state = state.copyWith(state: States.error, exception: e),
          (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final matchTermCounterProvider = StateNotifierProvider.family<
    MatchTermCounterNotifier, DataState<CounterData>, String>(
  (ref, matchSyncId) => MatchTermCounterNotifier(ref, 0),
);
final addGoalNotifierProvider = StateNotifierProvider.family<AddGoalNotifier,
    DataState<GoalModel>, GoalModel>(
  (ref, goal) => AddGoalNotifier(goal),
);

class AddGoalNotifier extends StateNotifier<DataState<GoalModel>> {
  AddGoalNotifier(this.goal)
      : super(
          DataState.initial(
            GoalModel(
              syncId: '',
              matchSyncId: '',
              playerSyncId: '',
              matchTermSyncId: '',
              goalTime: 0,
              goalType: '',
            ),
          ),
        );

  final GoalModel goal;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.addGoal(goal);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (goal) => state = state.copyWith(state: States.loaded, data: goal),
    );
  }
}

final addWarningNotifierProvider = StateNotifierProvider.family<
    AddWarningNotifier, DataState<WarningModel>, WarningModel>(
  (ref, warning) => AddWarningNotifier(warning),
);

class AddWarningNotifier extends StateNotifier<DataState<WarningModel>> {
  AddWarningNotifier(this.warning)
      : super(
          DataState.initial(
            WarningModel(
              syncId: '',
              matchSyncId: '',
              playerSyncId: '',
              matchTermSyncId: '',
              warningTime: 0,
              warningType: '',
            ),
          ),
        );

  final WarningModel warning;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.addWarning(warning);
    result.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

// ---------------------------------------------------------------------------
// Delete goal (sync-based)
// ---------------------------------------------------------------------------

final deleteGoalNotifierProvider = StateNotifierProvider.family<
    DeleteGoalNotifier, DataState<String?>, String>((ref, goalSyncId) {
  return DeleteGoalNotifier(goalSyncId);
});

class DeleteGoalNotifier extends StateNotifier<DataState<String?>> {
  DeleteGoalNotifier(this.goalSyncId) : super(DataState.initial(null));

  final String goalSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.deleteGoalBySyncId(goalSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}


final deleteWarningNotifierProvider = StateNotifierProvider.family<
    DeleteWarningNotifier, DataState<Unit>, String>((ref, warningSyncId) {
  return DeleteWarningNotifier(warningSyncId);
});

class DeleteWarningNotifier extends StateNotifier<DataState<Unit>> {
  DeleteWarningNotifier(this.warningSyncId) : super(DataState.initial(unit));

  final String warningSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.deleteWarningBySyncId(warningSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

/// Legacy: delete warning by numeric id.

// Update match-based providers to use matchSyncId
final getFullMatchDataProvider = StateNotifierProvider.family<
    GetFullMatchDataNotifier,
    DataState<MatchModel>,
    String>((ref, matchSyncId) {
  return GetFullMatchDataNotifier(matchSyncId);
});

class GetFullMatchDataNotifier extends StateNotifier<DataState<MatchModel>> {
  GetFullMatchDataNotifier(this.matchSyncId)
      : super(DataState.initial(const MatchModel())) {
    run();
  }

  final String matchSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getFullMatchData(matchSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final getCurrentMatchTermProvider = StateNotifierProvider.family<
    GetCurrentMatchTermNotifier,
    DataState<MatchTermModel?>,
    String>((ref, matchSyncId) {
  return GetCurrentMatchTermNotifier(matchSyncId);
});

class GetCurrentMatchTermNotifier
    extends StateNotifier<DataState<MatchTermModel?>> {
  GetCurrentMatchTermNotifier(this.matchSyncId)
      : super(
          DataState.initial(
            MatchTermModel(
                id: 0, matchSyncId: '', leagueTermSyncId: '', syncId: ''),
          ),
        ) {
    run();
  }

  final String matchSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCurrentMatchTerm(matchSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

///شك
final getCurrentLeagueRoundProvider = StateNotifierProvider.family<
    GetCurrentLeagueRoundNotifier,
    DataState<RoundModel>,
    String>((ref, leagueSyncId) {
  return GetCurrentLeagueRoundNotifier(leagueSyncId);
});

class GetCurrentLeagueRoundNotifier
    extends StateNotifier<DataState<RoundModel>> {
  GetCurrentLeagueRoundNotifier(this.leagueSyncId)
      : super(DataState.initial(RoundModel(
            leagueSyncId: leagueSyncId, roundName: '', roundType: ''))) {
    run();
  }

  final String leagueSyncId;
  final _repo = KnockoutRepository(
      local: di.sl(),
      connectivity: di.sl(),
      remote: di.sl(),
      syncService: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCurrentLeagueRound(leagueSyncId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final generateFirstKnockoutProvider = StateNotifierProvider.family<
    GenerateFirstKnockoutNotifier,
    DataState<RoundModel>,
    (String leagueSyncId, int qualifiedPerGroup)>(
  (ref, args) => GenerateFirstKnockoutNotifier(args.$1, args.$2),
);

class GenerateFirstKnockoutNotifier
    extends StateNotifier<DataState<RoundModel>> {
  final String leagueSyncId;
  final int qualifiedPerGroup;
  final _repo = KnockoutRepository(
      local: di.sl(),
      connectivity: di.sl(),
      remote: di.sl(),
      syncService: di.sl());

  GenerateFirstKnockoutNotifier(this.leagueSyncId, this.qualifiedPerGroup)
      : super(DataState.initial(
          RoundModel(id: -1, leagueSyncId: '', roundName: '', roundType: ''),
        ));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.generateFirstKnockout(
      leagueSyncId: leagueSyncId,
      qualifiedPerGroup: qualifiedPerGroup,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (round) => state = state.copyWith(state: States.loaded, data: round),
    );
  }
}

final generateNextKnockoutProvider = StateNotifierProvider.family<
    GenerateNextKnockoutNotifier,
    DataState<RoundModel?>,
    (String leagueSyncId, String finishedRoundId)>(
  (ref, args) => GenerateNextKnockoutNotifier(args.$1, args.$2),
);

class GenerateNextKnockoutNotifier
    extends StateNotifier<DataState<RoundModel?>> {
  final String leagueSyncId;
  final String finishedRoundSyncId;
  final _repo = KnockoutRepository(
      local: di.sl(),
      connectivity: di.sl(),
      remote: di.sl(),
      syncService: di.sl());

  GenerateNextKnockoutNotifier(this.leagueSyncId, this.finishedRoundSyncId)
      : super(DataState.initial(null));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.generateNextKnockout(
      leagueSyncId: leagueSyncId,
      finishedRoundSyncId: finishedRoundSyncId,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (round) => state = state.copyWith(state: States.loaded, data: round),
    );
  }
}
//
// final checkNextKnockoutRoundProvider = StateNotifierProvider.family<
//     CheckNextKnockoutRoundNotifier,
//     DataState<Unit>,
//     (String leagueSyncId, String finishedRoundSyncId)>((ref, args) {
//   return CheckNextKnockoutRoundNotifier(args.$1, args.$2);
// });
//
// class CheckNextKnockoutRoundNotifier extends StateNotifier<DataState<Unit>> {
//   final String leagueSyncId;
//   final String finishedRoundSyncId;
//   final _repo = KnockoutRepository(
//       local: di.sl(),
//       connectivity: di.sl(),
//       remote: di.sl(),
//       syncService: di.sl());
//
//   CheckNextKnockoutRoundNotifier(this.leagueSyncId, this.finishedRoundSyncId)
//       : super(DataState<Unit>.initial(unit));
//
//   Future<void> run() async {
//     state = state.copyWith(state: States.loading);
//
//     final res = await _repo.checkAndCreateNextKnockoutRoundIfNeeded(
//       leagueSyncId: leagueSyncId,
//       finishedRoundSyncId: finishedRoundSyncId,
//     );
//
//     res.fold(
//       (e) => state = state.copyWith(state: States.error, exception: e),
//       (_) => state = state.copyWith(state: States.loaded, data: unit),
//     );
//   }
// }

// final knockoutRoundsWithMatchesProvider = StateNotifierProvider.family<
//     KnockoutRoundsWithMatchesNotifier,
//     DataState<List<RoundModel>>,
//     Tuple2<String, String>>((ref, param) {
//   return KnockoutRoundsWithMatchesNotifier(param.value1, param.value2);
// });
//
// class KnockoutRoundsWithMatchesNotifier
//     extends StateNotifier<DataState<List<RoundModel>>> {
//   final String leagueSyncId;
//   final String matchFilter;
//
//   final _repo = KnockoutRepository(local: di.sl(),connectivity: di.sl(),remote: di.sl(),syncService: di.sl());
//
//   KnockoutRoundsWithMatchesNotifier(this.leagueSyncId, this.matchFilter)
//       : super(DataState.initial([])) {
//     load();
//   }
//
//   Future<void> load() async {
//     state = state.copyWith(state: States.loading);
//     final res =
//         await _repo.getAllKnockoutRoundsWithMatches(leagueSyncId, matchFilter);
//     res.fold(
//       (e) => state = state.copyWith(state: States.error, exception: e),
//       (data) {
//         print(data);
//         return state = state.copyWith(state: States.loaded, data: data);
//       },
//     );
//   }
// }

final checkGroupMatchesFinishedProvider = StateNotifierProvider.family<
    CheckGroupMatchesFinishedNotifier, DataState<bool>, String>(
  (ref, leagueSyncId) => CheckGroupMatchesFinishedNotifier(leagueSyncId),
);

class CheckGroupMatchesFinishedNotifier extends StateNotifier<DataState<bool>> {
  final String leagueSyncId;
  final _repo = KnockoutRepository(
      local: di.sl(),
      connectivity: di.sl(),
      remote: di.sl(),
      syncService: di.sl());

  CheckGroupMatchesFinishedNotifier(this.leagueSyncId)
      : super(DataState.initial(false)) {
    run();
  }

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res =
        await _repo.checkAllGroupMatchesFinished(leagueSyncId: leagueSyncId);

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (finished) {
        return state = state.copyWith(state: States.loaded, data: finished);
      },
    );
  }
}

/// --- Player stats (sync-id based) ---
final playerStatsProvider = StateNotifierProvider.family<
    PlayerStatsNotifier,
    DataState<PlayerStats>,
    ({String matchSyncId, String playerSyncId})>((ref, args) {
  return PlayerStatsNotifier(args.matchSyncId, args.playerSyncId);
});

class PlayerStatsNotifier extends StateNotifier<DataState<PlayerStats>> {
  PlayerStatsNotifier(this.matchSyncId, this.playerSyncId)
      : super(
          DataState.initial(
            PlayerStats(goals: 0, assists: 0, yellowCards: 0, redCards: 0),
          ),
        ) {
    load();
  }

  final String matchSyncId;
  final String playerSyncId;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> load() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.getPlayerStats(
      matchSyncId: matchSyncId,
      playerSyncId: playerSyncId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (stats) => state = state.copyWith(state: States.loaded, data: stats),
    );
  }
}

/// --- Participation status (sync-id based) ---
final getPlayerParticipationStatusProvider = FutureProvider.family<
    String?,
    ({
      String matchSyncId,
      String matchTermSyncId,
      String playerSyncId
    })>((ref, args) async {
  final repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());
  final res = await repo.getPlayerParticipationStatus(
    matchSyncId: args.matchSyncId,
    matchTermSyncId: args.matchTermSyncId,
    playerSyncId: args.playerSyncId,
  );

  return res.fold((_) => null, (r) => r);
});

/// --- Assist ---
final addAssistNotifierProvider = StateNotifierProvider.family<
    AddAssistNotifier,
    DataState<AssistModel>,
    AssistModel>((ref, assist) => AddAssistNotifier(assist));

class AddAssistNotifier extends StateNotifier<DataState<AssistModel>> {
  AddAssistNotifier(this.assist)
      : super(
          DataState.initial(
            AssistModel(
              matchSyncId: '',
              playerSyncId: '',
              matchTermSyncId: '',
              goalSyncId: '',
              assistTime: 0,
            ),
          ),
        );

  final AssistModel assist;
  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.addAssist(assist);
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

/// --- Substitute player ---
class SubstitutePlayerNotifier extends StateNotifier<DataState<Unit>> {
  SubstitutePlayerNotifier() : super(DataState.initial(unit));

  final _repo = MatchTermsEventRepository(
      local: di.sl(), syncService: di.sl(), connectivity: di.sl());

  String? _matchSyncId;
  String? _matchTermSyncId;
  String? _outgoingPlayerSyncId;
  String? _incomingPlayerSyncId;
  int? _substitutionMinute;

  void setParams({
    required String matchSyncId,
    required String matchTermSyncId,
    required String outgoingPlayerSyncId,
    required String incomingPlayerSyncId,
    required int substitutionMinute,
  }) {
    _matchSyncId = matchSyncId;
    _matchTermSyncId = matchTermSyncId;
    _outgoingPlayerSyncId = outgoingPlayerSyncId;
    _incomingPlayerSyncId = incomingPlayerSyncId;
    _substitutionMinute = substitutionMinute;
  }

  Future<void> run() async {
    if (_matchSyncId == null ||
        _matchTermSyncId == null ||
        _outgoingPlayerSyncId == null ||
        _incomingPlayerSyncId == null ||
        _substitutionMinute == null) {
      state = state.copyWith(state: States.error);
      return;
    }

    state = state.copyWith(state: States.loading);
    final res = await _repo.substitutePlayer(
      matchSyncId: _matchSyncId!,
      matchTermSyncId: _matchTermSyncId!,
      outgoingPlayerSyncId: _outgoingPlayerSyncId!,
      incomingPlayerSyncId: _incomingPlayerSyncId!,
      substitutionMinute: _substitutionMinute!,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final substitutePlayerNotifierProvider =
    StateNotifierProvider<SubstitutePlayerNotifier, DataState<Unit>>(
        (ref) => SubstitutePlayerNotifier());

// final roundsWithKnockoutStreamProvider =
//     StreamProvider.family<List<RoundModel>, Tuple2<String, String>>(
//         (ref, param) {
//   final repo = KnockoutRepository(
//       local: di.sl(),
//       connectivity: di.sl(),
//       remote: di.sl(),
//       syncService: di.sl());
//   return repo.watchLeagueRoundsWithMatchesKnockout(
//     leagueSyncId: param.value1,
//     matchFilter: param.value2,
//   );
// });
final roundsWithKnockoutStreamProvider =
    StreamProvider.family<List<RoundModel>, Tuple2<String, String>>(
        (ref, param) {
  final repo = ref.read(knockoutRepoProvider);
  return repo.watchLeagueRoundsWithMatchesKnockout(
    leagueSyncId: param.value1,
    matchFilter: param.value2,
  );
});
final knockoutRepoProvider = Provider<KnockoutRepository>((ref) {
  return KnockoutRepository(
    local: di.sl(),
    connectivity: di.sl(),
    remote: di.sl(),
    syncService: di.sl(),
  );
});
final roundsRefreshKnockoutProvider = StateNotifierProvider.family<
    RoundsKnockoutRefreshNotifier,
    RefreshState,
    Tuple3<String, String, String>>((ref, param) {
  return RoundsKnockoutRefreshNotifier(
      param.value1, param.value2, param.value3);
});

class RoundsKnockoutRefreshNotifier extends StateNotifier<RefreshState> {
  final String leagueSyncId;
  final String matchFilter;
  final String role;

  RoundsKnockoutRefreshNotifier(this.leagueSyncId, this.matchFilter, this.role)
      : super(RefreshState.idle());

  final repo = KnockoutRepository(
      local: di.sl(),
      connectivity: di.sl(),
      remote: di.sl(),
      syncService: di.sl());

  Future<void> refresh() async {
    state = state.copyWith(status: RefreshStatus.loading, exception: null);

    final res = await repo.refreshLeagueRoundsMatchesKnockout(
        leagueSyncId: leagueSyncId, matchFilter: matchFilter, role: role);

    res.fold(
      (e) => state = state.copyWith(status: RefreshStatus.error, exception: e),
      (_) =>
          state = state.copyWith(status: RefreshStatus.idle, exception: null),
    );
  }
}

final ensureKnockoutOnEnterProvider = StateNotifierProvider.family<
    EnsureKnockoutOnEnterNotifier,
    DataState<Unit>,
    String>((ref, leagueSyncId) {
  return EnsureKnockoutOnEnterNotifier(ref, leagueSyncId);
});

class EnsureKnockoutOnEnterNotifier extends StateNotifier<DataState<Unit>> {
  EnsureKnockoutOnEnterNotifier(this.ref, this.leagueSyncId)
      : super(DataState.initial(unit));

  final Ref ref;
  final String leagueSyncId;

  bool _running = false;

  Future<void> run() async {
    if (_running) return;
    _running = true;

    if (mounted) {
      state = state.copyWith(state: States.loading, exception: null);
    }

    try {
      // 1) current round
      await ref
          .read(getCurrentLeagueRoundProvider(leagueSyncId).notifier)
          .run();
      if (!mounted) return;

      final roundState = ref.read(getCurrentLeagueRoundProvider(leagueSyncId));
      if (roundState.stateData == States.error) {
        if (mounted) {
          state = state.copyWith(
              state: States.error, exception: roundState.exception);
        }
        return;
      }

      final round = roundState.data;

      // =========================
      // GROUP BRANCH
      // =========================
      if (round.roundType == 'group') {
        await ref
            .read(checkGroupMatchesFinishedProvider(leagueSyncId).notifier)
            .run();
        if (!mounted) return;

        final finishedState =
            ref.read(checkGroupMatchesFinishedProvider(leagueSyncId));
        if (finishedState.stateData == States.error) {
          if (mounted) {
            state = state.copyWith(
                state: States.error, exception: finishedState.exception);
          }
          return;
        }

        final isFinishedAllGroupMatch = finishedState.data == true;

        if (isFinishedAllGroupMatch) {
          // ✅ Idempotency: لا تنشئ knockout إذا موجود محلياً
          final hasKnockout =
              ref.read(hasAnyKnockoutRoundsProvider(leagueSyncId));
          if (!hasKnockout) {
            await ref
                .read(generateFirstKnockoutProvider((leagueSyncId, 4)).notifier)
                .run();
            if (!mounted) return;
          }

          final knockoutState =
              ref.read(generateFirstKnockoutProvider((leagueSyncId, 4)));

          // refresh knockout list
          ref
              .read(roundsRefreshKnockoutProvider(
                      Tuple3(leagueSyncId, 'unscheduled', 'organizer'))
                  .notifier)
              .refresh();

          if (knockoutState.stateData == States.error) {
            // ignore: avoid_print
            print(
                "⚠️ خطأ أثناء تفعيل الأدوار الإقصائية: ${knockoutState.exception}");
          } else if (knockoutState.stateData == States.loaded) {
            // ignore: avoid_print
            print(
                "🎯 تم إنشاء الجولة الإقصائية الأولى: ${knockoutState.data.roundName}");
          }
        }

        // refresh group + rounds
        ref.read(groupRefreshProvider(leagueSyncId).notifier).refresh();
        ref
            .read(roundsRefreshProvider(Tuple3(
                    leagueSyncId, 'scheduled,live,finished', 'organizer'))
                .notifier)
            .refresh();
        ref
            .read(roundsRefreshProvider(
                    Tuple3(leagueSyncId, 'scheduled,live', 'organizer'))
                .notifier)
            .refresh();

        if (mounted) {
          state = state.copyWith(state: States.loaded, data: unit);
        }
        return;
      }

      // =========================
      // KNOCKOUT BRANCH
      // =========================
      final key = await ref
          .read(lastFinishedKnockoutRoundKeyProvider(leagueSyncId).future);
      if (!mounted) return;

      final finishedRoundId =
          key?.syncId; // ✅ int? هو المطلوب للـ provider عندك
      if (finishedRoundId != null) {
        await ref
            .read(generateNextKnockoutProvider((leagueSyncId, finishedRoundId))
                .notifier)
            .run();
        if (!mounted) return;
      }

      ref
          .read(roundsRefreshKnockoutProvider(
                  Tuple3(leagueSyncId, 'scheduled,live,finished', 'organizer'))
              .notifier)
          .refresh();
      ref
          .read(roundsRefreshKnockoutProvider(
                  Tuple3(leagueSyncId, 'unscheduled', 'organizer'))
              .notifier)
          .refresh();
      ref
          .read(roundsRefreshKnockoutProvider(
                  Tuple3(leagueSyncId, 'scheduled,live', 'organizer'))
              .notifier)
          .refresh();

      if (mounted) {
        state = state.copyWith(state: States.loaded, data: unit);
      }
    } catch (e, st) {
      if (mounted) {
        state = state.copyWith(state: States.error, exception: e);
      }
      // ignore: avoid_print
      print("❌ خطأ أثناء إدارة الأدوار الإقصائية: $e\n$st");
    } finally {
      _running = false;
    }
  }
}

final lastFinishedKnockoutRoundKeyProvider =
    FutureProvider.family<({int? id, String? syncId})?, String>(
        (ref, leagueSyncId) async {
  final rounds = await ref.read(roundsWithKnockoutStreamProvider(
          Tuple2(leagueSyncId, 'scheduled,live,finished'))
      .future);

  final knockoutRounds =
      rounds.where((r) => r.roundType == 'knockout').toList();

  // ترتيب (لو عندك createdAt/updatedAt استخدمها بدل id)
  knockoutRounds.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));

  for (final r in knockoutRounds.reversed) {
    final matches = r.matches;
    if (matches == null || matches.isEmpty) continue;

    final allFinished = matches.every((m) => m.status == 'finished');
    if (!allFinished) continue;

    final rid = r.id;
    final rsync = r.syncId;

    // لازم على الأقل واحد يكون موجود
    if (rid != null || (rsync != null && rsync.isNotEmpty)) {
      return (id: rid, syncId: rsync);
    }
  }

  return null;
});
final hasAnyKnockoutRoundsProvider =
    Provider.family<bool, String>((ref, leagueSyncId) {
  final asyncRounds = ref.watch(
    roundsWithKnockoutStreamProvider(
      Tuple2(leagueSyncId, 'scheduled,live,finished,unscheduled'),
    ),
  );

  return asyncRounds.maybeWhen(
    data: (rounds) => rounds.any((r) => r.roundType == 'knockout'),
    orElse: () => false, // ✅ لا تظل loading
  );
});
// lib/features/knockout/presentation/ensure_knockout_progress_provider.dart

// 1) وفر الـ repo عبر provider (لا تنشئه داخل notifier)
final knockoutRepositoryProvider = Provider<KnockoutRepository>((ref) {
  return KnockoutRepository(
    local: di.sl(),
    remote: di.sl(),
    connectivity: di.sl(),
    syncService: di.sl(),
  );
});

// 2) Provider family للـ notifier
final ensureKnockoutProgressProvider = StateNotifierProvider.family<
    EnsureKnockoutProgressNotifier, DataState<Unit>, String>(
  (ref, leagueSyncId) => EnsureKnockoutProgressNotifier(
    ref: ref,
    leagueSyncId: leagueSyncId,
    repo: ref.read(knockoutRepositoryProvider),
  ),
);

class EnsureKnockoutProgressNotifier extends StateNotifier<DataState<Unit>> {
  EnsureKnockoutProgressNotifier({
    required this.ref,
    required this.leagueSyncId,
    required KnockoutRepository repo,
  })  : _repo = repo,
        super(DataState.initial(unit));

  final Ref ref;
  final String leagueSyncId;
  final KnockoutRepository _repo;

  bool _running = false;

  bool get _alive => ref.mounted;

  Future<void> run({int qualifiedPerGroup = 4}) async {
    if (_running) return;
    _running = true;

    state = state.copyWith(state: States.loading, exception: null);

    try {
      final res = await _repo.ensureKnockoutProgress(
        leagueSyncId: leagueSyncId,
        qualifiedPerGroup: qualifiedPerGroup,
      );

      if (!_alive) return;

      // 3) لا تستخدم fold مع async — افصلها
      res.fold(
        (DioException e) {
          if (!_alive) return;
          state = state.copyWith(state: States.error, exception: e);
        },
        (createdRound) {
          if (!_alive) return;

          // لو ما في شيء جديد تم إنشاؤه: still success
          // لكن ممكن ما تعمل refresh أو تعمل refresh خفيف حسب رغبتك
          if (createdRound != null) {
            ref
                .read(roundsRefreshKnockoutProvider(
                  Tuple3(leagueSyncId, 'unscheduled', 'organizer'),
                ).notifier)
                .refresh();

            ref
                .read(roundsRefreshKnockoutProvider(
                  Tuple3(leagueSyncId, 'scheduled,live,finished', 'organizer'),
                ).notifier)
                .refresh();
          }

          state = state.copyWith(state: States.loaded, data: unit);
        },
      );
    } catch (e, st) {
      if (!_alive) return;
      state = state.copyWith(state: States.error, exception: e);
      // ignore: avoid_print
      print("❌ ensureKnockoutProgress error: $e\n$st");
    } finally {
      _running = false;
    }
  }
}
