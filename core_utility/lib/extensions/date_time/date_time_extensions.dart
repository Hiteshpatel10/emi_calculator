import 'package:core_utility/extensions/date_time/date_formats.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime? {
  dateTimeToString(DateFormat dateFormat) {
    if (this == null) {
      return "";
    }

    return dateFormat.format(this!);
  }
}

extension StringToDateTimeExtensions on String? {
  stringToDatabaseDateFormat(DateFormat stringDateFormat) {
    if (this == null) {
      return "";
    }

    return DateFormats.yearMonthDate.format(stringDateFormat.parse(this!));
  }


  stringToDateFormat(DateFormat formatTo) {
    if (this == null) {
      return "";
    }

    final date = DateFormats.yearMonthDate.parse(this!);

    return formatTo.format(date);
  }
  
  
}
