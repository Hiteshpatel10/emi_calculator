class CoreRegex {
  static final numericRegex = RegExp(r'^[0-9]+(\.[0-9]*)?$');
  static final numericRegexWithoutDecimal = RegExp(r'^[0-9]+$');
  static final numericOnly = RegExp(r'[^0-9]');

  static final number = RegExp(r'/^\d*\.?\d*$/');
  static RegExp isEmail = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  static RegExp alphabetRegex = RegExp(r'^[a-zA-Z\s]+$');
  static RegExp pan = RegExp(r'^([A-Z]){5}([0-9]){4}([A-Z])$');
}
