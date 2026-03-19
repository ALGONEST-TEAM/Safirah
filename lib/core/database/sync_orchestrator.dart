import 'package:safirah/core/database/sync_service.dart';

import '../network/urls.dart';

class SyncOrchestrator {
  final SyncService _syncService;

  const SyncOrchestrator(this._syncService);

  Future<void> syncAll({bool throwOnFirstError = false}) async {
    await _syncService.syncPendingOperations(
      entityEndpointResolver: defaultEntityEndpointResolver,
      throwOnFirstError: throwOnFirstError,
    );
  }
}

/// Resolver افتراضي لنقاط النهاية الخاصة بالمزامنة.
/// عدِّل المسارات (`path`) لتطابق API الحقيقي عندك.
Future<EntitySyncEndpoint> defaultEntityEndpointResolver(
  String entityType,
  String operation,
) async {
  switch (entityType) {
    case 'league':
      return _resolveLeagueEndpoint(operation);
    case 'invitations':
      return _resolveTeamAndPlayerEndpoint(operation);
    case 'playerToTeam':
      return _resolvePlayerToTeamEndpoint(operation);
    case 'drawGroups':
      return _resolveDrawGroupEndpoint(operation);
    case 'rounds':
      return _resolveRoundsEndpoint(operation);
    case 'leagueTerm':
      return _resolveLeagueTermEndpoint(operation);
    case 'match':
      return _resolveMatchEndpoint(operation);
    case 'team':
      return _resolveTeamEndpoint(operation);
    case 'leagueStatus':
      return _resolveLeagueStatusEndpoint(operation);
    case 'qualifiedTeam':
      return _resolveQualifiedTeamEndpoint(operation);
    case 'goal':
      return _resolveGoalEndpoint(operation);
    case 'assist':
      return _resolveAssistEndpoint(operation);
    case 'warning':
      return _resolveWarningEndpoint(operation);
    case 'rule':
      return _resolveRuleEndpoint(operation);
    default:
      throw UnsupportedError('Unknown entityType: $entityType');
  }
}

EntitySyncEndpoint _resolveLeagueEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/leagues',
        // POST لإنشاء دوري جديد
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }}

  EntitySyncEndpoint _resolveGoalEndpoint(String operation) {
    switch (operation) {
      case SyncService.operationCreate:
        return EntitySyncEndpoint(
          path: '${AppURL.baseURL}/league-application/goals',
          // POST لإنشاء دوري جديد
          method: HttpMethod.post,
        );
      case SyncService.operationUpdate:
        return EntitySyncEndpoint(
          path: '${AppURL.baseURL}/league-application/goals/cancel',
          method: HttpMethod.put,
        );
      default:
        throw UnsupportedError('Unknown operation for league: $operation');
    }
  }
EntitySyncEndpoint _resolveAssistEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/assists',
        // POST لإنشاء دوري جديد
        method: HttpMethod.post,
      );
    case SyncService.operationUpdate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/assists/cancel',
        method: HttpMethod.put,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}
EntitySyncEndpoint _resolveWarningEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/warnings',
        // POST لإنشاء دوري جديد
        method: HttpMethod.post,
      );
    case SyncService.operationUpdate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/warnings/cancel',
        method: HttpMethod.put,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}
EntitySyncEndpoint _resolvePlayerToTeamEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/players',
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}

EntitySyncEndpoint _resolveRuleEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/league-rules',
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}
EntitySyncEndpoint _resolveLeagueTermEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/league-terms',
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}
EntitySyncEndpoint _resolveDrawGroupEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/groups', // POST لإنشاء دوري جديد
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}

EntitySyncEndpoint _resolveMatchEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/matches',
        method: HttpMethod.post,
      );
    case SyncService.operationUpdate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/matches',
        method: HttpMethod.put,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}

EntitySyncEndpoint _resolveTeamEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/teams/update',
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }}
  EntitySyncEndpoint _resolveQualifiedTeamEndpoint(String operation) {
    switch (operation) {
      case SyncService.operationUpdate:
        return EntitySyncEndpoint(
          path: '${AppURL.baseURL}/league-application/qualified-teams',
          method: HttpMethod.put,
        );
      default:
        throw UnsupportedError('Unknown operation for league: $operation');
    }
}

EntitySyncEndpoint _resolveLeagueStatusEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationUpdate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/league-status',
        method: HttpMethod.put,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}
EntitySyncEndpoint _resolveRoundsEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/rounds', // POST لإنشاء دوري جديد
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }
}

EntitySyncEndpoint _resolveTeamAndPlayerEndpoint(String operation) {
  switch (operation) {
    case SyncService.operationCreate:
      return EntitySyncEndpoint(
        path: '${AppURL.baseURL}/league-application/invitations/respond',
        method: HttpMethod.post,
      );
    default:
      throw UnsupportedError('Unknown operation for league: $operation');
  }

}

