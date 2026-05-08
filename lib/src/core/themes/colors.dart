import 'package:flutter/material.dart';

/// All the colors used in the application are defined here
///
/// Update the colors as desired with their dark mode variations below them.
abstract class AppColors {
  // objects Colors
  static const Color primaryColor = Color(0xFFB58934);
  static const Color secondaryColor = Color(0xFFFEE086);
  static const Color thirdColor = Color(0xFFE5E5E5);

  static const Color iconButtonIconColor = primaryColor;

  // background Colors
  static const Color backgroundColor = Colors.white;
  static const Color unSelectedRadioBKColor = Color(0XFFD1D1D6);
  static const Color selectedRadioBKColor = AppColors.primaryColor;

  static const Color notificationBk = Color(0XFFE0E0E0);
  static const Color disabledGreenColorBk = Color(0xFFEAF8D3);
  static const Color appBarBackGroundColor = Colors.white;
  static const Color navBarBackgroundColor = Color(0xFF323539);

  // text colors
  static const Color labelTextColor = Colors.black;
  static const Color buttonTextColor = Color(0xFF1D1D1D);
  static const Color bodyTextColor = Color(0xFF181818);
  static const Color hintColor = Color(0XFFABABAB);
  static const Color bodySmallGreyTextColor = Color(0XFFABABAB);
  static const Color tileTextColor = Color(0xFF333333);

  static const Color textButtonTextColor = Color(0XFF181818);
  static const Color inputTextColor = Color(0xFF181818);
  static const Color titleTextColor = Color(0XFF1D1D1D);
  static const Color errorTextColor = Color(0xFFFF0E0E);

  // border colors
  static const Color fieldBorderColor = Color(0XFFABABAB);
}
