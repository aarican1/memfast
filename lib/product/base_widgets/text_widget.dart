import 'package:flutter/material.dart';

class BaseTextWidget extends StatelessWidget {
  const BaseTextWidget({
    super.key,
    required this.fontSize,
    required this.textColor, required this.text,
  });

  final double fontSize;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(     fontSize: fontSize, color: textColor));
  }
}
