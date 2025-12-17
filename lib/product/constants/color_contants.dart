import 'package:flutter/material.dart';

class ColorConstants {
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: colorList,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const List<Color> colorList = <Color>[
    Color(0xff0118D8),
    Color(0xffED3500),
  ];

  static const Color grey = Colors.grey;
  static const Color buttonBackgroundColor = Color(0xFFFFB433);
  static const Color textColor = Colors.white;
  static const Color levelButtonColorHalfElevation = Color.fromRGBO(
    255,
    255,
    255,
    0.5,
  );
}
