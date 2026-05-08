import 'package:flutter/material.dart';

abstract class ThemeGuide {
  // TODO: add box shadows

  /// Checks if the theme is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == ThemeData.dark().brightness;
  }
}
