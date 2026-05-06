import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../generated/l10n.dart';

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
