import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppGradients {
  static const buttonGradient = LinearGradient(
    colors: [AppColors.secondaryColor, AppColors.primaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const brandGradient = LinearGradient(
    colors: [AppColors.primaryColor, AppColors.secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
