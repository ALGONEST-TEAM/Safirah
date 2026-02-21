// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
//
// import '../../../../../core/database/sync_service.dart';
// import '../../../../../core/database/sync_trigger.dart';
// import '../../../../../core/network/connectivity_service.dart';
// import '../../../../../core/network/errors/repo_guard.dart';
// import '../../../../../core/network/errors/sync_dio_exception.dart';
// import '../../../../../injection.dart' as di;
// import '../../../match/data/data_source/remote_data_source/remote_data_source.dart';
// import '../../../match/data/model/round_model.dart';
// import '../data_source/local_data_source/local_knockout_data_source.dart';
// import '../data_source/remote_data_source/remote_data_source.dart';
//
// class KnockoutRepository {
//   final KnockoutGeneratorLocalDataSource local;
//   final ConnectivityService connectivity;
//   final SyncService syncService;
//   final MatchTermRemoteDataSource remote;
//
//   KnockoutRepository(
//       {required this.local,
//       required this.remote,
//       required this.connectivity,
//       required this.syncService});
//
//   Future<Either<DioException, RoundModel>> generateFirstKnockout({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//   }) async {
//     try {
//       final result = await local.generateKnockoutFromGroups(
//         leagueSyncId: leagueSyncId,
//         qualifiedPerGroup: qualifiedPerGroup,
//       );
//       await syncService.enqueueOperation(
//         entityType: 'rounds',
//         operation: SyncService.operationCreate,
//         payload: {
//           'rounds': [
//             result.toJson(),
//           ]
//         },
//       );
//       try {
//         await di.sl<SyncTrigger>().syncIfOnline();
//       } on DioException catch (e) {
//         throw SyncDioException.from(e);
//       }
//       return Right(result);
//     } catch (e) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/knockout/first'),
//         error: e,
//       ));
//     }
//   }
//
//   /// إنشاء الجولة التالية بعد انتهاء الحالية
//   Future<Either<DioException, RoundModel?>> generateNextKnockout({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//   }) async {
//     try {
//       final result = await local.createNextKnockoutRoundFromFinished(
//         leagueSyncId: leagueSyncId,
//         finishedRoundSyncId: finishedRoundSyncId,
//       );
//       await syncService.enqueueOperation(
//         entityType: 'rounds',
//         operation: SyncService.operationCreate,
//         payload: {
//           'rounds': [
//             result!.toJson(),
//           ]
//         },
//       );
//       try {
//         await di.sl<SyncTrigger>().syncIfOnline();
//       } on DioException catch (e) {
//         throw SyncDioException.from(e);
//       }
//       return Right(result);
//     } on DioException catch (e) {
//       return Left(e);
//     }
//   }
//
//   Future<Either<DioException, Unit>> checkAndCreateNextKnockoutRoundIfNeeded({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//   }) async {
//     try {
//       await local.checkAndCreateNextKnockoutRoundIfNeeded(
//         leagueSyncId,
//         finishedRoundSyncId,
//       );
//       return const Right(unit);
//     } catch (e) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/rounds/next_knockout'),
//         error: e,
//       ));
//     }
//   }
//
//   Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
//     required String leagueSyncId,
//     required String matchFilter,
//   }) {
//     return local.watchLeagueRoundsWithMatchesKnockout(
//       leagueSyncId: leagueSyncId,
//       matchFilter: matchFilter,
//     );
//   }
//
//   Future<Either<DioException, void>> refreshLeagueRoundsMatchesKnockout(
//       {required String leagueSyncId,
//       required String matchFilter,
//       required String role}) async {
//     return RepoGuard.run<void>(action: () async {
//       final List<RoundModel> remoteRounds;
//       if (!await connectivity.isOnline()) return;
//       if (role == 'organizer') {
//         remoteRounds = await remote.getLeagueRoundsKnockout(
//           leagueSyncId,
//         );
//       } else {
//         remoteRounds =
//             await remote.getLeagueRoundsKnockoutRole(leagueSyncId, 'media');
//       }
//
//       final rounds = remoteRounds;
//       print('API rounds knoc=${rounds.length}');
//       //  print('first groups=${rounds.first.groups.length}');
//      // print('first matches knoc=${rounds.first.groups.first.matches.length}');
//
//       local.upsertRoundsWithMatchesLocal(rounds);
//
//       await di.sl<SyncTrigger>().syncIfOnline();
//     });
//   }
//
//   // Future<Either<DioException, List<RoundModel>>>
//   //     getAllKnockoutRoundsWithMatches(
//   //         String leagueSyncId, String matchFilter) async {
//   //   try {
//   //     final result = await local.getAllKnockoutRoundsWithMatches(
//   //         leagueSyncId, matchFilter);
//   //     if (await connectivity.isOnline()) {
//   //       final rounds = await remote.getLeagueRoundsKnockout(leagueSyncId);
//   //       print(rounds[0].roundName);
//   //       local.upsertRoundsWithMatchesLocal(rounds);
//   //       await di.sl<SyncTrigger>().syncIfOnline();
//   //     }
//   //
//   //     return Right(result);
//   //   } catch (e, st) {
//   //     print(e);
//   //     return Left(DioException(
//   //       requestOptions: RequestOptions(path: '/rounds/next_knockout'),
//   //       error: e,
//   //     ));
//   //   }
//   // }
//
//   Future<Either<DioException, RoundModel>> getCurrentLeagueRound(
//       String leagueSyncId) async {
//     try {
//       final result = await local.getCurrentLeagueRound(leagueSyncId);
//       return Right(result!);
//     } catch (e, st) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/rounds/next_knockout'),
//         error: e,
//       ));
//     }
//   }
//
//   Future<Either<DioException, bool>> checkAllGroupMatchesFinished({
//     required String leagueSyncId,
//   }) async {
//     try {
//       final finished = await local.areAllGroupMatchesFinished(leagueSyncId);
//       return Right(finished);
//     } catch (e, s) {
//       return Left(DioException(
//         stackTrace: s,
//         requestOptions: RequestOptions(path: '/groups/check-matches-finished'),
//         error: e,
//       ));
//     }
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../injection.dart' as di;

