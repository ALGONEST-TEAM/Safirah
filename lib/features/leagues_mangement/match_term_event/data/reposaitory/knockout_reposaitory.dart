// lib/features/knockout/data/knockout_repository.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../injection.dart' as di;
import '../../../match/data/model/round_model.dart';
import '../data_source/local_data_source/local_knockout_data_source.dart';
import '../data_source/remote_data_source/remote_data_source.dart';

class KnockoutRepository {
  final KnockoutGeneratorLocalDataSource local;
  final ConnectivityService connectivity;
  final SyncService syncService;
  final MatchTermRemoteDataSource remote;

  KnockoutRepository({
    required this.local,
    required this.remote,
    required this.connectivity,
    required this.syncService,
  });

  /// ✅ Idempotent:
  /// - ينشئ "جولة واحدة كحد أقصى" لكل استدعاء
  /// - يعتمد على locks داخل local (ممتاز)
  Future<Either<DioException, RoundModel?>> ensureKnockoutProgress({
    required String leagueSyncId,
    required int qualifiedPerGroup,
  }) async {
    try {
      final created = await local.ensureKnockoutProgress(
        leagueSyncId: leagueSyncId,
        qualifiedPerGroup: qualifiedPerGroup,
      );

      if (created == null) return const Right(null);

      // ignore: avoid_print
      print('[KnockoutRepository] created knockout round syncId=${created.syncId}');

      await _enqueueRoundCreate(created);
      di.sl<SyncTrigger>().syncIfOnline(throwOnFirstError: true);

      // sync لا يكسر نتيجة local creation: إذا فشل sync ارجع created برضه
    // await _syncIfOnlineSafely();

      return Right(created);
    } catch (e, st) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/ensure-progress'),
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<Either<DioException, RoundModel>> generateFirstKnockout({
    required String leagueSyncId,
    required int qualifiedPerGroup,
  }) async {
    try {
      final created = await local.generateKnockoutFromGroups(
        leagueSyncId: leagueSyncId,
        qualifiedPerGroup: qualifiedPerGroup,
      );

      await _enqueueRoundCreate(created);
      await _syncIfOnlineSafely();

      return Right(created);
    } catch (e, st) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/first'),
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<Either<DioException, RoundModel?>> generateNextKnockout({
    required String leagueSyncId,
    required String finishedRoundSyncId,
  }) async {
    try {
      final created = await local.createNextKnockoutRoundFromFinished(
        leagueSyncId: leagueSyncId,
        finishedRoundSyncId: finishedRoundSyncId,
      );

      print(created!.syncId??'npppppppppp');
      if (created == null) return const Right(null);

      await _enqueueRoundCreate(created);
      await _syncIfOnlineSafely();

      return Right(created);
    } catch (e, st) {
      // ignore: avoid_print
      print('[KnockoutRepository] generateNextKnockout FAILED: $e\n$st');
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/next'),
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<void> _enqueueRoundCreate(RoundModel created) async {
    final round = created.toJson();


    await syncService.enqueueOperation(
      entityType: 'rounds',
      operation: SyncService.operationCreate,
      payload: {'rounds': [round]},
    );
  }

  Future<void> _syncIfOnlineSafely() async {
    // ملاحظة: عندك SyncTrigger بالـ DI
    if (!await connectivity.isOnline()) return;
    try {
      di.sl<SyncTrigger>().syncIfOnline(throwOnFirstError: true);
    } on DioException catch (e) {
      // ignore: avoid_print
      print('[KnockoutRepository] background sync failed: ${e.message}');
      // لا نرميها هنا كي لا نكسر local creation
    }
  }

  Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
    required String leagueSyncId,
    required String matchFilter,
  }) {
    return local.watchLeagueRoundsWithMatchesKnockout(
      leagueSyncId: leagueSyncId,
      matchFilter: matchFilter,
    );
  }

  Future<Either<DioException, void>> refreshLeagueRoundsMatchesKnockout({
    required String leagueSyncId,
    required String matchFilter,
    required String role,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;

      final remoteRounds = (role == 'organizer')
          ? await remote.getLeagueRoundsKnockout(leagueSyncId)
          : await remote.getLeagueRoundsKnockoutRole(leagueSyncId, 'Referee');


      try {
        await local.upsertRoundsWithMatchesLocal(remoteRounds);
      } catch (e, st) {
        print('❌ upsertRoundsWithMatchesLocal failed: $e\n$st');
        rethrow;
      }
      // sync afterwards (safe)
      await _syncIfOnlineSafely();
    });
  }
  Future<Either<DioException, RoundModel>> getCurrentLeagueRound(
      String leagueSyncId) async {
    try {
      final result = await local.getCurrentLeagueRound(leagueSyncId);
      return Right(result!);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/rounds/current'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, bool>> checkAllGroupMatchesFinished({
    required String leagueSyncId,
  }) async {
    try {
      final finished = await local.areAllGroupMatchesFinished(leagueSyncId);
      return Right(finished);
    } catch (e, s) {
      return Left(DioException(
        stackTrace: s,
        requestOptions: RequestOptions(path: '/groups/check-matches-finished'),
        error: e,
      ));
    }}
}