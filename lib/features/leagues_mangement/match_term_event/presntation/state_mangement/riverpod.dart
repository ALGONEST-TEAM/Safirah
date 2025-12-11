import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart' as di show sl;
import '../../../group/presntaion/state_managment/riverpod.dart';
import '../../../match/data/model/match_model.dart';
import '../../../match/data/model/round_model.dart';
import '../../../match/presntaion/state_managment/riverpod.dart';
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
  final _repo = MatchTermsEventRepository(local: di.sl());

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
    DataState<List<LeagueTermModel>>, int>((ref, leagueId) {
  return LeagueTermNotifier(leagueId);
});

class LeagueTermNotifier
    extends StateNotifier<DataState<List<LeagueTermModel>>> {
  LeagueTermNotifier(this.leagueId)
      : _repo = MatchTermsEventRepository(local: di.sl()),
        super(DataState.initial(const []));

  final int leagueId;
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

    List<int> selectedTermIds = [];

    if (selectedTermsCount == 1) {
      final first =
          allTerms.firstWhere((t) => t.type == 'regular' && t.order == 1);
      selectedTermIds.add(first.id!);
    } else if (selectedTermsCount == 2) {
      selectedTermIds.addAll(
        allTerms.where((t) => t.type == 'regular').take(2).map((t) => t.id!),
      );
    }

    if (includeExtraAndPenalties) {
      selectedTermIds.addAll(
        allTerms
            .where((t) => t.type == 'extra' || t.type == 'penalty')
            .map((t) => t.id!),
      );
    } else {
      final penalty = allTerms.firstWhere((t) => t.type == 'penalty');
      selectedTermIds.add(penalty.id!);
    }
    print(selectedTermIds);
    await initTerms(
      selectedTermIds: selectedTermIds,
      durationMinutes: matchDuration,
    );
  }

  Future<void> initTerms({
    required List<int> selectedTermIds,
    required int durationMinutes,
  }) async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.initLeagueTerms(
      leagueId: leagueId,
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
    StateNotifierProvider.family<TermDurationNotifier, DataState<int>, int>(
  (ref, matchTermId) => TermDurationNotifier(matchTermId),
);

class TermDurationNotifier extends StateNotifier<DataState<int>> {
  final int matchTermId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  TermDurationNotifier(this.matchTermId) : super(DataState.initial(0)) {
    loadTermDuration();
  }

  Future<void> loadTermDuration() async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.getTermDurationByMatchTermId(matchTermId);

    result.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (duration) =>
          state = state.copyWith(state: States.loaded, data: duration),
    );
  }
}

final updateAdditionalMinutesNotifierProvider = StateNotifierProvider.family<
        UpdateAdditionalMinutesNotifier, DataState<bool>, Map<String, int>>(
    (ref, params) =>
        UpdateAdditionalMinutesNotifier(params['termId']!, params['minutes']!));

class UpdateAdditionalMinutesNotifier extends StateNotifier<DataState<bool>> {
  final int termId;
  final int minutes;
  final _repo = MatchTermsEventRepository(local: di.sl());

  UpdateAdditionalMinutesNotifier(this.termId, this.minutes)
      : super(DataState.initial(false)) {
    update();
  }

  Future<void> update() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.updateAdditionalMinutes(termId, minutes);
    res.fold(
      (l) => state = state.copyWith(state: States.error, exception: l),
      (r) => state = state.copyWith(state: States.loaded, data: true),
    );
  }
}

final startTermNotifierProvider = StateNotifierProvider.family<
        StartTermNotifier, DataState<bool>, Map<String, int>>(
    (ref, params) =>
        StartTermNotifier(ref, params['matchId']!, params['idMatchTerm']!));

class StartTermNotifier extends StateNotifier<DataState<bool>> {
  final Ref ref;
  final int matchId;
  final int idMatchTerm;
  final _repo = MatchTermsEventRepository(local: di.sl());

  StartTermNotifier(this.ref, this.matchId, this.idMatchTerm)
      : super(DataState.initial(false)) {
    startTerm();
  }

  /// ✅ بدء الشوط مع التحقق من وقت المباراة
  Future<void> startTerm() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.startTermSafe(matchId, idMatchTerm);

