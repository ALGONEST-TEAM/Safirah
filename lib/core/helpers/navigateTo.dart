import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FadePageRoute<T> extends PageRouteBuilder<T> {
  FadePageRoute({
    required Widget child,
    RouteSettings? settings,
  }) : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

Route<T> buildAdaptivePageRoute<T>({
  required Widget child,
  RouteSettings? settings,
  TargetPlatform? platform,
  bool instant = false,
}) {
  if (instant) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (_, __, ___) => child,
    );
  }

  final resolvedPlatform = platform ?? defaultTargetPlatform;
  if (resolvedPlatform == TargetPlatform.iOS) {
    return CupertinoPageRoute<T>(
      builder: (_) => child,
      settings: settings,
    );
  }

  if (resolvedPlatform == TargetPlatform.android) {
    return FadePageRoute<T>(
      child: child,
      settings: settings,
    );
  }

  return MaterialPageRoute<T>(
    builder: (_) => child,
    settings: settings,
  );
}

void navigateTo(context, widget) =>
    Navigator.of(context).push(buildAdaptivePageRoute(child: widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, buildAdaptivePageRoute(child: widget), (route) {
      return false;
    });

void navigateReplacement(context, widget) => Navigator.of(context)
    .pushReplacement(buildAdaptivePageRoute(child: widget));
