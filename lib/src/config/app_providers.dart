import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invastro/src/core/shared/presentation/cubit/others_cubit.dart';
import 'package:invastro/src/core/shared/providers/timers.dart';
import 'package:invastro/src/features/my_ads/presentation/providers/my_ads.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/di/locator.dart';
import '../core/di/locator_service.dart';
import '../core/shared/providers/app_settings.dart';
import '../features/ad_details/presentation/providers/ad_details.dart';
import '../features/auth/presentation/providers/auth.dart';
import '../features/auth/presentation/providers/auth_naviagtions.dart';
import '../features/chat/presentation/providers/chat.dart';
import '../features/home/presentation/providers/ads.dart';
import '../features/notifications/presentation/providers/notifications.dart';
import '../features/static_pages/presentation/providers/static_pages.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    // BlocProvider<AppSettingsCubit>.value(value: locator<AppSettingsCubit>()),
    // BlocProvider<AppSettingsCubit>.value(value: locator<AppSettingsCubit>()),
    BlocProvider<OthersCubit>.value(value: locator<OthersCubit>()),
  ];
}

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppSettings>(
      create: (_) => LocatorService.appSettings,
    ),
    ChangeNotifierProvider<Auth>(create: (_) => LocatorService.auth),
    ChangeNotifierProvider<AuthNavigations>(
      create: (_) => LocatorService.authNavigations,
    ),
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
  ];
}
