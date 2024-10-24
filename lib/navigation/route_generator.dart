import 'package:core_calculator/utils/core_calculator_route_generator.dart';
import 'package:emi_calculator/main.dart';
import 'package:emi_calculator/navigation/route_paths.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static dynamic args;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    args = settings.arguments;

    debugPrint("Navigation => RouteGenerator > ${settings.name}\narguments: $args");

    if (settings.name?.contains('calculator-') == true) {
      return coreCalculatorRouteGenerator(settings);
    }

    switch (settings.name) {
      // ------------------------------------------- AUTH -----------------------------------------------

      case RoutePaths.landing:
        return MaterialPageRoute(
          builder: (_) => const LandingView(),
        );

      default:
        return _errorRoute();
    }
  }

  // error screen
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              'Error ! Something went wrong',
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
          ),
        );
      },
    );
  }
}
