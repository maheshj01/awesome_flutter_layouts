import 'dart:math' as math;
import 'package:flutter/material.dart';

///source:https://flutter.dev/docs/cookbook/animation/page-route-animation

Route scaleRoute(
  Widget route, {
  Duration duration = const Duration(seconds: 2),
}) {
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) =>
          route,
      transitionDuration: duration,
      reverseTransitionDuration: Duration(seconds: 2),
      transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      });
}

Route scaleAndRotateRoute(Widget route, {double rotations = math.pi}) {
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) =>
          route,
      transitionDuration: Duration(seconds: 3),
      reverseTransitionDuration: Duration(seconds: 2),
      transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
        return Transform.rotate(
          angle: animation.value * rotations,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      });
}

Route slideRoute(Widget route,
    {Offset begin = const Offset(0.0, 1.0),
    Offset end = Offset.zero,
    Duration duration = const Duration(seconds: 2),
    Duration reverseDuration = const Duration(seconds: 3)}) {
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) =>
          route,
      transitionDuration: duration,
      reverseTransitionDuration: reverseDuration,
      transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

//// Widgets
Widget plane() {
  return Container(
    height: 100,
    width: 100,
    child: Icon(
      Icons.airplanemode_active,
      size: 40,
    ),
  );
}

Widget ball({double size}) {
  return Container(
    height: size ?? 20,
    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
  );
}
