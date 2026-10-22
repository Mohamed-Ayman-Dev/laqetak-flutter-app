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
}
