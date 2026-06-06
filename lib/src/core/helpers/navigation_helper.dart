import 'package:flutter/material.dart';

abstract class NavigationHelper {
  static PageRouteBuilder fadeRouteBuilder(BuildContext context, Widget page,
      [Duration duration = const Duration(milliseconds: 500),
      dynamic args,
      String? name]) {
    return PageRouteBuilder(
      opaque: true,
      transitionDuration: duration,
      settings: RouteSettings(arguments: args, name: name),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static PageRouteBuilder slideRightRouteBuilder(
      BuildContext context, Widget page,
      [Duration duration = const Duration(milliseconds: 500),
      dynamic args,
      String? name]) {
    return PageRouteBuilder(
      opaque: true,
      transitionDuration: duration,
      settings: RouteSettings(arguments: args, name: name),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
          SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(animation),
        child: child,
      ),
    );
  }

  void navigateWithFade(BuildContext context, Widget targetScreen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
        transitionDuration:
            const Duration(milliseconds: 300), // Animation duration
      ),
    );
  }
}

PageRouteBuilder<dynamic> createFadeScalePageRoute(Widget targetScreen,
    {Map<String, dynamic>? settings}) {
  return PageRouteBuilder(
    settings: RouteSettings(arguments: settings), // Set the RouteSettings here
    pageBuilder: (context, animation, secondaryAnimation) {
      return targetScreen; // Directly return the target screen
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Fade animation
      var fadeTween = Tween(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeInOut));

      var fadeAnimation = animation.drive(fadeTween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
