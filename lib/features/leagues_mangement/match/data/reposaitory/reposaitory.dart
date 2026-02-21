import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../injection.dart' as di;
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source/remote_data_source.dart';
import '../model/round_model.dart';

class MatchesRepository {
  final MatchesLocalDataSource local;
  final ConnectivityService connectivity;
  final SyncService syncService;
  final MatchRemoteDataSource remote;

  MatchesRepository(
      {required this.local,
      required this.connectivity,
      required this.syncService,
      required this.remote});

  Future<Either<DioException, Unit>> ensureGroupRounds(
      String leagueSyncId) async {
    try {
      final rounds = await local.ensureGroupRounds(leagueSyncId: leagueSyncId);
      await syncService.enqueueOperation(
        entityType: 'rounds',
        operation: SyncService.operationCreate,
        payload: {
          'rounds': rounds.map((r) => r.toJson()).toList(),
        },
      );
      try {
        di.sl<SyncTrigger>().syncIfOnlineInBackground();
      } on DioException catch (e) {
        throw SyncDioException.from(e);
      }
      return Right(unit);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> scheduleGroupStageMatchesRR(
      String leagueSyncId) async {
    return RepoGuard.run<Unit>(
      action: () async {
        final matches =
            await local.scheduleGroupStageMatchesRR(leagueSyncId: leagueSyncId);
        await syncService.enqueueOperation(
          entityType: 'match',
          operation: SyncService.operationCreate,
          payload: {
            'matches': matches.map((d) => d.toJson()).toList(),
          },
        );

        try {
          di.sl<SyncTrigger>().syncIfOnlineInBackground();
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }
        return unit;
      },
    );
  }

  Stream<List<RoundModel>> watchLeagueRoundsWithGroupsAndMatches({
    required String leagueSyncId,
    required String matchFilter,
  }) {
    return local.watchLeagueRoundsWithGroupsAndMatches(
      leagueSyncId: leagueSyncId,
      matchFilter: matchFilter,
    );
  }

  Future<Either<DioException, void>> refreshLeagueRoundsWithGroupsAndMatches({
    required String leagueSyncId,
    required String matchFilter,
    required String role

  }) async {
    return RepoGuard.run<void>(action: () async {
      final List<RoundModel> remoteRounds;
      if (!await connectivity.isOnline()) return;
      if(role == 'organizer'){
         remoteRounds = await remote.getLeagueRounds(
          leagueSyncId,
        );
      }else{
        remoteRounds = await remote.getLeagueRoundsRole(
          leagueSyncId,
          'media'
        );
      }

      final rounds = remoteRounds;
      print('API rounds=${rounds.length}');
      print('first groups=${rounds.first.groups.length}');
      print('first matches=${rounds.first.groups.first.matches.length}');

      await local.upsertLeagueRoundsFromApiOneResponse(
        leagueSyncId: leagueSyncId,
        apiRounds: remoteRounds,
      );
      di.sl<SyncTrigger>().syncIfOnlineInBackground();
    });
  }

  Future<Either<DioException, Unit>> scheduleMatch({
    required String matchSyncId,
    required DateTime scheduledDateTime,
    required String refereeSyncId,
    required String mediaSyncId,
  }) async {
    return RepoGuard.run<Unit>(
      action: () async {
        final matches = await local.scheduleMatch(
          matchSyncId: matchSyncId,
          scheduledDateTime: scheduledDateTime,
          refereeSyncId: refereeSyncId,
          mediaSyncId: mediaSyncId,
        );
   //     print("jjh" + matches.mediaSyncId!);
        await syncService.enqueueOperation(
          entityType: 'match',
          operation: SyncService.operationUpdate,
          payload: matches.toJson(),
        );

        try {
          di.sl<SyncTrigger>().syncIfOnlineInBackground();
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }
        return unit;
      },
    );
  }
}
