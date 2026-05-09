import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator(color: AppColors.primaryColor)
        : const SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
  }
}
