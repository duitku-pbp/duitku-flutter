import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<AuthProvider>(() => AuthProvider(client: sl()));

  sl.registerLazySingleton(() => http.Client());
}
