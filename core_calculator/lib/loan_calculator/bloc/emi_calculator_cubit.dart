import 'package:bloc/bloc.dart';
import 'package:core_calculator/loan_calculator/functions/emi_function.dart';
import 'package:core_calculator/loan_calculator/functions/flat_vs_reducing_function.dart';
import 'package:meta/meta.dart';
part 'emi_calculator_state.dart';

class EmiCalculatorCubit extends Cubit<EmiCalculatorState> {
  EmiCalculatorCubit() : super(EmiCalculatorInitial());

  calculateEMI({
    required double principle,
    required double interestRate,
    required int tenure,
  }) {
    emit(EmiCalculatorLoading());

    final emi = calculateEMIInstallment(principle, interestRate, tenure);

    final model = performEMICalculation(
      principal: principle,
      annualInterestRate: interestRate,
      numberOfMonths: tenure,
      emi: emi,
    );

    emit(EmiCalculatorSuccess(model));
  }

  calculateTenure({
    required double principle,
    required double emi,
    required double interestRate,
  }) {
    emit(EmiCalculatorLoading());

    final tenure = calculateEMITenure(principle, emi, interestRate);

    final model = performEMICalculation(
      principal: principle,
      annualInterestRate: interestRate,
      numberOfMonths: tenure,
      emi: emi,
    );

    emit(EmiCalculatorSuccess(model));
  }


  calculatePrinciple({
    required int tenure,
    required double emi,
    required double interestRate,
  }) {
    emit(EmiCalculatorLoading());

    final principle = calculateLoanAmount( emi, interestRate, tenure);

    final model = performEMICalculation(
      principal: principle,
      annualInterestRate: interestRate,
      numberOfMonths: tenure,
      emi: emi,
    );

    emit(EmiCalculatorSuccess(model));
  }




  calculateFlatVsReducing({
    required double principle,
    required int tenure,
    required double interestRate,
  }) {
    emit(EmiCalculatorLoading());

    final model = performFlatVsReducing(
      principle: principle,
      annualInterestRate: interestRate,
      numberOfMonths: tenure,
    );

    emit(EmiFlatVsReducingSuccess(model));
  }
}
