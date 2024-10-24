import 'package:core_calculator/components/core_tenure_selector.dart';
import 'package:core_calculator/loan_calculator/bloc/emi_calculator_cubit.dart';
import 'package:core_calculator/utils/calculator_enums.dart';
import 'package:core_utility/core_validators.dart';
import 'package:core_utility/extensions/string_extensions.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_builder.dart';
import 'package:validator_forge/validators.dart';

class CarBuyingCalculatorInputView extends StatefulWidget {
  const CarBuyingCalculatorInputView({super.key});

  @override
  State<CarBuyingCalculatorInputView> createState() => _CarBuyingCalculatorInputViewState();
}

class _CarBuyingCalculatorInputViewState extends State<CarBuyingCalculatorInputView> {
  final _salaryController = TextEditingController(text: '10,00,000');
  final _salaryPercentageController = TextEditingController(text: '20%');
  final _interestRateController = TextEditingController(text: '8.5%');
  final _tenureController = TextEditingController(text: '10');
  TenureType _selectedTenureType = TenureType.years;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Affordability Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(
                  labelText: 'Salary Per Month',
                  hintText: 'Enter your monthly salary',
                ),
                inputFormatters: [
                  AmountInputFormatter(),
                ],
                validator: (String? value) {
                  final amount = value.toAmountFromINR();

                  final error = validatorBuilder([
                        () => Validators.requiredValidator(value),
                        () => Validators.minimum(amount, min: 5000),
                        () => Validators.maximum(amount, max: 20000000),
                  ]);

                  return error;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _salaryPercentageController,
                decoration: const InputDecoration(
                  labelText: 'Percentage of salary for EMI',
                  hintText: 'Enter percentage of salary for EMI',
                ),
                inputFormatters: [
                  PercentageInputFormatter(),
                ],
                validator: (String? value) {
                  final rate = num.tryParse((value ?? '').replaceAll('%', ''));
                  final error = validatorBuilder([
                        () => Validators.requiredValidator(value),
                        () => Validators.minimum(rate, min: 6),
                        () => Validators.maximum(rate, max: 40),
                  ]);
                  return error;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _interestRateController,
                decoration: const InputDecoration(
                  labelText: 'Interest rate',
                  hintText: 'Enter your interest rate',
                ),
                inputFormatters: [
                  PercentageInputFormatter(),
                ],
                validator: (String? value) {
                  final rate = num.tryParse((value ?? '').replaceAll('%', ''));
                  final error = validatorBuilder([
                        () => Validators.requiredValidator(value),
                        () => Validators.minimum(rate, min: 6),
                        () => Validators.maximum(rate, max: 40),
                  ]);
                  return error;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tenureController,
                decoration: InputDecoration(
                  labelText: 'Loan tenure',
                  hintText: 'Enter your loan tenure',
                  suffixIcon: getTenureSelector(
                    context,
                    selectedTenure: _selectedTenureType,
                    onTenureChange: (tenureType) {
                      setState(() {
                        _selectedTenureType = tenureType;
                      });
                    },
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (String? value) {
                  final duration = num.tryParse((value ?? ''));
                  String? error;
                  if (_selectedTenureType == TenureType.years) {
                    error = validatorBuilder([
                          () => Validators.requiredValidator(value),
                          () => Validators.minimum(duration, min: 1),
                          () => Validators.maximum(duration, max: 40),
                    ]);
                  } else {
                    error = validatorBuilder([
                          () => Validators.requiredValidator(value),
                          () => Validators.minimum(duration, min: 12),
                          () => Validators.maximum(duration, max: 480),
                    ]);
                  }

                  return error;
                },
              ),
              const SizedBox(height: 34),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }

                  int duration = int.tryParse((_tenureController.text )) ?? 0;

                  if (_selectedTenureType == TenureType.years) {
                    duration = duration * 12;
                  }

                  final emi = (_salaryController.text.toAmountFromINR() * _salaryPercentageController.text.toRate())/100;

                  BlocProvider.of<EmiCalculatorCubit>(context).calculatePrinciple(
                    emi: emi,
                    interestRate: _interestRateController.text.toRate(),
                    tenure: duration,
                  );

                  CoreNavigator.pushNamed(CoreCalculatorRoutes.emiResult);
                },
                child: const Text("Calculate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
