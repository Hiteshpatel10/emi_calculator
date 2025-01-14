import 'package:branch_locator/util/locator_api_endpoints.dart';
import 'package:branch_locator/util/locator_route_generator.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/core_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:branch_locator/util/locator_bloc_init.dart';

import 'navigation/route_generator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: 'AIzaSyCdJoD0lKc_I-BmX9Gh6PigzjyHbo0Fygk',
      //   appId: '1:393406614769:android:db3aa5f337004c98f36d50',
      //   projectId: 'gita-sarathi',
      //   messagingSenderId: '',
      // ),
      );

  await initGlobalKeys(navigatorKey, scaffoldMessengerKey, baseUrl: LocatorApiEndpoints.base);

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ...coreCalculatorBlocInit(),
        ...locatorBlocInit(),
      ],
      child: MaterialApp(
        title: 'EMI Calculator',
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: LocatorRoutePaths.landing,
        onGenerateRoute: (settings) {
          return RouteGenerator.buildRouteGenerator(settings, {
            "/locator": locatorRouteGenerator(settings),
            // "/calculator": coreCalculatorRouteGenerator(settings),
          });
        },
        theme: CoreAppTheme.theme(context),
      ),
    );
  }
}
