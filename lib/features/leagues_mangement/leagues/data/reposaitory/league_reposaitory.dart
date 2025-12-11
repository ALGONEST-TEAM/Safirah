import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../../../../core/database/safirah_database.dart';
import '../data_source/local_data_source.dart';
import '../model/league_model.dart';
import '../model/league_status_model.dart';
import '../model/rule_league_model.dart';

class LeagueRepository {
  final LeagueLocalDataSource local; // final LeagueRemoteDataSource remote;

  LeagueRepository({
    required this.local,
  });

  /// جلب الدوريات: نحاول Remote وبعدها نخزّن محليًا، وإلا نFallback للمحلي
  Future<Either<DioException, List<LeagueModel>>> getLeagues(
      {bool refresh = true}) async {
    try {
      if (refresh) {
        final cached = await local.getAllLeagues();

        // final remoteLeagues = await remote.fetchRemoteLeagues();
        // تخزين محلي (بسيط: نحذف القديم ونضيف الجديد - عدّلها لاحقًا حسب حاجتك)
        // final old = await local.getAllLeagues();
        // await local.replaceAllLeagues(remoteLeagues);
        //
        return Right(cached.map(LeagueModel.fromEntity).toList());
      } else {
        final cached = await local.getAllLeagues();
        return Right(cached.map(LeagueModel.fromEntity).toList());
      }
    } on DioException catch (e) {
      final cached = await local.getAllLeagues();
      if (cached.isNotEmpty) {
        return Right(cached.map(LeagueModel.fromEntity).toList());
      }
      return Left(e);
    }
  }

  /// إنشاء دوري: نحفظ محليًا + نضيفه لطابور المزامنة (create)
  // Future<Either<DioException, int>> createLeagueLocal(LeagueModel model) async {
  //   try {
  //     final id = await local!.insertLeague(model.toCompanion());
  //     await local!.enqueueCreate(model.copyWith(id: id));
  //     return Right(id);
  //   } on DioException catch (e) {
  //     print(e.response);
  //     return Left(e);
  //   } catch (_) {
  //     return Left(
  //         DioException(requestOptions: RequestOptions(path: '/leagues')));
  //   }
  // }
// league_repository.dart
  Future<Either<DioException, int>> createLeague(LeagueModel model) async {
    try {
      final leagueId = await local.insertLeague(model.toCompanion());

      // بذر غير قاتل: لو فشل لا يفشل إنشاء الدوري
      try {
        await local.createTeamsAndCatOnLeagueCreate(
          leagueId: leagueId,
          maxMainPlayers: model.maxMainPlayers ?? 0,
          maxSubPlayers: model.maxSubPlayers ?? 0,
          maxTeams: model.maxTeams ?? 0,
        );
        await local.seedDummyLeaguePlayers(leagueId: leagueId);
      } catch (e, st) {
        // سجل فقط
        // ignore: avoid_print
        print('seedOnLeagueCreate error: $e\n$st');
      }

      return Right(leagueId);
    } catch (e, st) {
      // ignore: avoid_print
      print('createLeagueLocal error: $e\n$st');
      return Left(DioException(requestOptions: RequestOptions(path: '/leagues'), error: e.toString()));
    }
  }


  /// حذف دوري محليًا + Enqueue
  Future<Either<DioException, int>> deleteLeagueLocal(int id) async {
    try {
      final count = await local.deleteLeague(id);
      return Right(count);
    } on DioException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
          DioException(requestOptions: RequestOptions(path: '/leagues')));
    }
  }

Future<Either<DioException, int>> addRule(LeagueRuleModel companion,int idLeague) async {
  try {
    final id = await local.insertRule(companion.toCompanion(idLeague));
    return Right(id);
  } on DioException catch (e) {
    return Left(e);
  } catch (e) {
    return Left(
      DioException(requestOptions: RequestOptions(path: '/league_rule')),
    );
  }
}

/// جلب القواعد الخاصة بدوري
Future<Either<DioException, List<LeagueRule>>> getRulesByLeague(int leagueId) async {
  try {
    final rules = await local.getRulesByLeague(leagueId);
    return Right(rules);
  } on DioException catch (e) {
    return Left(e);
  } catch (_) {
    return Left(
      DioException(requestOptions: RequestOptions(path: '/league_rule')),
    );
  }
}

/// حذف قاعدة
Future<Either<DioException, int>> deleteRule(int id) async {
  try {
    final deletedCount = await local.deleteRule(id);
    return Right(deletedCount);
  } on DioException catch (e) {
    return Left(e);
  } catch (_) {
    return Left(
      DioException(requestOptions: RequestOptions(path: '/league_rule')),
    );
  }
}

  Future<Either<DioException, Unit>> replaceRulesForLeague(
      int leagueId, List<LeagueRuleModel> rules) async {
    try {
      // نحذف القواعد القديمة
      await local.deleteRule(leagueId);

      // ندخل القواعد الجديدة
      await local.insertRules(
        rules.map((r) => r.toCompanion(leagueId)).toList(),
      );

      return right(unit); // نجاح
    } on DioException catch (e) {
      return left(e); // خطأ من نوع Dio
    } catch (e) {
      return left(DioException(
        requestOptions: RequestOptions(path: '/leagueRules'),
        error: e.toString(),
      ));
    }
  }

  Future<Either<DioException, List<LeagueModel>>> getLeaguesByPrivacy({
    required bool isPrivate,
  }) async {
    try {
      final r = await local.getLeaguesByPrivacy(isPrivate: isPrivate);
      return Right(r);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/leagues/byPrivacy'),
        error: e,
      ));
    }
  }
  Future<Either<DioException,LeagueModel>> getLeague({
    required int idLeague,
  }) async {
    try {
      final r = await local.getLeagueById(idLeague);
      return Right(r);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/leagues/byPrivacy'),
        error: e,
      ));
    }
  }
  Future<Either<DioException, Unit>> updateLeagueStatus({
    required int leagueId,
    bool? hasGroups,
    bool? hasTeamsInGroups,
    bool? hasMatches,
    bool? hasPlayersAssigned,
  }) async {
    try {
      await local.updateLeagueStatus(
        leagueId: leagueId,
        hasGroups: hasGroups,
        hasTeamsInGroups: hasTeamsInGroups,
        hasMatches: hasMatches,
        hasPlayersAssigned: hasPlayersAssigned,
      );
      return const Right(unit);
    }on DioException catch(e) {
      print('❌ [Repo] Failed to update league status: $e');
      return Left(e);
    }
  }

  Future<Either<DioException, LeagueStatusModel>> getStatus(int leagueId) async {
    try {
      final status = await local.getLeagueStatus(leagueId);
      return Right(status);
    } catch (e) {
      return Left(DioException(
        requestOptions: RequestOptions(path: '/league/status'),
        error: e,
      ));
    }
  }
}
