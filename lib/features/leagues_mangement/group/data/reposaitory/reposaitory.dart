import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/local_data_source.dart';
import '../model/model.dart';

typedef GroupWithQt = (GroupModel, List<QualifiedTeamModel>);

class GroupsRepository {
  final GroupsLocalDataSource local;

  GroupsRepository({required this.local});

  Future<Either<DioException, Unit>> draw({
    required int leagueId,
    required int groupsCount,
    required int qualifiedPerGroup,

    bool clearExisting = true,
    bool useLetters = true,
  }) async {
    try {
      await local.drawGroupsByCount(
        leagueId: leagueId,
        groupsCount: groupsCount,
        clearExisting: clearExisting,
        qualifiedPerGroup: qualifiedPerGroup,
        useLetters: useLetters,
      );
      return const Right(unit);
    } on DioException catch (erorr) {
      return Left(erorr);
    }
  }

  Future<Either<DioException, List<GroupWithQt>>>
      getLeagueGroupsWithQualifiedTeams(int leagueId) async {
    try {
      final list = await local.getLeagueGroupsWithQualifiedTeams(leagueId);
      return Right(list);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioException(
        requestOptions:
            RequestOptions(path: '/groups/$leagueId/qualified-teams'),
        error: e,
      ));
    }
  }

 }
// Future<Either<DioException, T>> _guard<T>(
//   Future<T> Function() call,
// ) async {
//   try {
//     final result = await call();
//     return Right(result);
//   } on DioException catch (e) {
//     return Left(e);
//   }
// }
