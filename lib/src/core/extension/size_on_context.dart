import 'package:flutter/material.dart';

extension MediaQueryValue on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  // For tablets and larger devices
  bool get isTablet => width > 600;

  // Paddings
  TextScaler get textScaleFactor {
    return MediaQuery.textScalerOf(this);
  }

  bool get isKeyboardOpen => keyboardHeight > 0;
  double get keyboardHeight => View.of(this).viewInsets.bottom;
}

