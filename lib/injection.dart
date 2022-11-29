import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:duitku/wallet/datasources/wallet_datasource.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:duitku/wallet/repositories/wallet_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory<AuthProvider>(() => AuthProvider(client: sl(), jar: sl()));
  sl.registerFactory<WalletProvider>(() => WalletProvider(repository: sl()));

  // Repositories
  sl.registerFactory<WalletRepository>(
      () => WalletRepository(datasource: sl()));

  // Datasources
  sl.registerFactory<WalletDatasource>(
      () => WalletDatasource(client: sl(), jar: sl()));

  // Clients
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => CookieJar());
}