import '../../../match/data/model/round_model.dart';
import '../data_source/local_data_source/local_knockout_data_source.dart';
import '../data_source/remote_data_source/remote_data_source.dart';

// class KnockoutRepository {
//   final KnockoutGeneratorLocalDataSource local;
//   final ConnectivityService connectivity;
//   final SyncService syncService;
//   final MatchTermRemoteDataSource remote;
//
//   KnockoutRepository({
//     required this.local,
//     required this.remote,
//     required this.connectivity,
//     required this.syncService,
//   });
//
//   // ---------------------------------------------------------------------------
//   // ✅ NEW: Ensure progression (idempotent) - creates at most one round per call
//   // ---------------------------------------------------------------------------
//   Future<Either<DioException, RoundModel?>> ensureKnockoutProgresss({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//   }) async {
//     try {
//       final created = await local.ensureKnockoutProgress(
//         leagueSyncId: leagueSyncId,
//         qualifiedPerGroup: qualifiedPerGroup,
//       );
//
//       // لا يوجد شيء جديد
//       if (created == null) return const Right(null);
//
//       // enqueue round create (matches/terms تُزامن عندك عبر SyncService حسب تصميمك)
//       await syncService.enqueueOperation(
//         entityType: 'rounds',
//         operation: SyncService.operationCreate,
//         payload: {
//           'rounds': [created.toJson()]
//         },
//       );
//
//       try {
//         await di.sl<SyncTrigger>().syncIfOnline();
//       } on DioException catch (e) {
//         throw SyncDioException.from(e);
//       }
//
//       return Right(created);
//     } catch (e, st) {
//       return Left(
//         DioException(
//           requestOptions: RequestOptions(path: '/knockout/ensure_progress'),
//           error: e,
//           stackTrace: st,
//         ),
//       );
//     }
//   }
//   Future<Either<DioException, RoundModel?>> ensureKnockoutProgress({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//   }) async {
//     try {
//       // 1) current round
//       final current = await local.getCurrentLeagueRound(leagueSyncId);
//       if (current == null) return const Right(null);
//
//       // =======================
//       // GROUP => First Knockout
//       // =======================
//       if (current.roundType == 'group') {
//         final should = await local.shouldGenerateFirstKnockout(leagueSyncId);
//         if (!should) return const Right(null);
//
//         // ✅ استخدم repo method (فيها enqueue + sync)
//         final createdEither = await generateFirstKnockout(
//           leagueSyncId: leagueSyncId,
//           qualifiedPerGroup: qualifiedPerGroup,
//         );
//
//         return createdEither.map((r) => r);
//       }
//
//       // =======================
//       // KNOCKOUT => Next Knockout
//       // =======================
//       final finishedRoundSyncId =
//       await local.getLastFinishedKnockoutRoundSyncId(leagueSyncId);
//
//       if (finishedRoundSyncId == null) return const Right(null);
//
//       // هنا يعتمد على locks التي عندك في local (ممتاز)
//       // بس لازم نخلي إنشاء الجولة يتم عبر repo (enqueue + sync)
//       final nextEither = await generateNextKnockout(
//         leagueSyncId: leagueSyncId,
//         finishedRoundSyncId: finishedRoundSyncId,
//       );
//
//       return nextEither.map((r) => r);
//     } catch (e) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/knockout/ensure-progress'),
//         error: e,
//       ));
//     }
//   }
//   // ---------------------------------------------------------------------------
//   // your existing methods (unchanged)
//   // ---------------------------------------------------------------------------
//   Future<Either<DioException, RoundModel>> generateFirstKnockout({
//     required String leagueSyncId,
//     required int qualifiedPerGroup,
//   }) async {
//     try {
//       final result = await local.generateKnockoutFromGroups(
//         leagueSyncId: leagueSyncId,
//         qualifiedPerGroup: qualifiedPerGroup,
//       );
//
//       await syncService.enqueueOperation(
//         entityType: 'rounds',
//         operation: SyncService.operationCreate,
//         payload: {'rounds': [result.toJson()]},
//       );
//
//       try {
//         await di.sl<SyncTrigger>().syncIfOnline();
//       } on DioException catch (e) {
//         throw SyncDioException.from(e);
//       }
//
//       return Right(result);
//     } catch (e) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/knockout/first'),
//         error: e,
//       ));
//     }
//   }
//
//   Future<Either<DioException, RoundModel?>> generateNextKnockout({
//     required String leagueSyncId,
//     required String finishedRoundSyncId,
//   }) async {
//     try {
//       final result = await local.createNextKnockoutRoundFromFinished(
//         leagueSyncId: leagueSyncId,
//         finishedRoundSyncId: finishedRoundSyncId,
//       );
//
//       if (result == null) return const Right(null);
//
//       await syncService.enqueueOperation(
//         entityType: 'rounds',
//         operation: SyncService.operationCreate,
//         payload: {'rounds': [result.toJson()]},
//       );
//
//       try {
//         await di.sl<SyncTrigger>().syncIfOnline();
//       } on DioException catch (e) {
//         throw SyncDioException.from(e);
//       }
//
//       return Right(result);
//     } on DioException catch (e) {
//       return Left(e);
//     }
//   }
//   //
//   // Future<Either<DioException, Unit>> checkAndCreateNextKnockoutRoundIfNeeded({
//   //   required String leagueSyncId,
//   //   required String finishedRoundSyncId,
//   // }) async {
//   //   try {
//   //     await local.checkAndCreateNextKnockoutRoundIfNeeded(
//   //       leagueSyncId,
//   //       finishedRoundSyncId,
//   //     );
//   //     return const Right(unit);
//   //   } catch (e) {
//   //     return Left(DioException(
//   //       requestOptions: RequestOptions(path: '/rounds/next_knockout'),
//   //       error: e,
//   //     ));
//   //   }
//   // }
//
//   Stream<List<RoundModel>> watchLeagueRoundsWithMatchesKnockout({
//     required String leagueSyncId,
//     required String matchFilter,
//   }) {
//     return local.watchLeagueRoundsWithMatchesKnockout(
//       leagueSyncId: leagueSyncId,
//       matchFilter: matchFilter,
//     );
//   }
//
//   Future<Either<DioException, void>> refreshLeagueRoundsMatchesKnockout({
//     required String leagueSyncId,
//     required String matchFilter,
//     required String role,
//   }) async {
//     return RepoGuard.run<void>(action: () async {
//       final List<RoundModel> remoteRounds;
//       if (!await connectivity.isOnline()) return;
//
//       if (role == 'organizer') {
//         remoteRounds = await remote.getLeagueRoundsKnockout(leagueSyncId);
//       } else {
//         remoteRounds = await remote.getLeagueRoundsKnockoutRole(leagueSyncId, 'media');
//       }
//
//       local.upsertRoundsWithMatchesLocal(remoteRounds);
//       await di.sl<SyncTrigger>().syncIfOnline();
//     });
//   }
//
//   Future<Either<DioException, RoundModel>> getCurrentLeagueRound(
//       String leagueSyncId) async {
//     try {
//       final result = await local.getCurrentLeagueRound(leagueSyncId);
//       return Right(result!);
//     } catch (e) {
//       return Left(DioException(
//         requestOptions: RequestOptions(path: '/rounds/current'),
//         error: e,
//       ));
//     }
//   }

  // Future<Either<DioException, bool>> checkAllGroupMatchesFinished({
  //   required String leagueSyncId,
  // }) async {
  //   try {
  //     final finished = await local.areAllGroupMatchesFinished(leagueSyncId);
  //     return Right(finished);
  //   } catch (e, s) {
  //     return Left(DioException(
  //       stackTrace: s,
  //       requestOptions: RequestOptions(path: '/groups/check-matches-finished'),
  //       error: e,
  //     ));
  //   }
//   }
// }
// lib/features/knockout/data/knockout_repository.dart

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

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

      await _enqueueRoundCreate(created);

      // sync لا يكسر نتيجة local creation: إذا فشل sync ارجع created برضه
      await _syncIfOnlineSafely();

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

      if (created == null) return const Right(null);

      await _enqueueRoundCreate(created);
      await _syncIfOnlineSafely();

      return Right(created);
    } catch (e, st) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/knockout/next'),
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<void> _enqueueRoundCreate(RoundModel created) async {
    await syncService.enqueueOperation(
      entityType: 'rounds',
      operation: SyncService.operationCreate,
      payload: {'rounds': [created.toJson()]},
    );
  }

  Future<void> _syncIfOnlineSafely() async {
    // ملاحظة: عندك SyncTrigger بالـ DI
    if (!await connectivity.isOnline()) return;
    try {
      di.sl<SyncTrigger>().syncIfOnlineInBackground();
    } on DioException catch (e) {
      // لا نرميها هنا كي لا نكسر local creation
      // إن أردت: log فقط
      // throw SyncDioException.from(e);
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
          : await remote.getLeagueRoundsKnockoutRole(leagueSyncId, 'media');

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