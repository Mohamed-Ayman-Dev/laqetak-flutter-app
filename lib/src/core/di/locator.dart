import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:laqetak/src/features/notifications/data/services/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/ad_details/data/datasources/ad_details_remote_data_source.dart';
import '../../features/ad_details/data/datasources/ad_details_remote_data_source_impl.dart';
import '../../features/ad_details/data/repositories/ad_details_repository.dart';
import '../../features/ad_details/data/repositories/ad_details_repositoryImpl.dart';
import '../../features/ad_details/presentation/cubit/ad_details_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repositoryImpl.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../features/chat/data/datasources/chat_remote_data_source_impl.dart';
import '../../features/chat/data/repositories/chat_repository.dart';
import '../../features/chat/data/repositories/chat_repositoryImpl.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../features/home/data/datasources/ads_remote_data_source.dart';
import '../../features/home/data/datasources/ads_remote_data_source_impl.dart';
import '../../features/home/data/repositories/ads_repository.dart';
import '../../features/home/data/repositories/ads_repositoryImpl.dart';
import '../../features/home/presentation/cubit/ads_cubit.dart';
import '../../features/my_ads/data/datasources/my_ads_remote_data_source.dart';
import '../../features/my_ads/data/datasources/my_ads_remote_data_source_impl.dart';
import '../../features/my_ads/data/repositories/my_ads_repository.dart';
import '../../features/my_ads/data/repositories/my_ads_repositoryImpl.dart';
import '../../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../../features/notifications/data/datasources/notifications_remote_data_source.dart';
import '../../features/notifications/data/datasources/notifications_remote_data_source_impl.dart';
import '../../features/notifications/data/repositories/notifications_repository.dart';
import '../../features/notifications/data/repositories/notifications_repositoryImpl.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../features/static_pages/data/datasources/static_pages_remote_data_source.dart';
import '../../features/static_pages/data/datasources/static_pages_remote_data_source_impl.dart';
import '../../features/static_pages/data/repositories/static_pages_repository.dart';
import '../../features/static_pages/data/repositories/static_pages_repositoryImpl.dart';
import '../../features/static_pages/presentation/cubit/static_pages_cubit.dart';
import '../cache/cache_helper.dart';
import '../navigation_service.dart';
import '../network/api_client.dart';
import '../network/app_interceptors.dart';
import '../network/network_info.dart';
import '../shared/network/presentation/cubit/network_cubit.dart';
import '../shared/others/data/datasources/others_remote_data_source.dart';
import '../shared/others/data/datasources/others_remote_data_source_impl.dart';
import '../shared/others/data/repositories/others_repository.dart';
import '../shared/others/data/repositories/others_repositoryImpl.dart';
import '../shared/others/presentation/cubit/others_cubit.dart';
import '../shared/settings/data/datasources/settings_remote_data_source.dart';
import '../shared/settings/data/datasources/settings_remote_data_source_impl.dart';
import '../shared/settings/data/repositories/settings_repository.dart';
import '../shared/settings/data/repositories/settings_repositoryImpl.dart';
import '../shared/settings/presentation/cubit/settings_cubit.dart';
import '../shared/timers/presentation/cubit/timer_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupServices() async {
  /// register cache
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => pref);
  locator.registerLazySingleton<CacheHelper>(() => CacheHelper(locator()));

  /// register network
  locator.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 3),
      checkInterval: const Duration(seconds: 5),
      addresses: [
        AddressCheckOption(
          uri: Uri.parse('https://clients3.google.com/generate_204'),
          timeout: const Duration(seconds: 3),
        ),
        AddressCheckOption(
          uri: Uri.parse('https://1.1.1.1'),
          timeout: const Duration(seconds: 3),
        ),
        AddressCheckOption(
          uri: Uri.parse('https://www.google.com'),
          timeout: const Duration(seconds: 3),
        ),
      ],
    ),
  );
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<AppInterceptors>(() => AppInterceptors());
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: locator(), appInterceptors: locator()),
  );

  /// register services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<NotificationsService>(
    () => NotificationsService(),
  );

  /// register data sources
  locator.registerLazySingleton<OthersRemoteDataSource>(
    () => OthersRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<StaticPagesRemoteDataSource>(
    () => StaticPagesRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<AdsRemoteDataSource>(
    () => AdsRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<MyAdsRemoteDataSource>(
    () => MyAdsRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<AdDetailsRemoteDataSource>(
    () => AdDetailsRemoteDataSourceImpl(locator()),
  );

  /// register repositories
  locator.registerLazySingleton<OthersRepository>(
    () => OthersRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<StaticPagesRepository>(
    () => StaticPagesRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<AdsRepository>(
    () => AdsRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<MyAdsRepository>(
    () => MyAdsRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<AdDetailsRepository>(
    () => AdDetailsRepositoryImpl(remoteDataSource: locator()),
  );

  /// register cubits
  locator.registerLazySingleton<NetworkCubit>(() => NetworkCubit(locator()));
  locator.registerLazySingleton<TimerCubit>(() => TimerCubit());
  locator.registerLazySingleton<OthersCubit>(() => OthersCubit(locator()));
  locator.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(locator(), locator()),
  );
  locator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(locator(), locator()),
  );
  locator.registerLazySingleton<StaticPagesCubit>(
    () => StaticPagesCubit(locator()),
  );
  locator.registerLazySingleton<NotificationsCubit>(
    () => NotificationsCubit(locator()),
  );
  locator.registerLazySingleton<AdsCubit>(() => AdsCubit(locator()));
  locator.registerLazySingleton<MyAdsCubit>(() => MyAdsCubit(locator()));
  locator.registerLazySingleton<ChatCubit>(() => ChatCubit(locator()));
  locator.registerLazySingleton<AdDetailsCubit>(
    () => AdDetailsCubit(locator(), locator()),
  );
}
