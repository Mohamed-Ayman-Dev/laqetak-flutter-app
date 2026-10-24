import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/config/routes.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../../generated/l10n.dart';
import '../core/constants/constant.dart';
import '../core/constants/images_assets.dart';
import '../core/di/locator_service.dart';
import '../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../core/shared/settings/presentation/cubit/settings_state.dart';
import '../core/themes/theme.dart';
import 'app_providers.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // separate file: core/utils/asset_precache.dart
  Future<void> precacheAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(
        const AssetImage(ImagesAssets.assetsImagesSplashImage),
        context,
      ),
      precacheImage(const AssetImage(ImagesAssets.assetsImagesLogo), context),
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheAssets(context);
    });
  }

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(375, 812),
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        final scale = instance.scaleWidth.clamp(0.85, 1.15);
        return fontSize * scale;
      },
      child: MultiBlocProvider(
        providers: AppBlocProviders.providers,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (previous, current) =>
              (previous.language != current.language ||
              previous.themeMode != current.themeMode ||
              previous.urlType != current.urlType),
          builder: (BuildContext context, state) {
            return MaterialApp(
              navigatorKey: LocatorService.navigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(state.language, ''),
              title: Constant.appName,
              color: Colors.white,
              themeMode: state.themeMode,
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
