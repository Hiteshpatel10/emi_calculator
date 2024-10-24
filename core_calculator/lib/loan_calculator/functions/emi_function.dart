import 'dart:math';

import 'package:flutter/cupertino.dart';

double calculateEMIInstallment(
  double principal,
  double annualInterestRate,
  int numberOfMonths,
) {
  // Convert annual interest rate to a monthly interest rate
  double monthlyInterestRate = annualInterestRate / (12 * 100);

  // EMI calculation using the formula
  // EMI=Pxrx(1+r)n/((1+r)n-1)

  double emi = principal *
      monthlyInterestRate *
      pow(1 + monthlyInterestRate, numberOfMonths) /
      (pow(1 + monthlyInterestRate, numberOfMonths) - 1);

  return emi;
}

int calculateEMITenure(
  double principal,
  double emi,
  double annualInterestRate,
) {
  // Convert annual interest rate to a monthly interest rate
  double monthlyInterestRate = annualInterestRate / (12 * 100);

  // Rearranged EMI formula to solve for tenure (number of months)
  // EMI = P * r * (1 + r)^n / ((1 + r)^n - 1)
  // Rearranging to solve for n (tenure):
  // n = log(EMI / (EMI - P * r)) / log(1 + r)

  double numerator = log(emi / (emi - principal * monthlyInterestRate));
  double denominator = log(1 + monthlyInterestRate);

  // Calculate the number of months (tenure)
  int numberOfMonths = (numerator / denominator).round();

  return numberOfMonths;
}

double calculateLoanAmount(double emi, double annualInterestRate, int numberOfMonths) {
  // Convert annual interest rate to a monthly interest rate
  double monthlyInterestRate = annualInterestRate / (12 * 100);

  // Rearranged EMI formula to solve for principal (loan amount):
  // P = EMI * ((1 + r)^n - 1) / (r * (1 + r)^n)
  if (monthlyInterestRate == 0) {
    // If the interest rate is 0, the principal is simply EMI * numberOfMonths
    return emi * numberOfMonths;
  }

  double loanAmount = emi * (pow(1 + monthlyInterestRate, numberOfMonths) - 1) /
      (monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfMonths));

  return loanAmount;
}


CoreEMIModel performEMICalculation({
  required double principal,
  required double annualInterestRate,
  required int numberOfMonths,
  required double emi,
}) {
  double monthlyInterestRate = annualInterestRate / (12 * 100);

  double loanAmount = principal;

  final List<CoreEMIReportModel> yearlyReport = [];
  final List<List<CoreEMIReportModel>> monthlyReport = [];

  double totalInterest = 0;

  int tenureYears = numberOfMonths % 12 == 0 ? numberOfMonths ~/ 12 : numberOfMonths ~/ 12 + 1;
  int tenureRemainingMonths = numberOfMonths % 12;

  for (int year = 1; year <= tenureYears; year++) {
    List<CoreEMIReportModel> tempMonthlyReport = [];

    int months = 12;
    months = year == tenureYears ? tenureRemainingMonths : 12;
    if (tenureRemainingMonths == 0) {
      months = 12;
    }

    double yearStartBalance = loanAmount;
    double yearInterestPaid = 0;
    double yearPrinciplePaid = 0;

    for (int month = 1; month <= months; month++) {
      final interest = loanAmount * monthlyInterestRate;
      final beginningBalance = loanAmount;
      final principalRepayment = (emi - interest);

      loanAmount -= principalRepayment;
      totalInterest += interest;

      yearInterestPaid += interest;
      yearPrinciplePaid += principalRepayment;

      tempMonthlyReport.add(
        CoreEMIReportModel(
          beginningBalance: beginningBalance,
          interest: interest,
          principalRepayment: principalRepayment.toDouble(),
          emi: emi,
          principleOutstanding: loanAmount,
        ),
      );
    }

    if (tempMonthlyReport.isNotEmpty) {
      yearlyReport.add(
        CoreEMIReportModel(
          beginningBalance: yearStartBalance,
          interest: yearInterestPaid,
          principalRepayment: yearPrinciplePaid,
          emi: emi,
          principleOutstanding: yearStartBalance - (yearPrinciplePaid),
        ),
      );
    }
    monthlyReport.add([...tempMonthlyReport]);
  }

  return CoreEMIModel(
    loanAmount: principal,
    emi: emi,
    tenure: numberOfMonths,
    interestRate: annualInterestRate,
    report: CoreReportModel<CoreEMIReportModel>(
      monthlyReport: monthlyReport,
      yearlyReport: yearlyReport,
    ),
    interestPaid: totalInterest,
  );
}

class CoreEMIModel {
  CoreEMIModel({
    required this.emi,
    required this.loanAmount,
    required this.tenure,
    required this.interestRate,
    required this.report,
    required this.interestPaid,
  });

  final double emi;
  final double loanAmount;
  final int tenure; //? Months
  final double interestRate;
  final double interestPaid;

  /// Annual
  final CoreReportModel<CoreEMIReportModel> report;

  double get principlePaid => loanAmount - interestPaid;
  double get totalRepayment => loanAmount + interestPaid;
}

class CoreEMIReportModel {
  CoreEMIReportModel({
    required this.beginningBalance,
    required this.interest,
    required this.principalRepayment,
    required this.emi,
    required this.principleOutstanding,
  });
  final double beginningBalance;
  final double interest;
  final double principalRepayment;
  final double emi;
  final double principleOutstanding;
}

class CoreReportModel<T> {
  CoreReportModel({
    required this.yearlyReport,
    required this.monthlyReport,
  });

  final List<T> yearlyReport;
  final List<List<T>> monthlyReport;
}
