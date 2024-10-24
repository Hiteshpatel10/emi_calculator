import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreBoxDecoration {
  static BoxDecoration getBoxDecoration({
    double borderRadius = 12,
    Color color = Colors.white,
    bool removeShadow = false,
    bool addBorder = false,
    Border? border,
    Gradient? gradient,
    BoxShape shape = BoxShape.rectangle,
    List<BoxShadow> boxShadow = const [
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 12,
        color: CoreColors.black04,
      )
    ],
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
      color: color,
      shape: shape,
      border: addBorder == true
          ? border ??
              Border.all(
                width: 1,
                color: CoreColors.toryBlue,
              )
          : null,
      boxShadow: removeShadow == false ? boxShadow : null,
    );
  }
}
