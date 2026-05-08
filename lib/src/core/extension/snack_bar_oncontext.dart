import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/text_styles.dart';

extension ShowMessenger on BuildContext {
  dynamic showSnackBar({required String message}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        snackBarAnimationStyle: const AnimationStyle(),
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          elevation: 0,

          backgroundColor: AppColors.primaryColor,
          margin: const EdgeInsets.all(16),
          shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          content: Text(message, style: AppTextStyles.bodyMedium),
        ),
      );
}
