import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'package:safirah/core/database/sync_service.dart';
import 'package:safirah/core/database/sync_trigger.dart';
import 'package:safirah/core/network/connectivity_service.dart';
import 'package:safirah/features/authorization/authorization_keys.dart';
import 'package:safirah/features/authorization/authorization_permissions.dart';
import 'package:safirah/features/authorization/authorization_roles.dart';
import 'package:safirah/features/authorization/data/data_source/authorization_local_data_source.dart';
import 'package:safirah/features/authorization/data/data_source/authorization_remote_data_source.dart';
import 'package:safirah/features/authorization/data/model/authorization_models.dart';
import 'package:safirah/features/authorization/data/reposaitory/authorization_repository.dart';
import 'package:safirah/features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:safirah/features/leagues_mangement/match/data/model/round_model.dart';
import 'package:safirah/features/leagues_mangement/match/data/reposaitory/reposaitory.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/model/goal_model.dart';
import 'package:safirah/features/leagues_mangement/match_term_event/data/reposaitory/reposaitory.dart';
import 'package:safirah/injection.dart' as di;
import 'package:uuid/uuid.dart';

import '../helpers/test_db_helper.dart';

import 'package:safirah/core/database/sync_orchestrator.dart';

class FakeConnectivityService extends ConnectivityService {
  bool isConnected;
  FakeConnectivityService({this.isConnected = true});

  @override
  Future<bool> isOnline({Duration timeout = const Duration(seconds: 2)}) async {
    return isConnected;
  }
}

class FakeSyncTrigger extends SyncTrigger {
  FakeSyncTrigger({required super.connectivity, required super.orchestrator});

  @override
  Future<void> syncIfOnline({bool throwOnFirstError = true}) async {}

  @override
  void syncIfOnlineInBackground({bool throwOnFirstError = false}) {}
}

class FakeAuthorizationRemoteDataSource extends AuthorizationRemoteDataSource {
  UserAccessForAllLeaguesModel? mockedAccess;
  FakeAuthorizationRemoteDataSource({this.mockedAccess});

  @override
  Future<UserAccessForAllLeaguesModel> fetchUserAccessForAllLeagues() async {
    return mockedAccess ?? const UserAccessForAllLeaguesModel(data: []);
  }
}

class FakeMatchRemoteDataSource extends MatchRemoteDataSource {
  String? lastCalledRole;
  bool getLeagueRoundsCalled = false;
  bool getLeagueRoundsRoleCalled = false;
  List<RoundModel> mockedRounds = [];

  @override
  Future<List<RoundModel>> getLeagueRounds(String leagueSyncId) async {
    getLeagueRoundsCalled = true;
    return mockedRounds;
  }

  @override
  Future<List<RoundModel>> getLeagueRoundsRole(String leagueSyncId, String role) async {
    getLeagueRoundsRoleCalled = true;
    lastCalledRole = role;
    return mockedRounds;
  }
}

