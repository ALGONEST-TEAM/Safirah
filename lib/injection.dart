import 'package:get_it/get_it.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'core/database/sync_service.dart';
import 'core/database/sync_orchestrator.dart';
import 'core/database/sync_auto_runner.dart';
import 'core/database/sync_trigger.dart';
import 'core/network/connectivity_service.dart';
import 'features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/group/data/data_source/remote_data_source/remote_data_source.dart';
import 'features/leagues_mangement/group/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/leagues/data/data_source/league_remote_data_source.dart';
import 'features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/leagues/data/reposaitory/league_reposaitory.dart';
import 'core/local/secure_storage.dart';
import 'features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/match/data/data_source/remote_data_source/remote_data_source.dart';
import 'features/leagues_mangement/match/data/reposaitory/reposaitory.dart';

import 'features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_knockout_data_source.dart';
import 'features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'features/leagues_mangement/match_term_event/data/data_source/remote_data_source/remote_data_source.dart';
import 'features/leagues_mangement/match_term_event/data/reposaitory/knockout_reposaitory.dart';
import 'features/leagues_mangement/match_term_event/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/team_and_player/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/team_and_player/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/team_and_player/data/data_source/remote_data_source/remote_data_source.dart';
import 'features/authorization/authorization_service.dart';
import 'features/authorization/data/data_source/authorization_local_data_source.dart';
import 'features/authorization/data/data_source/authorization_remote_data_source.dart';
import 'features/authorization/data/reposaitory/authorization_repository.dart';
import 'features/authorization/authorization_sync_runner.dart';
import 'features/authorization/authorization_access_policy.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ✅ قاعدة البيانات
  final db = await Safirah.create();
  sl.registerLazySingleton<Safirah>(() => db);

  // ✅ Connectivity (Internet online/offline)
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // ✅ خدمة المزامنة العامة
  sl.registerLazySingleton<SyncService>(() => SyncService(db: sl<Safirah>()));

  // ✅ orchestrator (syncAll)
  sl.registerLazySingleton<SyncOrchestrator>(
    () => SyncOrchestrator(sl<SyncService>()),
  );

  // ✅ Auto runner: sync on app start + on connectivity regained
  sl.registerLazySingleton<SyncAutoRunner>(
    () => SyncAutoRunner(
      connectivity: sl<ConnectivityService>(),
      orchestrator: sl<SyncOrchestrator>(),
    ),
  );

  // ✅ SyncTrigger: sync immediately after local enqueue if online
  sl.registerLazySingleton<SyncTrigger>(
    () => SyncTrigger(
      connectivity: sl<ConnectivityService>(),
      orchestrator: sl<SyncOrchestrator>(),
    ),
  );

  // ✅ LocalDataSource
  sl.registerLazySingleton<LeagueLocalDataSource>(
    () => LeagueLocalDataSource(sl<Safirah>()),
  );

  // ✅ Leagues RemoteDataSource
  sl.registerLazySingleton<LeagueRemoteDataSource>(
    () => const LeagueRemoteDataSource(),
  );

  // ✅ Repository
  sl.registerLazySingleton<LeagueRepository>(
    () => LeagueRepository(
      local: sl<LeagueLocalDataSource>(),
      remote: sl<LeagueRemoteDataSource>(),
      connectivity: sl<ConnectivityService>(),
      syncService: sl<SyncService>(),
    ),
  );
  sl.registerLazySingleton<TeamAndPlayerLocalDataSource>(
      () => TeamAndPlayerLocalDataSource(sl<Safirah>()));
  sl.registerLazySingleton<TeamAndPlayerRemoteDataSource>(
    () => const TeamAndPlayerRemoteDataSource(),
  );
  sl.registerLazySingleton<TeamAndPlayerRepository>(
    () => TeamAndPlayerRepository(
      syncService: sl<SyncService>(),
      local: sl<TeamAndPlayerLocalDataSource>(),
      remote: sl<TeamAndPlayerRemoteDataSource>(),
      connectivity: sl<ConnectivityService>(),
    ),
  );
  sl.registerLazySingleton<GroupsLocalDataSource>(
    () => GroupsLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<GroupRemoteDataSource>(
    () => const GroupRemoteDataSource(),
  );
  sl.registerLazySingleton<GroupsRepository>(() => GroupsRepository(
      local: sl<GroupsLocalDataSource>(),
      connectivity: sl<ConnectivityService>(),
      syncService: sl<SyncService>(),
      remote: sl<GroupRemoteDataSource>()));
  //match
  sl.registerLazySingleton<MatchesLocalDataSource>(
    () => MatchesLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<MatchRemoteDataSource>(
        () => const MatchRemoteDataSource(),
  );
  sl.registerLazySingleton<MatchesRepository>(() => MatchesRepository(
      local: sl(),
      remote: sl(),
      connectivity: sl<ConnectivityService>(),
      syncService: sl<SyncService>()));
  ///////////////////////////////////////////////////////////////
  sl.registerLazySingleton<MatchTermsEventLocalDataSource>(
    () => MatchTermsEventLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<MatchTermsEventRepository>(() =>
      MatchTermsEventRepository(
          local: sl(),
          connectivity: sl<ConnectivityService>(),
          syncService: sl<SyncService>()));

  sl.registerLazySingleton<KnockoutGeneratorLocalDataSource>(
    () => KnockoutGeneratorLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<MatchTermRemoteDataSource>(
        () => MatchTermRemoteDataSource(),
  );
  sl.registerLazySingleton<KnockoutRepository>(
      () => KnockoutRepository(local: sl(), remote: sl(),
          connectivity: sl<ConnectivityService>(),
          syncService: sl<SyncService>()));
  // ✅ Secure Storage
  sl.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));

  // ✅ Authorization (Roles & Permissions)
  sl.registerLazySingleton<AuthorizationLocalDataSource>(
    () => AuthorizationLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<AuthorizationRemoteDataSource>(
    () => const AuthorizationRemoteDataSource(),
  );
  sl.registerLazySingleton<AuthorizationRepository>(
    () => AuthorizationRepository(
      local: sl<AuthorizationLocalDataSource>(),
      remote: sl<AuthorizationRemoteDataSource>(),
      connectivity: sl<ConnectivityService>(),
      syncService: sl<SyncService>(),
    ),
  );
  sl.registerLazySingleton<AuthorizationService>(
    () => AuthorizationService(sl<AuthorizationRepository>()),
  );
  sl.registerLazySingleton<AuthorizationSyncRunner>(
    () => AuthorizationSyncRunner(
      connectivity: sl<ConnectivityService>(),
      service: sl<AuthorizationService>(),
    ),
  );
  sl.registerLazySingleton<AuthorizationAccessPolicy>(
    () => AuthorizationAccessPolicy(sl<AuthorizationLocalDataSource>()),
  );
}
