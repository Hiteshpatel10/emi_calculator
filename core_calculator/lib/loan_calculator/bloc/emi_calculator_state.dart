part of 'emi_calculator_cubit.dart';

@immutable
sealed class EmiCalculatorState {}

final class EmiCalculatorInitial extends EmiCalculatorState {}

final class EmiCalculatorLoading extends EmiCalculatorState {}

final class EmiCalculatorSuccess extends EmiCalculatorState {
  final CoreEMIModel emiModel;

  EmiCalculatorSuccess(this.emiModel);
}

final class EmiFlatVsReducingSuccess extends EmiCalculatorState {
  final CoreFlatVsReducingModel emiModel;

  EmiFlatVsReducingSuccess(this.emiModel);
}

final class EmiCalculatorError extends EmiCalculatorState {
  final String message;

  EmiCalculatorError(this.message);
}

final class EmiCalculatorInvalidInput extends EmiCalculatorState {
  final String errorMessage;

  EmiCalculatorInvalidInput(this.errorMessage);
}
