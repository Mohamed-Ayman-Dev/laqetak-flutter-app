import 'package:flutter/material.dart';

abstract class NavigationHelper {
  static PageRouteBuilder fadeRouteBuilder(
    BuildContext context,
    Widget page, [
    Duration duration = const Duration(milliseconds: 500),
    dynamic args,
    String? name,
  ]) {
    return PageRouteBuilder(
      opaque: true,
      transitionDuration: duration,
      settings: RouteSettings(arguments: args, name: name),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  static PageRouteBuilder slideRightRouteBuilder(
    BuildContext context,
    Widget page, [
    Duration duration = const Duration(milliseconds: 500),
    dynamic args,
    String? name,
  ]) {
    return PageRouteBuilder(
      opaque: true,
      transitionDuration: duration,
      settings: RouteSettings(arguments: args, name: name),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
    );
  }
}
