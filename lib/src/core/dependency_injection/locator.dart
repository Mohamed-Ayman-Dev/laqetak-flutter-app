import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/auth_di.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_manager.dart';
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
  sl.registerLazySingleton<CacheManager>(() => CacheManager(sl(), sl(), sl()));
  await sl<CacheManager>().loadCachedData();

  /// ---------------- Remote Api ----------------
  sl.registerLazySingleton<OnErrorHelper>(() => OnErrorHelper());
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(
      onErrorHelper: sl(),
      cacheManager: sl(),
      authCubit: sl(),
      appSettingsCubit: sl(),
    ),
  );
  sl.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(dio: sl(), appInterceptors: sl()),
  );

  /// ---------------- Features ----------------
  AuthDI.init();
}
