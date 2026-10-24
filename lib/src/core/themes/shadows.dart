import 'package:flutter/cupertino.dart';
import 'colors.dart';

abstract class AppShadows {
  static const languageButtonBoxShadow = BoxShadow(
    color: AppColors.shadowLanguageButton,
    blurRadius: 18,
  );
  static const walletBalanceShadow = BoxShadow(
    color: AppColors.shadowWallet,
    offset: Offset(0, 4),
    blurRadius: 60,
    spreadRadius: 0,
  );
  static const mapAppbarBoxShadow = BoxShadow(
    color: AppColors.shadowMapAppbar,
    blurRadius: 6,
    offset: Offset(0, 3),
  );

  /// Floating nav bar elevation shadow
  static const floatingNavBarShadow = [
    BoxShadow(
      color: Color.fromRGBO(16, 42, 67, 0.08), // primaryColor 8%
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color.fromRGBO(16, 42, 67, 0.04), // primaryColor 4%
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];
}
