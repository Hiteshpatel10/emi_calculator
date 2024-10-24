import 'package:core_calculator/loan_calculator/view/car_loan/car_buying_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/car_loan/car_loan_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_calculator_result_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_tenure_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/flat_vs_reducing_rate/flat_vs_reducing_rate_input_view.dart';
import 'package:core_calculator/loan_calculator/view/flat_vs_reducing_rate/flat_vs_reducing_rate_result_view.dart';
import 'package:core_calculator/loan_calculator/view/home_loan/home_loan_calculator_input_view.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:flutter/material.dart';

MaterialPageRoute coreCalculatorRouteGenerator(RouteSettings settings) {
  dynamic args = settings.arguments;

  switch (settings.name) {
    case CoreCalculatorRoutes.emiInput:
      return MaterialPageRoute(
        builder: (_) => const EmiCalculatorInputView(),
      );

    case CoreCalculatorRoutes.emiResult:
      return MaterialPageRoute(
        builder: (_) => const EmiResultView(),
      );

    case CoreCalculatorRoutes.emiTenureInput:
      return MaterialPageRoute(
        builder: (_) => const EmiTenureCalculatorInputView(),
      );

    case CoreCalculatorRoutes.carLoanInput:
      return MaterialPageRoute(
        builder: (_) => const CarLoanCalculatorInputView(),
      );

      case CoreCalculatorRoutes.carBuyingLoanInput:
      return MaterialPageRoute(
        builder: (_) => const CarBuyingCalculatorInputView(),
      );
    //
    case CoreCalculatorRoutes.homeLoanInput:
      return MaterialPageRoute(
        builder: (_) => const HomeLoanCalculatorInputView(),
      );

    case CoreCalculatorRoutes.flatVsReducingInput:
      return MaterialPageRoute(
        builder: (_) => const FlatVsReducingRateInputView(),
      );

      case CoreCalculatorRoutes.flatVsReducingResult:
      return MaterialPageRoute(
        builder: (_) => const FlatVsReducingRateResultView(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
              centerTitle: true,
            ),
            body: const Center(
              child: Text(
                'Error ! Something went wrong ',
                style: TextStyle(color: Colors.red, fontSize: 18.0),
              ),
            ),
          );
        },
      );
  }
}
