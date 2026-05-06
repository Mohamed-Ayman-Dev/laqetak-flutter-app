import 'package:flutter/material.dart';

import '../error/error_dialog.dart';

extension Dialogs on BuildContext {
  openDialog(Widget dialog, {bool barrierDismissible = true}) => showDialog(
    context: this,
    barrierDismissible: barrierDismissible,
    builder: (context) => dialog,
  );

  get loadingDialog =>
      openDialog(const Center(child: CircularProgressIndicator.adaptive()));

  errorDialog(String message, {String? title}) =>
      openDialog(MyAlertDialog(message: message, title: title));

  successDialog(String message) =>
      openDialog(MyAlertDialog(message: message, title: 'Success'));
}
