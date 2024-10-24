library core_utility;

import 'package:flutter/material.dart';

late final GlobalKey<NavigatorState> globalNavigatorKey;
late final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey;

initGlobalKeys(
  GlobalKey<NavigatorState> navigatorKey,
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
) async {
  globalNavigatorKey = navigatorKey;
  globalScaffoldMessengerKey = scaffoldMessengerKey;

  debugPrint(
      "----------------- initGlobalKeys -----------------\n$navigatorKey - $scaffoldMessengerKey");
}
