import 'package:flutter/services.dart';

class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the raw new text value without the percentage sign
    String newText = newValue.text.replaceAll('%', '');


    if(newText == ''){
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Add the percentage sign at the end
    String formattedText = '$newText%';

    // Calculate the new cursor position
    int newOffset = newValue.selection.end;

    // Adjust the cursor position if needed
    if (newOffset > formattedText.length - 1) {
      newOffset = formattedText.length - 1;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
