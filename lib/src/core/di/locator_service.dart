import 'package:invastro/src/features/notifications/data/services/notifications_service.dart';

import '../../features/ad_details/presentation/cubit/ad_details_cubit.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../features/home/presentation/cubit/ads_cubit.dart';
import '../../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../cache/cache_helper.dart';
import '../navigation_service.dart';
import '../shared/settings/presentation/cubit/settings_cubit.dart';
import '../shared/timers/presentation/cubit/timer_cubit.dart';
import 'locator.dart';

abstract class LocatorService {
  /// Cache
  static CacheHelper get cacheHelper => locator<CacheHelper>();

  /// Services
  static NavigationService get navigationService =>
      locator<NavigationService>();

  static NotificationsService get notificationService =>
      locator<NotificationsService>();

  /// Cubits
  static TimerCubit get timerCubit => locator<TimerCubit>();

  static SettingsCubit get settingsCubit => locator<SettingsCubit>();

  static AuthCubit get authCubit => locator<AuthCubit>();

  static NotificationsCubit get notificationsCubit =>
      locator<NotificationsCubit>();

  static AdsCubit get adsCubit => locator<AdsCubit>();

  static MyAdsCubit get myAdsCubit => locator<MyAdsCubit>();

  static ChatCubit get chatCubit => locator<ChatCubit>();

  static AdDetailsCubit get adDetailsCubit => locator<AdDetailsCubit>();
}
