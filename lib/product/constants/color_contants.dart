import 'package:flutter/material.dart';

class ColorConstants {
  static const LinearGradient backgroundGradient = LinearGradient(
      colors: colorList, begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const List<Color> colorList = <Color>[
    Color(0xff000000),
    Color(0xff1D3655)
  ];
  static const Color buttonBackgroundColor = Colors.black; //Color(0xFF5E7387);
  static const Color textColor = Colors.white;
  static const Color levelButtonColorHalfElevation =
      Color.fromRGBO(255, 255, 255, 0.5);
}
