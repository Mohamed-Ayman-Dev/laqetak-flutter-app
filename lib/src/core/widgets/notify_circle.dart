import 'package:flutter/material.dart';

import '../themes/colors.dart';

class NotifyCircle extends StatelessWidget {
  final bool showNotify;

  const NotifyCircle({super.key, this.showNotify = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondaryColor,
        border: Border.fromBorderSide(
          BorderSide(width: showNotify ? 1.5 : 0, color: AppColors.navBarBackgroundColor),
        ),
      ),
      width: showNotify ? 10 : 0,
      padding: const EdgeInsets.only(top: 1),
      height: showNotify ? 10 : 0,
    );
  }
}
