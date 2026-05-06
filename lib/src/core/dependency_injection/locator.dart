import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cache_manager.dart';
import '../cache/cash_helper.dart';
import '../cache/session_manager.dart';
import '../error/on_error_helper.dart';
import '../network/api_service.dart';
import '../network/api_service_impl.dart';
import '../network/app_interceptors.dart';

GetIt sl = GetIt.instance;

Future<void> setupServices() async {
  /// ---------------- External ----------------
  final pref = await SharedPreferences.getInstance();
  sl.registerSingleton<InternetConnectionChecker>(
    InternetConnectionChecker.createInstance(),
  );
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SharedPreferences>(() => pref);

  /// ---------------- Cache ----------------
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sl()));
  sl.registerLazySingleton<CacheManager>(() => CacheManager(sl()));
  sl.registerLazySingleton<SessionManager>(() => SessionManager());
  await sl<CacheManager>().getCachedData();

  /// ---------------- Remote Api ----------------
  sl.registerLazySingleton<OnErrorHelper>(() => OnErrorHelper());
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(onErrorHelper: sl(), cacheManager: sl()),
  );
  sl.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(dio: sl(), appInterceptors: sl()),
  );

  /// ---------------- Features ----------------
  // AddressDI.init();
  // AuthDI.init();


}
