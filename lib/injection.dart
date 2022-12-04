import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/auth/data/datasources/auth_datasource.dart';
import 'package:duitku/auth/data/repositories/auth_repository.dart';
import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:duitku/wallet/datasources/wallet_datasource.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:duitku/wallet/repositories/wallet_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      prefs: sl(),
      client: sl(),
      jar: sl(),
    ),
  );
  sl.registerFactory<WalletProvider>(() => WalletProvider(repository: sl()));

  // Repositories
  sl.registerFactory<AuthRepository>(() => AuthRepository(datasource: sl()));
  sl.registerFactory<WalletRepository>(
      () => WalletRepository(datasource: sl()));

  // Datasources
  sl.registerFactory<AuthDatasource>(
    () => AuthDatasource(
      client: sl(),
      jar: sl(),
      prefs: sl(),
    ),
  );
  sl.registerFactory<WalletDatasource>(
    () => WalletDatasource(
      client: sl(),
      jar: sl(),
    ),
  );

  // Externals
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => CookieJar());
}
