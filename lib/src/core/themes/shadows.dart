import 'package:flutter/cupertino.dart';

abstract class AppShadows {
  static const languageButtonBoxShadow = BoxShadow(
    color: Color.fromRGBO(64, 75, 81, 0.04),
    blurRadius: 18,
  );
  static const walletBalanceShadow = BoxShadow(
    color: Color(0x14040F60),
    offset: Offset(0, 4),
    blurRadius: 60,
    spreadRadius: 0,
  );
  static const mapAppbarBoxShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.09),
    blurRadius: 6,
    offset: Offset(0, 3),
  );
}
