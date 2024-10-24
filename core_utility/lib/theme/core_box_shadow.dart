import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreBoxShadow {
  static List<BoxShadow> legacyShadow = const [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 20,
      color: CoreColors.black04,
    )
  ];

  static List<BoxShadow> calculatorShadow = const [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 10,
      color: CoreColors.black04,
    )
  ];
}
