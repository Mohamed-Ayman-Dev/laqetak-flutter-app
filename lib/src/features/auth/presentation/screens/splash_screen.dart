import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/widgets/animations/animated_fade_scale_wrapper.dart';
import 'package:laqetak/src/features/auth/presentation/screens/auth_screen.dart';

import '../../../../core/constants/images_assets.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../../../home/presentation/screens/home_layout_screen.dart';

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
    Widget myScreen;
    String myRoute;
    final settingsCubit = context.read<SettingsCubit>();
    await settingsCubit.loadStoredPrefs();
    final authCubit = LocatorService.authCubit;

    if (authCubit.state.isAuth) {
      myScreen = const HomeLayoutScreen();
      myRoute = HomeLayoutScreen.routeName;
    } else if (await authCubit.tryAutoLogin()) {
      myScreen = const HomeLayoutScreen();
      myRoute = HomeLayoutScreen.routeName;
    } else {
      myScreen = const AuthScreen();
      myRoute = AuthScreen.routeName;
    }

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
      context.read<SettingsCubit>().getSettings();
    });
    setOptimalDisplayMode();
    _hideScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImagesAssets.assetsImagesSplashImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedFadeScaleWrapper(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        ImagesAssets.assetsImagesLogo,
                        fit: BoxFit.cover,
                        width: 289.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
