import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get currentState => navigatorKey.currentState;

  BuildContext? get currentContext => navigatorKey.currentContext!;
}
