import 'package:get_it/get_it.dart';
import 'package:invastro/src/core/shared/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/presentation/providers/auth.dart';
import '../../features/auth/presentation/providers/auth_naviagtions.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_manager.dart';
import '../shared/providers/app_settings.dart';
import '../shared/providers/others.dart';
import '../shared/providers/timers.dart';
import '../shared/services/navigation_service.dart';
import '../shared/services/others_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupServices() async {
  /// register cache
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => pref);
  locator.registerLazySingleton<CacheHelper>(() => CacheHelper(locator()));
  locator.registerLazySingleton<CacheManager>(() => CacheManager(locator()));
  await locator<CacheManager>().loadCachedData();

  /// register services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<SettingsService>(() => SettingsService());
  locator.registerLazySingleton<OthersService>(() => OthersService());
  // locator.registerLazySingleton<NotificationService>(
  //       () => NotificationService(),
  // );
  // locator.registerLazySingleton<BannersService>(() => BannersService());
  // locator.registerLazySingleton<ProductsService>(() => ProductsService());
  // locator.registerLazySingleton<StoresService>(() => StoresService());
  // locator.registerLazySingleton<AddressService>(() => AddressService());
  // locator.registerLazySingleton<WalletService>(() => WalletService());
  // locator.registerLazySingleton<PaymentsService>(() => PaymentsService());
  // locator.registerLazySingleton<StaticPagesService>(() => StaticPagesService());
  // locator.registerLazySingleton<OrdersService>(() => OrdersService());
  // locator.registerLazySingleton<SearchService>(() => SearchService());
  // locator.registerLazySingleton<StorageService>(() => StorageService());
  // locator.registerLazySingleton<SettingsService>(() => SettingsService());
  //
  // locator.registerLazySingleton<ChatService>(() => ChatService());

  /// register providers
  locator.registerLazySingleton<AppSettings>(() => AppSettings());
  locator.registerLazySingleton<Auth>(() => Auth());
  locator.registerLazySingleton<AuthNavigations>(() => AuthNavigations());
  locator.registerLazySingleton<Others>(() => Others());
  // locator.registerLazySingleton<Notifications>(() => Notifications());
  locator.registerLazySingleton<Timers>(() => Timers());
  // locator.registerLazySingleton<Banners>(() => Banners());
  // locator.registerLazySingleton<Addresses>(() => Addresses());
  // locator.registerLazySingleton<Wallets>(() => Wallets());
  // locator.registerLazySingleton<Payments>(() => Payments());
  // locator.registerLazySingleton<StaticPages>(() => StaticPages());
  // locator.registerLazySingleton<Searches>(() => Searches());
  // locator.registerLazySingleton<Settings>(() => Settings());
  // locator.registerLazySingleton<Invoices>(() => Invoices());
  // locator.registerLazySingleton<Complaints>(() => Complaints());
  //
  // locator.registerLazySingleton<Chat>(() => Chat());
}
