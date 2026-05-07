import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/di/locator_service.dart';
import '../features/auth/presentation/providers/auth.dart';
import '../features/auth/presentation/providers/auth_naviagtions.dart';
import 'app_settings/presentation/providers/app_settings.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppSettings>(
      create: (_) => LocatorService.appSettings,
    ),
    ChangeNotifierProvider<Auth>(create: (_) => LocatorService.auth),
    ChangeNotifierProvider<AuthNavigations>(
      create: (_) => LocatorService.authNavigations,
    ),
    // ChangeNotifierProvider<Notifications>(
    //   create: (_) => LocatorService.notifications,
    // ),
    // ChangeNotifierProvider<Timers>(create: (_) => LocatorService.timers),
    // ChangeNotifierProvider<Banners>(create: (_) => LocatorService.banners),
    // ChangeNotifierProvider<Chat>(create: (_) => LocatorService.chat),
    // ChangeNotifierProvider<Stores>(create: (_) => LocatorService.stores),
    // ChangeNotifierProvider<Addresses>(create: (_) => LocatorService.addresses),
    // ChangeNotifierProvider<Settings>(create: (_) => LocatorService.settingss),
    // ChangeNotifierProvider<Wallets>(create: (_) => LocatorService.wallets),
    // ChangeNotifierProvider<Payments>(create: (_) => LocatorService.payments),
    // ChangeNotifierProvider<StaticPages>(
    //   create: (_) => LocatorService.staticPages,
    // ),
    // ChangeNotifierProvider<Cars>(create: (_) => LocatorService.cars),
    // ChangeNotifierProvider<QuoteRequests>(
    //   create: (_) => LocatorService.quoteRequests,
    // ),
    // ChangeNotifierProvider<Complaints>(
    //   create: (_) => LocatorService.complaints,
    // ),
    // ChangeNotifierProvider<Others>(create: (_) => LocatorService.others),
    // ChangeNotifierProvider<Searches>(create: (_) => LocatorService.searches),
    // ChangeNotifierProvider<Invoices>(create: (_) => LocatorService.invoices),
  ];
}
