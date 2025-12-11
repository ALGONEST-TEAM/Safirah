import 'package:get_it/get_it.dart';
import 'package:safirah/core/database/safirah_database.dart';
import 'features/leagues_mangement/group/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/group/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/leagues/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/leagues/data/reposaitory/league_reposaitory.dart';
import 'core/local/secure_storage.dart';
import 'features/leagues_mangement/match/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/match/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_knockout_data_source.dart';
import 'features/leagues_mangement/match_term_event/data/data_source/local_data_source/local_term_data_source.dart';
import 'features/leagues_mangement/match_term_event/data/reposaitory/knockout_reposaitory.dart';
import 'features/leagues_mangement/match_term_event/data/reposaitory/reposaitory.dart';
import 'features/leagues_mangement/team_and_player/data/data_source/local_data_source.dart';
import 'features/leagues_mangement/team_and_player/data/reposaitory/reposaitory.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ✅ قاعدة البيانات
  final db = await Safirah.create();
  sl.registerLazySingleton<Safirah>(() => db);

  // ✅ LocalDataSource
  sl.registerLazySingleton<LeagueLocalDataSource>(
        () => LeagueLocalDataSource(sl<Safirah>()),
  );

  // ✅ Repository
  sl.registerLazySingleton<LeagueRepository>(
        () => LeagueRepository(local: sl<LeagueLocalDataSource>()),
  );
  sl.registerLazySingleton<TeamAndPlayerLocalDataSource>(() => TeamAndPlayerLocalDataSource(sl<Safirah>()));
  sl.registerLazySingleton<TeamAndPlayerRepository>(() => TeamAndPlayerRepository(local: sl<TeamAndPlayerLocalDataSource>()));
  sl.registerLazySingleton<GroupsLocalDataSource>(
        () => GroupsLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<GroupsRepository>(
        () => GroupsRepository(local: sl<GroupsLocalDataSource>()),
  );
  //match
  sl.registerLazySingleton<MatchesLocalDataSource>(
        () => MatchesLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<MatchesRepository>(() => MatchesRepository(local: sl()));
  ///////////////////////////////////////////////////////////////
  sl.registerLazySingleton<MatchTermsEventLocalDataSource>(
        () => MatchTermsEventLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<MatchTermsEventRepository>(() => MatchTermsEventRepository(local: sl()));


  sl.registerLazySingleton<KnockoutGeneratorLocalDataSource>(
        () => KnockoutGeneratorLocalDataSource(sl<Safirah>()),
  );
  sl.registerLazySingleton<KnockoutRepository>(() => KnockoutRepository(local: sl()));
  // ✅ Secure Storage
  sl.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));
}
