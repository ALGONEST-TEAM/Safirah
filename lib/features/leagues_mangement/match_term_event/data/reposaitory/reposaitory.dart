import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

  MatchTermsEventRepository({required this.local});

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

  Future<Either<DioException, MatchModel>> getFullMatchData(int matchId) async {
    try {
      final result = await local.getFullMatchData(matchId);
      return Right(result!);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/terms'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, MatchTermModel>> getCurrentMatchTerm(
      int matchId) async {
    try {
      final result = await local.getCurrentMatchTerm(matchId);
      return Right(result);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/terms'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, Unit>> initLeagueTerms({
    required int leagueId,
    required List<int> selectedTermIds,
    required int durationMinutes,
  }) async {
    try {
      await local.initLeagueTerms(
        leagueId: leagueId,
        selectedTermIds: selectedTermIds,
        durationMinutes: durationMinutes,
      );
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions: RequestOptions(path: '/league-terms/init'),
      ));
    }
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


  Future<Either<DioException, Unit>> updateAdditionalMinutes(int termId,
      int additionalMinutes) async {
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

  Future<Either<DioException, Unit>> startTermSafe(int matchId,
      int idMatchTerm) async {
    try {
      await local.startTermSafe(matchId, idMatchTerm);
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions:
        RequestOptions(path: '/match-terms/start-next-safe/$matchId'),
      ));
    }
  }

  Future<Either<DioException, Unit>> finishCurrentTerm(int matchId,
      int termId) async {
    try {
      await local.finishTermSmart(matchId: matchId, termId: termId);
      return const Right(unit);
    } catch (e, s) {
      return Left(DioException(
        error: e,
        stackTrace: s,
        requestOptions: RequestOptions(path: '/match-terms/finish-current'),
      ));
    }
  }

  Future<Either<DioException, GoalModel>> addGoal(GoalModel goal) async {
    try {
      final goals = await local.insertGoalAndUpdateQualifiedTeams(goal);
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
      return Right(waring);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/warnings/add'),
        error: e,
      ));
    }
  }

  Future<Either<DioException, int?>> deleteGoal(int goalId) async {
    try {
      final assistPlayer = await local.deleteGoal(goalId);
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
    required int matchId,
    required int playerId,
  }) async {
    try {
      final stats =
      await local.getPlayerStats(matchId: matchId, playerId: playerId);
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

// dart

  /// استبدال لاعب (خارج/داخل) في مباراة وشوط محدد
  Future<Either<DioException, Unit>> substitutePlayer({
    required int matchId,
    required int matchTermId,
    required int outgoingPlayerId,
    required int incomingPlayerId,
    required int substitutionMinute,
  }) async {
    try {
      final result = await local.substitutePlayer(
        matchId: matchId,
        matchTermId: matchTermId,
        outgoingPlayerId: outgoingPlayerId,
        incomingPlayerId: incomingPlayerId,
        substitutionMinute: substitutionMinute,
      );
      return Right(result);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/player/stats'),
          error: e,
        ),
      );
    }
  }

  Future<Either<DioException, String?>> getPlayerParticipationStatus({
    required int matchId,
    required int matchTermId,
    required int playerId,
  }) async {
    try {
      final status = await local.getPlayerParticipationStatus(
        matchId: matchId,
        matchTermId: matchTermId,
        playerId: playerId,
      );
      return Right(status);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: '/player/stats'),
          error: e,
        ),
      );
    }
  }
  Future<Either<DioException, Unit>> initStartersForMatchTerm({
    required int matchId,
    required int matchTermId,
  }) async {
    try {
      await local.initStartersForMatchTerm(
        matchId: matchId,
        matchTermId: matchTermId,
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

}
