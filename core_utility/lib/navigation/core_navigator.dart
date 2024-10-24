import 'package:core_utility/core_utility.dart';
import 'package:flutter/material.dart';

class CoreNavigator {
  static String? currentRoute;

  // Method to push a new named route
  static void pushNamed(String routeName, {Object? arguments}) {
    _logRouteChange(routeName, arguments);
    _navigateSafely(() {
      currentRoute = routeName;
      globalNavigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
    });
  }

  // Method to pop the current route
  static void pop() {
    _navigateSafely(() {
      currentRoute = null;
      globalNavigatorKey.currentState?.pop();
    });
  }

  // Method to pop routes until the predicate is satisfied
  static void popUntil(RoutePredicate predicate) {
    _navigateSafely(() {
      currentRoute = null;
      globalNavigatorKey.currentState!.popUntil(predicate);
    });
  }

  // Method to push a named route and remove all routes until the predicate is satisfied
  static void pushNamedAndRemoveUntil(String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    _logRouteChange(newRouteName, arguments);
    _navigateSafely(() {
      currentRoute = newRouteName;
      globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
    });
  }

  // Method to push a named route, replacing the current route
  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    _logRouteChange(routeName, arguments);
    _navigateSafely(() {
      currentRoute = routeName;
      globalNavigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
    });
  }

  // Private method to log route changes
  static void _logRouteChange(String routeName, [Object? arguments]) {
    debugPrint("Navigating to route: $routeName with arguments: $arguments");
  }

  // Private method to handle navigation safely and catch errors
  static void _navigateSafely(Function navigationAction) {
    try {
      navigationAction();
    } catch (e, stackTrace) {
      debugPrint("Navigation error: $e\n$stackTrace");
    }
  }
}
