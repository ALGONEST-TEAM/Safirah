import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/repo_guard.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../injection.dart' as di;
import '../../../match/data/model/match_model.dart';
import '../data_source/local_data_source/local_term_data_source.dart';
import '../model/assist_model.dart';
import '../model/goal_model.dart';
import '../model/match_term_model.dart';
import '../model/player_stats.dart';
import '../model/terms_model.dart';
import '../model/warring_model.dart';

class MatchTermsEventRepository {
  final MatchTermsEventLocalDataSource local;
  final ConnectivityService connectivity;
  final SyncService syncService;
  MatchTermsEventRepository({required this.local,required this.connectivity,required this.syncService});

  Future<Either<DioException, List<TermModel>>> getAllTerms() async {
    try {
      final result = await local.getAllTerms();
      return Right(result);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/terms'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, MatchModel>> getFullMatchData(String matchSyncId) async {
    try {
      final result = await local.getFullMatchData(matchSyncId);
      return Right(result!);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/terms'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, MatchTermModel>> getCurrentMatchTerm(
      String matchSyncId) async {
    try {
      final result = await local.getCurrentMatchTerm(matchSyncId);
      return Right(result);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/terms'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> initLeagueTerms({
    required String leagueSyncId,
    required List<String> selectedTermIds,
    required int durationMinutes,
  }) async {
      return RepoGuard.run<Unit>(
        action: () async {
          final leagueTerm = await local.initLeagueTerms(
            leagueSyncId: leagueSyncId,
            selectedTermIds: List<String>.from(selectedTermIds),
            durationMinutes: durationMinutes,
          );
          await syncService.enqueueOperation(
            entityType: 'leagueTerm',
            operation: SyncService.operationCreate,
            payload: {
              'league_sync_id': leagueSyncId,
              'terms': leagueTerm.map((d) => d.toJson()).toList(),
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

  Future<Either<DioException, int>> getTermDurationByMatchTermId(
      int matchTermId) async {
    try {
      final duration = await local.getTermDurationByMatchTermId(matchTermId);
      if (duration == null) {
        return Left(DioException(
          error: "No duration found for matchTermId $matchTermId",
          requestOptions:
              RequestOptions(path: '/league-terms/get-duration/$matchTermId'),
        ));
      }
      return Right(duration);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions:
            RequestOptions(path: '/league-terms/get-duration/$matchTermId'),
      ));
    }
  }

  Future<Either<DioException, Unit>> updateAdditionalMinutes(
    int termId,
    int additionalMinutes,
  ) async {
    try {
      await local.updateAdditionalMinutes(termId, additionalMinutes);
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions: RequestOptions(
            path: '/match-terms/update-additional-minutes/$termId'),
      ));
    }
  }

  Future<Either<DioException, Unit>> startTermSafe(
    String matchSyncId,
    int idMatchTerm,
  ) async {
    try {
      await local.startTermSafe(matchSyncId, idMatchTerm);
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions:
            RequestOptions(path: '/match-terms/start-next-safe/$matchSyncId'),
      ));
    }
  }

  Future<Either<DioException, Unit>> finishCurrentTerm({
    required String matchSyncId,
    required int termId,
  }) async {
    return RepoGuard.run<Unit>(action: () async {
      // 1) محلي
      final result = await local.finishTermSmart(
        matchSyncId: matchSyncId,
        termId: termId,
      );

      // 2) مزامنة الشوط دائماً (API المباراة/الشوط واحد)
      await syncService.enqueueOperation(
        entityType: 'match',
        operation: SyncService.operationUpdate,
        payload: {
          'match_sync_id': matchSyncId,
          'league_sync_id': result.leagueSyncId,
          'match_terms':
            [
              {
                'sync_id': result.matchTermSyncId,
                'league_term_sync_id': result.leagueTermSyncId,
                'start_time': result.matchEndTime?.toIso8601String(),
                'end_time': result.matchEndTime?.toIso8601String(),
                'additional_minutes':0,
                'is_finished': true,
              }
            ]

        },
      );

      // 3) إذا انتهت المباراة: مزامنة المباراة
      if (result.matchFinished) {
        await syncService.enqueueOperation(
          entityType: 'match',
          operation: SyncService.operationUpdate,
          payload: {
            'league_sync_id': result.leagueSyncId,
            'match_sync_id': matchSyncId,
            'status': 'finished',
            'end_time': result.matchEndTime?.toIso8601String(),
            'home_score': result.homeScore,
            'away_score': result.awayScore,
          },
        );

       // 4) إذا تم تحديث النقاط محلياً (غير knockout) -> استخدم API النقاط الآخر
        if (!result.isKnockout && result.pointsUpdatedLocally) {
          final res = await local.finishMatchAndUpdatePoints(matchSyncId, DateTime.now());
          print(res.home?.points);
          print(res.away?.points);
          await syncService.enqueueOperation(
            entityType: 'qualifiedTeam',
            operation: SyncService.operationUpdate,
            payload:
              res.home!.toJson(),
          );
          await syncService.enqueueOperation(
            entityType: 'qualifiedTeam',
            operation: SyncService.operationUpdate,
            payload:
            res.away!.toJson(),
          );
        }
      }

      // 5) حاول مزامنة فورية
      di.sl<SyncTrigger>().syncIfOnlineInBackground();

      return unit;
    });
  }

  Future<Either<DioException, GoalModel>> addGoal(GoalModel goal) async {
    try {
      final goals = await local.insertGoalAndUpdateQualifiedTeams(goal);
      await syncService.enqueueOperation(
        entityType: 'goal',
        operation: SyncService.operationCreate,
        payload: goal.toJson()
      );
      di.sl<SyncTrigger>().syncIfOnlineInBackground();

      return Right(goals);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/match-events/add-goal'),
          error: e,
        ),
      );
    }
  }

  Future<Either<DioException, WarningModel>> addWarning(
      WarningModel warning) async {
    try {
      final waring = await local.insertWarning(warning);
      await syncService.enqueueOperation(
          entityType: 'warning',
          operation: SyncService.operationCreate,
          payload: waring.toJson()
      );
      di.sl<SyncTrigger>().syncIfOnlineInBackground();

      return Right(waring);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/warnings/add'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, String?>> deleteGoal(int goalId) async {
    try {
      final assistPlayer = await local.deleteGoal(goalId);
      await syncService.enqueueOperation(
          entityType: 'goal',
          operation: SyncService.operationUpdate,
          payload:{
            'goal_sync_id':assistPlayer
          }
      );
      // ignore: avoid_print
      di.sl<SyncTrigger>().syncIfOnlineInBackground();

      print(assistPlayer);
      return Right(assistPlayer);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/goals/delete'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> deleteWarning(int warningId) async {
    try {
      await local.deleteWarning(warningId);
      // await syncService.enqueueOperation(
      //     entityType: 'goal',
      //     operation: SyncService.operationUpdate,
      //     payload:{
      //       'goal_sync_id':assistPlayer
      //     }
      // );
      return const Right(unit);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/warnings/delete'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, AssistModel>> addAssist(
      AssistModel assist) async {
    try {
      final result = await local.addAssist(assist);
      await syncService.enqueueOperation(
          entityType: 'assist',
          operation: SyncService.operationCreate,
          payload: assist.toJson()
      );
      di.sl<SyncTrigger>().syncIfOnlineInBackground();
      return Right(result);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/match-events/add-assist'),
          error: e,
        ),
      );
    }
  }

  Future<Either<DioException, PlayerStats>> getPlayerStats({
    required String matchSyncId,
    required String playerSyncId,
  }) async {
    try {
      final stats = await local.getPlayerStats(
          matchSyncId: matchSyncId, playerSyncId: playerSyncId);
      return Right(stats);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/player/stats'),
          error: e,
        ),
      );
    }
  }

  /// استبدال لاعب (خارج/داخل)
  Future<Either<DioException, Unit>> substitutePlayer({
    required String matchSyncId,
    required String matchTermSyncId,
    required String outgoingPlayerSyncId,
    required String incomingPlayerSyncId,
    required int substitutionMinute,
  }) async {
    try {
      final result = await local.substitutePlayer(
        matchSyncId: matchSyncId,
        matchTermSyncId: matchTermSyncId,
        outgoingPlayerSyncId: outgoingPlayerSyncId,
        incomingPlayerSyncId: incomingPlayerSyncId,
        substitutionMinute: substitutionMinute,
      );
      return Right(result);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/player/substitute'),
          error: e,
        ),
      );
    }
  }

  Future<Either<DioException, String?>> getPlayerParticipationStatus({
    required String matchSyncId,
    required String matchTermSyncId,
    required String playerSyncId,
  }) async {
    try {
      final status = await local.getPlayerParticipationStatus(
        matchSyncId: matchSyncId,
        matchTermSyncId: matchTermSyncId,
        playerSyncId: playerSyncId,
      );
      return Right(status);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/player/participation-status'),
          error: e,
        ),
      );
    }
  }

  Future<Either<DioException, Unit>> initStartersForMatchTerm({
    required String matchSyncId,
    required String matchTermSyncId,
  }) async {
    try {
      await local.initMatchTermParticipation(
        matchSyncId: matchSyncId,
        matchTermSyncId: matchTermSyncId,
      );
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions: RequestOptions(path: '/match/starters/init'),
      ));
    }
  }

  Future<Either<DioException, String?>> deleteGoalBySyncId(String goalSyncId) async {
    try {
      final assistPlayer = await local.deleteGoalBySyncId(goalSyncId);
      return Right(assistPlayer);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/goals/delete-by-sync/$goalSyncId'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> deleteWarningBySyncId(String warningSyncId) async {
    try {
      await local.deleteWarningBySyncId(warningSyncId);
      return const Right(unit);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/warnings/delete-by-sync/$warningSyncId'),
        error: e,
      ));
    }
  }
}
