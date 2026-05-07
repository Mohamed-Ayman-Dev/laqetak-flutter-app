import 'package:flutter/material.dart';

class AuthNavigations with ChangeNotifier {
  bool isNotValid = false;
  String? newCode;
  String? wrongVerificationError;
  GlobalKey<FormState> activationFormKey = GlobalKey<FormState>();

  void setWrongVerificationCode(String? wrongVerificationError) {
    if (wrongVerificationError != null) {
      isNotValid = true;
    } else {
      isNotValid = false;
    }
    this.wrongVerificationError = wrongVerificationError;
    notifyListeners();
  }

  void setIsNotValid(bool value) {
    isNotValid = value;
    notifyListeners();
  }

  // setNewCode(String value) {
  //   newCode = value;
  //   notifyListeners();
  // }
}
