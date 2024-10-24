// import 'package:core_utility/validators/core_regex.dart';
//
// extension StringExtension on String? {
//   String toTitleCase() {
//     return split(' ').map((word) {
//       if (word.isEmpty) {
//         return word;
//       }
//       return word[0].toUpperCase() + word.substring(1).toLowerCase();
//     }).join(' ');
//   }
//
//   bool isEmptyOrNull(){
//     return this == null || this!.isEmpty;
//   }
//   double toAmountFromINR() {
//
//     if( this == null){
//       return 0.0;
//     }
//
//     String sanitizedString = replaceAll(RegExp(r'[^\d.,]'), '');
//
//     sanitizedString = sanitizedString.replaceAll(',', '.');
//
//     return double.tryParse(sanitizedString) ?? 0.0;
//   }
//
//   double toRate() {
//     return double.tryParse(replaceAll('%', '')) ?? 0;
//   }
// }

import 'package:flutter/cupertino.dart';

extension StringExtension on String? {
  String toTitleCase() {
    if (this == null || this!.isEmpty) return '';
    return this!.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  bool isEmptyOrNull() {
    return this == null || this!.isEmpty;
  }

  double toAmountFromINR({double? onNull}) {
    if (this == null) return onNull ??  0.0;

    String sanitizedString = this!.replaceAll(RegExp(r'[^\d.,]'), '');
    sanitizedString = sanitizedString.replaceAll(',', '');

    return double.tryParse(sanitizedString) ?? onNull ?? 0.0;
  }

  double toRate() {
    if (this == null) return 0.0;

    return double.tryParse(this!.replaceAll('%', '')) ?? 0.0;
  }
}
