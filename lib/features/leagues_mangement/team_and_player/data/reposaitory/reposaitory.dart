import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/database/sync_service.dart';
import '../../../../../core/database/sync_trigger.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/network/errors/sync_dio_exception.dart';
import '../../../../../injection.dart' as di;
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source/remote_data_source.dart';
import '../model/team_model.dart';
import '../../../../../core/network/errors/repo_guard.dart';

class TeamAndPlayerRepository {
  final TeamAndPlayerLocalDataSource local;
  final TeamAndPlayerRemoteDataSource remote;
  final ConnectivityService connectivity;
  final SyncService syncService;

  TeamAndPlayerRepository({
    required this.local,
    required this.remote,
    required this.connectivity,
    required this.syncService,
  });

  Future<Either<DioException, List<TeamModel>>> getTeamsByLeague(
      String leagueSyncId) {
    return RepoGuard.run<List<TeamModel>>(
      action: () => local.getTeamsByLeague(leagueSyncId),
    );
  }

  Future<Either<DioException, List<PlayerModel>>> getPlayersOfTeam(
      String teamSyncId) {
    return RepoGuard.run<List<PlayerModel>>(
      action: () => local.getPlayerTeam(teamSyncId: teamSyncId),
    );
  }

  Future<Either<DioException, Unit>> updateTeam(TeamModel team) {
    return RepoGuard.run<Unit>(
      action: () async {
       final teams =  await   local.updateTeam(team);
         print(team.syncId);
        await syncService.enqueueOperation(
          entityType: 'team',
          operation: SyncService.operationUpdate,
          payload: {
           'team_sync_id': teams!.syncId,
            'team_name': teams.teamName,
          },
        );

        try {
          await di.sl<SyncTrigger>().syncIfOnline();
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }
        return unit;
      },
    );

  }


