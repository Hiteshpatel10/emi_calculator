import 'package:core_calculator/loan_calculator/functions/emi_function.dart';

CoreFlatVsReducingModel performFlatVsReducing({
  required double principle,
  required double annualInterestRate,
  required int numberOfMonths,
}) {
  final emi = calculateEMIInstallment(principle, annualInterestRate, numberOfMonths);

  final reducing = performEMICalculation(
    principal: principle,
    annualInterestRate: annualInterestRate,
    numberOfMonths: numberOfMonths,
    emi: emi,
  );

  final flatInterest = calculateSimpleInterest(principle, annualInterestRate, numberOfMonths);

  final flatEmi = (flatInterest + principle) / numberOfMonths;
  return CoreFlatVsReducingModel(
    flat: CoreEMIModel(
      emi: flatEmi,
      loanAmount: principle,
      tenure: numberOfMonths,
      interestRate: annualInterestRate,
      report: CoreReportModel(yearlyReport: [], monthlyReport: []),
      interestPaid: flatInterest,
    ),
    reducing: reducing,
  );
}

double calculateSimpleInterest(
  double principle,
  double annualInterestRate,
  int numberOfMonths,
) {
  return principle * (annualInterestRate / 100) * (numberOfMonths / 12);
}

class CoreFlatVsReducingModel {
  CoreFlatVsReducingModel({required this.flat, required this.reducing});

  final CoreEMIModel flat;
  final CoreEMIModel reducing;

  double get interestDifference => flat.interestPaid - reducing.interestPaid;
}
