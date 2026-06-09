import 'package:invastro/src/core/shared/services/settings_service.dart';
import 'package:invastro/src/features/home/data/services/ads_service.dart';
import 'package:invastro/src/features/home/presentation/providers/ads.dart';
import 'package:invastro/src/features/my_ads/data/services/my_ads_service.dart';
import 'package:invastro/src/features/my_ads/presentation/providers/my_ads.dart';
import 'package:invastro/src/features/notifications/data/services/notifications_service.dart';

import '../../features/ad_details/data/services/ad_details_service.dart';
import '../../features/ad_details/presentation/providers/ad_details.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/presentation/providers/auth.dart';
import '../../features/auth/presentation/providers/auth_naviagtions.dart';
import '../../features/chat/data/services/chat_service.dart';
import '../../features/chat/presentation/providers/chat.dart';
import '../../features/notifications/presentation/providers/notifications.dart';
import '../../features/static_pages/data/services/static_pages_service.dart';
import '../../features/static_pages/presentation/providers/static_pages.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_manager.dart';
import '../shared/providers/app_settings.dart';
import '../shared/providers/others.dart';
import '../shared/providers/timers.dart';
import '../shared/services/navigation_service.dart';
import '../shared/services/others_service.dart';
import 'locator.dart';

abstract class LocatorService {
  /// Cache
  static CacheHelper get cacheHelper => locator<CacheHelper>();

  static CacheManager get cacheManager => locator<CacheManager>();

  /// Services
  static NavigationService get navigationService =>
      locator<NavigationService>();

  static AuthService get authService => locator<AuthService>();

  static MyAdsService get myAdsService => locator<MyAdsService>();

  static SettingsService get settingsService => locator<SettingsService>();

  static OthersService get othersService => locator<OthersService>();

  static NotificationsService get notificationService =>
      locator<NotificationsService>();

  static AdsService get adsService => locator<AdsService>();

  static ChatService get chatService => locator<ChatService>();

  static AdDetailsService get adDetailsService => locator<AdDetailsService>();

  //
  // static ProductsService get productsService => locator<ProductsService>();
  //
  // static StoresService get storesService => locator<StoresService>();
  //
  // static AddressService get addressService => locator<AddressService>();
  //
  // static WalletService get walletService => locator<WalletService>();
  //
  // static PaymentsService get paymentsService => locator<PaymentsService>();
  //
  static StaticPagesService get staticPagesService =>
      locator<StaticPagesService>();

  // static OrdersService get ordersService => locator<OrdersService>();
  //
  // static SearchService get searchService => locator<SearchService>();
  //
  // static SettingsService get settingsService => locator<SettingsService>();
  //
  // static InvoicesService get invoicesService => locator<InvoicesService>();
  //
  // static ChatService get chatService => locator<ChatService>();

  /// Providers
  static AppSettings get appSettings => locator<AppSettings>();

  //
  static Auth get auth => locator<Auth>();

  //
  static AuthNavigations get authNavigations => locator<AuthNavigations>();

  //
  static Others get others => locator<Others>();

  static MyAds get myAds => locator<MyAds>();

  static Notifications get notifications => locator<Notifications>();

  static Ads get ads => locator<Ads>();

  static Chat get chat => locator<Chat>();

  static AdDetails get adDetails => locator<AdDetails>();

  //
  static Timers get timers => locator<Timers>();

  //
  // static Banners get banners => locator<Banners>();
  //
  // static Complaints get complaints => locator<Complaints>();
  //
  // static Invoices get invoices => locator<Invoices>();
  //
  // static Stores get stores => locator<Stores>();
  //
  // static Addresses get addresses => locator<Addresses>();
  //
  // static Wallets get wallets => locator<Wallets>();
  //
  // static Payments get payments => locator<Payments>();
  //
  static StaticPages get staticPages => locator<StaticPages>();

  //
  //
  // static Searches get searches => locator<Searches>();
  //
  // static Settings get settingss => locator<Settings>();
  //
  // static Chat get chat => locator<Chat>();
}
