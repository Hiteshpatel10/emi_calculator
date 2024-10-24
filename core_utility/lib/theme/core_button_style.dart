import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreButtonStyle {
  static ButtonStyle calculatorButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: CoreColors.toryBlue,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      foregroundColor: Colors.white,
    );
  }
}
