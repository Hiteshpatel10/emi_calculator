import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:core_utility/validators/core_regex.dart';
import 'package:flutter/services.dart';

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Prevents entering invalid characters

    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Removes any non-digit characters
    final newText = newValue.text.replaceAll(CoreRegex.numericOnly, '');


    final amount = format2INR(newText);
    final formattedValue = amount == '-' ?  '': amount;


    // Returns the formatted text
    return TextEditingValue(
      text: formattedValue ,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
