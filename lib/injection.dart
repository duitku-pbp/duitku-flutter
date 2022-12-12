import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/auth/data/datasources/auth_datasource.dart';
import 'package:duitku/auth/data/repositories/auth_repository.dart';
import 'package:duitku/auth/presentation/bloc/providers/auth_provider.dart';
import 'package:duitku/donasi/data/datasources/donasi_datasource.dart';
import 'package:duitku/donasi/data/repository/donasi_repository.dart';
import 'package:duitku/donasi/presentation/bloc/providers/donasi_provider.dart';
import 'package:duitku/wallet/data/datasources/wallet_datasource.dart';
import 'package:duitku/wallet/data/repositories/wallet_repository.dart';
import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:duitku/investasiku/data/datasources/investasiku_datasources.dart';
import 'package:duitku/investasiku/data/repositories/investasiku_repositories.dart';
import 'package:duitku/investasiku/presentation/provider/investasiku_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      prefs: sl(),
      jar: sl(),
      repository: sl(),
    ),
  );
  sl.registerFactory<WalletProvider>(() => WalletProvider(repository: sl()));
  sl.registerFactory<DonasiProvider>(() => DonasiProvider(repository: sl()));
  sl.registerFactory<PortofolioProvider>(
      () => PortofolioProvider(repository: sl()));

  // Repositories
  sl.registerFactory<AuthRepository>(() => AuthRepository(datasource: sl()));
  sl.registerFactory<WalletRepository>(
      () => WalletRepository(datasource: sl()));
  sl.registerFactory<DonasiRepository>(
      () => DonasiRepository(datasource: sl()));
  sl.registerFactory<InvestasikuRepository>(
      () => InvestasikuRepository(datasource: sl()));

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
  sl.registerFactory<DonasiDatasource>(
    () => DonasiDatasource(
      client: sl(),
      jar: sl(),
    ),
  );
  sl.registerFactory<PortofolioDataSources>(
    () => PortofolioDataSources(
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
