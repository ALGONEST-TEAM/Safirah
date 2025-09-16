import 'package:get_it/get_it.dart';
import 'core/local/secure_storage.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));
}