    res.fold(
      (error) {
        state = state.copyWith(state: States.error, exception: error);
      },
      (_) {
        state = state.copyWith(state: States.loaded, data: true);
      },
    );
  }
}

final finishTermNotifierProvider = StateNotifierProvider.family<
    FinishTermNotifier, DataState<bool>, Map<String, int>>((ref, ids) {
  return FinishTermNotifier(matchId: ids['matchId']!, termId: ids['termId']!);
});

class FinishTermNotifier extends StateNotifier<DataState<bool>> {
  final int matchId;
  final int termId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  bool _isRunning = false; // لمنع الاستدعاء المتكرر

  FinishTermNotifier({required this.matchId, required this.termId})
      : super(DataState.initial(false));

  Future<void> finish() async {
    if (_isRunning) return; // إذا كانت العملية جارية بالفعل، تجاهل الاستدعاء
    _isRunning = true;

    try {
      state = state.copyWith(state: States.loading);

      final res = await _repo.finishCurrentTerm(matchId, termId);

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
      required int roundId,
      required int leagueId}) async {
    if (_timer != null) return;

    final termId = currentTerm.id;
    final matchId = currentTerm.matchId;

    final startTermProviderRef = startTermNotifierProvider({
      'matchId': matchId,
      'idMatchTerm': termId,
    });

    await ref.read(startTermProviderRef.notifier).startTerm();
// بعد startTermSafe و قبل تشغيل الـ timer
    if (currentTerm.termType == 'regular' &&
        currentTerm.termName == 'الشوط الأول') {
      await ref
          .read(initStartersNotifierProvider(
              (matchId: matchId, matchTermId: termId)).notifier)
          .run();
    }
    final startState = ref.read(startTermProviderRef);
    if (startState.stateData == States.error) {
      return;
    }

    int baseDuration;
    final durationState = ref.read(termDurationProvider(termId));
    if (durationState.stateData == States.loaded) {
      baseDuration = durationState.data;
    } else {
      try {
        await ref
            .read(termDurationProvider(termId).notifier)
            .loadTermDuration();
        baseDuration = ref.read(termDurationProvider(termId)).data;
      } catch (e) {
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
    ref.read(matchTermStateProvider(termId).notifier).state = true;
    await ref.read(getCurrentMatchTermProvider(matchId).notifier).run();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (_waitingExtraTime || _isFinishing) return;

      final newElapsed = state.data.elapsedSeconds + 1;
      ref.read(matchTimerProvider.notifier).state = newElapsed;
      state = state.copyWith(
        state: States.loaded,
        data: state.data.copyWith(elapsedSeconds: newElapsed),
      );

      // if (_isPaused) return;
      if (!state.data.alertShown && newElapsed >= (baseDuration - 1) * 60) {
      //if (!state.data.alertShown && newElapsed >= (baseDuration - 1)) {
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
              .read(updateAdditionalMinutesNotifierProvider({
                'termId': termId,
                'minutes': extra,
              }).notifier)
              .update();

          additional = extra;
          _waitingExtraTime = false;
        } else {
          await _finishCurrentTerm(roundId, leagueId, currentTerm);
        }
      }

      // 🎯 تحقق من نهاية الوقت الكلي (الرسمي + الإضافي)
      //if (newElapsed >= (baseDuration + additional)) {
        if (newElapsed >= (baseDuration + additional) * 60) {
        await _finishCurrentTerm(roundId, leagueId, currentTerm);
      }
    });
  }

  void stop(int termId) {
    if (_isPaused) return;
    ref.read(stopTermStateProvider(termId).notifier).state = true;

    _isPaused = true;
    _pauseStartTime = DateTime.now();

    state = state.copyWith(
      state: States.loaded,
      data: state.data.copyWith(isPaused: true),
    );
  }

  void resume(int termId) {
    if (!_isPaused || _pauseStartTime == null) return;
    final pausedSeconds = DateTime.now().difference(_pauseStartTime!).inSeconds;
    state = state.copyWith(
      state: States.loaded,
      data: state.data.copyWith(
        totalWastedSeconds: state.data.totalWastedSeconds + pausedSeconds,
        isPaused: false,
      ),
    );
    ref.read(stopTermStateProvider(termId).notifier).state = false;

    _pauseStartTime = null;
    _isPaused = false;
  }

  Future<void> _finishCurrentTerm(
      int finishedRoundId, int leagueId, MatchTermModel currentTerm) async {
    if (_isFinishing) return;
    _isFinishing = true;

    final termId = currentTerm.id;
    final matchId = currentTerm.matchId;

    try {
      _timer?.cancel();
      _timer = null;

      final notifier = ref.read(finishTermNotifierProvider({
        'matchId': matchId,
        'termId': termId,
      }).notifier);

      await notifier.finish();
      final finishState = ref.read(finishTermNotifierProvider({
        'matchId': matchId,
        'termId': termId,
      }));

      if (finishState.stateData == States.error) {
        return;
      }

      ref.read(matchTermStateProvider(termId).notifier).state = false;

      try {
        await ref.read(getCurrentLeagueRoundProvider(leagueId).notifier).run();
        final roundType = ref.read(getCurrentLeagueRoundProvider(leagueId));
        if (roundType.data.roundType == 'group') {
          await ref
              .read(checkGroupMatchesFinishedProvider(leagueId).notifier)
              .run();
          final isFinishedAllGroupMatch =
              ref.read(checkGroupMatchesFinishedProvider(leagueId));
          if (isFinishedAllGroupMatch.data) {
            await ref
                .read(generateFirstKnockoutProvider((leagueId, 4)).notifier)
                .run();

            final knockoutState =
                ref.read(generateFirstKnockoutProvider((leagueId, 4)));
            ref
                .read(knockoutRoundsWithMatchesProvider(
                        Tuple2(leagueId, 'unscheduled'))
                    .notifier)
                .load();
            if (knockoutState.stateData == States.error) {
              print(
                  "⚠️ خطأ أثناء تفعيل الأدوار الإقصائية: ${knockoutState.exception}");
            } else if (knockoutState.stateData == States.loaded) {
              print(
                  "🎯 تم إنشاء الجولة الإقصائية الأولى: ${knockoutState.data.roundName}");
            }
          }

          await ref.read(getCurrentMatchTermProvider(matchId).notifier).run();
          ref.read(groupsWithQualifiedTeamsProvider(leagueId).notifier).load();
          ref
              .read(roundsWithGroupsProvider(
                      Tuple2(leagueId, 'scheduled,live,finished'))
                  .notifier)
              .run();
          ref
              .read(roundsWithGroupsProvider(Tuple2(leagueId, 'scheduled,live'))
                  .notifier)
              .run();
        } else {
          await ref.read(getCurrentMatchTermProvider(matchId).notifier).run();

          // await ref
          //     .read(checkGroupMatchesFinishedProvider(leagueId).notifier)
          //     .run();

          await ref
              .read(generateNextKnockoutProvider((leagueId, finishedRoundId))
                  .notifier)
              .run();
          ref
              .read(knockoutRoundsWithMatchesProvider(
                      Tuple2(leagueId, 'scheduled,live,finished'))
                  .notifier)
              .load();
          ref
              .read(knockoutRoundsWithMatchesProvider(
                      Tuple2(leagueId, 'unscheduled'))
                  .notifier)
              .load();
          ref
              .read(knockoutRoundsWithMatchesProvider(
                      Tuple2(leagueId, 'scheduled,live'))
                  .notifier)
              .load();
        }
      } catch (e, st) {
        print("❌ خطأ أثناء إدارة الأدوار الإقصائية: $e\n$st");
      }

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

final matchTermCounterProvider = StateNotifierProvider.family<
    MatchTermCounterNotifier, DataState<CounterData>, int>(
  (ref, dummy) => MatchTermCounterNotifier(ref, dummy),
);
final addGoalNotifierProvider = StateNotifierProvider.family<AddGoalNotifier,
    DataState<GoalModel>, GoalModel>(
  (ref, goal) => AddGoalNotifier(goal),
);

class AddGoalNotifier extends StateNotifier<DataState<GoalModel>> {
  AddGoalNotifier(this.goal)
      : super(DataState.initial(GoalModel(
          matchId: 0,
          playerId: 0,
          matchTermId: 0,
          goalTime: 0,
          goalType: '',
        )));

  final GoalModel goal;
  final _repo = MatchTermsEventRepository(local: di.sl());

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
      : super(DataState.initial(WarningModel(
          matchId: 0,
          playerId: 0,
          matchTermId: 0,
          warningTime: 0,
          warningType: '',
        )));

  final WarningModel warning;
  late final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final result = await _repo.addWarning(warning);
    result.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final deleteGoalNotifierProvider =
    StateNotifierProvider.family<DeleteGoalNotifier, DataState<int?>, int>(
        (ref, goalId) {
  return DeleteGoalNotifier(goalId);
});

class DeleteGoalNotifier extends StateNotifier<DataState<int?>> {
  DeleteGoalNotifier(this.goalId) : super(DataState.initial(null));

  final int goalId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.deleteGoal(goalId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) {
        return state = state.copyWith(state: States.loaded, data: data);
      },
    );
  }
}

final deleteWarningNotifierProvider =
    StateNotifierProvider.family<DeleteWarningNotifier, DataState<Unit>, int>(
        (ref, warningId) {
  return DeleteWarningNotifier(warningId);
});

class DeleteWarningNotifier extends StateNotifier<DataState<Unit>> {
  DeleteWarningNotifier(this.warningId) : super(DataState.initial(unit));

  final int warningId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.deleteWarning(warningId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final getFullMatchDataProvider = StateNotifierProvider.family<
    GetFullMatchDataNotifier, DataState<MatchModel>, int>((ref, matchId) {
  return GetFullMatchDataNotifier(matchId);
});

class GetFullMatchDataNotifier extends StateNotifier<DataState<MatchModel>> {
  GetFullMatchDataNotifier(this.matchId)
      : super(DataState.initial(const MatchModel())) {
    run();
  }

  final int matchId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getFullMatchData(matchId);
    r.fold(
      (e) {
        print('error in getFullMatchData: $e');
        return state = state.copyWith(state: States.error, exception: e);
      },
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final getCurrentMatchTermProvider = StateNotifierProvider.family<
    GetCurrentMatchTermNotifier,
    DataState<MatchTermModel?>,
    int>((ref, matchId) {
  return GetCurrentMatchTermNotifier(matchId);
});

class GetCurrentMatchTermNotifier
    extends StateNotifier<DataState<MatchTermModel?>> {
  GetCurrentMatchTermNotifier(this.matchId)
      : super(DataState.initial(
            MatchTermModel(id: 0, matchId: 0, leagueTermId: 0))) {
    run();
  }

  final int matchId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCurrentMatchTerm(matchId);
    r.fold(
      (e) {
        return state = state.copyWith(state: States.error, exception: e);
      },
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final getCurrentLeagueRoundProvider = StateNotifierProvider.family<
    GetCurrentLeagueRoundNotifier, DataState<RoundModel>, int>((ref, matchId) {
  return GetCurrentLeagueRoundNotifier(matchId);
});

class GetCurrentLeagueRoundNotifier
    extends StateNotifier<DataState<RoundModel>> {
  GetCurrentLeagueRoundNotifier(this.leagueId)
      : super(DataState.initial(
            RoundModel(leagueId: leagueId, roundName: '', roundType: ''))) {
    run();
  }

  final int leagueId;
  final _repo = KnockoutRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.getCurrentLeagueRound(leagueId);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final generateFirstKnockoutProvider = StateNotifierProvider.family<
    GenerateFirstKnockoutNotifier,
    DataState<RoundModel>,
    (int leagueId, int qualifiedPerGroup)>(
  (ref, args) => GenerateFirstKnockoutNotifier(args.$1, args.$2),
);

class GenerateFirstKnockoutNotifier
    extends StateNotifier<DataState<RoundModel>> {
  final int leagueId;
  final int qualifiedPerGroup;
  final _repo = KnockoutRepository(local: di.sl());

  GenerateFirstKnockoutNotifier(this.leagueId, this.qualifiedPerGroup)
      : super(DataState.initial(
          RoundModel(id: -1, leagueId: 0, roundName: '', roundType: ''),
        ));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.generateFirstKnockout(
      leagueId: leagueId,
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
    (int leagueId, int finishedRoundId)>(
  (ref, args) => GenerateNextKnockoutNotifier(args.$1, args.$2),
);

class GenerateNextKnockoutNotifier
    extends StateNotifier<DataState<RoundModel?>> {
  final int leagueId;
  final int finishedRoundId;
  final _repo = KnockoutRepository(local: di.sl());

  GenerateNextKnockoutNotifier(this.leagueId, this.finishedRoundId)
      : super(DataState.initial(null));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.generateNextKnockout(
      leagueId: leagueId,
      finishedRoundId: finishedRoundId,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (round) => state = state.copyWith(state: States.loaded, data: round),
    );
  }
}

final checkNextKnockoutRoundProvider = StateNotifierProvider.family<
    CheckNextKnockoutRoundNotifier,
    DataState<Unit>,
    (int leagueId, int finishedRoundId)>((ref, args) {
  return CheckNextKnockoutRoundNotifier(args.$1, args.$2);
});

class CheckNextKnockoutRoundNotifier extends StateNotifier<DataState<Unit>> {
  final int leagueId;
  final int finishedRoundId;
  final _repo = KnockoutRepository(local: di.sl());

  CheckNextKnockoutRoundNotifier(this.leagueId, this.finishedRoundId)
      : super(DataState<Unit>.initial(unit));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);

    final res = await _repo.checkAndCreateNextKnockoutRoundIfNeeded(
      leagueId: leagueId,
      finishedRoundId: finishedRoundId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

final knockoutRoundsWithMatchesProvider = StateNotifierProvider.family<
    KnockoutRoundsWithMatchesNotifier,
    DataState<List<RoundModel>>,
    Tuple2<int, String>>((ref, param) {
  return KnockoutRoundsWithMatchesNotifier(param.value1, param.value2);
});

class KnockoutRoundsWithMatchesNotifier
    extends StateNotifier<DataState<List<RoundModel>>> {
  final int leagueId;
  final String matchFilter;

  final _repo = KnockoutRepository(local: di.sl());

  KnockoutRoundsWithMatchesNotifier(this.leagueId, this.matchFilter)
      : super(DataState.initial([])) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final res =
        await _repo.getAllKnockoutRoundsWithMatches(leagueId, matchFilter);
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) {
        print(data);
        return state = state.copyWith(state: States.loaded, data: data);
      },
    );
  }
}

final checkGroupMatchesFinishedProvider = StateNotifierProvider.family<
    CheckGroupMatchesFinishedNotifier, DataState<bool>, int>(
  (ref, leagueId) => CheckGroupMatchesFinishedNotifier(leagueId),
);

class CheckGroupMatchesFinishedNotifier extends StateNotifier<DataState<bool>> {
  final int leagueId;
  final _repo = KnockoutRepository(local: di.sl());

  CheckGroupMatchesFinishedNotifier(this.leagueId)
      : super(DataState.initial(false)) {
    run();
  }

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.checkAllGroupMatchesFinished(leagueId: leagueId);

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (finished) {
        return state = state.copyWith(state: States.loaded, data: finished);
      },
    );
  }
}

final addAssistNotifierProvider = StateNotifierProvider.family<
    AddAssistNotifier, DataState<AssistModel>, AssistModel>(
  (ref, assist) => AddAssistNotifier(assist),
);

class AddAssistNotifier extends StateNotifier<DataState<AssistModel>> {
  AddAssistNotifier(this.assist)
      : super(
          DataState.initial(
            AssistModel(
              matchId: 0,
              playerId: 0,
              matchTermId: 0,
              goalId: 0,
              assistTime: 0,
            ),
          ),
        );

  final AssistModel assist;
  final _repo = MatchTermsEventRepository(local: di.sl());

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.addAssist(assist);
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }
}

final substitutePlayerNotifierProvider =
    StateNotifierProvider<SubstitutePlayerNotifier, DataState<Unit>>(
  (ref) => SubstitutePlayerNotifier(),
);

class SubstitutePlayerNotifier extends StateNotifier<DataState<Unit>> {
  SubstitutePlayerNotifier() : super(DataState.initial(unit));

  final MatchTermsEventRepository _repo =
      MatchTermsEventRepository(local: di.sl());

  int? _matchId;
  int? _matchTermId;
  int? _outgoingPlayerId;
  int? _incomingPlayerId;
  int? _substitutionMinute;

  void setParams({
    required int matchId,
    required int matchTermId,
    required int outgoingPlayerId,
    required int incomingPlayerId,
    required int substitutionMinute,
  }) {
    _matchId = matchId;
    _matchTermId = matchTermId;
    _outgoingPlayerId = outgoingPlayerId;
    _incomingPlayerId = incomingPlayerId;
    _substitutionMinute = substitutionMinute;
  }

  Future<void> run() async {
    if (_matchId == null ||
        _matchTermId == null ||
        _outgoingPlayerId == null ||
        _incomingPlayerId == null ||
        _substitutionMinute == null) {
      // لا يوجد إعداد كامل للبارامترات
      return;
    }

    state = state.copyWith(state: States.loading);
    final res = await _repo.substitutePlayer(
      matchId: _matchId!,
      matchTermId: _matchTermId!,
      outgoingPlayerId: _outgoingPlayerId!,
      incomingPlayerId: _incomingPlayerId!,
      substitutionMinute: _substitutionMinute!,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}

/// حالة مشاركة لاعب في شوط/مباراة معينة: هل هو داخل الملعب الآن أم لا
final playerOnPitchProvider = FutureProvider.family<bool?,
    ({int matchId, int matchTermId, int playerId})>((ref, args) async {
  final repo = MatchTermsEventRepository(local: di.sl());
  final res = await repo.getPlayerParticipationStatus(
    matchId: args.matchId,
    matchTermId: args.matchTermId,
    playerId: args.playerId,
  );
  return res.fold(
    (e) => false,
    (status) {
      if (status == null) return null;
      return status == 'STARTER' || status == 'SUB_IN';
    },
  );
});

final getPlayerParticipationStatusProvider = StateNotifierProvider.family<
    GetPlayerParticipationStatusNotifier,
    DataState<String?>,
    ({int matchId, int matchTermId, int playerId})>((ref, args) {
  return GetPlayerParticipationStatusNotifier(
      matchId: args.matchId,
      matchTermId: args.matchTermId,
      playerId: args.playerId);
});

class GetPlayerParticipationStatusNotifier
    extends StateNotifier<DataState<String?>> {
  GetPlayerParticipationStatusNotifier(
      {required this.matchId,
      required this.matchTermId,
      required this.playerId})
      : _repo = MatchTermsEventRepository(local: di.sl()),
        super(DataState.initial(null)) {
    run();
  }

  final MatchTermsEventRepository _repo;

  int matchId;
  int matchTermId;
  int playerId;

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.getPlayerParticipationStatus(
      matchId: matchId,
      matchTermId: matchTermId,
      playerId: playerId,
    );

    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (status) => state = state.copyWith(state: States.loaded, data: status),
    );
  }
}

class PlayerStatsNotifier extends StateNotifier<DataState<PlayerStatsState>> {
  final int matchId;
  final int playerId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  PlayerStatsNotifier({required this.matchId, required this.playerId})
      : super(DataState.initial(PlayerStatsState())) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.getPlayerStats(
      matchId: matchId,
      playerId: playerId,
    );
    res.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (stats) => state = state.copyWith(
        state: States.loaded,
        data: PlayerStatsState(
          goals: stats.goals,
          assists: stats.assists,
          yellow: stats.yellowCards,
          red: stats.redCards,
        ),
      ),
    );
  }
}

final playerStatsProvider = StateNotifierProvider.family<PlayerStatsNotifier,
    DataState<PlayerStatsState>, ({int matchId, int playerId})>((ref, args) {
  return PlayerStatsNotifier(matchId: args.matchId, playerId: args.playerId);
});
final initStartersNotifierProvider = StateNotifierProvider.family<
    InitStartersNotifier, DataState<Unit>, ({int matchId, int matchTermId})>(
  (ref, args) => InitStartersNotifier(
    matchId: args.matchId,
    matchTermId: args.matchTermId,
  ),
);

class InitStartersNotifier extends StateNotifier<DataState<Unit>> {
  final int matchId;
  final int matchTermId;
  final _repo = MatchTermsEventRepository(local: di.sl());

  InitStartersNotifier({
    required this.matchId,
    required this.matchTermId,
  }) : super(DataState.initial(unit));

  Future<void> run() async {
    state = state.copyWith(state: States.loading);
    final r = await _repo.initStartersForMatchTerm(
      matchId: matchId,
      matchTermId: matchTermId,
    );
    r.fold(
      (e) => state = state.copyWith(state: States.error, exception: e),
      (_) => state = state.copyWith(state: States.loaded, data: unit),
    );
  }
}
