import 'package:flutter/material.dart';

class PageRouteAnimator {
  static Route createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fastAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
        );

        return FadeTransition(
          opacity: fastAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
