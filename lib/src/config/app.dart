import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/config/routes.dart';
import 'package:invastro/src/config/themes/theme.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../core/bloc_helpers/app_bloc_providers.dart';
import '../core/dependency_injection/locator_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // separate file: core/utils/asset_precache.dart
  Future<void> precacheAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage('assets/images/logo.png'), context),
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheAssets(context);
    });
  }

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance; // ✅ here

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(393, 852),
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        final scale = instance.scaleWidth.clamp(0.85, 1.15);
        return fontSize * scale;
      },
      child: MultiBlocProvider(
        providers: AppBlocProviders.providers,

        child: Consumer<AppSettings>(
          builder: (BuildContext context, appSettings, _) {
            Translator.of(context).setLanguage(appSettings.language);
            return MaterialApp(
              navigatorKey: LocatorService.navigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return Stack(
                  children: [
                    // Your normal app widgets
                    EasyLoading.init(
                      builder: appSettings.urlType == 'production'
                          ? null
                          : (context, child) {
                              return Banner(
                                message: 'Develop',
                                location: BannerLocation.topEnd,
                                child: child,
                              );
                            },
                    )(context, child),
                  ],
                );
              },
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(appSettings.language, ''),
              title: 'غيارتك',
              color: Colors.white,
              themeMode: appSettings.themeMode,
              theme: CustomTheme.lightTheme,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: _analytics),
                NavigationHistoryObserver(),
              ],
              initialRoute: Routes.initialRoute,
              routes: Routes.routes,
            );
          },
        ),
      ),
    );
  }
}