  Stream<List<LeaguePlayerModel>> watchLeaguePlayer({
    required String leagueSyncId,
  }) {
    return local.watchLeaguesPlayer(
      leagueSyncId: leagueSyncId,
    );
  }
  Future<Either<DioException, void>> refreshLeaguePlayer({
    required String leagueSyncId,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;

      final remoteRounds = await remote.getLeaguePlayers(
       leagueSyncId:  leagueSyncId,

      );

      final normalized = remoteRounds
          .map((r) => r.copyWith(leagueSyncId: leagueSyncId))
          .toList();

      await local.upsertLeaguePlayers(normalized);
      await di.sl<SyncTrigger>().syncIfOnline();
    });
  }

  Stream<List<TeamModel>> watchTeams({
    required String leagueSyncId,
  }) {
    return local.watchTeams(
      leagueSyncId: leagueSyncId,
    );
  }
  Future<Either<DioException, void>> refreshTeams({
    required String leagueSyncId,
  }) async {
    return RepoGuard.run<void>(action: () async {
      if (!await connectivity.isOnline()) return;

      final teamRemote = await remote.getTeams(
        leagueSyncId:  leagueSyncId,

      );

      final normalized = teamRemote
          .map((r) => r.copyWith(leagueSyncId: leagueSyncId))
          .toList();

      print(normalized[0].player);
      await local.upsertTeams(normalized);

      await di.sl<SyncTrigger>().syncIfOnline();
    });
  }


  Future<Either<DioException, List<TeamPlayerCategoryModel>>>
      getCategoriesByLeague(String leagueSyncId) {
    return RepoGuard.run<List<TeamPlayerCategoryModel>>(
      action: () => local.getCategoriesByLeague(leagueSyncId),
    );
  }

  Future<Either<DioException, List<InvitationsPlayersModel>>>
      getLeagueInvitationsPlayers(String leagueSyncId) {
    return RepoGuard.run<List<InvitationsPlayersModel>>(
      action: () =>
          remote.getLeagueInvitationsPlayers(leagueSyncId: leagueSyncId),
    );
  }

  Future<Either<DioException, bool>> setLeaguePlayerCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) {
    return RepoGuard.run<bool>(
      action: () async {
        final updated = await local.setLeaguePlayerCategory(
          leaguePlayerId: leaguePlayerId,
          categoryId: categoryId,
        );
        return updated > 0;
      },
    );
  }

  Future<Either<DioException, bool>> deleteLeaguePlayerCategory({
    required int leaguePlayerId,
    required int categoryId,
  }) {
    return RepoGuard.run<bool>(
      action: () async {
        final updated = await local.deleteLeaguePlayerCategory(
          leaguePlayerId: leaguePlayerId,
          categoryId: categoryId,
        );
        return updated > 0;
      },
    );
  }

  Future<Either<DioException, List<LeaguePlayerModel>>>
      getLeaguePlayersByCategory({
    required String leagueSyncId,
    required int categoryId,
  }) {
    return RepoGuard.run<List<LeaguePlayerModel>>(
      action: () => local.getLeaguePlayersByCategory(
        leagueSyncId: leagueSyncId,
        categoryId: categoryId,
      ),
    );
  }

  Future<Either<DioException, List<PlayerModel>>> runDraft(
      String leagueSyncId) {
      return RepoGuard.run<List<PlayerModel>>(
        action: () async {
          final player = await local.runDraft(leagueSyncId: leagueSyncId);

          await syncService.enqueueOperation(
            entityType: 'playerToTeam',
            operation: SyncService.operationCreate,
            payload: {
              'players': player.map((p) => p.toJson()).toList(),
            },
          );

          try {
            await di.sl<SyncTrigger>().syncIfOnline();
          } on DioException catch (e) {
            throw SyncDioException.from(e);
          }
          return player;
        },
      );
  }

  Future<Either<DioException, List<PlayerModel>>> assignPlayersToTeam({
    required String teamSyncId,
    required List<String> leaguePlayerIds,
  }) {
    return RepoGuard.run<List<PlayerModel>>(
      action: () async {
        final player = await local.assignPlayersToTeam(
          teamSyncId: teamSyncId,
          leaguePlayerSyncIds: leaguePlayerIds,
        );
        await syncService.enqueueOperation(
          entityType: 'playerToTeam',
          operation: SyncService.operationCreate,
          payload: {
            'players': player.map((p) => p.toJson()).toList(),
          },
        );
        try {
          await di.sl<SyncTrigger>().syncIfOnline();
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }
        return player;
      },
    );
  }

  Future<Either<DioException, List<LeaguePlayerModel>>>
      leaguePlayersWithoutCategory(String leagueSyncId) {
    return RepoGuard.run<List<LeaguePlayerModel>>(
      action: () => local.leaguePlayersWithoutCategory(leagueSyncId),
    );
  }

  Future<Either<DioException, List<LeaguePlayerModel>>>
      leaguePlayersWithoutTeam(String leagueSyncId) {
    return RepoGuard.run<List<LeaguePlayerModel>>(
      action: () => local.leaguePlayersWithoutTeam(leagueSyncId),
    );
  }

  Future<Either<DioException, Unit>> addLeaguePlayer(
      InvitationsPlayersModel leagueInvitationPlayer) {
    return RepoGuard.run<Unit>(
      allowSyncErrorsToBubble: true,
      action: () async {
        final leaguePlayerSyncId = const Uuid().v7();
        print(
            'addLeaguePlayer called for invitation ${leagueInvitationPlayer.id} '
            'with syncId $leaguePlayerSyncId');

        await local.addLeaguePlayer(
          LeaguePlayerModel(
            idInvitation: leagueInvitationPlayer.id,
            syncId: leaguePlayerSyncId,
            leagueSyncId: leagueInvitationPlayer.leagueSyncId,
            name: leagueInvitationPlayer.userName,
          ),
        );

        print('Local league player inserted with syncId $leaguePlayerSyncId');

        await syncService.enqueueOperation(
          entityType: 'invitations',
          operation: SyncService.operationCreate,
          payload: {
            'action': leagueInvitationPlayer.action,
            'sync_id': leaguePlayerSyncId,
            'invitation_id': leagueInvitationPlayer.id,
            'league_player_sync_id': leaguePlayerSyncId,
          },
        );

        print(
            'Enqueued sync operation for leaguePlayerSyncId $leaguePlayerSyncId');

        try {
          await di.sl<SyncTrigger>().syncIfOnline();
          print('Sync finished successfully');
        } on DioException catch (e) {
          throw SyncDioException.from(e);
        }

        return unit;
      },
    );
  }
  Future<Either<DioException, LeaguePlayerStatsModel>>
  getLeaguePlayersStatistics(String leagueSyncId) {
    return RepoGuard.run<LeaguePlayerStatsModel>(
      action: () =>
          remote.getLeaguePlayersStatistics(leagueSyncId: leagueSyncId),
    );
  }

}
