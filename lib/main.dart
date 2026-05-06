import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invastro/src/core/dependency_injection/locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    // start existing code
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // deeplink using apps flyer
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.getAPNSToken();
    // end existing code
    configLoading();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      !kDebugMode,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
        );
      }).sendPort,
    );
    // start existing code
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupServices();

    return runApp(MyApp());
    // end existing code
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    // ..indicatorType = EasyLoadingIndicatorType.spinningCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..indicatorColor = Colors.white
    ..backgroundColor = AppColors.primaryColor
    ..textColor = AppColors.primaryColor
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = Colors.white
    // ..maskColor = Colors.black.withOpacity(0.2)
    // ..maskType = EasyLoadingMaskType.custom
    ..textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'IBMPlexSansArabic',
    )
    // ..radius = 10.0
    // ..progressColor = Colors.yellow
    // ..backgroundColor = Colors.green
    ..indicatorWidget = const SizedBox(
      width: 40,
      height: 40,
      child: SpinKitSpinningLines(color: Colors.white),
    )
    // ..indicatorColor = Colors.yellow
    // ..textColor = Colors.yellow
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
