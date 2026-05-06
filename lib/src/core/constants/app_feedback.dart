import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../generated/l10n.dart';
import '../../config/themes/colors.dart';

final class AppFeedback {
  AppFeedback._();

  static void successToast(String message) {
    EasyLoading.showToast(
      message,
      toastPosition: EasyLoadingToastPosition.bottom,
      dismissOnTap: true,
      duration: const Duration(seconds: 3),
    );
  }

  // static void successPopUp(String message, {String? desc}) {
  //   EasyLoading.dismiss();
  //   AlertUtils.showSuccessDialog(
  //     title: message,
  //     oneButton: true,
  //     pop: false,
  //     desc: desc,
  //     onTab: () {
  //       LocatorService.navigationService.currentState?.pop();
  //     },
  //   );
  // }

  static void loadingMessage({String? message}) {
    EasyLoading.show(status: message ?? S.current.pleaseWait);
  }

  static void errorMessage(dynamic message) {
    final errorMessage = message?.toString() ?? S.current.somethingWentWrong;
    EasyLoading.showError(
      errorMessage,
      dismissOnTap: true,
      duration: const Duration(seconds: 3),
    );
  }
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
