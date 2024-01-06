import 'package:auto_route/auto_route.dart';
import 'package:be_focused/app/logger.dart';
import 'package:flutter/widgets.dart';

class RoutingObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.i('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.i('New tab route initialized ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.i('Tab route changed from ${previousRoute.name} to ${route.name}');
  }
}
