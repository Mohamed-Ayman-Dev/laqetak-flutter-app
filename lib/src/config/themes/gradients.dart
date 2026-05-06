import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppGradients {
  static const buttonGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [AppColors.primaryColor, AppColors.thirdColor],
  );
  static const walletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF101010), Color(0xFF313130)],
  );
  static const redButtonGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [AppColors.darkRedButtonGradient, AppColors.lightRedButtonGradient],
  );
  static const buttonGreenGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0XFF3DE290), Color(0XFF32CE84)],
  );
}
