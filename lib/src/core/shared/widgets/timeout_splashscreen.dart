import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/app_logo.dart';

class TimeoutSplashScreen extends StatefulWidget {
  static const routeName = '/timeout-splashscreen';

  const TimeoutSplashScreen({super.key});

  @override
  State<TimeoutSplashScreen> createState() => _TimeoutSplashScreenState();
}

class _TimeoutSplashScreenState extends State<TimeoutSplashScreen> {
  Size? deviceSize;

  @override
  void dispose() {
    super.dispose();
  }

  dynamic timeout;
  bool timerStarted = false;

  @override
  void didChangeDependencies() {
    //    Provider.of<GlobalData>(context, listen: false).getCountriesAndCategories();
    //    Provider.of<GlobalData>(context, listen: false).getCountriesAndCategories();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    if (args != null) {
      timeout = args['timeout'];
      if (timeout != null && timerStarted == false) {
        Future.delayed(const Duration(milliseconds: 500), () {
          args['callback']?.call();
        });
        timerStarted = true;
        Future.delayed(timeout, () {
          Navigator.of(context).pop();
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        alignment: Alignment.center,
        child: const Center(child: AppLogo()),
      ),
    );
  }
}
