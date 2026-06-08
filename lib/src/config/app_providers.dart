import 'package:invastro/src/core/shared/providers/timers.dart';
import 'package:invastro/src/features/my_ads/presentation/providers/my_ads.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/di/locator_service.dart';
import '../core/shared/providers/app_settings.dart';
import '../core/shared/providers/others.dart';
import '../features/ad_details/presentation/providers/ad_details.dart';
import '../features/auth/presentation/providers/auth.dart';
import '../features/auth/presentation/providers/auth_naviagtions.dart';
import '../features/chat/presentation/providers/chat.dart';
import '../features/home/presentation/providers/ads.dart';
import '../features/notifications/presentation/providers/notifications.dart';
import '../features/static_pages/presentation/providers/static_pages.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppSettings>(
      create: (_) => LocatorService.appSettings,
    ),
    ChangeNotifierProvider<Auth>(create: (_) => LocatorService.auth),
    ChangeNotifierProvider<AuthNavigations>(
      create: (_) => LocatorService.authNavigations,
    ),
    ChangeNotifierProvider<Others>(create: (_) => LocatorService.others),
    ChangeNotifierProvider<Timers>(create: (_) => LocatorService.timers),
    ChangeNotifierProvider<StaticPages>(
      create: (_) => LocatorService.staticPages,
    ),
    ChangeNotifierProvider<MyAds>(create: (_) => LocatorService.myAds),
    ChangeNotifierProvider<Notifications>(
      create: (_) => LocatorService.notifications,
    ),
    ChangeNotifierProvider<Ads>(create: (_) => LocatorService.ads),
    ChangeNotifierProvider<AdDetails>(create: (_) => LocatorService.adDetails),
    ChangeNotifierProvider<Chat>(create: (_) => LocatorService.chat),

    // ChangeNotifierProvider<Timers>(create: (_) => LocatorService.timers),
    // ChangeNotifierProvider<Banners>(create: (_) => LocatorService.banners),
    // ChangeNotifierProvider<Chat>(create: (_) => LocatorService.chat),
    // ChangeNotifierProvider<Stores>(create: (_) => LocatorService.stores),
    // ChangeNotifierProvider<Addresses>(create: (_) => LocatorService.addresses),
    // ChangeNotifierProvider<Settings>(create: (_) => LocatorService.settingss),
    // ChangeNotifierProvider<Wallets>(create: (_) => LocatorService.wallets),
    // ChangeNotifierProvider<Payments>(create: (_) => LocatorService.payments),

    // ChangeNotifierProvider<Cars>(create: (_) => LocatorService.cars),
    // ChangeNotifierProvider<QuoteRequests>(
    //   create: (_) => LocatorService.quoteRequests,
    // ),
    // ChangeNotifierProvider<Complaints>(
    //   create: (_) => LocatorService.complaints,
    // ),
    // ChangeNotifierProvider<Searches>(create: (_) => LocatorService.searches),
    // ChangeNotifierProvider<Invoices>(create: (_) => LocatorService.invoices),
  ];
}
