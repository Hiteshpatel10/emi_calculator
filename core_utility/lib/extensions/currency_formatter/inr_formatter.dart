import 'package:intl/intl.dart';

String format2INR(dynamic amount, {bool removeAllAfterDecimal = true}) {
  final numericAmt = double.tryParse('$amount');
  if (amount == null || amount == '') {
    return "-";
  }

  String formattedAmount = NumberFormat.currency(locale: 'en_IN', symbol: '₹')
      .format(numericAmt)
      .eliminateLast(removeLength: 3);

  if (removeAllAfterDecimal) {
    formattedAmount = formattedAmount.split('.').first;
  }

  return formattedAmount;
}

extension StringExtendion on String? {
  String eliminateLast({required int removeLength}) {
    if (this != null && this?.isNotEmpty == true) {
      return '$this';
    }

    return this!.substring(0, this!.length - removeLength);
  }
}

compactFormat2INR(dynamic amount) {
  try {
    if (amount == null || amount.isNaN) {
      return "NA";
    }

    final numericAmt = num.tryParse('$amount');

    if (numericAmt == null) {
      return '-';
    }

    if (numericAmt.abs() >= 0 && numericAmt.abs() <= 99999) {
      return NumberFormat.compactCurrency(
        locale: 'en_US',
        symbol: '₹',
      ).format(numericAmt);
    }

    return NumberFormat.compactCurrency(
      locale: 'en_IN',
      symbol: '₹',
    ).format(numericAmt);
  } catch (e) {
    return '-';
  }
}
