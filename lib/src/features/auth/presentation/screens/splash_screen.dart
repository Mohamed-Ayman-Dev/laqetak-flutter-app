import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:invastro/src/features/auth/presentation/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/app_settings/presentation/controllers/settings_controller.dart';
import '../../../../config/app_settings/presentation/providers/app_settings.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //fix frameRate
  Future<void> setOptimalDisplayMode() async {
    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
  }

  Future<void> _hideScreen() async {
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        logoOpacity = 1;
      });
    });
    // final auth = Provider.of<Auth>(context, listen: false);
    // uncomment this to enable mode switching
    // await auth.getStoredMode();
    Widget myScreen;
    String myRoute;
    final appSettings = Provider.of<AppSettings>(context, listen: false);
    await appSettings.getStoredLanguageAndTheme();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool hasSeenSplash = prefs.getBool('hasSeenSplash') ?? false;
    if (LocatorService.appSettings.mySettings == null) {
      LocatorService.appSettings.mySettings?.currentStage =
          prefs.getString('currentStage') ?? '1';
    }

    // if (hasSeenSplash) {
    //   final auth = LocatorService.auth;
    // if (auth.isAuth) {
    //   myScreen = const HomeLayoutScreen();
    //   myRoute = HomeLayoutScreen.routeName;
    // } else if (await AuthController.tryAutoLogin()) {
    //   myScreen = const HomeLayoutScreen();
    //   myRoute = HomeLayoutScreen.routeName;
    // } else {
    //   myScreen = const LoginScreen();
    //   myRoute = LoginScreen.routeName;
    // }
    // } else {
    myScreen = const AuthScreen();
    myRoute = AuthScreen.routeName;
    // }

    Timer(const Duration(milliseconds: 1000), () async {
      await LocatorService.navigationService.currentState!.pushReplacement(
        PageRouteBuilder(
          opaque: true,
          settings: RouteSettings(name: myRoute),
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (BuildContext context, _, __) => myScreen,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  double logoOpacity = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SettingsController.getGeneralSettings();
      // BannersController.getPopUps();
      // BannersController.getSliders();
    });
    setOptimalDisplayMode();
    _hideScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isTablet) 200.heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [const AppLogo()],
          ),
          if (isTablet) 160.heightSpace else 320.heightSpace,
          Text(
            '${S.of(context).version} 1.0.0',
            style: TextStyle(color: Colors.black),
          ),
          30.heightSpace,
        ],
      ),
    );
  }
}
