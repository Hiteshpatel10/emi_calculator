// import 'package:branch_locator/util/locator_route_generator.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static dynamic args;

  static Route<dynamic>? buildRouteGenerator(
    RouteSettings settings,
    Map<String, MaterialPageRoute<dynamic>> routeBuilders,
  ) {
    String? key = settings.name?.split('-').first;
    if (key != null) {
      if (routeBuilders.containsKey(key)) {
        return routeBuilders[key];
      }
      if (routeBuilders.containsKey('/$key')) {
        return routeBuilders['/$key'];
      }
    }


    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Route not found: ${settings.name}'),
        ),
      ),
    );
  }

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   args = settings.arguments;
  //
  //   debugPrint("Navigation => RouteGenerator > ${settings.name}\narguments: $args");
  //
  //   if (settings.name?.contains('calculator-') == true) {
  //     return coreCalculatorRouteGenerator(settings);
  //   }
  //
  //   if (settings.name?.contains('locator-') == true) {
  //     return locatorRouteGenerator(settings);
  //   }
  //
  //   switch (settings.name) {
  //     // ------------------------------------------- AUTH -----------------------------------------------
  //
  //     default:
  //       return _errorRoute();
  //   }
  // }

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
