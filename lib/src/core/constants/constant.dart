import 'package:flutter/animation.dart';

final class Constant {
  const Constant._();

  static const String fontFamily = 'Almarai';
  static const String appName = 'Laqetak';
  static const pageTransitionDuration = Duration(milliseconds: 400);
  static const Curve pageTransitionCurve = Curves.easeInOut;
  static const loadingDuration = Duration(milliseconds: 700);
  static const durationZero = Duration(seconds: 0);
  static const progressTimerDuration = Duration(seconds: 11);
  static const Duration screenTimeOut = Duration(seconds: 60);
  static const List<double> profits = [10, 15, 17, 22, 12];

  // static const driverGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  //   crossAxisCount: 2,
  //   crossAxisSpacing: 16,
  //   mainAxisSpacing: 16,
  //   childAspectRatio: 0.6,
  // );
}
