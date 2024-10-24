import 'package:core_calculator/core_calculator.dart';
import 'package:core_utility/core_model/core_key_value_pair_model.dart';
import 'package:core_utility/core_utility.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:emi_calculator/navigation/route_paths.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/route_generator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCdJoD0lKc_I-BmX9Gh6PigzjyHbo0Fygk',
      appId: '1:393406614769:android:db3aa5f337004c98f36d50',
      projectId: 'gita-sarathi',
      messagingSenderId: '',
    ),
  );

  await initGlobalKeys(navigatorKey, scaffoldMessengerKey);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kDebugMode);
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
        ...coreCalculatorBlocInit(),
      ],
      child: MaterialApp(
        title: 'EMI Calculator',
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        initialRoute: RoutePaths.landing,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)), // Customize radius
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, // Seed color primary
                width: 2.0, // Border thickness
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant, // Border color for enabled state
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, // Seed color for focused state
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, // Seed color for error state
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, // Seed color for focused error state
                width: 2.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant, // Label text color
            ),
            hintStyle: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.6), // Hint text color with opacity
            ),
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error, // Error text color
            ),
          ),
        ),
      ),
    );
  }
}

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            Text(
              "EMI Calculator",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            ...List.generate(
              data.length,
              (index) {
                final item = data[index];
                return _buildMainCard(context,
                    route: item.value, title: item.key, asset: item.extra!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context, {
    required String route,
    required String title,
    required String asset,
  }) {
    return GestureDetector(
      onTap: () {

        CoreNavigator.pushNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: CoreBoxDecoration.getBoxDecoration(
          addBorder: true,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Image.asset(
              asset,
              width: 100,
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

final List<CoreKeyValuePairModel<String, String, String>> data = [
  CoreKeyValuePairModel(
    key: "EMI Calculator",
    value: CoreCalculatorRoutes.emiInput,
    extra: 'assets/icons/emi.png',
  ),
  CoreKeyValuePairModel(
    key: "EMI Tenure Calculator",
    value: CoreCalculatorRoutes.emiTenureInput,
    extra: 'assets/icons/tenure.png',
  ),
  CoreKeyValuePairModel(
    key: "Flat Vs Reducing",
    value: CoreCalculatorRoutes.flatVsReducingInput,
    extra: 'assets/icons/coin_stack.png',
  ),
  CoreKeyValuePairModel(
    key: "Home Loan Calculator",
    value: CoreCalculatorRoutes.homeLoanInput,
    extra: 'assets/icons/home_loan.png',
  ),
  CoreKeyValuePairModel(
    key: "Car Loan Calculator",
    value: CoreCalculatorRoutes.carLoanInput,
    extra: 'assets/icons/car_loan.png',
  ),
  CoreKeyValuePairModel(
    key: "Car Affordability",
    value: CoreCalculatorRoutes.carBuyingLoanInput,
    extra: 'assets/icons/car_cart.png',
  ),
];
