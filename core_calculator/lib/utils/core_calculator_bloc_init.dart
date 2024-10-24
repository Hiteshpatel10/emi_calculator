
import 'package:core_calculator/loan_calculator/bloc/emi_calculator_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List coreCalculatorBlocInit(){
  return [
    BlocProvider<EmiCalculatorCubit>(create: (context) => EmiCalculatorCubit()),
  ];
}