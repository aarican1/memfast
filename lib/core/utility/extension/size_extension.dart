import 'package:flutter/material.dart';

extension DynamicSizeExtension on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  /// It gives the value in the multiplier ratio entered with device heigth
  ///  double value = context.dynamicHeigth(0.5)
  double dynamicHeigth(double multiplier) =>
      (size.height * multiplier).roundToDouble();

  /// It gives the value in the multiplier ratio entered with device width
  ///  double value = context.dynamicWidth(0.5)
  double dynamicWidth(double multiplier) =>
      (size.width * multiplier).roundToDouble();
}
