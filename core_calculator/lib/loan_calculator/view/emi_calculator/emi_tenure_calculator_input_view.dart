import 'package:core_calculator/loan_calculator/bloc/emi_calculator_cubit.dart';
import 'package:core_utility/core_validators.dart';
import 'package:core_utility/extensions/string_extensions.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_builder.dart';
import 'package:validator_forge/validators.dart';

class EmiTenureCalculatorInputView extends StatefulWidget {
  const EmiTenureCalculatorInputView({super.key});

  @override
  State<EmiTenureCalculatorInputView> createState() => _EmiTenureCalculatorInputViewState();
}

class _EmiTenureCalculatorInputViewState extends State<EmiTenureCalculatorInputView> {
  final _amountController = TextEditingController(text: '1,00,00,000');
  final _interestRateController = TextEditingController(text: '8.5%');
  final _emiController = TextEditingController(text: '10');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emi Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Loan Amount',
                  hintText: 'Enter your loan amount',
                ),
                inputFormatters: [
                  AmountInputFormatter(),
                ],
                validator: (String? value) {
                  final amount = value.toAmountFromINR();
                  final emi = _emiController.text.toAmountFromINR(onNull: 5000);

                  final error = validatorBuilder([
                    () => Validators.requiredValidator(value),
                    () => Validators.minimum(amount, min: emi),
                    () => Validators.maximum(amount, max: 20000000),
                  ]);

                  return error;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _interestRateController,
                decoration: const InputDecoration(
                  labelText: 'Interest rate',
                  hintText: 'Enter your loan amount',
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
                controller: _emiController,
                decoration: const InputDecoration(
                  labelText: 'Monthly installment (EMI)',
                  hintText: 'Enter your monthly installment',
                ),
                inputFormatters: [
                  AmountInputFormatter(),
                ],
                validator: (String? value) {
                  final emi = value.toAmountFromINR();
                  final amount  = _amountController.text.toAmountFromINR(onNull: 100000);

                  final error = validatorBuilder([
                        () => Validators.requiredValidator(value),
                        () => Validators.minimum(emi, min: 100),
                        () => Validators.maximum(emi, max: amount),
                  ]);

                  return error;
                },
              ),
              const SizedBox(height: 34),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }

                  BlocProvider.of<EmiCalculatorCubit>(context).calculateTenure(
                    principle: _amountController.text.toAmountFromINR(),
                    interestRate: _interestRateController.text.toRate(),
                    emi: _emiController.text.toAmountFromINR(),
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
