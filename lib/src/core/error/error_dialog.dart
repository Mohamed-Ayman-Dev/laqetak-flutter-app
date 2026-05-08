import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/text_styles.dart';

class MyAlertDialog extends StatelessWidget {
  final String message;
  final String? title;

  const MyAlertDialog({super.key, required this.message, this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(title ?? 'Oops', style: AppTextStyles.bodyLarge),
            ),

            // Message content centered
            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            // OK button centered
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
