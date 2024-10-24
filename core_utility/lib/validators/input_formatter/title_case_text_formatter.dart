import 'package:core_utility/extensions/string_extensions.dart';
import 'package:flutter/services.dart';

class TitleCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toTitleCase(),
      selection: newValue.selection,
    );
  }
}