void main() {
  late Safirah db;
  late FakeConnectivityService connectivity;
  late SyncService syncService;
  late AuthorizationLocalDataSource authLocal;
  late FakeAuthorizationRemoteDataSource authRemote;
  late AuthorizationRepository authRepo;

  late LeagueLocalDataSource leagueLocal;
  late GroupsLocalDataSource groupLocal;
  late MatchesLocalDataSource matchLocal;
  late FakeMatchRemoteDataSource matchRemote;
  late MatchesRepository matchesRepo;

  late MatchTermsEventLocalDataSource termLocal;
  late MatchTermsEventRepository termRepository;

  setUp(() async {
    db = TestDbHelper.createTestDatabase();
    connectivity = FakeConnectivityService(isConnected: true);
    syncService = SyncService(db: db);

    authLocal = AuthorizationLocalDataSource(db);
    authRemote = FakeAuthorizationRemoteDataSource();
    authRepo = AuthorizationRepository(
      local: authLocal,
      remote: authRemote,
      connectivity: connectivity,
      syncService: syncService,
    );

    leagueLocal = LeagueLocalDataSource(db);
    groupLocal = GroupsLocalDataSource(db);
    matchLocal = MatchesLocalDataSource(db);
    matchRemote = FakeMatchRemoteDataSource();

    matchesRepo = MatchesRepository(
      local: matchLocal,
      remote: matchRemote,
      connectivity: connectivity,
      syncService: syncService,
    );

    termLocal = MatchTermsEventLocalDataSource(db);
    termRepository = MatchTermsEventRepository(
      local: termLocal,
      connectivity: connectivity,
      syncService: syncService,
    );

    final orchestrator = SyncOrchestrator(syncService);
    final syncTrigger = FakeSyncTrigger(connectivity: connectivity, orchestrator: orchestrator);

    if (di.sl.isRegistered<SyncTrigger>()) {
      di.sl.unregister<SyncTrigger>();
    }
    di.sl.registerSingleton<SyncTrigger>(syncTrigger);
  });

  tearDown(() async {
    if (di.sl.isRegistered<SyncTrigger>()) {
      di.sl.unregister<SyncTrigger>();
    }
    await db.close();
  });

  /// Helper to setup a league with 2 teams and 1 scheduled match
  Future<({
    String leagueSyncId,
    String teamHomeSyncId,
    String teamAwaySyncId,
    String playerHomeSyncId,
    String matchSyncId,
  })> setupMinimalLeagueAndMatch() async {
    await TestDbHelper.seedDefaultTerms(db);

    final lSyncId = const Uuid().v7();
    await leagueLocal.insertLeague(
      LeaguesCompanion.insert(
        syncId: lSyncId,
        name: 'دوري الاختبار',
        subscriptionPrice: '100',
        status: const Value('active'),
      ),
    );

    // Setup 2 terms for league
    await db.batch((batch) {
      batch.insertAll(db.leagueTerms, [
        LeagueTermsCompanion.insert(
          syncId: const Uuid().v7(),
          leagueSyncId: lSyncId,
          termSyncId: TestDbHelper.termRegular1SyncId,
          durationMinutes: const Value(45),
        ),
        LeagueTermsCompanion.insert(
          syncId: const Uuid().v7(),
          leagueSyncId: lSyncId,
          termSyncId: TestDbHelper.termRegular2SyncId,
          durationMinutes: const Value(45),
        ),
      ]);
    });

    final tHome = const Uuid().v7();
    final tAway = const Uuid().v7();
    await db.into(db.teams).insert(TeamsCompanion.insert(syncId: tHome, leagueSyncId: lSyncId, teamName: 'فريق أ'));
    await db.into(db.teams).insert(TeamsCompanion.insert(syncId: tAway, leagueSyncId: lSyncId, teamName: 'فريق ب'));

    final lpId = const Uuid().v7();
    final pHomeId = const Uuid().v7();
    await db.into(db.leaguePlayers).insert(LeaguePlayersCompanion.insert(syncId: lpId, leagueSyncId: lSyncId, name: const Value('لاعب 1')));
    await db.into(db.players).insert(PlayersCompanion.insert(syncId: pHomeId, playerLeagueSyncId: lpId, teamSyncId: tHome, fullName: 'مهاجم أ'));

    await groupLocal.drawGroupsByCount(leagueSyncId: lSyncId, groupsCount: 1, qualifiedPerGroup: 2);
    await matchLocal.ensureGroupRounds(leagueSyncId: lSyncId);
    await matchLocal.scheduleGroupStageMatchesRR(leagueSyncId: lSyncId);

    final matches = await (db.select(db.matches)..where((m) => m.leagueSyncId.equals(lSyncId))).get();

    return (
      leagueSyncId: lSyncId,
      teamHomeSyncId: tHome,
      teamAwaySyncId: tAway,
      playerHomeSyncId: pHomeId,
      matchSyncId: matches.first.syncId,
    );
  }

  group('User Roles & Permissions (User Types) Verification Tests', () {
    test('1. User is ONLY Organizer: possesses administrative permissions but NOT match.manage', () async {
      final setup = await setupMinimalLeagueAndMatch();
      final leagueId = setup.leagueSyncId;

      // Seed user as organizer
      await authLocal.seedCreatorAsOrganizer(
        leagueSyncId: leagueId,
        userName: 'أحمد المنظم',
        userId: 101,
      );

      // Verify user has role row in users_has_role
      final userRoles = await authLocal.getUsersHasRoles(leagueSyncId: leagueId);
      expect(userRoles.length, 1);
      expect(userRoles.first.name, 'أحمد المنظم');
      expect(userRoles.first.role, AuthorizationRoles.organizer);

      // Verify permissions for organizer
      final canEditLeague = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.leagueEdit);
      final canManageTeams = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.teamManage);
      final canViewLeague = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.leagueView);
      final canManageMatches = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.matchManage);

      expect(canEditLeague.getOrElse(() => false), isTrue);
      expect(canManageTeams.getOrElse(() => false), isTrue);
      expect(canViewLeague.getOrElse(() => false), isTrue);

      // IMPORTANT: In Safirah, organizer does NOT have match.manage by default (commented out in AuthorizationPermissions)
      expect(canManageMatches.getOrElse(() => false), isFalse);
    });

    test('2. User is ONLY Referee: possesses match.manage but CANNOT edit league or teams', () async {
      final setup = await setupMinimalLeagueAndMatch();
      final leagueId = setup.leagueSyncId;

      // Seed user as referee
      final refereeSyncId = const Uuid().v7();
      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(
          syncId: refereeSyncId,
          leagueSyncId: leagueId,
          name: 'محمد الحكم',
          role: AuthorizationRoles.referee,
          roleOrder: const Value(2),
        ),
      );

      // Store permissions for referee
      final refPerms = AuthorizationPermissions.permissionsForRoles(const [AuthorizationRoles.referee]);
      await authLocal.replaceLeaguePermissions(
        leagueSyncId: leagueId,
        permissionKeys: refPerms.toList(),
        syncIdFactory: () => const Uuid().v7(),
      );

      final canManageMatches = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.matchManage);
      final canEditLeague = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.leagueEdit);
      final canManageTeams = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.teamManage);

      // Referee CAN manage matches
      expect(canManageMatches.getOrElse(() => false), isTrue);

      // Referee CANNOT edit league or manage teams
      expect(canEditLeague.getOrElse(() => false), isFalse);
      expect(canManageTeams.getOrElse(() => false), isFalse);

      // Calling refresh with role 'Referee' triggers the dedicated referee endpoint
      await matchesRepo.refreshLeagueRoundsWithGroupsAndMatches(
        leagueSyncId: leagueId,
        matchFilter: 'scheduled',
        role: 'Referee',
      );
      expect(matchRemote.getLeagueRoundsRoleCalled, isTrue);
      expect(matchRemote.lastCalledRole, 'Referee');
    });

    test('3. DUAL ROLE: User is BOTH Organizer AND Referee (ماذا يحدث عندما يكون المستخدم منظم وحكم)', () async {
      final setup = await setupMinimalLeagueAndMatch();
      final leagueId = setup.leagueSyncId;

      // 1) Remote API returns BOTH roles for this user in this league:
      authRemote.mockedAccess = UserAccessForAllLeaguesModel(
        data: [
          LeagueUserAccessModel(
            leagueId: 99,
            leagueSyncId: leagueId,
            roles: const [
              RoleModel(id: 1, syncId: 'role-org-1', nameAr: 'منظم', nameEn: 'Organizer'),
              RoleModel(id: 2, syncId: 'role-ref-2', nameAr: 'حكم', nameEn: 'Referee'),
            ],
          ),
        ],
      );

      // Mock access contains both keys
      final accessModel = authRemote.mockedAccess!.data.first;
      expect(accessModel.roleKeys.toSet(), {'organizer', 'referee'});

      // 2) Compute unified permissions for dual role:
      final unifiedPermissions = AuthorizationPermissions.permissionsForRoles(accessModel.roleKeys);

      // Verify the union has ALL permissions
      expect(unifiedPermissions, contains(AuthorizationKeys.leagueView));
      expect(unifiedPermissions, contains(AuthorizationKeys.leagueEdit));
      expect(unifiedPermissions, contains(AuthorizationKeys.teamManage));
      expect(unifiedPermissions, contains(AuthorizationKeys.matchManage));

      // 3) Store unified permissions in local database
      await authLocal.replaceLeaguePermissions(
        leagueSyncId: leagueId,
        permissionKeys: unifiedPermissions.toList(),
        syncIdFactory: () => const Uuid().v7(),
      );

      // 4) Verify all authorization checks pass:
      final canEditLeague = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.leagueEdit);
      final canManageMatches = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.matchManage);
      final canManageTeams = await authRepo.can(leagueSyncId: leagueId, permissionKey: AuthorizationKeys.teamManage);

      expect(canEditLeague.getOrElse(() => false), isTrue, reason: 'Organizer role grants league.edit');
      expect(canManageMatches.getOrElse(() => false), isTrue, reason: 'Referee role grants match.manage');
      expect(canManageTeams.getOrElse(() => false), isTrue, reason: 'Organizer role grants team.manage');

      // 5) Register dual role records in users_has_role
      final userOrgSyncId = const Uuid().v7();
      final userRefSyncId = const Uuid().v7();

      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(
          syncId: userOrgSyncId,
          leagueSyncId: leagueId,
          name: 'سلطان (منظم وحكم)',
          role: AuthorizationRoles.organizer,
          roleOrder: const Value(1),
        ),
      );

      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(
          syncId: userRefSyncId,
          leagueSyncId: leagueId,
          name: 'سلطان (منظم وحكم)',
          role: AuthorizationRoles.referee,
          roleOrder: const Value(2),
        ),
      );

      final rolesInDb = await authLocal.getUsersHasRoles(leagueSyncId: leagueId);
      expect(rolesInDb.length, 2);
    });

    test('4. Dual-Role Action: Organizer assigns himself as Referee, then referees the match completely', () async {
      final setup = await setupMinimalLeagueAndMatch();
      final leagueId = setup.leagueSyncId;
      final matchId = setup.matchSyncId;

      // 1) Setup dual-role user in users_has_role
      final myRefereeSyncId = const Uuid().v7();
      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(
          syncId: myRefereeSyncId,
          leagueSyncId: leagueId,
          name: 'المدير والحكم',
          role: AuthorizationRoles.referee,
          roleOrder: const Value(1),
        ),
      );

      final dummyMediaSyncId = const Uuid().v7();
      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(
          syncId: dummyMediaSyncId,
          leagueSyncId: leagueId,
          name: 'المصور',
          role: 'media',
          roleOrder: const Value(2),
        ),
      );

      // 2) As Organizer: Schedule match in the future first to verify business rule
      final futureDateTime = DateTime.now().add(const Duration(hours: 2));
      await matchLocal.scheduleMatch(
        matchSyncId: matchId,
        scheduledDateTime: futureDateTime,
        refereeSyncId: myRefereeSyncId,
        mediaSyncId: dummyMediaSyncId,
      );

      final terms = await (db.select(db.matchTerms)..where((t) => t.matchSyncId.equals(matchId))).get();

      // Verify business safety rule: Cannot start match before scheduled time!
      final prematureStartRes = await termRepository.startTermSafe(matchId, terms[0].syncId);
      expect(prematureStartRes.isLeft(), isTrue);

      // Now as Organizer: Reschedule match to current time so referee can start
      final nowDateTime = DateTime.now().subtract(const Duration(minutes: 1));
      final scheduledMatch = await matchLocal.scheduleMatch(
        matchSyncId: matchId,
        scheduledDateTime: nowDateTime,
        refereeSyncId: myRefereeSyncId,
        mediaSyncId: dummyMediaSyncId,
      );

      expect(scheduledMatch.status, 'scheduled');
      expect(scheduledMatch.refereeSyncId, myRefereeSyncId);

      // Verify db row
      final matchRow = await (db.select(db.matches)..where((m) => m.syncId.equals(matchId))).getSingle();
      expect(matchRow.status, 'scheduled');
      expect(matchRow.refereeSyncId, myRefereeSyncId);

      // 3) As Referee: Now officiate and referee this scheduled match
      // Start 1st half
      final startRes = await termRepository.startTermSafe(matchId, terms[0].syncId);
      expect(startRes.isRight(), isTrue);

      // Score goal
      final goalRes = await termRepository.addGoal(
        GoalModel(
          syncId: const Uuid().v7(),
          matchSyncId: matchId,
          playerSyncId: setup.playerHomeSyncId,
          matchTermSyncId: terms[0].syncId,
          goalTime: 20,
          goalType: 'regular',
        ),
      );
      expect(goalRes.isRight(), isTrue);

      // Finish 1st half, start 2nd half, finish match
      await termRepository.finishCurrentTerm(matchSyncId: matchId, matchTermSyncId: terms[0].syncId);
      await termRepository.startTermSafe(matchId, terms[1].syncId);
      final finishRes = await termRepository.finishCurrentTerm(matchSyncId: matchId, matchTermSyncId: terms[1].syncId);
      expect(finishRes.isRight(), isTrue);

      // 4) Verify complete match finalization and standings update
      final finishedMatch = await (db.select(db.matches)..where((m) => m.syncId.equals(matchId))).getSingle();
      expect(finishedMatch.status, 'finished');
      expect(finishedMatch.homeScore, 1);
      expect(finishedMatch.awayScore, 0);

      final winnerStanding = await (db.select(db.qualifiedTeam)
            ..where((q) => q.leagueSyncId.equals(leagueId) & q.teamSyncId.equals(setup.teamHomeSyncId)))
          .getSingle();
      expect(winnerStanding.points, 3);
      expect(winnerStanding.played, 1);
      expect(winnerStanding.goalsFor, 1);
    });

    test('5. Referee Match Filtering: Querying matches assigned strictly to a referee', () async {
      final setup = await setupMinimalLeagueAndMatch();
      final leagueId = setup.leagueSyncId;

      final refereeA = const Uuid().v7();
      final refereeB = const Uuid().v7();

      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(syncId: refereeA, leagueSyncId: leagueId, name: 'حكم أ', role: AuthorizationRoles.referee),
      );
      await db.into(db.usersHasRole).insert(
        UsersHasRoleCompanion.insert(syncId: refereeB, leagueSyncId: leagueId, name: 'حكم ب', role: AuthorizationRoles.referee),
      );

      // Assign referee A to the match
      await (db.update(db.matches)..where((m) => m.syncId.equals(setup.matchSyncId))).write(
        MatchesCompanion(
          refereeSyncId: Value(refereeA),
          status: const Value('scheduled'),
        ),
      );

      // Query matches for Referee A
      final matchesForRefA = await (db.select(db.matches)
            ..where((m) => m.leagueSyncId.equals(leagueId) & m.refereeSyncId.equals(refereeA)))
          .get();
      expect(matchesForRefA.length, 1);
      expect(matchesForRefA.first.syncId, setup.matchSyncId);

      // Query matches for Referee B (should be 0)
      final matchesForRefB = await (db.select(db.matches)
            ..where((m) => m.leagueSyncId.equals(leagueId) & m.refereeSyncId.equals(refereeB)))
          .get();
      expect(matchesForRefB.length, 0);
    });
  });
}
